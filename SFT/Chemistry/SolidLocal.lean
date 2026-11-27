import SFT.Chemistry.MetalClusterDerivation
namespace SFT.Chemistry.SolidLocal
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (sameLabel distinctLabels)
structure FormulaEntry where
 species : HeldLabel
 primitiveCount : PositiveCount

def formulaEntry (species : HeldLabel) (n : PositiveCount) : Except String FormulaEntry :=
 if !Text.equal species.family "chemical-species" then .error "formula entry requires a retained chemical species"
 else .ok ⟨species,n⟩

def speciesName (x : HeldLabel) : String :=
 String.ofList ((Text.chars x.label).takeWhile (fun c => c.toNat != 35))

def speciesLabels (xs : List HeldLabel) : List String :=
 xs.foldl (fun labels x => if labels.any (Text.equal (speciesName x)) then labels else labels++[speciesName x]) []

def speciesCount (xs : List HeldLabel) (label : String) : Nat :=
 (xs.filter (fun x => Text.equal (speciesName x) label)).length

def primitiveFormula (xs : List HeldLabel) : Except String (List FormulaEntry) := do
 let labels := speciesLabels xs
 let counts := labels.map (speciesCount xs)
 let divisor ← match counts with
  | [] => .error "reduce() of empty sequence with no initial value"
  | n::ns => .ok (ns.foldl Nat.gcd n)
 labels.mapM fun label => do
  let species ← heldLabel "chemical-species" label
  let n ← count (speciesCount xs label / divisor)
  formulaEntry species n

def sameFormula : List FormulaEntry → List FormulaEntry → Bool
 | [],[] => true
 | a::as,b::bs => sameLabel a.species b.species && a.primitiveCount.value==b.primitiveCount.value && sameFormula as bs
 | [],_::_ | _::_,[] => false

abbrev Bond := HeldLabel × HeldLabel
def sameBond (a b : Bond) : Bool := sameLabel a.1 b.1 && sameLabel a.2 b.2
def distinctBonds : List Bond → Bool
 | [] => true
 | b::bs => !(bs.any (sameBond b)) && distinctBonds bs
inductive Constituent where
 | emptyOne : String → Constituent
 | support : List HeldLabel → Constituent
structure Solid where
 motif : HeldLabel
 occurrences : List HeldLabel
 localBonds : List Bond
 formula : List FormulaEntry
 repeatAxes : List HeldLabel
 constituent : Constituent
 chemistryScope : HeldLabel
 bulkHandoff : HeldLabel

def scope : HeldLabel := ⟨"ownership","composition-and-local-bonding",rfl,rfl⟩
def handoff : HeldLabel := ⟨"ownership-handoff","materials-bulk-response",rfl,rfl⟩
def validConstituent : Constituent → Bool
 | .emptyOne _ => true
 | .support xs => !xs.isEmpty && !(xs.any (fun x => !Text.equal x.family "second-constituent-occurrence"))

def solid (motif : HeldLabel) (occurrences : List HeldLabel) (bonds : List Bond)
 (formula : List FormulaEntry) (axes : List HeldLabel) (constituent : Constituent)
 (chemistryScope bulkHandoff : HeldLabel) : Except String Solid :=
 if !Text.equal motif.family "local-solid-motif" || occurrences.isEmpty || !distinctLabels occurrences then
  .error "local solid chemistry requires one positive complete occurrence motif"
 else if occurrences.any (fun x => !Text.equal x.family "species-occurrence") then
  .error "motif occurrence is not a species occurrence"
 else if formula.isEmpty then .error "formula must be the exact primitive positive occurrence ratio"
 else match primitiveFormula occurrences with
 | .error err => .error err
 | .ok expected =>
  if !sameFormula formula expected then .error "formula must be the exact primitive positive occurrence ratio"
  else if axes.length<1 || axes.length>3 || axes.any (fun x => !Text.equal x.family "generated-repeat-axis") || !distinctLabels axes then
   .error "repeat support has exact generated rank one, two or three"
  else if !distinctBonds bonds || bonds.any (fun b => !MulticentreSupport.contains occurrences b.1 || !MulticentreSupport.contains occurrences b.2 || sameLabel b.1 b.2) then
   .error "local bond support is incomplete or invalid"
  else if !validConstituent constituent then .error "second constituent support must be positive or structural EmptyOne"
  else if !sameLabel chemistryScope scope || !sameLabel bulkHandoff handoff then .error "Chemistry/Materials ownership boundary changed"
  else .ok ⟨motif,occurrences,bonds,formula,axes,constituent,chemistryScope,bulkHandoff⟩

def occurrence (species : String) (index : PositiveCount) : Except String HeldLabel :=
 heldLabel "species-occurrence" (Text.intercalate "#" [species,toString index.value])

def appendOccurrence (state : Solid) (species : String) (bondTo : HeldLabel) : Except String Solid := do
 let existing := speciesCount state.occurrences species
 let added ← occurrence species ⟨existing+1,Nat.zero_lt_succ existing⟩
 let occurrences := state.occurrences++[added]
 let formula ← primitiveFormula occurrences
 solid state.motif occurrences (state.localBonds++[(bondTo,added)]) formula state.repeatAxes state.constituent state.chemistryScope state.bulkHandoff
end SFT.Chemistry.SolidLocal
