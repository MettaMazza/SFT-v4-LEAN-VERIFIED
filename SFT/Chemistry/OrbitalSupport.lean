import SFT.Chemistry.ElectronCountSpin
namespace SFT.Chemistry.OrbitalSupport
open SFT.Host SFT.Physics.CapabilityValues ElectronCountSpin
abbrev AxisRank := CountOrEmpty
inductive Observation where
 | emptyOne : String → Observation
 | held : HeldLabel → Observation
structure MolecularSupportCell where
 molecularCarrier : HeldLabel
 radialRecurrence : PositiveCount
 axisRecurrence : AxisRank
 joiningPhase : HeldLabel
 exchangeObservation : Observation
 reflectionObservation : Observation
def validObservation (family : String) : Observation → Bool
 | .emptyOne _ => true
 | .held label => Text.equal label.family family
def validCell (cell : MolecularSupportCell) : Except String MolecularSupportCell := do
 if !Text.equal cell.molecularCarrier.family "molecular-carrier" then
  throw "support cell requires one identified molecular carrier"
 if !Text.equal cell.joiningPhase.family "joining-phase" ||
  !(Text.equal cell.joiningPhase.label "fibre-a" || Text.equal cell.joiningPhase.label "fibre-b") then
  throw "joined support has exactly two held phase fibres"
 if !validObservation "nuclear-exchange" cell.exchangeObservation then
  throw "exchange observation has an invalid family"
 if !validObservation "axis-reflection" cell.reflectionObservation then
  throw "reflection observation has an invalid family"
 return cell
structure OccupiedMolecularSupport where
 cell : MolecularSupportCell
 electronOccurrences : List HeldLabel
 spinFibres : List HeldLabel
def validOccupied (row : OccupiedMolecularSupport) : Except String OccupiedMolecularSupport := do
 if row.electronOccurrences.isEmpty || row.electronOccurrences.length > 2 then
  throw "one spatial support cell holds one occurrence or one complementary pair"
 if row.electronOccurrences.length != row.spinFibres.length then
  throw "every occupied support occurrence requires one spin fibre"
 if !distinctLabels row.electronOccurrences then
  throw "electron occurrence cannot occupy the same support twice"
 if !(row.electronOccurrences.all (fun label => Text.equal label.family "electron-occurrence")) then
  throw "support occupancy contains an invalid electron occurrence"
 if !(row.spinFibres.all (fun label => Text.equal label.family "electron-spin")) then
  throw "support occupancy contains an invalid spin fibre"
 let labels := row.spinFibres.map HeldLabel.label
 if !(labels.all (fun label => Text.equal label "fibre-a" || Text.equal label "fibre-b")) then
  throw "support occupancy left the generated spin pair"
 if labels.length==2 && !(labels.any (Text.equal "fibre-a") && labels.any (Text.equal "fibre-b")) then
  throw "double occupancy requires complementary spin fibres"
 return row
def occupancyCount (row : OccupiedMolecularSupport) : Except String PositiveCount := count row.electronOccurrences.length
def sameRank (a b : AxisRank) : Bool :=
 match a with
 | .emptyOne x => match b with | .emptyOne y => Text.equal x y | .count _ => false
 | .count x => match b with | .emptyOne _ => false | .count y => x.value==y.value
def sameObservation (a b : Observation) : Bool :=
 match a with
 | .emptyOne x => match b with | .emptyOne y => Text.equal x y | .held _ => false
 | .held x => match b with | .emptyOne _ => false | .held y => sameLabel x y
def sameCoordinate (a b : MolecularSupportCell) : Bool :=
 a.radialRecurrence.value==b.radialRecurrence.value && sameRank a.axisRecurrence b.axisRecurrence &&
 sameLabel a.joiningPhase b.joiningPhase && sameObservation a.exchangeObservation b.exchangeObservation &&
 sameObservation a.reflectionObservation b.reflectionObservation
def distinctCoordinates : List MolecularSupportCell → Bool
 | [] => true
 | cell::rest => !(rest.any (sameCoordinate cell)) && distinctCoordinates rest
structure CompleteMolecularSupport where
 molecularCarrier : HeldLabel
 exactElectronCount : PositiveCount
 occupiedCells : List OccupiedMolecularSupport
def validComplete (state : CompleteMolecularSupport) : Except String CompleteMolecularSupport := do
 if !Text.equal state.molecularCarrier.family "molecular-carrier" || state.occupiedCells.isEmpty then
  throw "complete support requires an identified carrier and positive occupied cells"
 if !(state.occupiedCells.all (fun row => sameLabel row.cell.molecularCarrier state.molecularCarrier)) then
  throw "every support cell must remain bound to the same molecule"
 let occurrences := state.occupiedCells.flatMap OccupiedMolecularSupport.electronOccurrences
 if occurrences.length != state.exactElectronCount.value || !distinctLabels occurrences then
  throw "occupied cells must exhaust every electron occurrence exactly once"
 if !distinctCoordinates (state.occupiedCells.map OccupiedMolecularSupport.cell) then
  throw "a complete support cannot duplicate a spatial cell coordinate"
 return state
def joinedPhasePair (molecularLabel : String) (radial : PositiveCount) (axis : AxisRank) :
 Except String (List MolecularSupportCell) := do
 let carrier ← heldLabel "molecular-carrier" molecularLabel
 ["fibre-a","fibre-b"].mapM fun phase => do
  let joining ← heldLabel "joining-phase" phase
  validCell ⟨carrier,radial,axis,joining,.emptyOne "empty-One",.emptyOne "empty-One"⟩
def axisRankFromPositiveOrdinal (ordinal : PositiveCount) : Except String AxisRank :=
 if ordinal.value==1 then .ok structuralEmpty else (count (ordinal.value-1)).map CountOrEmpty.count
def axisRankLabel : AxisRank → Except String HeldLabel
 | .emptyOne identity => if Text.equal identity "empty-One" then heldLabel "axis-support-rank" "structural-empty-One"
   else .error "'EmptyOne' object has no attribute 'value'"
 | .count n => heldLabel "axis-support-rank"
   (if n.value==1 then "first-recurrence" else if n.value==2 then "second-recurrence"
    else if n.value==3 then "third-recurrence" else Text.append "positive-recurrence-" (Canonical.render (.integer (.ofNat n.value))))
def conventionalSupportCorrespondence (symbol : String) : Except String AxisRank :=
 if Text.equal symbol "Σ" || Text.equal symbol "σ" then axisRankFromPositiveOrdinal ⟨1,by decide⟩
 else if Text.equal symbol "Π" || Text.equal symbol "π" then axisRankFromPositiveOrdinal ⟨2,by decide⟩
 else if Text.equal symbol "Δ" || Text.equal symbol "δ" then axisRankFromPositiveOrdinal ⟨3,by decide⟩
 else if Text.equal symbol "Φ" || Text.equal symbol "φ" then axisRankFromPositiveOrdinal ⟨4,by decide⟩
 else .error "conventional support symbol is outside the declared comparison boundary"
def occupiedSupportFromSourceAssignment (molecularLabel : String) (radial : PositiveCount)
 (symbol : String) (occupancy : PositiveCount) : Except String OccupiedMolecularSupport := do
 if occupancy.value > 2 then throw "one molecular spatial support cannot hold more than the complementary spin pair"
 let carrier ← heldLabel "molecular-carrier" molecularLabel
 let rank ← conventionalSupportCorrespondence symbol
 let phase ← heldLabel "joining-phase" "fibre-a"
 let cell ← validCell ⟨carrier,radial,rank,phase,.emptyOne "empty-One",.emptyOne "empty-One"⟩
 let occurrences ← (List.range occupancy.value).mapM fun position => numberedLabel "electron-occurrence" "electron-" (position+1)
 let a ← heldLabel "electron-spin" "fibre-a"
 let spins ← if occupancy.value==1 then .ok [a] else do
  let b ← heldLabel "electron-spin" "fibre-b"
  pure [a,b]
 validOccupied ⟨cell,occurrences,spins⟩
end SFT.Chemistry.OrbitalSupport
