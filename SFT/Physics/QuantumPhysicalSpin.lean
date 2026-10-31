import SFT.Physics.QuantumPhysicalIncompatibility
import SFT.QuantumComputation.PhaseInterference
namespace SFT.Physics.QuantumPhysicalSpin
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.PhaseInterference

structure Action (p : QuantumPhysicalState.Prepared) where
  orientationTrace : List String
  result : State
  generated : phaseAction p.state orientationTrace = .ok result

def record {p : QuantumPhysicalState.Prepared} (a : Action p) :=
  (p,a.orientationTrace,a.result)

theorem cyclicLabelAction {p : QuantumPhysicalState.Prepared} (a : Action p) :
    shiftBranches p.state.phaseCycle (a.orientationTrace.length % p.state.phaseCycle.length)
      p.state.branches = some a.result.branches := (phaseActionSource _ _ _ a.generated).2

theorem originalCycleRetained {p : QuantumPhysicalState.Prepared} (a : Action p) :
    a.result.phaseCycle = p.state.phaseCycle := (phaseActionSource _ _ _ a.generated).1

theorem wordSupportRetained {p : QuantumPhysicalState.Prepared} (a : Action p) :
    support a.result = support p.state := shiftRetainsSupport _ _ _ _ (cyclicLabelAction a)

theorem fullOrientationRecurrenceReturns (p : QuantumPhysicalState.Prepared) (steps : List String)
    (period : steps.length = p.state.phaseCycle.length) : phaseAction p.state steps = .ok p.state :=
  exactPhasePeriod _ _ p.admitted period

theorem everyHeldLabelHasGeneratedAction (p : QuantumPhysicalState.Prepared) (phase : String)
    (held : phase ∈ p.state.phaseCycle) (steps : List String) :
    ∃ result, shiftPhase p.state.phaseCycle (steps.length % p.state.phaseCycle.length) phase = some result ∧
      result ∈ p.state.phaseCycle :=
  shiftedPhaseExists _ (Nat.lt_of_lt_of_le (by decide : 0 < 2) (admittedPhaseCycle _ p.admitted).2.2) _ held _

theorem distinctReadingsRemainDistinct (word : Word) (left right : String) (different : left ≠ right) :
    (word,left) ≠ (word,right) := fun eq => different (congrArg Prod.snd eq)

theorem completePreparationRetained {p : QuantumPhysicalState.Prepared} (a : Action p) :
    (record a).1.preparation = p.preparation ∧ (record a).1.sourceIdentity = p.sourceIdentity := ⟨rfl,rfl⟩

theorem fullActionTraceRetained {p : QuantumPhysicalState.Prepared} (a : Action p) :
    (record a).2.1 = a.orientationTrace := rfl
end SFT.Physics.QuantumPhysicalSpin
