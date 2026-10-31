import SFT.Physics.QuantumPhysicalContextuality
namespace SFT.Physics.QuantumPhysicalDecoherence
open SFT.QuantumComputation.ReversibleModel QuantumPhysicalEvolution

-- Environmental words retain the original held phase labels after reversible evolution.
structure Distribution (p : QuantumPhysicalState.Prepared) where
  evolution : Evolution p
  environment : Word × String → Word
  readPhase : Word → String
  phaseRetained : ∀ branch ∈ evolution.terminal.branches, readPhase (environment branch) = branch.2

def globalRow {p : QuantumPhysicalState.Prepared} (d : Distribution p) (branch : Word × String) :=
  (branch.1,d.environment branch)

def recoverRow {p : QuantumPhysicalState.Prepared} (d : Distribution p) (row : Word × Word) :=
  (row.1,d.readPhase row.2)

theorem phaseRecordRecoversEntireBranch {p : QuantumPhysicalState.Prepared} (d : Distribution p)
    (branch : Word × String) (held : branch ∈ d.evolution.terminal.branches) :
    recoverRow d (globalRow d branch) = branch := by
  change (branch.1,d.readPhase (d.environment branch)) = branch
  rw [d.phaseRetained branch held]

theorem globalEncodingCannotMergeHeldBranches {p : QuantumPhysicalState.Prepared} (d : Distribution p)
    (a b : Word × String) (ha : a ∈ d.evolution.terminal.branches) (hb : b ∈ d.evolution.terminal.branches)
    (same : globalRow d a = globalRow d b) : a = b :=
  (phaseRecordRecoversEntireBranch d a ha).symm.trans
    ((congrArg (recoverRow d) same).trans (phaseRecordRecoversEntireBranch d b hb))

theorem distinctPhaseRequiresDistinctEnvironment {p : QuantumPhysicalState.Prepared} (d : Distribution p)
    (a b : Word × String) (ha : a ∈ d.evolution.terminal.branches) (hb : b ∈ d.evolution.terminal.branches)
    (different : a.2 ≠ b.2) : d.environment a ≠ d.environment b := by
  intro same
  exact different ((d.phaseRetained a ha).symm.trans
    ((congrArg d.readPhase same).trans (d.phaseRetained b hb)))

def globalSupport {p : QuantumPhysicalState.Prepared} (d : Distribution p) :=
  d.evolution.terminal.branches.map (globalRow d)

theorem fullSupportReconstructed {p : QuantumPhysicalState.Prepared} (d : Distribution p) :
    (globalSupport d).map (recoverRow d) = d.evolution.terminal.branches := by
  have all (rows : List (Word × String)) (held : ∀ row ∈ rows, row ∈ d.evolution.terminal.branches) :
      (rows.map (globalRow d)).map (recoverRow d) = rows := by
    induction rows with
    | nil => rfl
    | cons row rest ih =>
      change recoverRow d (globalRow d row) :: _ = row :: rest
      rw [phaseRecordRecoversEntireBranch d row (held row (.head _)),ih (fun r hr => held r (.tail _ hr))]
  exact all _ (fun _ h => h)

theorem reducedObservationForgetsOnlyEnvironment {p : QuantumPhysicalState.Prepared} (d : Distribution p) :
    (globalSupport d).map Prod.fst = support d.evolution.terminal := by
  change (d.evolution.terminal.branches.map (globalRow d)).map Prod.fst = d.evolution.terminal.branches.map Prod.fst
  induction d.evolution.terminal.branches with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.1) ih

theorem reducedPhaseDistinctionClosed {p : QuantumPhysicalState.Prepared} (d : Distribution p)
    (a b : Word × String) (sameSystem : a.1 = b.1) : (globalRow d a).1 = (globalRow d b).1 := sameSystem

theorem originalPreparationGloballyRecoverable {p : QuantumPhysicalState.Prepared} (d : Distribution p) :
    SFT.QuantumComputation.ReversibleExecution.Backward d.evolution.terminal
      (SFT.QuantumComputation.ReversibleExecution.reverseOrder d.evolution.gates) p.state :=
  exactlyReversible d.evolution
end SFT.Physics.QuantumPhysicalDecoherence
