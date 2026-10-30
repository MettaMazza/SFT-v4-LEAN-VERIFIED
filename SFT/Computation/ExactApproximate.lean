import SFT.Computation.NumericalLedger
namespace SFT.Computation.ExactApproximate
open NumericalError NumericalLedger SFT.Foundation.ExactOperations

structure Report where
  reference : List Number
  approximation : List Number
  errorLedger : List Row

def compare (reference approximation : List Number) : Except String Report := do
  let rows ← exactErrorLedger reference approximation
  pure ⟨reference,approximation,rows⟩

theorem exactReport (reference approximation : List Number) (rows : List Row)
    (accepted : exactErrorLedger reference approximation = .ok rows) :
    compare reference approximation = .ok ⟨reference,approximation,rows⟩ := by
  unfold compare
  rw [accepted]
  rfl

theorem reportReconstruction (reference approximation : List Number) (report : Report)
    (accepted : compare reference approximation = .ok report) :
    report.reference = reference ∧ report.approximation = approximation ∧
      reference ≠ [] ∧ Rows 1 reference approximation report.errorLedger := by
  unfold compare at accepted
  cases h : exactErrorLedger reference approximation with
  | error e => rw [h] at accepted; cases accepted
  | ok rows =>
    rw [h] at accepted
    cases accepted
    exact ⟨rfl,rfl,(exactAdmission _ _ _).mp h⟩

theorem approximationCannotReplaceReference (reference first second : List Number)
    (a b : Report) (ha : compare reference first = .ok a) (hb : compare reference second = .ok b) :
    a.reference = b.reference :=
  (reportReconstruction _ _ _ ha).1.trans (reportReconstruction _ _ _ hb).1.symm

theorem completeErrorLedger (reference approximation : List Number) (report : Report)
    (accepted : compare reference approximation = .ok report) :
    report.errorLedger.length = reference.length := by
  have reconstructed := (reportReconstruction _ _ _ accepted).2.2.2
  exact rowsCount 1 reference approximation report.errorLedger (replay _ _ _ _ reconstructed)

theorem equalityRetainsOne (exact approximate : PositiveFraction)
    (same : approximate.numerator*exact.denominator = exact.numerator*approximate.denominator) :
    errorValue exact approximate = (NumericalError.one,"equal") := equalMarker _ _ same
def partLE (a b : PositiveFraction) : Prop := a.numerator*b.denominator ≤ b.numerator*a.denominator

def outputInterval (exact approximate : PositiveFraction) : PositiveFraction × PositiveFraction :=
  if approximate.numerator*exact.denominator ≤ exact.numerator*approximate.denominator then
    (approximate,exact)
  else (exact,approximate)

theorem referenceInInterval (exact approximate : PositiveFraction) :
    partLE (outputInterval exact approximate).1 exact ∧
      partLE exact (outputInterval exact approximate).2 := by
  unfold outputInterval
  split
  · rename_i h
    exact ⟨h,Nat.le_refl _⟩
  · rename_i h
    exact ⟨Nat.le_refl _,Nat.le_of_lt (Nat.lt_of_not_ge h)⟩

theorem approximationInInterval (exact approximate : PositiveFraction) :
    partLE (outputInterval exact approximate).1 approximate ∧
      partLE approximate (outputInterval exact approximate).2 := by
  unfold outputInterval
  split
  · rename_i h
    exact ⟨Nat.le_refl _,h⟩
  · rename_i h
    exact ⟨Nat.le_of_lt (Nat.lt_of_not_ge h),Nat.le_refl _⟩

theorem rightDistribution (a b c : Nat) : (a+b)*c = a*c+b*c := by
  rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]

theorem belowReconstructsReference (exact approximate : PositiveFraction)
    (below : approximate.numerator*exact.denominator < exact.numerator*approximate.denominator) :
    (errorValue exact approximate).1.numerator*(exact.denominator*approximate.denominator) +
        (approximate.numerator*exact.denominator)*(errorValue exact approximate).1.denominator =
      (exact.numerator*approximate.denominator)*(errorValue exact approximate).1.denominator := by
  have d := (belowValue exact approximate below).2
  rw [← d,← rightDistribution,SFT.Foundation.FractionReduction.subtractAdd _ _ (Nat.le_of_lt below)]

theorem aboveReconstructsApproximation (exact approximate : PositiveFraction)
    (above : exact.numerator*approximate.denominator < approximate.numerator*exact.denominator) :
    (errorValue exact approximate).1.numerator*(exact.denominator*approximate.denominator) +
        (exact.numerator*approximate.denominator)*(errorValue exact approximate).1.denominator =
      (approximate.numerator*exact.denominator)*(errorValue exact approximate).1.denominator := by
  have d := (aboveValue exact approximate above).2
  rw [← d,← rightDistribution,SFT.Foundation.FractionReduction.subtractAdd _ _ (Nat.le_of_lt above)]

theorem precisionProvenance (reference approximation : List Number) (report : Report)
    (accepted : compare reference approximation = .ok report) :
    ∀ row, row ∈ report.errorLedger → ∃ (position : Nat) (exact approximate : PositiveFraction),
      .positive exact ∈ reference ∧ .positive approximate ∈ approximation ∧
      row = (SFT.Host.Text.append "cell-" (toString position),errorValue exact approximate) :=
  rowProvenance _ _ _ _ (reportReconstruction _ _ _ accepted).2.2.2

theorem appendComparison (reference approximation : List Number) (report : Report)
    (accepted : compare reference approximation = .ok report) (exact approximate : PositiveFraction) :
    compare (reference++[.positive exact]) (approximation++[.positive approximate]) =
      .ok ⟨reference++[.positive exact],approximation++[.positive approximate],
        report.errorLedger++[(SFT.Host.Text.append "cell-" (toString (1+reference.length)),errorValue exact approximate)]⟩ := by
  have prior := (reportReconstruction _ _ _ accepted).2.2.2
  have next := successor 1 reference approximation report.errorLedger prior exact approximate
  have nonempty : reference++[.positive exact] ≠ [] := by
    cases reference <;> intro h <;> cases h
  exact exactReport _ _ _ ((exactAdmission _ _ _).mpr ⟨nonempty,next⟩)

end SFT.Computation.ExactApproximate
