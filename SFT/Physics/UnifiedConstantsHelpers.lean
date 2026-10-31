import SFT.Physics.AlphaCovers
namespace SFT.Physics.UnifiedConstantsHelpers
open GeneratorOperations

def positivePredecessor (value : CountInput) : Except String Nat :=
 (GeneratorOperations.positivePredecessor value).mapError (fun _ => "positive predecessor requires a count beyond the One")
def positivePower (base exponent : CountInput) : Except String Nat :=
 (AlphaCovers.positivePower base exponent).mapError (fun _ => "positive power requires positive generated counts")

-- This source's cover guard does not reject Boolean True as the carrier.
-- Its separately supplied binary argument must exceed One.
def integerValue : CountInput → Option Nat
 | .integer (.ofNat n) => some n
 | .integer (.negSucc _) => none
 | .boolean false => some 0
 | .boolean true => some 1

inductive CoverRun (carrier binary : Nat) : Nat → Nat → Nat → Prop where
 | stop (depth support : Nat) (covered : carrier≤support) : CoverRun carrier binary depth support depth
 | step (depth support result : Nat) (notCovered : support<carrier)
   (tail : CoverRun carrier binary (depth+1) (support*binary) result) : CoverRun carrier binary depth support result

theorem successorBudget (carrier binary support fuel : Nat) (binaryBound : 2≤binary)
 (positive : 0<support) (bound : carrier≤support+(fuel+1)) : carrier≤support*binary+fuel :=
 Nat.le_trans (AlphaCovers.successorBudget carrier support fuel positive bound)
  (Nat.add_le_add_right (Nat.mul_le_mul_left support binaryBound) fuel)

def coverBounded (carrier binary : Nat) (binaryBound : 2≤binary) :
 (fuel depth support : Nat) → (positive : 0<support) → (bound : carrier≤support+fuel) →
 {result : Nat // CoverRun carrier binary depth support result}
 | 0,depth,support,_,bound => ⟨depth,.stop depth support (by rw [Nat.add_zero] at bound; exact bound)⟩
 | fuel+1,depth,support,positive,bound =>
  if smaller : support<carrier then
   let next := coverBounded carrier binary binaryBound fuel (depth+1) (support*binary)
    (Nat.mul_pos positive (Nat.lt_of_lt_of_le (by decide) binaryBound))
    (successorBudget carrier binary support fuel binaryBound positive bound)
   ⟨next.val,.step depth support next.val smaller next.property⟩
  else ⟨depth,.stop depth support (Nat.le_of_not_gt smaller)⟩

def minimalBinaryCover (carrier binary : CountInput) : Except String Nat :=
 match integerValue carrier with
 | none => .error "cover requires positive carrier and nonidentity fibre count"
 | some c => match integerValue binary with
  | none => .error "cover requires positive carrier and nonidentity fibre count"
  | some b =>
   if hc : 0<c then
    if hb : 1<b then .ok (coverBounded c b hb c 1 b (Nat.lt_trans (by decide) hb) (Nat.le_add_left c b)).val
    else .error "cover requires positive carrier and nonidentity fibre count"
   else .error "cover requires positive carrier and nonidentity fibre count"

theorem runDepthLower (carrier binary depth support result : Nat)
 (run : CoverRun carrier binary depth support result) : depth≤result := by
 induction run with
 | stop => exact Nat.le_refl _
 | step depth support result smaller tail ih => exact Nat.le_trans (Nat.le_succ _) ih

theorem runCovers (carrier binary depth support result : Nat)
 (run : CoverRun carrier binary depth support result) (power : support=binary^depth) : carrier≤binary^result := by
 induction run with
 | stop depth support covered => exact power ▸ covered
 | step depth support result smaller tail ih =>
  apply ih
  rw [power,Nat.pow_succ]

theorem runLeast (carrier binary depth support result : Nat)
 (run : CoverRun carrier binary depth support result) (power : support=binary^depth)
 (earlier : ∀ k,0<k → k<depth → binary^k<carrier) :
 ∀ k,0<k → k<result → binary^k<carrier := by
 induction run with
 | stop => exact earlier
 | step depth support result smaller tail ih =>
  apply ih
  · rw [power,Nat.pow_succ]
  · intro k positive below
    cases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ below) with
    | inl h => exact earlier k positive h
    | inr h => exact h ▸ (power ▸ smaller)

theorem arbitraryBinaryCover (carrier binary : Nat) (bound : 2≤binary) :
 let depth := (coverBounded carrier binary bound carrier 1 binary (Nat.lt_of_lt_of_le (by decide) bound) (Nat.le_add_left carrier binary)).val
 0<depth ∧ carrier≤binary^depth ∧ ∀ k,0<k → k<depth → binary^k<carrier := by
 let run := (coverBounded carrier binary bound carrier 1 binary (Nat.lt_of_lt_of_le (by decide) bound) (Nat.le_add_left carrier binary)).property
 refine ⟨runDepthLower _ _ _ _ _ run,runCovers _ _ _ _ _ run (show binary^1=binary from Nat.one_mul binary).symm,?_⟩
 apply runLeast _ _ _ _ _ run (show binary^1=binary from Nat.one_mul binary).symm
 intro k positive below
 exact False.elim (Nat.not_lt_of_ge positive below)

theorem predecessorEveryAdmittedCount (n : Nat) : positivePredecessor (.integer (.ofNat (n+2)))=.ok (n+1) := rfl

theorem powerEveryAdmittedPair (b e : Nat) : positivePower (.integer (.ofNat (b+1))) (.integer (.ofNat (e+1)))=.ok ((b+1)^(e+1)) := by
 unfold positivePower
 rw [AlphaCovers.positivePowerValue]
 rfl

theorem originalCover : minimalBinaryCover (.integer 27) (.integer 2)=.ok 5 := rfl

theorem nonbinaryArgumentRetained : minimalBinaryCover (.integer 27) (.integer 3)=.ok 3 := rfl

theorem booleanCarrierAccepted : minimalBinaryCover (.boolean true) (.integer 2)=.ok 1 := rfl

theorem booleanBinaryRejected (b : Bool) : minimalBinaryCover (.integer 27) (.boolean b)=
 .error "cover requires positive carrier and nonidentity fibre count" := by cases b <;> rfl
end SFT.Physics.UnifiedConstantsHelpers
