import SFT.Materials.QuasicrystalInflation
import SFT.Host.Canonical
namespace SFT.Materials.QuasicrystalInflation
open SFT.Host

def leastCandidateRejected : Bool := decide (1 ≠ 1 + 1)
def fixedPointCertificate : Canonical.Value := .object [
 ("recurrence",.text "(first,second)->(first+second,first)"),
 ("fixed_scale_equation",.text "p^2=p*q+q^2 for coprime positive wholes p,q"),
 ("coprime_divisibility",.text "q|p^2 and p|q^2 force p=q=1"),
 ("least_candidate",.array [.object [("value",.integer 1)],.object [("value",.integer 1)]]),
 ("least_candidate_rejected",.boolean leastCandidateRejected),
 ("positive_rational_fixed_scale",.object [("family",.text "existence"),("label",.text "structural-absence")])]
def substitutionWitness : Bool :=
 ((substitutionPopulations ⟨6,by decide⟩).map (fun row => (row.first.val,row.second.val)) ==
 [(1,1),(2,1),(3,2),(5,3),(8,5),(13,8)]) && leastCandidateRejected
theorem substitutionWitnessPassed : substitutionWitness = true := rfl
#print axioms leastCandidateRejected
#print axioms fixedPointCertificate
#print axioms substitutionWitness
#print axioms substitutionWitnessPassed
end SFT.Materials.QuasicrystalInflation
