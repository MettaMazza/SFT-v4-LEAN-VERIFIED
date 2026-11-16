import SFT.Physics.StrongCPActions
namespace SFT.Physics.StrongCPComposition
open StrongCPActions
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- The original generated mediator signatures, with their actual endpoint types.
def signatures : List (Nat × Nat × Nat) := sectorActionSignatures.toOption.getD []
theorem allGeneratedPreserve : signatures.all (fun (s,t,_)=>s==t)=true := rfl
theorem generatedPreserves (s t cell : Nat) (member : (s,t,cell)∈signatures) : s=t := by
 have extract : ∀ (xs : List (Nat × Nat × Nat)), xs.all (fun (a,b,_)=>a==b)=true → (s,t,cell)∈xs → s=t := by
  intro xs
  induction xs with
  | nil => intro _ member; cases member
  | cons x xs ih =>
   intro all member
   have split : ∀ (a b : Bool), (a && b)=true → a=true ∧ b=true := by
    intro a b h
    cases a <;> cases b <;> cases h
    exact ⟨rfl,rfl⟩
   have pair := split _ _ all
   cases member with
   | head => exact Nat.eq_of_beq_eq_true pair.1
   | tail _ member => exact ih pair.2 member
 exact extract signatures allGeneratedPreserve member
-- V3 SPEC.induction_base/induction_step: finite paths composed only of generated actions.
inductive Path : Nat → Nat → Type where
 | base (sector : Nat) : Path sector sector
 | successor {start current next : Nat} (prior : Path start current) (cell : Nat)
   (generated : (current,next,cell)∈signatures) : Path start next
theorem everyFiniteComposition {start finish : Nat} (path : Path start finish) : start=finish := by
 induction path with
 | base => rfl
 | successor prior cell generated ih => exact ih.trans (generatedPreserves _ _ cell generated)
theorem noColourToBinary (path : Path 3 2) : False := by
 have h := everyFiniteComposition path
 contradiction
#print axioms signatures
#print axioms allGeneratedPreserve
#print axioms generatedPreserves
#print axioms everyFiniteComposition
#print axioms noColourToBinary
end SFT.Physics.StrongCPComposition
