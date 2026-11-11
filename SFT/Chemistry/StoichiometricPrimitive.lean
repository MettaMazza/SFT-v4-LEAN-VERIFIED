import SFT.Chemistry.ReactionTotals
namespace SFT.Chemistry.StoichiometricPrimitive
open ReactionTotals SFT.Foundation.FractionReduction

def commonFactor : Nat → List Species → Nat
 | common, [] => common
 | common, species :: rest => commonFactor (Nat.gcd common species.coefficient) rest

def primitiveCoefficients (word : List Species) : Bool :=
 if !reactionIsBalanced word then false else
 match word with
 | [] => false
 | first :: rest => decide (commonFactor first.coefficient rest = 1)

theorem commonDivisorRetained (factor first : Nat) (rest : List Species)
 (initial : factor ∣ first) (held : ∀ species ∈ rest, factor ∣ species.coefficient) :
 factor ∣ commonFactor first rest := by
 induction rest generalizing first with
 | nil => exact initial
 | cons species rest ih =>
   exact ih _ (commonDivisorDividesGcd _ _ _ initial (held species (.head _)))
     (fun next member => held next (.tail _ member))

theorem primitiveRequiresBalance (word : List Species) (admitted : primitiveCoefficients word = true) :
 reactionIsBalanced word = true := by
 unfold primitiveCoefficients at admitted
 cases balance : reactionIsBalanced word with
 | false => rw [balance] at admitted; cases admitted
 | true => rfl

theorem primitiveExactly (first : Species) (rest : List Species) (balanced : reactionIsBalanced (first::rest)=true) :
 primitiveCoefficients (first::rest)=true ↔ commonFactor first.coefficient rest = 1 := by
 unfold primitiveCoefficients
 rw [balanced]
 exact ⟨of_decide_eq_true,decide_eq_true⟩
theorem commonFactorPositive (first : Nat) (positive : 0 < first) (rest : List Species) :
 0 < commonFactor first rest := by
 induction rest generalizing first with
 | nil => exact positive
 | cons species rest ih => exact ih _ (gcdPositive _ _ species.positive)

theorem dividesTransitive (a b c : Nat) (ab : a ∣ b) (bc : b ∣ c) : a ∣ c := by
 obtain ⟨x,hx⟩ := ab
 obtain ⟨y,hy⟩ := bc
 exact ⟨x*y,hy.trans ((congrArg (fun n => n*y) hx).trans (mulAssoc a x y))⟩

theorem commonFactorDivides (first : Nat) (rest : List Species) :
 commonFactor first rest ∣ first ∧ ∀ species ∈ rest, commonFactor first rest ∣ species.coefficient := by
 induction rest generalizing first with
 | nil => exact ⟨⟨1,(Nat.mul_one _).symm⟩,fun species h => nomatch h⟩
 | cons species rest ih =>
   have tail := ih (Nat.gcd first species.coefficient)
   have pair := gcdDivides first species.coefficient
   refine ⟨dividesTransitive _ _ _ tail.1 pair.1,?_⟩
   intro next held
   cases held with
   | head => exact dividesTransitive _ _ _ tail.1 pair.2
   | tail _ h => exact tail.2 next h

def scaleSpecies (scale : Nat) (positive : 0 < scale) (species : Species) : Species :=
 {species with coefficient := scale*species.coefficient,positive := Nat.mul_pos positive species.positive}

def scaleWord (scale : Nat) (positive : 0 < scale) (word : List Species) := word.map (scaleSpecies scale positive)

theorem commonFactorScale (scale : Nat) (positive : 0 < scale) (first : Nat) (rest : List Species) :
 commonFactor (scale*first) (scaleWord scale positive rest) = scale*commonFactor first rest := by
 induction rest generalizing first with
 | nil => rfl
 | cons species rest ih =>
   change commonFactor (Nat.gcd (scale*first) (scale*species.coefficient)) (scaleWord scale positive rest) = _
   rw [SFT.Foundation.ExactValueIdentity.gcdScale _ _ _ positive]
   exact ih _

theorem scaledTotals (scale : Nat) (positive : 0 < scale) (side : Side) (label : String) (word : List Species) :
 total side label (scaleWord scale positive word) = scale*total side label word := by
 induction word with
 | nil => exact (Nat.mul_zero _).symm
 | cons species rest ih =>
   change (if species.side=side then (scale*species.coefficient)*elementTotal label species.elements else 0) +
     total side label (scaleWord scale positive rest) = scale*((if species.side=side then species.coefficient*elementTotal label species.elements else 0)+total side label rest)
   rw [ih,Nat.mul_add]
   cases same : species.side <;> cases side <;> first
   | exact congrArg (fun n => n + scale * total _ label rest) (mulAssoc _ _ _)
   | exact congrArg (fun n => n + scale * total _ label rest) (Nat.mul_zero _).symm

theorem scalePreservesClosed (scale : Nat) (positive : 0 < scale) (word : List Species) (balance : closed word) :
 closed (scaleWord scale positive word) := by
 intro label
 rw [scaledTotals,scaledTotals,balance label]

theorem primitiveScaleForced (scale : Nat) (positive : 0 < scale) (first : Species) (rest : List Species)
 (primitive : commonFactor first.coefficient rest = 1)
 (scaledPrimitive : commonFactor (scaleSpecies scale positive first).coefficient (scaleWord scale positive rest) = 1) : scale = 1 := by
 change commonFactor (scale*first.coefficient) (scaleWord scale positive rest) = 1 at scaledPrimitive
 rw [commonFactorScale,primitive,Nat.mul_one] at scaledPrimitive
 exact scaledPrimitive

theorem everyCommonFactorOfPrimitiveIsOne (first : Species) (rest : List Species)
 (primitive : commonFactor first.coefficient rest = 1) (factor : Nat)
 (head : factor ∣ first.coefficient) (tail : ∀ species ∈ rest, factor ∣ species.coefficient) : factor = 1 := by
 have divides := commonDivisorRetained factor first.coefficient rest head tail
 rw [primitive] at divides
 obtain ⟨multiple,equal⟩ := divides
 exact factorOfOne factor multiple equal.symm

theorem scalingRetainsFormula (scale : Nat) (positive : 0 < scale) (species : Species) :
 (scaleSpecies scale positive species).elements = species.elements ∧
 (scaleSpecies scale positive species).identity = species.identity ∧
 (scaleSpecies scale positive species).side = species.side := ⟨rfl,rfl,rfl⟩
def divideSpecies (factor : Nat) (positive : 0 < factor) (species : Species)
 (divides : factor ∣ species.coefficient) : Species :=
 {species with coefficient := species.coefficient/factor, positive := quotientPositive _ _ species.positive positive divides}

theorem divisionReconstructs (factor : Nat) (positive : 0 < factor) (species : Species)
 (divides : factor ∣ species.coefficient) : scaleSpecies factor positive (divideSpecies factor positive species divides) = species := by
 cases species with
 | mk side identity coefficient nonzero elements nonempty nonblank distinct =>
   unfold scaleSpecies divideSpecies
   congr 1
   exact (quotientFactor coefficient factor positive divides).symm

def divideWord (factor : Nat) (positive : 0 < factor) :
 (word : List Species) → (∀ species ∈ word, factor ∣ species.coefficient) → List Species
 | [], _ => []
 | first::rest, divides => divideSpecies factor positive first (divides first (.head _)) ::
   divideWord factor positive rest (fun species held => divides species (.tail _ held))

theorem wordDivisionReconstructs (factor : Nat) (positive : 0 < factor) (word : List Species)
 (divides : ∀ species ∈ word, factor ∣ species.coefficient) :
 scaleWord factor positive (divideWord factor positive word divides) = word := by
 induction word with
 | nil => rfl
 | cons first rest ih =>
   change scaleSpecies factor positive (divideSpecies factor positive first (divides first (.head _))) ::
     scaleWord factor positive (divideWord factor positive rest _) = first::rest
   rw [divisionReconstructs,ih]

theorem dividedFactorScales (factor : Nat) (positive : 0 < factor) (first : Species) (rest : List Species)
 (head : factor ∣ first.coefficient) (tail : ∀ species ∈ rest, factor ∣ species.coefficient) :
 commonFactor first.coefficient rest = factor * commonFactor (first.coefficient/factor) (divideWord factor positive rest tail) := by
 have scaled := commonFactorScale factor positive (first.coefficient/factor) (divideWord factor positive rest tail)
 rw [wordDivisionReconstructs,← quotientFactor first.coefficient factor positive head] at scaled
 exact scaled

theorem divideByGreatestIsPrimitive (first : Species) (rest : List Species) :
 commonFactor (first.coefficient / commonFactor first.coefficient rest)
 (divideWord (commonFactor first.coefficient rest) (commonFactorPositive _ first.positive rest) rest (commonFactorDivides _ _).2) = 1 := by
 let factor := commonFactor first.coefficient rest
 have positive := commonFactorPositive first.coefficient first.positive rest
 have divides := commonFactorDivides first.coefficient rest
 have scaled := dividedFactorScales factor positive first rest divides.1 divides.2
 apply Nat.eq_of_mul_eq_mul_left positive
 exact scaled.symm.trans (Nat.mul_one factor).symm

theorem divisionPreservesClosed (factor : Nat) (positive : 0 < factor) (word : List Species)
 (divides : ∀ species ∈ word, factor ∣ species.coefficient) (balance : closed word) :
 closed (divideWord factor positive word divides) := by
 intro label
 apply Nat.eq_of_mul_eq_mul_left positive
 rw [← scaledTotals factor positive,← scaledTotals factor positive,wordDivisionReconstructs]
 exact balance label

theorem scaledQuotient (scale factor n : Nat) (hs : 0 < scale) (hf : 0 < factor)
 (divides : factor ∣ n) : (scale*n)/(scale*factor) = n/factor := by
 have scaledDivides : scale*factor ∣ scale*n := by
  obtain ⟨k,hk⟩ := divides
  exact ⟨k,(congrArg (fun x => scale*x) hk).trans (mulAssoc scale factor k).symm⟩
 apply Nat.eq_of_mul_eq_mul_left (Nat.mul_pos hs hf)
 exact (quotientFactor (scale*n) (scale*factor) (Nat.mul_pos hs hf) scaledDivides).symm.trans
   ((congrArg (fun x => scale*x) (quotientFactor n factor hf divides)).trans (mulAssoc scale factor (n/factor)).symm)

theorem commonRescalingSamePrimitiveCoefficient (scale : Nat) (hs : 0 < scale)
 (first : Species) (rest : List Species) (n : Nat) (divides : commonFactor first.coefficient rest ∣ n) :
 (scale*n) / commonFactor (scale*first.coefficient) (scaleWord scale hs rest) =
 n / commonFactor first.coefficient rest := by
 rw [commonFactorScale]
 exact scaledQuotient _ _ _ hs (commonFactorPositive _ first.positive rest) divides

theorem divisionRetainsSides (factor : Nat) (positive : 0 < factor) (word : List Species)
 (divides : ∀ species ∈ word, factor ∣ species.coefficient) (side : Side) :
 hasSide side (divideWord factor positive word divides) = hasSide side word := by
 induction word with
 | nil => rfl
 | cons first rest ih =>
   change (decide (first.side=side) || hasSide side (divideWord factor positive rest _)) =
     (decide (first.side=side) || hasSide side rest)
   rw [ih]

theorem divisionRetainsNonempty (factor : Nat) (positive : 0 < factor) (word : List Species)
 (divides : ∀ species ∈ word, factor ∣ species.coefficient) :
 (divideWord factor positive word divides).isEmpty = word.isEmpty := by
 cases word <;> rfl

theorem divisionPreservesBalance (factor : Nat) (positive : 0 < factor) (word : List Species)
 (divides : ∀ species ∈ word, factor ∣ species.coefficient) (balance : reactionIsBalanced word = true) :
 reactionIsBalanced (divideWord factor positive word divides) = true := by
 have original := (balanceExactly word).mp balance
 apply (balanceExactly _).mpr
 exact ⟨(divisionRetainsNonempty _ _ _ _).trans original.1,
   (divisionRetainsSides _ _ _ _ _).trans original.2.1,
   (divisionRetainsSides _ _ _ _ _).trans original.2.2.1,
   divisionPreservesClosed _ _ _ _ original.2.2.2⟩

def primitiveReduction (first : Species) (rest : List Species) : List Species :=
 divideWord (commonFactor first.coefficient rest) (commonFactorPositive _ first.positive rest) (first::rest)
 (fun species held => by
  cases held with
  | head => exact (commonFactorDivides _ _).1
  | tail _ h => exact (commonFactorDivides _ _).2 species h)

theorem reductionAdmitted (first : Species) (rest : List Species)
 (balance : reactionIsBalanced (first::rest)=true) : primitiveCoefficients (primitiveReduction first rest)=true := by
 have preserved := divisionPreservesBalance (commonFactor first.coefficient rest)
   (commonFactorPositive _ first.positive rest) (first::rest)
   (fun species held => by
    cases held with
    | head => exact (commonFactorDivides _ _).1
    | tail _ h => exact (commonFactorDivides _ _).2 species h) balance
 apply (primitiveExactly _ _ preserved).mpr
 exact divideByGreatestIsPrimitive first rest

theorem unbalancedExtensionRejected (word : List Species) (species : Species)
 (unbalanced : reactionIsBalanced (word++[species]) = false) : primitiveCoefficients (word++[species]) = false := by
 unfold primitiveCoefficients
 rw [unbalanced]
 rfl
end SFT.Chemistry.StoichiometricPrimitive
