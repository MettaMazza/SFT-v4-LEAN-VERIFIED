import SFT.Chemistry.AffinityComparison
open SFT.Chemistry.AffinityComparison
namespace AffinityAdmissionBoundary589
-- Diagnostic of the translated constructor alone, not of full recurrence traces.
def first : Raw := ⟨"atom-a","atom-b",originalSupport,"atom-a"⟩
def second : Raw := ⟨"atom-a","atom-b",originalSupport,"atom-b"⟩
theorem firstAccepted : admit first=.ok first := rfl
theorem secondAccepted : admit second=.ok second := rfl
theorem sameCarrier : first.firstAtom=second.firstAtom ∧
 first.secondAtom=second.secondAtom ∧ first.sharedSupport=second.sharedSupport := ⟨rfl,rfl,rfl⟩
theorem differentPreference : first.preferredEndpoint≠second.preferredEndpoint := by decide
#print axioms firstAccepted
#print axioms secondAccepted
#print axioms sameCarrier
#print axioms differentPreference
end AffinityAdmissionBoundary589
