import SFT.Physics.ReggeDimensional
namespace SFT.Physics.ReggeDimensionalWitnesses
open ReggeDimensional
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match motionShare with | .error _ => false | .ok q => q == LeptonIntervals.normalize 3 5 (by decide)
theorem witness0Passed : witness0=true := rfl
def witness1 : Bool := match tubeSuccessorShare with | .error _ => false | .ok q => q == LeptonIntervals.normalize 6 5 (by decide)
theorem witness1Passed : witness1=true := rfl
def witness2 : Bool := (theoremCertificate (.count (.integer 64))).toOption.map (fun c=>c.firstFive) == some [LeptonIntervals.normalize 3 5 (by decide),LeptonIntervals.normalize 9 5 (by decide),LeptonIntervals.normalize 3 1 (by decide),LeptonIntervals.normalize 21 5 (by decide),LeptonIntervals.normalize 27 5 (by decide)]
theorem witness2Passed : witness2=true := rfl
def witness3 : Bool := match theoremCertificate (.count (.integer 64)) with | .error _ => false | .ok c => c.constantSuccessor && c.closedForm
theorem witness3Passed : witness3=true := rfl
def witnesses : List Witness := [⟨"motion","The admitted rotating motion share is exactly 3/5.",witness0⟩,⟨"successor","Two Fold hands force exact successor share 6/5.",witness1⟩,⟨"first-five","The first five carriers are generated without measurement.",witness2⟩,⟨"induction","The exact closed form and constant step hold at every registered witness depth.",witness3⟩]
end SFT.Physics.ReggeDimensionalWitnesses
