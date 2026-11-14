import SFT.Physics.SpacetimeAdmissibility
namespace SFT.Physics.WarpEntryWitnesses
open SpacetimeAdmissibility
structure Witness where
 name : String
 statement : String
 passed : Bool
def admissibleCheck : Bool := warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) true
def ledgerCheck : Bool := !warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,4,by decide,by decide⟩) false
def gainCheck : Bool := !warpAdmissible (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,2,by decide,by decide⟩) true
def witnesses : List Witness := [⟨"admissible","A closed equal positive redistribution passes.",admissibleCheck⟩,⟨"ledger-rejected","An incomplete return ledger fails.",ledgerCheck⟩,⟨"gain-rejected","An unequal destination fails.",gainCheck⟩]
theorem admissibleCheckPassed : admissibleCheck=true := rfl
theorem ledgerCheckPassed : ledgerCheck=true := rfl
theorem gainCheckPassed : gainCheck=true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed=true := by
 change (admissibleCheck && ledgerCheck && gainCheck && true)=true
 rw [admissibleCheckPassed,ledgerCheckPassed,gainCheckPassed]
 rfl
end SFT.Physics.WarpEntryWitnesses
