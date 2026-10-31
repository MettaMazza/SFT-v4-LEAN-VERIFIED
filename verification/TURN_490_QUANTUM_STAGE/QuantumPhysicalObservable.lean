import SFT.Physics.QuantumPhysicalEvolution
import SFT.QuantumComputation.Measurement
namespace SFT.Physics.QuantumPhysicalObservable
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleObservation

structure Measurement (prepared : QuantumPhysicalState.Prepared) where
  partition : Classification
  observedClass : String
  selected : State
  records : List Record
  generated : observe prepared.state partition observedClass = .ok (selected,records)

def sourceBoundRecord {p : QuantumPhysicalState.Prepared} (m : Measurement p) :=
  (p.sourceIdentity,p.preparation,m.partition,m.observedClass,m.records)

theorem partitionExactlySelected {p : QuantumPhysicalState.Prepared} (m : Measurement p) (branch : Word × String) :
    branch ∈ m.selected.branches ↔ branch ∈ p.state.branches ∧
      SFT.InformationScience.EncodingMaps.lookupFirst m.partition branch.1 = some m.observedClass :=
  observationMembership _ _ _ _ _ m.generated branch

theorem everySourceClassRecorded {p : QuantumPhysicalState.Prepared} (m : Measurement p)
    (branch : Word × String) (member : branch ∈ p.state.branches) :
    ∃ outcome, SFT.InformationScience.EncodingMaps.lookupFirst m.partition branch.1 = some outcome ∧
      (branch,outcome) ∈ m.records :=
  SFT.QuantumComputation.Measurement.totalObservationRelation _ _ _ _ _ m.generated branch member

theorem closedClassNotErased {p : QuantumPhysicalState.Prepared} (m : Measurement p)
    (branch : Word × String) (member : branch ∈ p.state.branches) (outcome : String)
    (classified : SFT.InformationScience.EncodingMaps.lookupFirst m.partition branch.1 = some outcome)
    (different : outcome ≠ m.observedClass) : branch ∉ m.selected.branches ∧ (branch,outcome) ∈ m.records :=
  SFT.QuantumComputation.Measurement.closedDistinctionRetained _ _ _ _ _ _ m.generated branch member classified different

theorem fullStateReconstructed {p : QuantumPhysicalState.Prepared} (m : Measurement p) :
    (⟨m.records.map Prod.fst,m.selected.phaseCycle⟩ : State) = p.state :=
  SFT.QuantumComputation.Measurement.reconstructEntireState _ _ _ _ _ m.generated

theorem fullPreparationRetained {p : QuantumPhysicalState.Prepared} (m : Measurement p) :
    (sourceBoundRecord m).1 = p.sourceIdentity ∧ (sourceBoundRecord m).2.1 = p.preparation := ⟨rfl,rfl⟩
end SFT.Physics.QuantumPhysicalObservable
