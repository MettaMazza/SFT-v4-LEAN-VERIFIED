import SFT.Physics.LeptonIntervals
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.AtomicFieldSplitting
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
inductive CountArgument where
 | count (value : CountInput)
 | nonInteger
set_option maxRecDepth 20000
def magneticSublevelCount : CountArgument → Except String Nat
 | .count (.integer (.ofNat (n+1))) => .ok (n+2)
 | .count (.integer (.ofNat 0)) => .error "doubled angular support must be a positive whole count"
 | .count (.integer (.negSucc _)) => .error "doubled angular support must be a positive whole count"
 | .count (.boolean _) => .error "doubled angular support must be a positive whole count"
 | .nonInteger => .error "doubled angular support must be a positive whole count"
def positiveCarrier (message : String) : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error message
 | .fraction value => if !(wholeRatio 0).blt value then .error message else .ok value
def orientationDistance : CountArgument → Except String Nat
 | .count (.integer (.ofNat (n+1))) => .ok (n+1)
 | .count (.integer (.ofNat 0)) => .error "orientation distance must be a positive count"
 | .count (.integer (.negSucc _)) => .error "orientation distance must be a positive count"
 | .count (.boolean _) => .error "orientation distance must be a positive count"
 | .nonInteger => .error "orientation distance must be a positive count"
def zeemanShiftMagnitude (g : FoldFirstReturn.Input) (distance : CountArgument) (field : FoldFirstReturn.Input) : Except String Rat := do
 let g ← positiveCarrier "g carrier must be exact and positive" g
 let distance ← orientationDistance distance
 let field ← positiveCarrier "field magnitude must be exact and positive" field
 pure (multiply (multiply g (wholeRatio distance)) field)
def linearStarkMagnitude (dipole field : FoldFirstReturn.Input) : Except String Rat := do
 let dipole ← positiveCarrier "linear Stark carriers must be exact and positive" dipole
 let field ← positiveCarrier "linear Stark carriers must be exact and positive" field
 pure (multiply dipole field)
def quadraticStarkMagnitude (polarizability field : FoldFirstReturn.Input) : Except String Rat := do
 let polarizability ← positiveCarrier "quadratic Stark carriers must be exact and positive" polarizability
 let field ← positiveCarrier "quadratic Stark carriers must be exact and positive" field
 LeptonRatios.divide (multiply (multiply polarizability field) field) (wholeRatio 2)
theorem everySublevelCount (n : Nat) : magneticSublevelCount (.count (.integer (.ofNat (n+1))))=.ok (n+2) := rfl
theorem orientationSuccessor (n : Nat) : magneticSublevelCount (.count (.integer (.ofNat (n+2))))=.ok ((n+2)+1) := rfl
theorem firstSix : [magneticSublevelCount (.count (.integer 1)),magneticSublevelCount (.count (.integer 2)),magneticSublevelCount (.count (.integer 3)),magneticSublevelCount (.count (.integer 4)),magneticSublevelCount (.count (.integer 5)),magneticSublevelCount (.count (.integer 6))]=[.ok 2,.ok 3,.ok 4,.ok 5,.ok 6,.ok 7] := rfl
end SFT.Physics.AtomicFieldSplitting
