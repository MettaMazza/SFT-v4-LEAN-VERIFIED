import SFT.Physics.QuantumPhysicalBell
namespace SFT.Physics.QuantumPhysicalContextuality
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleObservation

structure Observation (p : QuantumPhysicalState.Prepared) where
  context : Classification
  selectedClass : String
  selected : State
  records : List Record
  generated : observe p.state context selectedClass = .ok (selected,records)

def fullRecord {p : QuantumPhysicalState.Prepared} (o : Observation p) :=
  (p,o.context,o.selectedClass,o.records)

theorem contextAndPreparationHeld {p : QuantumPhysicalState.Prepared} (o : Observation p) :
    (fullRecord o).1 = p ∧ (fullRecord o).2.1 = o.context := ⟨rfl,rfl⟩

theorem everyOriginalBranchHeld {p : QuantumPhysicalState.Prepared} (o : Observation p) :
    o.records.map Prod.fst = p.state.branches :=
  (observationReconstruction _ _ _ _ _ o.generated).1

theorem changedContextRecordExcludesErasedAssignment {Item Context Reading : Type}
    (read : Item → Context → Reading) (item : Item) (left right : Context)
    (changed : read item left ≠ read item right) :
    ¬ ∃ assignment : Item → Reading,
      assignment item = read item left ∧ assignment item = read item right := by
  intro ⟨assignment,a,b⟩
  exact changed (a.symm.trans b)

theorem noUniversalContextErasingAssignment {Item Context Reading : Type}
    (items : List Item) (contexts : List Context) (read : Item → Context → Reading)
    (item : Item) (left right : Context) (hi : item ∈ items)
    (hl : left ∈ contexts) (hr : right ∈ contexts)
    (changed : read item left ≠ read item right) :
    ¬ ∃ assignment : Item → Reading, ∀ i ∈ items, ∀ c ∈ contexts, assignment i = read i c := by
  intro ⟨assignment,h⟩
  exact changedContextRecordExcludesErasedAssignment read item left right changed
    ⟨assignment,h item hi left hl,h item hi right hr⟩

theorem distinctCompleteContextsRemainRecorded {p : QuantumPhysicalState.Prepared}
    (a b : Observation p) (different : a.context ≠ b.context) : fullRecord a ≠ fullRecord b :=
  fun equal => different (congrArg (fun x => x.2.1) equal)
end SFT.Physics.QuantumPhysicalContextuality
