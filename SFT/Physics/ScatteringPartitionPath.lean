import SFT.Physics.MatterScattering
import SFT.Physics.SymmetryActionPaths
import SFT.Physics.GeneratorOperations
namespace SFT.Physics.ScatteringPartitionPath
open LeptonIntervals GeneratorOperations
open SFT.Mathematics.LimitComputations (equalRat)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := normalize 1 1 (by decide)
def half : Rat := normalize 1 2 (by decide)
def exactlyTwoLabelsFrom (first : String) : Option String → List String → Bool
 | none,[] => false
 | some _,[] => true
 | none,label::rest => if SFT.Host.Text.equal first label then exactlyTwoLabelsFrom first none rest
   else exactlyTwoLabelsFrom first (some label) rest
 | some second,label::rest =>
   if SFT.Host.Text.equal first label || SFT.Host.Text.equal second label then exactlyTwoLabelsFrom first (some second) rest else false
def twoFibreOutcomeMeasure : List String → Except String (Rat × Rat)
 | [] => .error "the two Fold outcomes must remain distinguishable"
 | first::rest => if exactlyTwoLabelsFrom first none rest then .ok (half,half)
   else .error "the two Fold outcomes must remain distinguishable"
def partitionIsComplete (labels : List String) : Except String Bool := do
 let pair ← twoFibreOutcomeMeasure labels
 pure (equalRat (add pair.1 pair.2) one)
def crossSection (successful incident : CountInput) : Except String Rat :=
 match successful with
 | .boolean _ => .error "cross section requires positive contained support"
 | .integer (.negSucc _) => .error "cross section requires positive contained support"
 | .integer (.ofNat 0) => .error "cross section requires positive contained support"
 | .integer (.ofNat (s+1)) => match incident with
   | .boolean _ => .error "cross section requires positive contained support"
   | .integer (.negSucc _) => .error "cross section requires positive contained support"
   | .integer (.ofNat n) => if contained : s+1≤n then
      .ok (normalize (.ofNat (s+1)) n (Nat.lt_of_lt_of_le (Nat.zero_lt_succ _) contained))
     else .error "cross section requires positive contained support"
def meanFreePath (density cross : FoldFirstReturn.Input) : Except String Rat := do
 let n ← (SymmetryActionPaths.positiveCoordinate density).mapError (fun _ => "mean free path requires exact positive density and section")
 let s ← (SymmetryActionPaths.positiveCoordinate cross).mapError (fun _ => "mean free path requires exact positive density and section")
 LeptonRatios.divide one (multiply n s)
-- The original ordering test precedes the exact-Fraction admission test.
inductive OrderedInput where | fraction (value : Rat) | nonFractionNumber (value : Rat)
def orderedValue : OrderedInput → Rat | .fraction x => x | .nonFractionNumber x => x
def exactInput : OrderedInput → FoldFirstReturn.Input | .fraction x => .fraction x | .nonFractionNumber _ => .nonFraction
def largerSectionShortensPath (density : FoldFirstReturn.Input) (smaller larger : OrderedInput) : Except String Bool :=
 if zero.blt (orderedValue smaller) && (orderedValue smaller).blt (orderedValue larger) then do
  let short ← meanFreePath density (exactInput larger)
  let long ← meanFreePath density (exactInput smaller)
  pure (short.blt long)
 else .error "ordered positive cross sections are required"
end SFT.Physics.ScatteringPartitionPath
