import SFT.Chemistry.CovalentSharing
import SFT.Physics.QuantumPhysicalObservable
namespace SFT.Chemistry.AffinityPhysicalObservation
open SFT.Physics SFT.QuantumComputation.ReversibleModel
open SFT.QuantumComputation.ReversibleObservation
open SFT.InformationScience.EncodingMaps

-- The physical source uses Word keys and permits every String class label.
-- Retain its original Measurement domain, rather than coercing it into a
-- symbol alphabet with additional nonempty-label guards.
structure Endpoint {p : QuantumPhysicalState.Prepared}
    (measurement : QuantumPhysicalObservable.Measurement p) where
  branch : Word × String
  label : String
  retained : (branch,label) ∈ measurement.records

theorem retainedExactly {p : QuantumPhysicalState.Prepared}
    (m : QuantumPhysicalObservable.Measurement p) (branch : Word × String) (label : String) :
    (branch,label) ∈ m.records ↔ branch ∈ p.state.branches ∧
      lookupFirst m.partition branch.1 = some label :=
  recordMembership _ _ _ (observationSource _ _ _ _ _ m.generated).2.1 _ _

theorem everyBranchHasEndpoint {p : QuantumPhysicalState.Prepared}
    (m : QuantumPhysicalObservable.Measurement p) (branch : Word × String)
    (held : branch ∈ p.state.branches) :
    ∃ endpoint : Endpoint m, endpoint.branch = branch := by
  obtain ⟨label,_,recorded⟩ := QuantumPhysicalObservable.everySourceClassRecorded m branch held
  exact ⟨⟨branch,label,recorded⟩,rfl⟩

theorem endpointSource {p : QuantumPhysicalState.Prepared}
    {m : QuantumPhysicalObservable.Measurement p} (endpoint : Endpoint m) :
    endpoint.branch ∈ p.state.branches ∧
      lookupFirst m.partition endpoint.branch.1 = some endpoint.label :=
  (retainedExactly m _ _).mp endpoint.retained

theorem classUnique {p : QuantumPhysicalState.Prepared}
    {m : QuantumPhysicalObservable.Measurement p} (a b : Endpoint m)
    (same : a.branch.1 = b.branch.1) : a.label = b.label := by
  have left := (endpointSource a).2
  rw [same] at left
  exact Option.some.inj (left.symm.trans (endpointSource b).2)

theorem classEqualityExactly {p : QuantumPhysicalState.Prepared}
    {m : QuantumPhysicalObservable.Measurement p} (a b : Endpoint m) :
    a.label = b.label ↔ lookupFirst m.partition a.branch.1 = lookupFirst m.partition b.branch.1 := by
  rw [(endpointSource a).2,(endpointSource b).2]
  exact ⟨congrArg some,Option.some.inj⟩

theorem completeBranchSequence {p : QuantumPhysicalState.Prepared}
    (m : QuantumPhysicalObservable.Measurement p) : m.records.map Prod.fst = p.state.branches :=
  completeRecord _ _ _ (observationSource _ _ _ _ _ m.generated).2.1

theorem completeBranchCount {p : QuantumPhysicalState.Prepared}
    (m : QuantumPhysicalObservable.Measurement p) : m.records.length = p.state.branches.length :=
  recordCount _ _ _ (observationSource _ _ _ _ _ m.generated).2.1

-- Tie the observation to the SAME prepared recurrence already carried by the
-- covalent bond. No extra state, transition rule, or label guard is introduced.
theorem sharedRecurrenceAndCompleteObservation {WordType Cell : Type}
    (shared : CovalentSharing.BoundChannels WordType Cell)
    (m : QuantumPhysicalObservable.Measurement shared.bond.recurrence.prepared) :
    phaseAction shared.bond.recurrence.prepared.state
      (shared.bond.interactionTrace.flatMap Prod.snd) = .ok shared.bond.recurrence.prepared.state ∧
    m.records.map Prod.fst = shared.bond.recurrence.prepared.state.branches ∧
    (⟨m.records.map Prod.fst,m.selected.phaseCycle⟩ : State) = shared.bond.recurrence.prepared.state :=
  ⟨CovalentSharing.boundSourceRecurs shared,completeBranchSequence m,
    QuantumPhysicalObservable.fullStateReconstructed m⟩
end SFT.Chemistry.AffinityPhysicalObservation
