import SFT.Physics.QuantumPhysicalDecoherence
namespace SFT.Physics.QuantumPhysicalClassicalLimit
open SFT.QuantumComputation.ReversibleModel QuantumPhysicalDecoherence

-- The declared environmental record distinguishes the relevant predecessor classes.
def distinguishes {p : QuantumPhysicalState.Prepared} {Class : Type} (d : Distribution p)
    (classOf : Word × String → Class) : Prop :=
  ∀ a ∈ d.evolution.terminal.branches, ∀ b ∈ d.evolution.terminal.branches,
    d.environment a = d.environment b → classOf a = classOf b

theorem differentClassesHaveDifferentEnvironment {p : QuantumPhysicalState.Prepared} {Class : Type}
    (d : Distribution p) (classOf : Word × String → Class) (separated : distinguishes d classOf)
    (a b : Word × String) (ha : a ∈ d.evolution.terminal.branches) (hb : b ∈ d.evolution.terminal.branches)
    (different : classOf a ≠ classOf b) : d.environment a ≠ d.environment b :=
  fun same => different (separated a ha b hb same)

theorem everyEnvironmentalFibreHasOnePredecessorClass {p : QuantumPhysicalState.Prepared} {Class : Type}
    (d : Distribution p) (classOf : Word × String → Class) (separated : distinguishes d classOf)
    (environment : Word) (a b : Word × String)
    (ha : a ∈ d.evolution.terminal.branches) (hb : b ∈ d.evolution.terminal.branches)
    (ea : d.environment a = environment) (eb : d.environment b = environment) :
    classOf a = classOf b := separated a ha b hb (ea.trans eb.symm)

def jointObservation {p : QuantumPhysicalState.Prepared} {Macro : Type} (d : Distribution p)
    (macroscopic : Word × String → Macro) (branch : Word × String) := (macroscopic branch,d.environment branch)

theorem closedCrossClassMerging {p : QuantumPhysicalState.Prepared} {Class Macro : Type}
    (d : Distribution p) (classOf : Word × String → Class) (separated : distinguishes d classOf)
    (macroscopic : Word × String → Macro) (a b : Word × String)
    (ha : a ∈ d.evolution.terminal.branches) (hb : b ∈ d.evolution.terminal.branches)
    (different : classOf a ≠ classOf b) : jointObservation d macroscopic a ≠ jointObservation d macroscopic b :=
  fun same => differentClassesHaveDifferentEnvironment d classOf separated a b ha hb different
    (congrArg Prod.snd same)

def classicalLedger {p : QuantumPhysicalState.Prepared} {Macro : Type} (d : Distribution p)
    (macroscopic : Word × String → Macro) :=
  d.evolution.terminal.branches.map (fun branch => (branch,jointObservation d macroscopic branch))

theorem completeOriginalSupportRetained {p : QuantumPhysicalState.Prepared} {Macro : Type}
    (d : Distribution p) (macroscopic : Word × String → Macro) :
    (classicalLedger d macroscopic).map Prod.fst = d.evolution.terminal.branches := by
  change (d.evolution.terminal.branches.map (fun b => (b,jointObservation d macroscopic b))).map Prod.fst = _
  induction d.evolution.terminal.branches with
  | nil => rfl
  | cons b rest ih => exact congrArg (List.cons b) ih

theorem fullPhaseRecordSurvivesClassicalProjection {p : QuantumPhysicalState.Prepared}
    (d : Distribution p) (a b : Word × String)
    (ha : a ∈ d.evolution.terminal.branches) (hb : b ∈ d.evolution.terminal.branches)
    (sameEnvironment : d.environment a = d.environment b) : a.2 = b.2 :=
  (d.phaseRetained a ha).symm.trans ((congrArg d.readPhase sameEnvironment).trans (d.phaseRetained b hb))
end SFT.Physics.QuantumPhysicalClassicalLimit
