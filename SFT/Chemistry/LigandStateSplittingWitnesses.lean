import SFT.Chemistry.LigandStateSplittingDerivation
namespace SFT.Chemistry.LigandStateSplittingWitnesses
open SFT.Physics.CapabilityValues LigandStateSplitting
def generatorWitness : Bool := match generated with
 | .error _ => false
 | .ok rows => rows.length==5
def sixPartitionWitness : Bool := widths sixResult == [3,2]
def partIs (value : Distance) (n d : Nat) : Bool := match value with
 | .absent => false
 | .part p => p.numerator.value*d == n*p.denominator.value
def sixBalanceWitness : Bool := match sixResult with
 | .error _ => false
 | .ok s => partIs s.lower 2 5 && partIs s.upper 3 5
def fourPartitionWitness : Bool := widths fourResult == [2,3]
def memberWitness : Bool := match sixResult,fourResult with
 | .error _,.error _ | .error _,.ok _ | .ok _,.error _ => false
 | .ok six,.ok four => six.completeMemberPreservation && four.completeMemberPreservation
def removedResult : Except String Splitting := do
 removed (← heldLabel "coordination-central-occurrence" "removed-ligand-centre")
def removedWitness : Bool := match removedResult with
 | .error _ => false
 | .ok r => r.levels.length==1 &&
   match r.levels with
   | [] => false
   | first::_ => first.members.length==5 &&
    match first.rank with | .absent => true | .positive _ => false
theorem generatorPassed : generatorWitness = true := by decide
theorem sixPartitionPassed : sixPartitionWitness = true := by decide
theorem sixBalancePassed : sixBalanceWitness = true := by decide
theorem fourPartitionPassed : fourPartitionWitness = true := by decide
theorem memberPassed : memberWitness = true := by decide
theorem removedPassed : removedWitness = true := by decide
end SFT.Chemistry.LigandStateSplittingWitnesses
