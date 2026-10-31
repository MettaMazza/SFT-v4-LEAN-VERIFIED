import SFT.Physics.QuantumPhysicalObservable
namespace SFT.Physics.QuantumPhysicalWeight
open SFT.QuantumComputation.ReversibleModel
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations

theorem admittedCountPositive (state : State) (admitted : makeState state.branches state.phaseCycle = .ok state) :
    0 < state.branches.length := by
  have h := (admittedPhaseCycle state admitted).1
  cases hs : state.branches with
  | nil => rw [hs] at h; cases h
  | cons b bs => exact Nat.zero_lt_succ _

theorem selectedPositive {p : QuantumPhysicalState.Prepared} (m : QuantumPhysicalObservable.Measurement p) :
    0 < m.selected.branches.length :=
  admittedCountPositive _ (SFT.QuantumComputation.ReversibleObservation.observationSource _ _ _ _ _ m.generated).2.2.2.2

def weight {p : QuantumPhysicalState.Prepared} (m : QuantumPhysicalObservable.Measurement p) : PositiveFraction :=
  ratio m.selected.branches.length p.state.branches.length (selectedPositive m) (admittedCountPositive _ p.admitted)

theorem exactBranchRatio {p : QuantumPhysicalState.Prepared} (m : QuantumPhysicalObservable.Measurement p) :
    m.selected.branches.length * (weight m).denominator = (weight m).numerator * p.state.branches.length :=
  ratioValue _ _ _ _

theorem positiveWeight {p : QuantumPhysicalState.Prepared} (m : QuantumPhysicalObservable.Measurement p) :
    0 < (weight m).numerator := (weight m).positive

theorem onlyExactWeight {p : QuantumPhysicalState.Prepared} (m : QuantumPhysicalObservable.Measurement p)
    (candidate : PositiveFraction)
    (exactCount : m.selected.branches.length * candidate.denominator = candidate.numerator * p.state.branches.length) :
    candidate = weight m := by
  have a := FieldGeometricDilution.positiveNormalizationRepresents _ _ (selectedPositive m)
    (admittedCountPositive _ p.admitted) candidate exactCount
  have b := FieldGeometricDilution.positiveNormalizationRepresents _ _ (selectedPositive m)
    (admittedCountPositive _ p.admitted) (weight m) (exactBranchRatio m)
  exact a.symm.trans b

theorem fullRecordCount {p : QuantumPhysicalState.Prepared} (m : QuantumPhysicalObservable.Measurement p) :
    m.records.length = p.state.branches.length :=
  SFT.QuantumComputation.ReversibleObservation.recordCount _ _ _
    (SFT.QuantumComputation.ReversibleObservation.observationSource _ _ _ _ _ m.generated).2.1

theorem selectedCountAtMostWhole {p : QuantumPhysicalState.Prepared} (m : QuantumPhysicalObservable.Measurement p) :
    m.selected.branches.length ≤ p.state.branches.length := by
  rw [SFT.QuantumComputation.Measurement.selectedClassPreservesOrder _ _ _ _ _ m.generated]
  have bound {A : Type} (test : A → Bool) (xs : List A) : (xs.filter test).length ≤ xs.length := by
    induction xs with
    | nil => exact Nat.le_refl _
    | cons a rest ih =>
      change (match test a with | true => a :: rest.filter test | false => rest.filter test).length ≤ rest.length+1
      cases h : test a
      · exact Nat.le_trans ih (Nat.le_succ _)
      · exact Nat.succ_le_succ ih
  exact bound _ _
end SFT.Physics.QuantumPhysicalWeight
