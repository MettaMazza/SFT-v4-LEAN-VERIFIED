import SFT.Physics.MatterExchange
namespace SFT.Physics.MatterExchangeSpin
open SFT.Physics.QuantumPhysicalSpin SFT.Physics.MatterExchange
open SFT.Physics.MechanicalLocation SFT.QuantumComputation.ReversibleModel

def actionClass {p : QuantumPhysicalState.Prepared} (a : Action p)
    (read : State → Held) : Class := classify (read p.state) (read a.result)

theorem preservingSpinExactly {p : QuantumPhysicalState.Prepared} (a : Action p)
    (read : State → Held) : actionClass a read = .preserving ↔ read a.result = read p.state :=
  preservingExactly _ _

theorem alternatingSpinExactly {p : QuantumPhysicalState.Prepared} (a : Action p)
    (read : State → Held) : actionClass a read = .alternating ↔ read a.result = opposite (read p.state) :=
  alternatingExactly _ _

theorem completeSpinClasses {p : QuantumPhysicalState.Prepared} (a : Action p)
    (read : State → Held) : read a.result = read p.state ∨ read a.result = opposite (read p.state) :=
  twoHeldActionsExhaust _ _

theorem fullSpinPeriodPreserving {p : QuantumPhysicalState.Prepared} (a : Action p)
    (read : State → Held) (period : a.orientationTrace.length = p.state.phaseCycle.length) :
    actionClass a read = .preserving := by
  have result : a.result = p.state := Except.ok.inj (a.generated.symm.trans (fullOrientationRecurrenceReturns p a.orientationTrace period))
  apply (preservingSpinExactly a read).mpr
  exact congrArg read result

theorem spinExchangeCorrespondence {p : QuantumPhysicalState.Prepared} (a : Action p)
    (read : State → Held) {C : Type} (pair : QuantumPhysicalIdentity.Pair C)
    (orientation : QuantumPhysicalIdentity.Pair C → Held)
    (original : orientation pair = read p.state)
    (generated : orientation (QuantumPhysicalIdentity.exchange pair) = read a.result) :
    classify (orientation pair) (orientation (QuantumPhysicalIdentity.exchange pair)) = actionClass a read := by
  rw [original,generated]; rfl
end SFT.Physics.MatterExchangeSpin
