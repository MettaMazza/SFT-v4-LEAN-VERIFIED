import SFT.Chemistry.IonicConductivity
namespace SFT.Chemistry.IonicMobilityTransference
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Foundation.ExactOperations SFT.Chemistry.DihedralTorsion
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure IonicMobilityAccount where
 species : HeldLabel
 direction : HeldLabel
 composition : HeldLabel
 condition : HeldLabel
 path : HeldLabel
 traversals : PositiveCount
 carriers : PositiveCount
 pathResource : PositiveCount
structure ExactPart where
 value : PositiveFraction
 throughOne : value.numerator ≤ value.denominator
structure TransferenceRow where
 species : HeldLabel
 direction : HeldLabel
 mobility : Ratio
 transference : ExactPart
structure MobilityTransferenceResult where
 rows : List TransferenceRow
 completePartition : ExactPart
 composition : HeldLabel
 condition : HeldLabel
def makeAccount (species direction composition condition path : HeldLabel) (traversals carriers resource : CountInput) : Except String IonicMobilityAccount := do
 if !Text.equal species.family "ionic-species" || !Text.equal direction.family "transport-direction" ||
  !Text.equal composition.family "electrolyte-composition" || !Text.equal condition.family "transport-condition" || !Text.equal path.family "transport-path" then
  throw "mobility account lost species, direction, composition, condition or path"
 let readCount := fun c=>match c with
  | CountInput.count n => Except.ok n
  | .other => Except.error "mobility counts and resource must be positive exact values"
 pure ⟨species,direction,composition,condition,path,← readCount traversals,← readCount carriers,← readCount resource⟩
def mobility (a : IonicMobilityAccount) : Ratio :=
 ⟨a.traversals,⟨a.carriers.value*a.pathResource.value,
  Nat.mul_pos a.carriers.positive a.pathResource.positive⟩⟩
def contribution (a : IonicMobilityAccount) : PositiveFraction :=
 let m := fraction (mobility a)
 normalizePositive (m.numerator*a.carriers.value) m.denominator (Nat.mul_pos m.positive a.carriers.positive) (Nat.pos_of_ne_zero m.denominatorNonzero)
def exactPart (r : PositiveFraction) : Except String ExactPart :=
 if h : r.numerator ≤ r.denominator then .ok ⟨r,h⟩ else .error "an SFT part must lie in the exact positive domain through the One"
def mobilityAndTransference (accounts : List IonicMobilityAccount) : Except String MobilityTransferenceResult := do
 match accounts with
 | [] => throw "mobility partition requires at least one ionic species"
 | first::rest =>
  if !(accounts.all fun row=>equalLabel row.composition first.composition && equalLabel row.condition first.condition && equalLabel row.path first.path) then
   throw "mobility accounts must share composition, condition and path"
  if !distinctAtoms (accounts.map IonicMobilityAccount.species) then throw "every species must have exactly one mobility account"
  let total := rest.foldl (fun total row=>AlphaRatio.add total (contribution row)) (contribution first)
  let makeRow := fun row=>do
   let c := contribution row
   let part ← exactPart (normalizePositive (c.numerator*total.denominator) (c.denominator*total.numerator)
    (Nat.mul_pos c.positive (Nat.pos_of_ne_zero total.denominatorNonzero))
    (Nat.mul_pos (Nat.pos_of_ne_zero c.denominatorNonzero) total.positive))
   pure (TransferenceRow.mk row.species row.direction (mobility row) part)
  let firstRow ← makeRow first
  let restRows ← rest.mapM makeRow
  let partition ← exactPart (restRows.foldl (fun total row=>AlphaRatio.add total row.transference.value) firstRow.transference.value)
  pure ⟨firstRow::restRows,partition,first.composition,first.condition⟩
def absentSpeciesTransference : Height := .emptyOne
def exampleAccount (name direction : String) (traversals : Nat) : Except String IonicMobilityAccount := do
 makeAccount (← heldLabel "ionic-species" name) (← heldLabel "transport-direction" direction)
  (← heldLabel "electrolyte-composition" "test") (← heldLabel "transport-condition" "held")
  (← heldLabel "transport-path" "path") (.count (← count traversals)) (.count (← count 1)) (.count (← count 2))
def witnesses : Except String (List Bool) := do
 let first ← exampleAccount "cation" "toward-terminal" 3
 let second ← exampleAccount "anion" "toward-source" 1
 let result ← mobilityAndTransference [first,second]
 let duplicate := match mobilityAndTransference [first,← exampleAccount "cation" "toward-source" 1] with
  | .error _ => true
  | .ok _ => false
 let parts := result.rows.map fun r=>(r.transference.value.numerator,r.transference.value.denominator)
 let opposed := match result.rows with
  | a::b::_ => !equalLabel a.direction b.direction
  | [] => false
  | _::[] => false
 pure [result.rows.length==2,true,parts==[(3,4),(1,4)],result.completePartition.value.numerator==result.completePartition.value.denominator,
  opposed,Text.equal result.composition.family "electrolyte-composition",equalHeight absentSpeciesTransference .emptyOne,duplicate]
theorem originalEightWitnesses : witnesses = .ok [true,true,true,true,true,true,true,true] := rfl
end SFT.Chemistry.IonicMobilityTransference
