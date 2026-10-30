import SFT.QuantumComputation.StateComposition
namespace SFT.QuantumComputation.Entanglement
open SFT.QuantumComputation.StateComposition SFT.QuantumComputation.ReversibleObservation
open SFT.Mathematics.DiscreteObjects

theorem correlationRequiresBothDistinctions (joint : List (String × String))
    (nonempty : joint.isEmpty = false) (unique : distinct joint = true)
    (correlated : isFactorable joint = .ok false) :
    ∃ left, left ∈ joint ∧ ∃ right, right ∈ joint ∧
      left.1 ≠ right.1 ∧ left.2 ≠ right.2 ∧ (left.1,right.2) ∉ joint := by
  obtain ⟨left,leftHeld,right,rightHeld,missing⟩ := (correlatedMissingCell joint nonempty unique).mp correlated
  refine ⟨left,leftHeld,right,rightHeld,?_,?_,missing⟩
  · intro same
    have member : (left.1,right.2) ∈ joint := by rw [same]; exact rightHeld
    exact missing member
  · intro same
    have member : (left.1,right.2) ∈ joint := by rw [← same]; exact leftHeld
    exact missing member

theorem retainedCorrelationWitness (joint : List (String × String))
    (nonempty : joint.isEmpty = false) (unique : distinct joint = true)
    (left right : String × String) (leftHeld : left ∈ joint) (rightHeld : right ∈ joint)
    (missing : (left.1,right.2) ∉ joint) : isFactorable joint = .ok false :=
  (correlatedMissingCell joint nonempty unique).mpr ⟨left,leftHeld,right,rightHeld,missing⟩
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleComposition
open SFT.InformationScience.EncodingMaps

theorem selectedComponentProvenance (left right joint selected : State)
    (composed : compose left right = .ok joint) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe joint mapping label = .ok (selected,record))
    (row : Word × String) : row ∈ selected.branches ↔
    ∃ l r, Cell left right l r row ∧ lookupFirst mapping row.1 = some label := by
  constructor
  · intro held
    have original := (observationMembership joint selected mapping label record observed row).mp held
    obtain ⟨l,r,cell⟩ := (compositionRowsExactly left right joint composed row).mp original.1
    exact ⟨l,r,cell,original.2⟩
  · intro ⟨l,r,cell,classified⟩
    exact (observationMembership joint selected mapping label record observed row).mpr
      ⟨(compositionRowsExactly left right joint composed row).mpr ⟨l,r,cell⟩,classified⟩

theorem everyComponentRecordRetained (left right joint selected : State)
    (composed : compose left right = .ok joint) (mapping : Classification) (label : String)
    (record : List Record) (observed : observe joint mapping label = .ok (selected,record))
    (l r row : Word × String) (cell : Cell left right l r row) :
    row ∈ record.map Prod.fst := by
  rw [(observationReconstruction joint selected mapping label record observed).1]
  exact (compositionRowsExactly left right joint composed row).mpr ⟨l,r,cell⟩

end SFT.QuantumComputation.Entanglement
