import SFT.Foundation.FoldSorted
import SFT.Mathematics.OptimizationSelection
namespace SFT.Chemistry.LimitingProgress
open SFT.Foundation.ExactPartCarrier SFT.Foundation.FractionReduction
open SFT.Foundation.FoldUniformOrder SFT.Foundation.FoldSorted
structure Required where
 value : Nat
 positive : 0 < value
structure Ratio where
 numerator : Nat
 denominator : Nat
 positiveNumerator : 0 < numerator
 positiveDenominator : 0 < denominator

def progress (amount : Part) (required : Required) : Ratio :=
 ⟨amount.numerator,amount.denominator*required.value,amount.positive,
 Nat.mul_pos (Nat.pos_of_ne_zero amount.denominatorNonzero) required.positive⟩
theorem progressThroughOne (amount : Part) (required : Required) : amount.numerator ≤ amount.denominator*required.value := by
 have bound : amount.denominator ≤ amount.denominator*required.value := by
  have h := Nat.mul_le_mul_left amount.denominator required.positive
  rw [Nat.mul_one] at h
  exact h
 exact Nat.le_trans amount.throughOne bound

def progressPart (amount : Part) (required : Required) : Part :=
 SFT.Foundation.ExactOperations.normalizePart amount.numerator (amount.denominator*required.value)
 amount.positive (progressThroughOne amount required)

theorem exactRatioOrder (a b : Part) (ra rb : Required) :
 strictlyLarger (progressPart b rb) (progressPart a ra) ↔
 a.numerator*(b.denominator*rb.value) < b.numerator*(a.denominator*ra.value) :=
 normalizedOrder _ _ _ _ a.positive (progressThroughOne a ra) b.positive (progressThroughOne b rb)

def below (a b : Ratio) : Prop := a.numerator*b.denominator ≤ b.numerator*a.denominator
instance (a b : Ratio) : Decidable (below a b) := inferInstanceAs (Decidable (_ ≤ _))
def same (a b : Ratio) : Bool := decide (a.numerator*b.denominator = b.numerator*a.denominator)

theorem belowRefl (a : Ratio) : below a a := Nat.le_refl _
theorem belowTrans (a b c : Ratio) (ab : below a b) (bc : below b c) : below a c := by
 have held : b.denominator*(a.numerator*c.denominator) ≤ b.denominator*(c.numerator*a.denominator) := by
  calc
   _ = c.denominator*(a.numerator*b.denominator) := rotateProduct _ _ _
   _ ≤ c.denominator*(b.numerator*a.denominator) := Nat.mul_le_mul_left _ ab
   _ = a.denominator*(b.numerator*c.denominator) := rotateProduct _ _ _
   _ ≤ a.denominator*(c.numerator*b.denominator) := Nat.mul_le_mul_left _ bc
   _ = _ := rotateProduct _ _ _
 apply Nat.le_of_not_gt
 intro contrary
 exact Nat.not_le_of_gt (Nat.mul_lt_mul_of_pos_left contrary b.positiveDenominator) held

def lesser (a b : Ratio) : Ratio := if below a b then a else b

theorem lesserBelowLeft (a b : Ratio) : below (lesser a b) a := by
 unfold lesser
 split
 next h => exact belowRefl a
 next h => exact Nat.le_of_lt (Nat.lt_of_not_ge h)
theorem lesserBelowRight (a b : Ratio) : below (lesser a b) b := by
 unfold lesser
 split
 next h => exact h
 next h => exact belowRefl b

def minimum (first : Ratio) : List Ratio → Ratio
 | [] => first
 | next::rest => lesser first (minimum next rest)

theorem minimumBelowHead (first : Ratio) (rest : List Ratio) : below (minimum first rest) first := by
 cases rest with
 | nil => exact belowRefl _
 | cons next rest => exact lesserBelowLeft _ _

theorem minimumBelowMember (first : Ratio) (rest : List Ratio) (row : Ratio) (held : row ∈ first::rest) :
 below (minimum first rest) row := by
 induction rest generalizing first with
 | nil => cases held with
   | head => exact belowRefl _
   | tail _ h => cases h
 | cons next rest ih =>
   cases held with
   | head => exact minimumBelowHead _ _
   | tail _ h => exact belowTrans _ _ _ (lesserBelowRight _ _) (ih next h)

theorem minimumMember (first : Ratio) (rest : List Ratio) : minimum first rest ∈ first::rest := by
 induction rest generalizing first with
 | nil => exact .head _
 | cons next rest ih =>
   change lesser first (minimum next rest) ∈ first::next::rest
   unfold lesser
   split
   next h => exact .head _
   next h => exact .tail _ (ih next)

theorem sameExactly (a b : Ratio) : same a b = true ↔ below a b ∧ below b a := by
 constructor
 · intro h
   have equal := of_decide_eq_true h
   exact ⟨Nat.le_of_eq equal,Nat.le_of_eq equal.symm⟩
 · intro h
   exact decide_eq_true (Nat.le_antisymm h.1 h.2)

def tiedPositions (target : Ratio) (start : Nat) : List Ratio → List Nat
 | [] => []
 | row::rest => if same row target then start::tiedPositions target (start+1) rest else tiedPositions target (start+1) rest

inductive At : Nat → List Ratio → Nat → Ratio → Prop where
 | head (start : Nat) (row : Ratio) (rest : List Ratio) : At start (row::rest) start row
 | tail {start position : Nat} {row first : Ratio} {rest : List Ratio} :
   At (start+1) rest position row → At start (first::rest) position row

theorem tiedPositionsExactly (target : Ratio) (start : Nat) (rows : List Ratio) (position : Nat) :
 position ∈ tiedPositions target start rows ↔ ∃ row, At start rows position row ∧ same row target = true := by
 induction rows generalizing start with
 | nil => constructor
          · intro h; cases h
          · intro ⟨row,h,_⟩; cases h
 | cons row rest ih =>
   change position ∈ (if same row target then start::tiedPositions target (start+1) rest else tiedPositions target (start+1) rest) ↔ _
   cases equal : same row target with
   | false =>
     constructor
     · intro h
       obtain ⟨next,location,same⟩ := (ih (start+1)).mp h
       exact ⟨next,.tail location,same⟩
     · intro ⟨next,location,same⟩
       cases location with
       | head => rw [equal] at same; cases same
       | tail location => exact (ih (start+1)).mpr ⟨next,location,same⟩
   | true =>
     constructor
     · intro h
       cases h with
       | head => exact ⟨row,.head _ _ _,equal⟩
       | tail _ h =>
         obtain ⟨next,location,same⟩ := (ih (start+1)).mp h
         exact ⟨next,.tail location,same⟩
     · intro ⟨next,location,same⟩
       cases location with
       | head => exact .head _
       | tail location => exact .tail _ ((ih (start+1)).mpr ⟨next,location,same⟩)

theorem atMember {start position : Nat} {rows : List Ratio} {row : Ratio} (location : At start rows position row) : row ∈ rows := by
 induction location with
 | head => exact .head _
 | tail location ih => exact .tail _ ih

theorem atPositive {start position : Nat} {rows : List Ratio} {row : Ratio} (location : At start rows position row)
 (positive : 0 < start) : 0 < position := by
 induction location with
 | head => exact positive
 | tail location ih => exact ih (Nat.zero_lt_succ _)

def limiting (first : Ratio) (rest : List Ratio) : List Nat := tiedPositions (minimum first rest) 1 (first::rest)

theorem limitingExactly (first : Ratio) (rest : List Ratio) (position : Nat) :
 position ∈ limiting first rest ↔ ∃ row, At 1 (first::rest) position row ∧ ∀ other ∈ first::rest, below row other := by
 constructor
 · intro h
   obtain ⟨row,location,tie⟩ := (tiedPositionsExactly _ _ _ _).mp h
   exact ⟨row,location,fun other held => belowTrans _ _ _ ((sameExactly _ _).mp tie).1 (minimumBelowMember _ _ _ held)⟩
 · intro ⟨row,location,least⟩
   apply (tiedPositionsExactly _ _ _ _).mpr
   exact ⟨row,location,(sameExactly _ _).mpr ⟨least _ (minimumMember _ _),minimumBelowMember _ _ _ (atMember location)⟩⟩

theorem limitingPositive (first : Ratio) (rest : List Ratio) (position : Nat) (held : position ∈ limiting first rest) : 0 < position := by
 obtain ⟨row,location,_⟩ := (limitingExactly _ _ _).mp held
 exact atPositive location (by decide)
def pairedProgress : List Part → List Required → List Ratio
 | [], _ => []
 | amount::amounts, requirements => match requirements with
   | [] => []
   | required::requirements => progress amount required :: pairedProgress amounts requirements

def limitingComponentPositions (amounts : List Part) (requirements : List Required) : Except String (List Nat) :=
 if amounts.isEmpty || decide (amounts.length ≠ requirements.length) then
  .error "limiting support requires paired positive amount and coefficient rows"
 else match pairedProgress amounts requirements with
 | [] => .error "limiting support requires paired positive amount and coefficient rows"
 | first::rest => .ok (limiting first rest)

theorem emptyRejected (requirements : List Required) : limitingComponentPositions [] requirements =
 .error "limiting support requires paired positive amount and coefficient rows" := rfl

theorem unequalLengthsRejected (amounts : List Part) (requirements : List Required)
 (unequal : amounts.length ≠ requirements.length) : limitingComponentPositions amounts requirements =
 .error "limiting support requires paired positive amount and coefficient rows" := by
 unfold limitingComponentPositions
 rw [decide_eq_true unequal]
 cases amounts <;> rfl

theorem pairedSuccess (amount : Part) (amounts : List Part) (required : Required) (requirements : List Required)
 (lengths : (amount::amounts).length = (required::requirements).length) :
 limitingComponentPositions (amount::amounts) (required::requirements) =
 .ok (limiting (progress amount required) (pairedProgress amounts requirements)) := by
 unfold limitingComponentPositions
 rw [decide_eq_false (fun h => h lengths)]
 rfl

theorem singletonBoundary (amount : Part) (required : Required) : limitingComponentPositions [amount] [required] = .ok [1] := by
 rw [pairedSuccess _ _ _ _ rfl]
 change Except.ok (if same (progress amount required) (progress amount required) then [1] else []) = _
 rw [(sameExactly _ _).mpr ⟨belowRefl _,belowRefl _⟩]
 rfl

theorem membershipHasPosition (rows : List Ratio) (row : Ratio) (held : row ∈ rows) (start : Nat) :
 ∃ position, At start rows position row := by
 induction rows generalizing start with
 | nil => cases held
 | cons first rest ih =>
   cases held with
   | head => exact ⟨start,.head _ _ _⟩
   | tail _ h =>
     obtain ⟨position,location⟩ := ih h (start+1)
     exact ⟨position,.tail location⟩

theorem limitingExists (first : Ratio) (rest : List Ratio) : ∃ position, position ∈ limiting first rest := by
 obtain ⟨position,location⟩ := membershipHasPosition (first::rest) _ (minimumMember first rest) 1
 exact ⟨position,(limitingExactly _ _ _).mpr ⟨minimum first rest,location,fun other held => minimumBelowMember _ _ _ held⟩⟩

theorem consumptionBound (extent : Ratio) (amount : Part) (required : Required) :
 below extent (progress amount required) ↔
 extent.numerator * (amount.denominator*required.value) ≤ amount.numerator*extent.denominator := Iff.rfl

theorem completeConsumption (extent : Ratio) (amount : Part) (required : Required)
 (tie : same (progress amount required) extent = true) :
 amount.numerator*extent.denominator = extent.numerator*(amount.denominator*required.value) := of_decide_eq_true tie

theorem unavailableRejected (extent : Ratio) (amount : Part) (required : Required)
 (exceeded : amount.numerator*extent.denominator < extent.numerator*(amount.denominator*required.value)) :
 ¬ below extent (progress amount required) := Nat.not_le_of_gt exceeded

theorem retainedExcess (extent : Ratio) (amount : Part) (required : Required)
 (remaining : extent.numerator*(amount.denominator*required.value) < amount.numerator*extent.denominator) :
 0 < amount.numerator*extent.denominator - extent.numerator*(amount.denominator*required.value) :=
 SFT.Foundation.ExactCast.subtractPositive _ _ remaining

theorem extendedLeastExactly (row new : Ratio) (rows : List Ratio) :
 (∀ other ∈ rows++[new], below row other) ↔ (∀ other ∈ rows, below row other) ∧ below row new := by
 constructor
 · intro all
   exact ⟨fun other held => all other (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held),
    all new (SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head _))⟩
 · intro ⟨prior,newBound⟩ other held
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases _ _ _ held with
   | inl old => exact prior other old
   | inr last =>
     cases last with
     | head => exact newBound
     | tail _ h => cases h
end SFT.Chemistry.LimitingProgress

#print axioms SFT.Chemistry.LimitingProgress.progress
#print axioms SFT.Chemistry.LimitingProgress.progressThroughOne
#print axioms SFT.Chemistry.LimitingProgress.progressPart
#print axioms SFT.Chemistry.LimitingProgress.exactRatioOrder
#print axioms SFT.Chemistry.LimitingProgress.below
#print axioms SFT.Chemistry.LimitingProgress.same
#print axioms SFT.Chemistry.LimitingProgress.belowRefl
#print axioms SFT.Chemistry.LimitingProgress.belowTrans
#print axioms SFT.Chemistry.LimitingProgress.lesser
#print axioms SFT.Chemistry.LimitingProgress.lesserBelowLeft
#print axioms SFT.Chemistry.LimitingProgress.lesserBelowRight
#print axioms SFT.Chemistry.LimitingProgress.minimum
#print axioms SFT.Chemistry.LimitingProgress.minimumBelowHead
#print axioms SFT.Chemistry.LimitingProgress.minimumBelowMember
#print axioms SFT.Chemistry.LimitingProgress.minimumMember
#print axioms SFT.Chemistry.LimitingProgress.sameExactly
#print axioms SFT.Chemistry.LimitingProgress.tiedPositions
#print axioms SFT.Chemistry.LimitingProgress.tiedPositionsExactly
#print axioms SFT.Chemistry.LimitingProgress.atMember
#print axioms SFT.Chemistry.LimitingProgress.atPositive
#print axioms SFT.Chemistry.LimitingProgress.limiting
#print axioms SFT.Chemistry.LimitingProgress.limitingExactly
#print axioms SFT.Chemistry.LimitingProgress.limitingPositive
#print axioms SFT.Chemistry.LimitingProgress.pairedProgress
#print axioms SFT.Chemistry.LimitingProgress.limitingComponentPositions
#print axioms SFT.Chemistry.LimitingProgress.emptyRejected
#print axioms SFT.Chemistry.LimitingProgress.unequalLengthsRejected
#print axioms SFT.Chemistry.LimitingProgress.pairedSuccess
#print axioms SFT.Chemistry.LimitingProgress.singletonBoundary
#print axioms SFT.Chemistry.LimitingProgress.membershipHasPosition
#print axioms SFT.Chemistry.LimitingProgress.limitingExists
#print axioms SFT.Chemistry.LimitingProgress.consumptionBound
#print axioms SFT.Chemistry.LimitingProgress.completeConsumption
#print axioms SFT.Chemistry.LimitingProgress.unavailableRejected
#print axioms SFT.Chemistry.LimitingProgress.retainedExcess
#print axioms SFT.Chemistry.LimitingProgress.extendedLeastExactly
