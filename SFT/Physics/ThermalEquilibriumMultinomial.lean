import SFT.Physics.ThermalEquilibriumPaired
namespace SFT.Physics.ThermalEquilibriumMultinomial
open ThermalEquilibriumResponse SFT.Foundation.FractionReduction
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000

-- Integer comparison of the factorial factors in the original multinomial_count.
-- target is an original positive dyadic population; count is a competing count.
private theorem factorialPositive (n : Nat) : 0<factorial n := by
 induction n with
 | zero => exact Nat.zero_lt_succ _
 | succ n ih => exact Nat.mul_pos (Nat.zero_lt_succ _) ih

private theorem powerAdd (a b c : Nat) : a^(b+c)=a^b*a^c := by
 induction c with
 | zero => rw [Nat.add_zero,Nat.pow_zero,Nat.mul_one]
 | succ c ih => rw [Nat.add_succ,Nat.pow_succ,ih,Nat.pow_succ,mulAssoc]

private theorem differenceWitness (a b : Nat) (h : a≤b) : ∃ d, b=a+d := by
 induction h with
 | refl => exact ⟨0,rfl⟩
 | step h ih =>
   obtain ⟨d,hd⟩ := ih
   exact ⟨d+1,congrArg Nat.succ hd⟩

private theorem factorialSegmentBound (start count ceiling : Nat) (bound : start+count≤ceiling) :
 factorial (start+count) ≤ factorial start * ceiling^count := by
 induction count with
 | zero => rw [Nat.add_zero,Nat.pow_zero,Nat.mul_one]; exact Nat.le_refl _
 | succ count ih =>
   have prior := ih (Nat.le_trans (Nat.le_succ _) bound)
   have step := Nat.le_trans (Nat.mul_le_mul_right (factorial (start+count)) bound)
     (Nat.mul_le_mul_left ceiling prior)
   rw [←mulAssoc ceiling (factorial start) (ceiling^count),Nat.mul_comm ceiling (factorial start),
     mulAssoc,Nat.mul_comm ceiling (ceiling^count)] at step
   rw [Nat.add_succ,Nat.pow_succ]
   exact step

private theorem belowTargetBound (target count : Nat) (below : count≤target) :
 factorial target * target^count ≤ factorial count * target^target := by
 obtain ⟨d,eq⟩ := differenceWitness count target below
 have segment := factorialSegmentBound count d target (eq ▸ Nat.le_refl target)
 have scaled := Nat.mul_le_mul_right (target^count) segment
 rw [←eq,mulAssoc,Nat.mul_comm (target^d) (target^count),←powerAdd,←eq] at scaled
 exact scaled

private theorem aboveTargetStep (target d : Nat) (positive : 0<target)
 (prior : factorial target * target^(target+d) ≤ factorial (target+d)*target^target) :
 factorial target * target^(target+(d+1)) < factorial (target+(d+1))*target^target := by
 have first := Nat.mul_le_mul_left target prior
 have second := Nat.mul_lt_mul_of_pos_right
   (Nat.lt_succ_of_le (Nat.le_add_right target d))
   (Nat.mul_pos (factorialPositive (target+d)) (Nat.pow_pos (n:=target) positive))
 have combined := Nat.lt_of_le_of_lt first second
 rw [←mulAssoc target (factorial target),Nat.mul_comm target (factorial target),mulAssoc,
   Nat.mul_comm target (target^(target+d))] at combined
 rw [Nat.add_succ,Nat.pow_succ]
 change factorial target * (target^(target+d)*target) <
  ((target+d+1)*factorial (target+d))*target^target
 rw [mulAssoc (target+d+1)]
 exact combined

private theorem aboveTargetBound (target d : Nat) (positive : 0<target) :
 factorial target * target^(target+d) ≤ factorial (target+d)*target^target := by
 induction d with
 | zero => rw [Nat.add_zero]; exact Nat.le_refl _
 | succ d ih => exact Nat.le_of_lt (aboveTargetStep target d positive ih)

theorem originalFactorialWeightBound (target count : Nat) (positive : 0<target) :
 factorial target * target^count ≤ factorial count * target^target := by
 cases Nat.le_total count target with
 | inl below => exact belowTargetBound target count below
 | inr above =>
   obtain ⟨d,eq⟩ := differenceWitness target count above
   rw [eq]
   exact aboveTargetBound target d positive

theorem originalExcessCountStrictBound (target count : Nat) (positive : 0<target) (excess : target<count) :
 factorial target * target^count < factorial count * target^target := by
 obtain ⟨d,eq⟩ := differenceWitness (target+1) count excess
 have same : count=target+(d+1) := eq.trans (Nat.add_right_comm target 1 d)
 rw [same]
 exact aboveTargetStep target d positive (aboveTargetBound target d positive)

-- Products of the original factorial denominators and dyadic powers.
def factorialProduct : List Nat → Nat
 | [] => 1
 | n::ns => factorial n * factorialProduct ns

def powerProduct : List Nat → List Nat → Nat
 | [], _ => 1
 | _::_, [] => 1
 | t::ts, c::cs => t^c * powerProduct ts cs

private theorem factorialProductPositive (counts : List Nat) : 0<factorialProduct counts := by
 induction counts with
 | nil => exact Nat.zero_lt_succ _
 | cons c cs ih => exact Nat.mul_pos (factorialPositive c) ih

private theorem powerProductPositive (targets counts : List Nat)
 (positive : ∀ t ∈ targets, 0<t) : 0<powerProduct targets counts := by
 induction targets generalizing counts with
 | nil => exact Nat.zero_lt_succ _
 | cons t ts ih =>
   cases counts with
   | nil => exact Nat.zero_lt_succ _
   | cons c cs =>
     exact Nat.mul_pos (Nat.pow_pos (positive t (.head ts)))
       (ih cs (fun u hu => positive u (.tail t hu)))

theorem originalProductBound (targets counts : List Nat)
 (sameLength : targets.length=counts.length) (positive : ∀ t ∈ targets, 0<t) :
 factorialProduct targets * powerProduct targets counts ≤
 factorialProduct counts * powerProduct targets targets := by
 induction targets generalizing counts with
 | nil => cases counts with
   | nil => exact Nat.le_refl _
   | cons c cs => cases sameLength
 | cons t ts ih =>
   cases counts with
   | nil => cases sameLength
   | cons c cs =>
     have tail := ih cs (Nat.succ.inj sameLength) (fun u hu => positive u (.tail t hu))
     change (factorial t*factorialProduct ts)*(t^c*powerProduct ts cs) ≤
       (factorial c*factorialProduct cs)*(t^t*powerProduct ts ts)
     rw [SFT.Foundation.PrimitiveMaps.mulInterchange (factorial t) (factorialProduct ts),
       SFT.Foundation.PrimitiveMaps.mulInterchange (factorial c) (factorialProduct cs)]
     exact Nat.le_trans
       (Nat.mul_le_mul_right _ (originalFactorialWeightBound t c (positive t (.head ts))))
       (Nat.mul_le_mul_left _ tail)

theorem originalExcessProductStrict (targets counts : List Nat)
 (sameLength : targets.length=counts.length) (positive : ∀ t ∈ targets, 0<t)
 (excess : ∃ pair, pair∈targets.zip counts ∧ pair.1<pair.2) :
 factorialProduct targets * powerProduct targets counts <
 factorialProduct counts * powerProduct targets targets := by
 induction targets generalizing counts with
 | nil => obtain ⟨pair,h,_⟩ := excess; cases h
 | cons t ts ih =>
   cases counts with
   | nil => cases sameLength
   | cons c cs =>
     have tailLength := Nat.succ.inj sameLength
     have tailPositive : ∀ u ∈ ts, 0<u := fun u hu => positive u (.tail t hu)
     change (factorial t*factorialProduct ts)*(t^c*powerProduct ts cs) <
       (factorial c*factorialProduct cs)*(t^t*powerProduct ts ts)
     rw [SFT.Foundation.PrimitiveMaps.mulInterchange (factorial t) (factorialProduct ts),
       SFT.Foundation.PrimitiveMaps.mulInterchange (factorial c) (factorialProduct cs)]
     obtain ⟨pair,member,bigger⟩ := excess
     cases member with
     | head =>
       have first := Nat.mul_lt_mul_of_pos_right (originalExcessCountStrictBound t c (positive t (.head ts)) bigger)
         (Nat.mul_pos (factorialProductPositive ts) (powerProductPositive ts cs tailPositive))
       exact Nat.lt_of_lt_of_le first (Nat.mul_le_mul_left _ (originalProductBound ts cs tailLength tailPositive))
     | tail _ later =>
       have first := Nat.mul_le_mul_right (factorialProduct ts*powerProduct ts cs)
         (originalFactorialWeightBound t c (positive t (.head ts)))
       exact Nat.lt_of_le_of_lt first (Nat.mul_lt_mul_of_pos_left (ih cs tailLength tailPositive ⟨pair,later,bigger⟩)
         (Nat.mul_pos (factorialPositive c) (Nat.pow_pos (positive t (.head ts)))))

private def population : List Nat → Nat
 | [] => 0
 | c::cs => c+population cs
private theorem populationFold (counts : List Nat) (acc : Nat) :
 counts.foldl Nat.add acc=acc+population counts := by
 induction counts generalizing acc with
 | nil => rfl
 | cons c cs ih =>
   change cs.foldl Nat.add (acc+c)=acc+(c+population cs)
   rw [ih,Nat.add_assoc]

private theorem sameOrExcess (targets counts : List Nat)
 (sameLength : targets.length=counts.length) (total : population targets≤population counts) :
 targets=counts ∨ ∃ pair, pair∈targets.zip counts ∧ pair.1<pair.2 := by
 induction targets generalizing counts with
 | nil => cases counts with
   | nil => exact Or.inl rfl
   | cons c cs => cases sameLength
 | cons t ts ih =>
   cases counts with
   | nil => cases sameLength
   | cons c cs =>
     cases Nat.lt_or_ge t c with
     | inl bigger => exact Or.inr ⟨(t,c),.head _,bigger⟩
     | inr smaller =>
       have tailBound : population ts≤population cs := by
         cases Nat.lt_or_ge (population cs) (population ts) with
         | inl less =>
           have lower := Nat.lt_of_le_of_lt (Nat.add_le_add_right smaller (population cs))
             (Nat.add_lt_add_left less t)
           exact False.elim (Nat.not_lt_of_ge total lower)
         | inr bound => exact bound
       cases ih cs (Nat.succ.inj sameLength) tailBound with
       | inr excess =>
         obtain ⟨pair,member,bigger⟩ := excess
         exact Or.inr ⟨pair,.tail (t,c) member,bigger⟩
       | inl same =>
         have reverse : t≤c := by
           rw [same] at total
           cases Nat.lt_or_ge c t with
           | inl less => exact False.elim (Nat.not_lt_of_ge total (Nat.add_lt_add_right less (population cs)))
           | inr bound => exact bound
         have head := Nat.le_antisymm reverse smaller
         exact Or.inl (by rw [head,same])

theorem originalEqualPopulationAlternative (targets counts : List Nat)
 (sameLength : targets.length=counts.length)
 (samePopulation : targets.foldl Nat.add 0=counts.foldl Nat.add 0) :
 targets=counts ∨ ∃ pair, pair∈targets.zip counts ∧ pair.1<pair.2 := by
 rw [populationFold,populationFold,Nat.zero_add,Nat.zero_add] at samePopulation
 exact sameOrExcess targets counts sameLength (samePopulation ▸ Nat.le_refl _)

theorem originalFixedPopulationDenominatorStrict (targets counts : List Nat)
 (sameLength : targets.length=counts.length) (positive : ∀ t ∈ targets, 0<t)
 (samePopulation : targets.foldl Nat.add 0=counts.foldl Nat.add 0)
 (samePower : powerProduct targets counts=powerProduct targets targets)
 (different : targets≠counts) : factorialProduct targets<factorialProduct counts := by
 have excess : ∃ pair, pair∈targets.zip counts ∧ pair.1<pair.2 := by
   cases originalEqualPopulationAlternative targets counts sameLength samePopulation with
   | inl same => exact False.elim (different same)
   | inr bigger => exact bigger
 have strict := originalExcessProductStrict targets counts sameLength positive excess
 rw [samePower] at strict
 cases Nat.lt_or_ge (factorialProduct targets) (factorialProduct counts) with
 | inl result => exact result
 | inr contrary => exact False.elim (Nat.not_lt_of_ge
    (Nat.mul_le_mul_right (powerProduct targets targets) contrary) strict)
end SFT.Physics.ThermalEquilibriumMultinomial
