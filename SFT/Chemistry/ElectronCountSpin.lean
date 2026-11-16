import SFT.Physics.CapabilityValues
import SFT.Physics.GrandLockDependency
namespace SFT.Chemistry.ElectronCountSpin
open SFT.Host SFT.Physics.CapabilityValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure NuclearPopulation where
 elementSymbol : HeldLabel
 atomicNumber : PositiveCount
 occurrenceCount : PositiveCount
def validPopulation (row : NuclearPopulation) : Except String NuclearPopulation :=
 if !Text.equal row.elementSymbol.family "element-symbol" then
  .error "nuclear population requires a retained element symbol"
 else .ok row

inductive CountOrEmpty where
 | count : PositiveCount → CountOrEmpty
 | emptyOne : String → CountOrEmpty
def structuralEmpty : CountOrEmpty := .emptyOne "empty-One"
def multiplicity : CountOrEmpty → Nat
 | .count n => n.value
 | .emptyOne _ => 0
structure HeldChargeTransfer where
 action : HeldLabel
 count : CountOrEmpty
def validTransfer (transfer : HeldChargeTransfer) : Except String HeldChargeTransfer := do
 if !Text.equal transfer.action.family "electron-transfer" then
  throw "charge requires a held electron-transfer action"
 if Text.equal transfer.action.label "empty-One" then
  match transfer.count with
  | .count _ => throw "neutral charge is structural empty One"
  | .emptyOne identity =>
   if !Text.equal identity "empty-One" then throw "neutral charge is structural empty One"
   pure transfer
 else if Text.equal transfer.action.label "adjoin-electron" || Text.equal transfer.action.label "remove-electron" then
  match transfer.count with
  | .count _ => pure transfer
  | .emptyOne _ => throw "directed charge requires a positive transfer count"
 else throw "charge action is outside the generated Fold pair"

structure SpinCell where
 cellId : HeldLabel
 occupants : List HeldLabel
def validCell (cell : SpinCell) : Except String SpinCell := do
 if !Text.equal cell.cellId.family "electron-support-cell" || cell.occupants.isEmpty then
  throw "a spin cell requires named positive support"
 if !(cell.occupants.all (fun label => Text.equal label.family "electron-spin")) then
  throw "spin occupants must remain held fibre labels"
 let labels := cell.occupants.map HeldLabel.label
 if (SFT.Physics.GrandLockDependency.unique labels).length != labels.length || labels.length > 2 then
  throw "same-cell same-fibre doubling violates exclusion"
 if !(labels.all (fun label => Text.equal label "fibre-a" || Text.equal label "fibre-b")) then
  throw "electron spin has exactly two generated fibre labels"
 pure cell

structure Organization where
 molecularId : HeldLabel
 electronCount : PositiveCount
 electronOccurrenceIds : List HeldLabel
 cells : List SpinCell
 complementaryPairCount : CountOrEmpty
 unmatchedFibreCount : CountOrEmpty
 spinWidth : PositiveCount
def sameLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def distinctLabels : List HeldLabel → Bool
 | [] => true
 | x::xs => !(xs.any (sameLabel x)) && distinctLabels xs
def complementaryCell (cell : SpinCell) : Bool :=
 match cell.occupants with
 | [] => false
 | a::rest => match rest with
   | [] => false
   | b::tail => match tail with
     | [] => Text.equal a.label "fibre-a" && Text.equal b.label "fibre-b"
     | _::_ => false
def validOrganization (state : Organization) : Except String Organization := do
 if !Text.equal state.molecularId.family "molecular-carrier" then
  throw "electron organization requires one molecular carrier"
 if state.electronOccurrenceIds.length != state.electronCount.value then
  throw "electron count must equal complete occurrence support"
 if !distinctLabels state.electronOccurrenceIds then
  throw "electron occurrence identities must be unique"
 if !(state.electronOccurrenceIds.all (fun label => Text.equal label.family "electron-occurrence")) then
  throw "electron support contains an invalid occurrence identity"
 let occupied := (state.cells.map (fun cell => cell.occupants.length)).foldl (·+·) 0
 if occupied != state.electronCount.value then
  throw "every electron occurrence must occupy exactly one held-spin cell"
 let pairs := multiplicity state.complementaryPairCount
 let unmatched := multiplicity state.unmatchedFibreCount
 if pairs*2+unmatched != state.electronCount.value then
  throw "pair-plus-held decomposition does not exhaust electron support"
 if state.spinWidth.value != unmatched+1 then
  throw "spin width must be one successor beyond unmatched fibre count"
 let actualPairs := (state.cells.filter complementaryCell).length
 let actualSingles := (state.cells.filter (fun cell => cell.occupants.length == 1)).length
 if actualPairs != pairs || actualSingles != unmatched then
  throw "cell support differs from exact pair-plus-held decomposition"
 pure state

def neutralCount (populations : List NuclearPopulation) : Nat :=
 (populations.map (fun row => row.atomicNumber.value*row.occurrenceCount.value)).foldl (·+·) 0
def exactElectronCount (populations : List NuclearPopulation) (transfer : HeldChargeTransfer) : Except String PositiveCount := do
 if populations.isEmpty then throw "molecular nuclear support must be positive and finite"
 let neutral := neutralCount populations
 if Text.equal transfer.action.label "empty-One" then count neutral
 else do
  let n ← match transfer.count with
   | .count n => .ok n.value
   | .emptyOne _ => .error "AssertionError"
  if Text.equal transfer.action.label "adjoin-electron" then count (neutral+n)
  else if n >= neutral then throw "electron removal cannot erase or exceed positive molecular support"
  else count (neutral-n)
def requiredSpinWidthParity (electrons : PositiveCount) : Except String HeldLabel :=
 heldLabel "spin-width-parity" (if electrons.value%2==0 then "odd-positive-width" else "even-positive-width")
def countOrEmpty (n : Nat) : Except String CountOrEmpty :=
 if n==0 then pure structuralEmpty else do pure (.count (← count n))
def numberedLabel (family labelPrefix : String) (index : Nat) : Except String HeldLabel :=
 heldLabel family (Text.append labelPrefix (Canonical.render (.integer (.ofNat index))))
def buildCompleteSpinOrganization (molecularLabel : String) (electrons width : PositiveCount) : Except String Organization := do
 let unmatched := width.value-1
 if unmatched > electrons.value || (electrons.value-unmatched)%2 != 0 then
  throw "spin width is incompatible with exact electron support"
 let pairs := (electrons.value-unmatched)/2
 let paired ← (List.range pairs).mapM fun index => do
  let cellId ← numberedLabel "electron-support-cell" "pair-" (index+1)
  let a ← heldLabel "electron-spin" "fibre-a"
  let b ← heldLabel "electron-spin" "fibre-b"
  validCell ⟨cellId,[a,b]⟩
 let singles ← (List.range unmatched).mapM fun index => do
  let cellId ← numberedLabel "electron-support-cell" "held-" (index+1)
  let a ← heldLabel "electron-spin" "fibre-a"
  validCell ⟨cellId,[a]⟩
 let occurrences ← (List.range electrons.value).mapM fun index => numberedLabel "electron-occurrence" "electron-" (index+1)
 let molecularId ← heldLabel "molecular-carrier" molecularLabel
 let pairCount ← countOrEmpty pairs
 let unmatchedCount ← countOrEmpty unmatched
 validOrganization ⟨molecularId,electrons,occurrences,paired++singles,pairCount,unmatchedCount,width⟩
end SFT.Chemistry.ElectronCountSpin
