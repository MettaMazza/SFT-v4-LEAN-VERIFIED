import SFT.Physics.AlphaRatio
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.CompositeConfining
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def heldDenominator : CountInput → Except String Nat
 | .boolean _ => .error "Fold confinement requires a generated even sector beyond the binary fibre"
 | .integer n => if 2 < n && n % 2 = 0 then .ok (n.toNat-1)
  else .error "Fold confinement requires a generated even sector beyond the binary fibre"
def standingModeLabels (sector : CountInput) : Except String (List Nat) := do
 let denominator ← heldDenominator sector
 pure ((List.range (denominator-1)).map (fun n => n+1))
def standingModes (sector : CountInput) : Except String (List Rat) := do
 let denominator ← heldDenominator sector
 (← standingModeLabels sector).mapM (fun label => LeptonRatios.divide (wholeRatio label) (wholeRatio denominator))
def labelInteger : CountInput → Int
 | .integer n => n
 | .boolean true => 1
 | .boolean false => 0
def foldModeLabel (label sector : CountInput) : Except String Nat := do
 let denominator ← heldDenominator sector
 let labels ← standingModeLabels sector
 let value := labelInteger label
 if !(labels.any (fun n => Int.ofNat n = value)) then throw "Fold mode label lies outside the complete standing support"
 let folded := (value.toNat+value.toNat)%denominator
 if folded < 1 then throw "odd predecessor support cannot Fold a nonempty mode to an empty label"
 pure folded
def inverseFoldModeLabel (label sector : CountInput) : Except String Nat := do
 let denominator ← heldDenominator sector
 let labels ← standingModeLabels sector
 let value := labelInteger label
 if !(labels.any (fun n => Int.ofNat n = value)) then throw "inverse Fold label lies outside the complete standing support"
 let inverseTwo := (denominator+1)/2
 let predecessor := (inverseTwo*value.toNat)%denominator
 if predecessor < 1 then throw "Fold inverse did not reconstruct the held label"
 let folded ← foldModeLabel (.integer (.ofNat predecessor)) sector
 if !(Int.ofNat folded = value) then throw "Fold inverse did not reconstruct the held label"
 pure predecessor
def antipodalPairs (sector : CountInput) : Except String (List (Nat × Nat)) := do
 let denominator ← heldDenominator sector
 pure ((List.range ((denominator+1)/2-1)).map (fun n => (n+1,denominator-(n+1))))
def holdingCoupling (sector : CountInput) : Except String Rat := do
 let denominator ← heldDenominator sector
 LeptonRatios.divide (wholeRatio denominator) (wholeRatio (labelInteger sector).toNat)
end SFT.Physics.CompositeConfining
