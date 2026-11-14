import SFT.Physics.GravityWaveTrace
namespace SFT.Physics.GravityWaveEntryWitnesses
open GravityWaveTrace
structure Witness where
 name : String
 statement : String
 passed : Bool
def same (a b : Rat) : Bool := !a.blt b && !b.blt a
def speedCheck : Bool := match gravitationalWaveTrace with
 | .error _ => false
 | .ok x => same x.speed ⟨1,1,by decide,by decide⟩
def phaseCheck : Bool := match gravitationalWaveTrace with
 | .error _ => false
 | .ok x => match x.phaseTrace with
   | [] => false
   | h::tail => tail.all (fun q => same q h)
def quadrupoleCheck : Bool := match gravitationalWaveTrace with
 | .error _ => false
 | .ok x => decide (x.firstUnfrozenSecondDifferences=[12,18])
def witnesses : List Witness := [⟨"speed","Gravity wave speed is the One.",speedCheck⟩,⟨"phase","Eight One-speed ticks retain phase.",phaseCheck⟩,⟨"quadrupole","The first unfrozen drive has changing second differences.",quadrupoleCheck⟩]
theorem speedCheckPassed : speedCheck=true := by unfold speedCheck;rw [completeSourceRecord];rfl
theorem phaseCheckPassed : phaseCheck=true := by unfold phaseCheck;rw [completeSourceRecord];rfl
theorem quadrupoleCheckPassed : quadrupoleCheck=true := by unfold quadrupoleCheck;rw [completeSourceRecord];rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (speedCheck && phaseCheck && quadrupoleCheck && true)=true
 rw [speedCheckPassed,phaseCheckPassed,quadrupoleCheckPassed]
 rfl
end SFT.Physics.GravityWaveEntryWitnesses
