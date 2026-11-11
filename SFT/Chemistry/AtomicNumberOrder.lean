import SFT.Chemistry.ElementIdentity
import SFT.Mathematics.ExactTraceArithmetic
import SFT.Mathematics.CategoryIdentity
namespace SFT.Chemistry.AtomicNumberOrder
open ElementIdentity

def one (p : Proton) : Nucleus := ⟨p,[]⟩
def atomicNumber (a : Atom) : Nat := identity a

theorem singletonNumber (p : Proton) : count (one p) = 1 := rfl

theorem successorNumber (n : Nucleus) (p : Proton) : count (appendProton n p) = count n + 1 := by
 change (n.rest ++ [p]).length + 1 = (n.rest.length + 1) + 1
 rw [SFT.Foundation.CommonRefinement.appendLength]
 rfl

theorem successorStrict (n : Nucleus) (p : Proton) : count n < count (appendProton n p) := by
 rw [successorNumber]
 exact Nat.lt_succ_self _

theorem totalOrder (a b : Atom) : atomicNumber a ≤ atomicNumber b ∨ atomicNumber b ≤ atomicNumber a := Nat.le_total _ _

theorem antisymmetricOrder (a b : Atom) (ab : atomicNumber a ≤ atomicNumber b)
 (ba : atomicNumber b ≤ atomicNumber a) : sameElement a b := Nat.le_antisymm ab ba

theorem countClassEquivalence (a b : Atom) : atomicNumber a = atomicNumber b ↔
 (∀ member, classContains a member ↔ classContains b member) := by
 constructor
 · intro same member; exact equalRepresentatives a b same member
 · intro same
   exact ((same a).mp rfl).symm

theorem isotopeInvariant (a : Atom) (mass : Nat) (positive : 0 < mass) :
 atomicNumber (refineMass a mass positive) = atomicNumber a := rfl

theorem chargeInvariant (a : Atom) (electrons : List String) :
 atomicNumber (changeElectrons a electrons) = atomicNumber a := rfl

theorem nuclearTraceRetained (n : Nucleus) (p : Proton) :
 protons (appendProton n p) = protons n ++ [p] := rfl

theorem oldProtonsRetained (n : Nucleus) (p old : Proton) (held : old ∈ protons n) :
 old ∈ protons (appendProton n p) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft old (protons n) [p] held

inductive Generated : Nucleus → Prop where
 | base (p : Proton) : Generated (one p)
 | next {n : Nucleus} (prior : Generated n) (p : Proton) : Generated (appendProton n p)

theorem generatedSuffix (tail : List Proton) (n : Nucleus) (generated : Generated n) :
 Generated (⟨n.first,n.rest ++ tail⟩ : Nucleus) := by
 induction tail generalizing n with
 | nil => rw [SFT.Mathematics.CategoryIdentity.appendNil]; exact generated
 | cons p ps ih =>
   have rest := ih (appendProton n p) (.next generated p)
   change Generated ⟨n.first,(n.rest ++ [p]) ++ ps⟩ at rest
   rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative] at rest
   exact rest

theorem everyNucleusGenerated (n : Nucleus) : Generated n := by
 cases n with
 | mk first rest => exact generatedSuffix rest (one first) (.base first)

theorem uniqueCount (value : Nucleus → Nat)
 (base : ∀ p, value (one p) = 1)
 (step : ∀ n p, value (appendProton n p) = value n + 1)
 (n : Nucleus) : value n = count n := by
 have generated := everyNucleusGenerated n
 induction generated with
 | base p => exact base p
 | @next n generated p ih =>
   exact (step n p).trans ((congrArg (fun k => k+1) ih).trans (successorNumber n p).symm)

theorem noOffset (offset : Nat) (p : Proton) (base : count (one p) + offset = 1) : offset = 0 := by
 change 1 + offset = 1 + 0 at base
 rw [Nat.add_comm 1 offset] at base
 exact Nat.succ.inj base

theorem noMultiplier (factor : Nat) (p : Proton) (base : factor * count (one p) = 1) : factor = 1 := by
 change factor * 1 = 1 at base
 rw [Nat.mul_one] at base
 exact base

theorem equalNumberSameClass (a b : Atom) (same : atomicNumber a = atomicNumber b) : sameElement a b := same

theorem differentNumbersDifferentClasses (a b : Atom) (different : atomicNumber a ≠ atomicNumber b) : ¬ sameElement a b := different
end SFT.Chemistry.AtomicNumberOrder
