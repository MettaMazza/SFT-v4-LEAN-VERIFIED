import SFT.Physics.FizeauWitnesses
namespace SFT.Physics.FizeauWitnesses
open VelocityComposition VelocityCompositionWitnesses
theorem formalUniquePassed : formalUnique=true := rfl
theorem formalClosurePassed : formalClosure=true := by
 have h := closureAndAssociativityPassed
 cases hc : theoremCertificate with
 | error e =>
  unfold closureAndAssociativity at h
  rw [hc] at h
  cases h
 | ok c =>
  unfold closureAndAssociativity at h
  rw [hc] at h
  unfold formalClosure
  rw [hc]
  change (c.closure && c.strictSublimit && c.associativity)=true at h
  change (c.closure && c.associativity)=true
  cases h1 : c.closure <;> cases h2 : c.strictSublimit <;> cases h3 : c.associativity <;>
   rw [h1,h2,h3] at h <;> cases h <;> rfl
theorem formalLimitPassed : formalLimit=true := by
 have h := typedRestAndLimitPassed
 cases hc : theoremCertificate with
 | error e =>
  unfold typedRestAndLimit at h
  rw [hc] at h
  cases h
 | ok c =>
  unfold typedRestAndLimit at h
  rw [hc] at h
  unfold formalLimit
  rw [hc]
  change (c.limitingSpeedAbsorbing && c.typedRestIdentity)=true
  change (c.typedRestIdentity && c.limitingSpeedAbsorbing)=true at h
  rw [Bool.and_comm]
  exact h
theorem allWitnessesPassed : witnesses.all Witness.passed=true := by
 change (formalUnique && (formalClosure && (formalLimit && true)))=true
 rw [formalUniquePassed,formalClosurePassed,formalLimitPassed]
 rfl
end SFT.Physics.FizeauWitnesses
