import SFT.Physics.SpacetimeAdmissibility
namespace SFT.Physics.WormholeEntryWitnesses
open SpacetimeAdmissibility
structure Witness where
 name : String
 statement : String
 passed : Bool
def admissibleCheck : Bool := wormholeAdmissible (.fraction ⟨1,4,by decide,by decide⟩) true true
def remoteCheck : Bool := !wormholeAdmissible (.fraction ⟨1,4,by decide,by decide⟩) false true
def witnesses : List Witness := [⟨"admissible","A completely generated positive link passes the formal boundary.",admissibleCheck⟩,⟨"remote-rejected","An ungenerated remote link fails.",remoteCheck⟩]
theorem admissibleCheckPassed : admissibleCheck=true := rfl
theorem remoteCheckPassed : remoteCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (admissibleCheck && remoteCheck && true)=true
 rw [admissibleCheckPassed,remoteCheckPassed]
 rfl
end SFT.Physics.WormholeEntryWitnesses
