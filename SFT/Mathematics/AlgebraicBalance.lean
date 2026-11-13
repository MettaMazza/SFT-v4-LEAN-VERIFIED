import SFT.Mathematics.ExactRatioRelations
import SFT.Physics.LeptonIntervals
namespace SFT.Mathematics.AlgebraicBalance
open SFT.Foundation.ExactOperations
open SFT.Physics.LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

-- lineage_laws.py ALGEBRAIC_BALANCE: each side has positive coefficients;
-- absent terms are omitted, not represented by signed coefficients.
def positiveAdd (a b : PositiveFraction) : PositiveFraction :=
 normalizePositive (a.numerator*b.denominator+b.numerator*a.denominator)
  (a.denominator*b.denominator)
  (Nat.add_pos_left (Nat.mul_pos a.positive (Nat.pos_of_ne_zero b.denominatorNonzero)) _)
  (Nat.mul_pos (Nat.pos_of_ne_zero a.denominatorNonzero) (Nat.pos_of_ne_zero b.denominatorNonzero))

def positivePower (x : PositiveFraction) : Nat → PositiveFraction
 | 0 => normalizePositive 1 1 (by decide) (by decide)
 | n+1 => ExactRatioRelations.compose (positivePower x n) x

structure Term where
 coefficient : PositiveFraction
 exponent : Nat

structure Polynomial where
 first : Term
 rest : List Term

def terms (p : Polynomial) := p.first::p.rest

def termValue (t : Term) (x : PositiveFraction) := ExactRatioRelations.compose t.coefficient (positivePower x t.exponent)

def evaluate (p : Polynomial) (x : PositiveFraction) : PositiveFraction :=
 p.rest.foldl (fun total t => positiveAdd total (termValue t x)) (termValue p.first x)

def evaluationTrace (p : Polynomial) (x : PositiveFraction) := (terms p).map (fun t => (t,termValue t x))

theorem everyTermRetained (p : Polynomial) (x : PositiveFraction) :
 (evaluationTrace p x).map Prod.fst = terms p := by
 unfold evaluationTrace
 generalize terms p = ts
 induction ts with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons h) ih

theorem evaluationPositive (p : Polynomial) (x : PositiveFraction) : 0 < (evaluate p x).numerator :=
 (evaluate p x).positive

structure Sides where
 left : Polynomial
 right : Polynomial

def sideOrder (p : Sides) (x : PositiveFraction) : Ordering :=
 let a := evaluate p.left x
 let b := evaluate p.right x
 compare (a.numerator*b.denominator) (b.numerator*a.denominator)

def positiveMidpoint (a b : PositiveFraction) : PositiveFraction :=
 ExactRatioRelations.compose (positiveAdd a b) (normalizePositive 1 2 (by decide) (by decide))

def opposite (a b : Ordering) : Prop :=
 match a with
 | .lt => match b with | .lt => False | .eq => False | .gt => True
 | .eq => False
 | .gt => match b with | .lt => True | .eq => False | .gt => False

structure Bracket where
 lower : PositiveFraction
 upper : PositiveFraction

def orderSwap (p : Sides) (b : Bracket) := opposite (sideOrder p b.lower) (sideOrder p b.upper)

inductive Refinement where
 | balance (point : PositiveFraction)
 | bracket (held : Bracket)

def refineBracket (p : Sides) (b : Bracket) : Refinement :=
 let middle := positiveMidpoint b.lower b.upper
 match sideOrder p middle with
 | .eq => .balance middle
 | .lt => match sideOrder p b.lower with | .lt => .bracket ⟨middle,b.upper⟩ | .eq => .bracket ⟨b.lower,middle⟩ | .gt => .bracket ⟨b.lower,middle⟩
 | .gt => match sideOrder p b.lower with | .gt => .bracket ⟨middle,b.upper⟩ | .lt => .bracket ⟨b.lower,middle⟩ | .eq => .bracket ⟨b.lower,middle⟩

def refinementValid (p : Sides) : Refinement → Prop
 | .balance x => sideOrder p x = .eq
 | .bracket b => orderSwap p b

theorem refinementRetainsBalanceOrSwap (p : Sides) (b : Bracket) (held : orderSwap p b) :
 refinementValid p (refineBracket p b) := by
 unfold refineBracket
 dsimp only
 cases hm : sideOrder p (positiveMidpoint b.lower b.upper) with
 | eq => exact hm
 | lt =>
   cases hl : sideOrder p b.lower <;> cases hu : sideOrder p b.upper
   all_goals try (change opposite _ _ at held; rw [hl,hu] at held; cases held)
   all_goals simp only [hl,refinementValid,orderSwap,hm,hu,opposite]
 | gt =>
   cases hl : sideOrder p b.lower <;> cases hu : sideOrder p b.upper
   all_goals try (change opposite _ _ at held; rw [hl,hu] at held; cases held)
   all_goals simp only [hl,refinementValid,orderSwap,hm,hu,opposite]

-- The original executable witness, including Python range's zero iterations
-- for a negative supplied count.
def squareTwoStep (bracket : Rat × Rat) : Rat × Rat :=
 let middle := midpoint bracket.1 bracket.2
 if (multiply middle middle).blt (normalize 2 1 (by decide)) then (middle,bracket.2)
 else (bracket.1,middle)

def squareTwoRounds : Nat → (Rat × Rat) → (Rat × Rat)
 | 0,b => b
 | n+1,b => squareTwoRounds n (squareTwoStep b)

def squareTwoBracket (rounds : Int) : Rat × Rat :=
 squareTwoRounds rounds.toNat (normalize 7 5 (by decide),normalize 3 2 (by decide))

theorem originalBase : squareTwoBracket 0 = (normalize 7 5 (by decide),normalize 3 2 (by decide)) := rfl

theorem negativeRoundsRetainBase (n : Nat) : squareTwoBracket (.negSucc n) = squareTwoBracket 0 := rfl

def squareBalance : Bool :=
 (multiply (normalize 7 5 (by decide)) (normalize 7 5 (by decide))).blt (normalize 2 1 (by decide)) &&
 (normalize 2 1 (by decide)).blt (multiply (normalize 3 2 (by decide)) (normalize 3 2 (by decide)))

theorem squareBalancePassed : squareBalance = true := rfl

def vietaSum := add (add (normalize 1 2 (by decide)) (normalize 1 3 (by decide))) (normalize 1 6 (by decide))
def vietaPairs := add (add (multiply (normalize 1 2 (by decide)) (normalize 1 3 (by decide)))
 (multiply (normalize 1 2 (by decide)) (normalize 1 6 (by decide))))
 (multiply (normalize 1 3 (by decide)) (normalize 1 6 (by decide)))

theorem exactVietaSum : vietaSum = normalize 1 1 (by decide) := rfl
theorem exactVietaPairs : vietaPairs = normalize 11 36 (by decide) := rfl

-- Every supplied bisection is retained with its exact input and output.
def squareTwoTrace : Nat → (Rat × Rat) → List ((Rat × Rat) × (Rat × Rat))
 | 0,_ => []
 | n+1,b => (b,squareTwoStep b)::squareTwoTrace n (squareTwoStep b)

theorem squareTwoTraceLength (n : Nat) (b : Rat × Rat) :
 (squareTwoTrace n b).length = n := by
 induction n generalizing b with
 | zero => rfl
 | succ n ih => exact congrArg Nat.succ (ih (squareTwoStep b))

theorem squareTwoTraceReplays (n : Nat) (b : Rat × Rat) :
 ∀ row, row ∈ squareTwoTrace n b → row.2 = squareTwoStep row.1 := by
 induction n generalizing b with
 | zero => intro row held; cases held
 | succ n ih =>
   intro row held
   cases held with
   | head => rfl
   | tail _ held => exact ih (squareTwoStep b) row held

def twentyRefinementWitness : Bool :=
 let b := squareTwoBracket 20
 (multiply b.1 b.1).blt (normalize 2 1 (by decide)) &&
 (normalize 2 1 (by decide)).blt (multiply b.2 b.2) &&
 (subtract b.2 b.1 == normalize 1 (10*2^20) (by decide))

theorem twentyRefinementsExact : twentyRefinementWitness = true := rfl


-- Finite reconstruction follows the original base/successor rule and
-- retains an exact balance point when a midpoint already balances.
def refineState (p : Sides) : Refinement → Refinement
 | .balance point => .balance point
 | .bracket b => refineBracket p b

def refinementTrace (p : Sides) : Nat → Refinement → List Refinement
 | 0,state => [state]
 | n+1,state => state::refinementTrace p n (refineState p state)

theorem refineStateValid (p : Sides) (state : Refinement)
 (valid : refinementValid p state) : refinementValid p (refineState p state) := by
 cases state with
 | balance point => exact valid
 | bracket b => exact refinementRetainsBalanceOrSwap p b valid

theorem everyRefinementValid (p : Sides) (n : Nat) (state : Refinement)
 (valid : refinementValid p state) :
 ∀ held, held ∈ refinementTrace p n state → refinementValid p held := by
 induction n generalizing state with
 | zero =>
   intro held present
   cases present with
   | head => exact valid
   | tail _ absent => cases absent
 | succ n ih =>
   intro held present
   cases present with
   | head => exact valid
   | tail _ present => exact ih (refineState p state) (refineStateValid p state valid) held present

theorem refinementTraceLength (p : Sides) (n : Nat) (state : Refinement) :
 (refinementTrace p n state).length = n+1 := by
 induction n generalizing state with
 | zero => rfl
 | succ n ih => exact congrArg Nat.succ (ih (refineState p state))


theorem positiveAddValue (a b : PositiveFraction) :
 (a.numerator*b.denominator+b.numerator*a.denominator)*(positiveAdd a b).denominator =
 (positiveAdd a b).numerator*(a.denominator*b.denominator) :=
 normalizedValuePreserved _ _ _ _

theorem midpointValue (a b : PositiveFraction) :
 (a.numerator*b.denominator+b.numerator*a.denominator)*(positiveMidpoint a b).denominator =
 (positiveMidpoint a b).numerator*(2*(a.denominator*b.denominator)) := by
 have h := ExactRatioRelations.composeRepresents (positiveAdd a b)
   (normalizePositive 1 2 (by decide) (by decide))
   (a.numerator*b.denominator+b.numerator*a.denominator) (a.denominator*b.denominator) 1 2
   (positiveAddValue a b) (normalizedValuePreserved 1 2 (by decide) (by decide))
 simp only [Nat.mul_one] at h
 rw [Nat.mul_comm (a.denominator*b.denominator) 2] at h
 exact h

theorem midpointInside (a b : PositiveFraction)
 (ordered : a.numerator*b.denominator < b.numerator*a.denominator) :
 a.numerator*(positiveMidpoint a b).denominator < (positiveMidpoint a b).numerator*a.denominator ∧
 (positiveMidpoint a b).numerator*b.denominator < b.numerator*(positiveMidpoint a b).denominator := by
 have leftComm (x y z : Nat) : x*(y*z)=y*(x*z) := by
   rw [← SFT.Foundation.FractionReduction.mulAssoc, Nat.mul_comm x y,
     SFT.Foundation.FractionReduction.mulAssoc]
 let m := positiveMidpoint a b
 have hm := midpointValue a b
 have md : 0 < m.denominator := Nat.pos_of_ne_zero m.denominatorNonzero
 have low := Nat.mul_lt_mul_of_pos_right (Nat.add_lt_add_left ordered (a.numerator*b.denominator)) md
 have high := Nat.mul_lt_mul_of_pos_right (Nat.add_lt_add_right ordered (b.numerator*a.denominator)) md
 constructor
 · cases Nat.lt_or_ge (a.numerator*m.denominator) (m.numerator*a.denominator) with
   | inl h => exact h
   | inr h =>
     have bad := Nat.mul_le_mul_left (2*b.denominator) h
     have lhs : (2*b.denominator)*(a.numerator*m.denominator) =
       (a.numerator*b.denominator+a.numerator*b.denominator)*m.denominator := by
       rw [← Nat.two_mul, SFT.Foundation.FractionReduction.mulAssoc, SFT.Foundation.FractionReduction.mulAssoc, leftComm b.denominator a.numerator m.denominator, SFT.Foundation.FractionReduction.mulAssoc]
     have rhs : (2*b.denominator)*(m.numerator*a.denominator) =
       m.numerator*(2*(a.denominator*b.denominator)) := by
       rw [SFT.Foundation.FractionReduction.mulAssoc, leftComm b.denominator m.numerator a.denominator, leftComm 2 m.numerator (b.denominator*a.denominator), Nat.mul_comm b.denominator a.denominator]
     rw [lhs,rhs,← hm] at bad
     exact False.elim (Nat.not_lt_of_ge bad low)
 · cases Nat.lt_or_ge (m.numerator*b.denominator) (b.numerator*m.denominator) with
   | inl h => exact h
   | inr h =>
     have bad := Nat.mul_le_mul_left (2*a.denominator) h
     have lhs : (2*a.denominator)*(b.numerator*m.denominator) =
       (b.numerator*a.denominator+b.numerator*a.denominator)*m.denominator := by
       rw [← Nat.two_mul, SFT.Foundation.FractionReduction.mulAssoc, SFT.Foundation.FractionReduction.mulAssoc, leftComm a.denominator b.numerator m.denominator, SFT.Foundation.FractionReduction.mulAssoc]
     have rhs : (2*a.denominator)*(m.numerator*b.denominator) =
       m.numerator*(2*(a.denominator*b.denominator)) := by
       rw [SFT.Foundation.FractionReduction.mulAssoc, leftComm a.denominator m.numerator b.denominator, leftComm 2 m.numerator (a.denominator*b.denominator)]
     rw [lhs,rhs,← hm] at bad
     exact False.elim (Nat.not_lt_of_ge bad high)


def bracketOrdered (b : Bracket) : Prop :=
 b.lower.numerator*b.upper.denominator < b.upper.numerator*b.lower.denominator

def refinementOrdered : Refinement → Prop
 | .balance _ => True
 | .bracket b => bracketOrdered b

theorem refinementKeepsOrderedEndpoints (p : Sides) (b : Bracket)
 (ordered : bracketOrdered b) : refinementOrdered (refineBracket p b) := by
 have inside := midpointInside b.lower b.upper ordered
 unfold refineBracket
 dsimp only
 cases hm : sideOrder p (positiveMidpoint b.lower b.upper) with
 | eq => exact True.intro
 | lt =>
   cases hl : sideOrder p b.lower with
   | lt => exact inside.2
   | eq => exact inside.1
   | gt => exact inside.1
 | gt =>
   cases hl : sideOrder p b.lower with
   | lt => exact inside.1
   | eq => exact inside.1
   | gt => exact inside.2

def originalHalf (b : Bracket) : Refinement → Prop
 | .balance x => x = positiveMidpoint b.lower b.upper
 | .bracket c => c = ⟨b.lower,positiveMidpoint b.lower b.upper⟩ ∨
                 c = ⟨positiveMidpoint b.lower b.upper,b.upper⟩

theorem refinementIsOriginalHalf (p : Sides) (b : Bracket) :
 originalHalf b (refineBracket p b) := by
 unfold refineBracket
 dsimp only
 cases hm : sideOrder p (positiveMidpoint b.lower b.upper) with
 | eq => rfl
 | lt =>
   cases hl : sideOrder p b.lower with
   | lt => exact Or.inr rfl
   | eq => exact Or.inl rfl
   | gt => exact Or.inl rfl
 | gt =>
   cases hl : sideOrder p b.lower with
   | lt => exact Or.inl rfl
   | eq => exact Or.inl rfl
   | gt => exact Or.inr rfl

theorem finiteOrderedTrace (p : Sides) (n : Nat) (state : Refinement)
 (ordered : refinementOrdered state) :
 ∀ held, held ∈ refinementTrace p n state → refinementOrdered held := by
 induction n generalizing state with
 | zero =>
   intro held present
   cases present with
   | head => exact ordered
   | tail _ absent => cases absent
 | succ n ih =>
   intro held present
   cases present with
   | head => exact ordered
   | tail _ present =>
     apply ih (refineState p state) _ held present
     cases state with
     | balance point => exact True.intro
     | bracket b => exact refinementKeepsOrderedEndpoints p b ordered


theorem exactlyOneHalfSwaps (p : Sides) (b : Bracket)
 (held : orderSwap p b)
 (notBalance : sideOrder p (positiveMidpoint b.lower b.upper) ≠ .eq) :
 (orderSwap p ⟨b.lower,positiveMidpoint b.lower b.upper⟩ ∧
   ¬ orderSwap p ⟨positiveMidpoint b.lower b.upper,b.upper⟩) ∨
 (orderSwap p ⟨positiveMidpoint b.lower b.upper,b.upper⟩ ∧
   ¬ orderSwap p ⟨b.lower,positiveMidpoint b.lower b.upper⟩) := by
 unfold orderSwap at *
 cases hl : sideOrder p b.lower <;>
 cases hm : sideOrder p (positiveMidpoint b.lower b.upper) <;>
 cases hu : sideOrder p b.upper
 all_goals rw [hl,hu] at held
 all_goals try cases held
 all_goals try exact False.elim (notBalance hm)
 all_goals first | exact Or.inl ⟨True.intro,fun impossible => impossible⟩ |
                   exact Or.inr ⟨True.intro,fun impossible => impossible⟩

end SFT.Mathematics.AlgebraicBalance
