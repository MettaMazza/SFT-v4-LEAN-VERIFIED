import SFT.Physics.MixingCorrespondence
namespace SFT.Physics.MixingCorrespondenceEntryWitnesses
open MixingCorrespondence
structure Witness where
 name : String
 statement : String
 passed : Bool
def rowCheck : Bool := match mixingCorrespondence with
 | .error _ => false
 | .ok result => decide (result.leptonMatrix.headD []=originalLeptonMatrix.headD [])
def witnesses : List Witness := [⟨"lepton-row","The exact lepton first row is wide.",rowCheck⟩]
theorem rowCheckPassed : rowCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := rfl
end SFT.Physics.MixingCorrespondenceEntryWitnesses
