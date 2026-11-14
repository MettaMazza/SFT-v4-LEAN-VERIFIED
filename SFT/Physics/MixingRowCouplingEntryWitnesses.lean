import SFT.Physics.MixingRowCoupling
namespace SFT.Physics.MixingRowCouplingEntryWitnesses
open MixingRowCoupling
structure Witness where
 name : String
 statement : String
 passed : Bool
def locksCheck : Bool := match interEntryCouplings with
 | .error _ => false
 | .ok result => result.quarkLock == LeptonIntervals.normalize 2 3 (by decide) && result.leptonLock == LeptonIntervals.normalize 1 2 (by decide)
def witnesses : List Witness := [⟨"locks","Both row residues return their exact locks.",locksCheck⟩]
theorem locksCheckPassed : locksCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MixingRowCouplingEntryWitnesses
