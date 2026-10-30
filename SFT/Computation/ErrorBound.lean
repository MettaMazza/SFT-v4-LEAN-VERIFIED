import SFT.Computation.ErrorPropagation
namespace SFT.Computation.ErrorBound
open SFT.Foundation.FractionReduction

theorem cancelRight (a b c : Nat) (h : a+c = b+c) : a = b := by
  induction c with
  | zero => exact h
  | succ c ih => exact ih (Nat.succ.inj h)

theorem monotoneAccumulation (a b c : Nat) (ab : a ≤ b) (bc : b ≤ c) :
    (b-a)+(c-b) = c-a := by
  apply cancelRight _ _ a
  calc
    (b-a)+(c-b)+a = (c-b)+((b-a)+a) := by
      rw [Nat.add_assoc,Nat.add_comm (b-a) ((c-b)+a),Nat.add_assoc,Nat.add_comm a (b-a)]
    _ = (c-b)+b := by rw [subtractAdd b a ab]
    _ = c := subtractAdd c b bc
    _ = (c-a)+a := (subtractAdd c a (Nat.le_trans ab bc)).symm

theorem scaledDifference (a b d : Nat) (ab : a ≤ b) :
    (b-a)*d = b*d-a*d := by
  apply cancelRight _ _ (a*d)
  calc
    (b-a)*d+a*d = ((b-a)+a)*d := (SFT.Computation.ExactApproximate.rightDistribution _ _ _).symm
    _ = b*d := by rw [subtractAdd b a ab]
    _ = (b*d-a*d)+a*d := (subtractAdd (b*d) (a*d) (Nat.mul_le_mul_right d ab)).symm

def gap (a b : Nat) : Nat := if a ≤ b then b-a else a-b

theorem subLe (a b c : Nat) (h : a ≤ b+c) : a-b ≤ c := by
  induction b generalizing a with
  | zero =>
    rw [Nat.zero_add] at h
    exact h
  | succ b ih =>
    cases a with
    | zero => rw [Nat.zero_sub]; exact Nat.zero_le _
    | succ a =>
      rw [Nat.succ_add] at h
      rw [Nat.succ_sub_succ]
      exact ih a (Nat.le_of_succ_le_succ h)

theorem forwardBound (a b : Nat) : a ≤ b+gap a b := by
  unfold gap
  split
  · rename_i h
    exact Nat.le_trans h (Nat.le_add_right _ _)
  · rename_i h
    have eq := subtractAdd a b (Nat.le_of_lt (Nat.lt_of_not_ge h))
    rw [Nat.add_comm b (a-b),eq]
    exact Nat.le_refl _

theorem gapSymmetry (a b : Nat) : gap a b = gap b a := by
  unfold gap
  split
  · rename_i ab
    split
    · rename_i ba
      have same := Nat.le_antisymm ab ba
      rw [same]
    · rfl
  · rename_i ab
    rw [ite_eq_left (Nat.le_of_lt (Nat.lt_of_not_ge ab))]

theorem triangle (a b c : Nat) : gap a c ≤ gap a b + gap b c := by
  have left : a ≤ c+(gap a b+gap b c) := by
    calc
      a ≤ b+gap a b := forwardBound _ _
      _ ≤ (c+gap b c)+gap a b := Nat.add_le_add_right (forwardBound _ _) _
      _ = c+(gap a b+gap b c) := by rw [Nat.add_assoc,Nat.add_comm (gap b c) (gap a b)]
  have right : c ≤ a+(gap a b+gap b c) := by
    calc
      c ≤ b+gap c b := forwardBound _ _
      _ ≤ (a+gap b a)+gap c b := Nat.add_le_add_right (forwardBound _ _) _
      _ = a+(gap a b+gap b c) := by rw [gapSymmetry b a,gapSymmetry c b,Nat.add_assoc]
  unfold gap
  split
  · exact subLe c a _ right
  · exact subLe a c _ left

def accumulated (initial : Nat) : List Nat → Nat
  | [] => 0
  | next::rest => gap initial next + accumulated next rest

def terminal (initial : Nat) : List Nat → Nat
  | [] => initial
  | next::rest => terminal next rest

theorem accumulatedBound (initial : Nat) (trace : List Nat) :
    gap initial (terminal initial trace) ≤ accumulated initial trace := by
  induction trace generalizing initial with
  | nil =>
    change gap initial initial ≤ 0
    unfold gap
    rw [ite_eq_left (Nat.le_refl _),Nat.sub_self]
    exact Nat.le_refl _
  | cons next rest ih =>
    exact Nat.le_trans (triangle initial next (terminal next rest))
      (Nat.add_le_add_left (ih next) _)

theorem gapOfLE (a b : Nat) (h : a ≤ b) : gap a b = b-a := by
  unfold gap
  rw [ite_eq_left h]

theorem gapScale (a b d : Nat) : gap (a*d) (b*d) = gap a b*d := by
  if h : a ≤ b then
    rw [gapOfLE a b h,gapOfLE (a*d) (b*d) (Nat.mul_le_mul_right d h)]
    exact (scaledDifference a b d h).symm
  else
    have ba := Nat.le_of_lt (Nat.lt_of_not_ge h)
    rw [gapSymmetry (a*d) (b*d),gapSymmetry a b,
      gapOfLE b a ba,gapOfLE (b*d) (a*d) (Nat.mul_le_mul_right d ba)]
    exact (scaledDifference b a d ba).symm

open SFT.Foundation.ExactOperations SFT.Computation.NumericalError

def crossGap (a b : PositiveFraction) : Nat :=
  gap (a.numerator*b.denominator) (b.numerator*a.denominator)

theorem belowLedgerMagnitude (a b : PositiveFraction)
    (below : b.numerator*a.denominator < a.numerator*b.denominator) :
    crossGap a b*(errorValue a b).1.denominator =
      (errorValue a b).1.numerator*(a.denominator*b.denominator) := by
  unfold crossGap
  rw [gapSymmetry,gapOfLE _ _ (Nat.le_of_lt below)]
  exact (belowValue a b below).2

theorem aboveLedgerMagnitude (a b : PositiveFraction)
    (above : a.numerator*b.denominator < b.numerator*a.denominator) :
    crossGap a b*(errorValue a b).1.denominator =
      (errorValue a b).1.numerator*(a.denominator*b.denominator) := by
  unfold crossGap
  rw [gapOfLE _ _ (Nat.le_of_lt above)]
  exact (aboveValue a b above).2

theorem equalLedgerMarker (a b : PositiveFraction)
    (same : b.numerator*a.denominator = a.numerator*b.denominator) :
    errorValue a b = (NumericalError.one,"equal") := equalMarker a b same

theorem scaledTriangle (a b c : PositiveFraction) :
    crossGap a c*b.denominator ≤
      crossGap a b*c.denominator + crossGap b c*a.denominator := by
  unfold crossGap
  rw [← gapScale,← gapScale,← gapScale]
  have aOrder : a.numerator*c.denominator*b.denominator = a.numerator*b.denominator*c.denominator := by
    rw [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm c.denominator b.denominator,← SFT.Foundation.FractionReduction.mulAssoc]
  have bOrder : b.numerator*c.denominator*a.denominator = b.numerator*a.denominator*c.denominator := by
    rw [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm c.denominator a.denominator,← SFT.Foundation.FractionReduction.mulAssoc]
  have cOrder : c.numerator*b.denominator*a.denominator = c.numerator*a.denominator*b.denominator := by
    rw [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm b.denominator a.denominator,← SFT.Foundation.FractionReduction.mulAssoc]
  rw [aOrder,bOrder,cOrder]
  exact triangle _ _ _

theorem mulSwap (a b c : Nat) : a*b*c = a*c*b := by
  rw [mulAssoc,Nat.mul_comm b c,← mulAssoc]

inductive ScaledRows (denominator : Nat) : List PositiveFraction → List Nat → Prop where
  | base : ScaledRows denominator [] []
  | step (part : PositiveFraction) (coordinate : Nat) (parts : List PositiveFraction) (coordinates : List Nat)
      (same : coordinate*part.denominator = part.numerator*denominator)
      (tail : ScaledRows denominator parts coordinates) :
      ScaledRows denominator (part::parts) (coordinate::coordinates)

theorem rescaleRows (d factor : Nat) (parts : List PositiveFraction) (coordinates : List Nat)
    (rows : ScaledRows d parts coordinates) :
    ScaledRows (factor*d) parts (coordinates.map fun n => n*factor) := by
  induction rows with
  | base => exact .base
  | step part n parts coordinates same tail ih =>
    apply ScaledRows.step
    · calc
        n*factor*part.denominator = n*part.denominator*factor := mulSwap _ _ _
        _ = part.numerator*d*factor := congrArg (fun k => k*factor) same
        _ = part.numerator*(factor*d) := by rw [mulSwap,mulAssoc]
    · exact ih

structure Scale (parts : List PositiveFraction) where
  denominator : Nat
  positive : 0 < denominator
  coordinates : List Nat
  rows : ScaledRows denominator parts coordinates

def generateScale : (parts : List PositiveFraction) → Scale parts
  | [] => ⟨1,Nat.zero_lt_succ _,[],.base⟩
  | part::rest =>
    let prior := generateScale rest
    ⟨part.denominator*prior.denominator,
      Nat.mul_pos (Nat.pos_of_ne_zero part.denominatorNonzero) prior.positive,
      part.numerator*prior.denominator :: prior.coordinates.map (fun n => n*part.denominator),
      .step part _ _ _ ((mulSwap _ _ _).trans (mulAssoc _ _ _)) (rescaleRows _ _ _ _ prior.rows)⟩

theorem completeScaling (parts : List PositiveFraction) :
    ScaledRows (generateScale parts).denominator parts (generateScale parts).coordinates :=
  (generateScale parts).rows

theorem scaledRowsLength (d : Nat) (parts : List PositiveFraction) (coordinates : List Nat)
    (rows : ScaledRows d parts coordinates) : coordinates.length = parts.length := by
  induction rows with
  | base => rfl
  | step part n parts coordinates same tail ih => exact congrArg Nat.succ ih

theorem coordinateGap (a b : PositiveFraction) (na nb d : Nat)
    (ha : na*a.denominator = a.numerator*d)
    (hb : nb*b.denominator = b.numerator*d) :
    gap na nb*(a.denominator*b.denominator) = crossGap a b*d := by
  calc
    gap na nb*(a.denominator*b.denominator) =
        gap (na*(a.denominator*b.denominator)) (nb*(a.denominator*b.denominator)) := (gapScale _ _ _).symm
    _ = gap (a.numerator*b.denominator*d) (b.numerator*a.denominator*d) := by
      have left : na*(a.denominator*b.denominator) = a.numerator*b.denominator*d := by
        rw [← mulAssoc,ha,mulSwap]
      have right : nb*(a.denominator*b.denominator) = b.numerator*a.denominator*d := by
        rw [Nat.mul_comm a.denominator b.denominator,← mulAssoc,hb,mulSwap]
      rw [left,right]
    _ = crossGap a b*d := gapScale _ _ _

def generatedBound (first : PositiveFraction) (rest : List PositiveFraction) : Nat × Nat :=
  let scaled := generateScale (first::rest)
  match scaled.coordinates with
  | [] => (0,scaled.denominator)
  | initial::trace => (accumulated initial trace,scaled.denominator)

theorem generatedCoordinatesNonempty (first : PositiveFraction) (rest : List PositiveFraction) :
    (generateScale (first::rest)).coordinates ≠ [] := by
  intro impossible
  cases impossible

theorem generatedAccumulatedBound (first : PositiveFraction) (rest : List PositiveFraction) :
    ∃ (initial : Nat) (trace : List Nat),
      (generateScale (first::rest)).coordinates = initial::trace ∧
      ScaledRows (generatedBound first rest).2 (first::rest) (initial::trace) ∧
      gap initial (terminal initial trace) ≤ (generatedBound first rest).1 := by
  let prior := generateScale rest
  let initial := first.numerator*prior.denominator
  let trace := prior.coordinates.map (fun n => n*first.denominator)
  exact ⟨initial,trace,rfl,(generateScale (first::rest)).rows,accumulatedBound initial trace⟩

def lastPart (initial : PositiveFraction) : List PositiveFraction → PositiveFraction
  | [] => initial
  | next::rest => lastPart next rest

theorem terminalScaling (d : Nat) (first : PositiveFraction) (rest : List PositiveFraction)
    (initial : Nat) (trace : List Nat) (rows : ScaledRows d (first::rest) (initial::trace)) :
    terminal initial trace*(lastPart first rest).denominator =
      (lastPart first rest).numerator*d := by
  induction rest generalizing first initial trace with
  | nil =>
    cases rows with
    | step part coordinate parts coordinates same tail =>
      cases tail
      exact same
  | cons next rest ih =>
    cases rows with
    | step part coordinate parts coordinates same tail =>
      cases tail with
      | step next nextCoordinate rest suffix nextSame remaining =>
        exact ih next nextCoordinate suffix (.step _ _ _ _ nextSame remaining)

theorem generatedEndpointGap (first : PositiveFraction) (rest : List PositiveFraction)
    (initial : Nat) (trace : List Nat)
    (coordinates : (generateScale (first::rest)).coordinates = initial::trace) :
    gap initial (terminal initial trace)*(first.denominator*(lastPart first rest).denominator) =
      crossGap first (lastPart first rest)*(generateScale (first::rest)).denominator := by
  have rows := (generateScale (first::rest)).rows
  rw [coordinates] at rows
  have endSame := terminalScaling _ _ _ _ _ rows
  cases rows with
  | step part coordinate parts coordinates same tail =>
    exact coordinateGap _ _ _ _ _ same endSame

end SFT.Computation.ErrorBound
