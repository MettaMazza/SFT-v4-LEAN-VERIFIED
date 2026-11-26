import SFT.Chemistry.OrganometallicBond
namespace SFT.Chemistry.OrganometallicBondDerivation
open SFT.Physics.CapabilityValues OrganometallicBond
theorem structuralAbsence (entity identity : String) : forced entity (.empty identity)=.ok (.empty "empty-One") := rfl
theorem topologyRetains (entity : HeldLabel) (rows : List Incidence) (n : PositiveCount)
 (classification : HeldLabel) (result : Topology)
 (accepted : topology entity rows n classification=.ok result) : result=⟨entity,rows,n,classification⟩ := by
 unfold topology at accepted
 split at accepted
 · cases accepted
 · split at accepted
   · cases accepted
   · split at accepted
     · cases accepted
     · split at accepted
       · cases accepted
       · cases accepted; rfl
theorem forceRowsRetains (entity : String) (rows : List Incidence) (result : Topology)
 (accepted : forceRows entity rows=.ok result) :
 result.incidences=rows ∧ result.directCount.value=rows.length ∧ result.classification.label="organometallic" := by
 unfold forceRows at accepted
 split at accepted
 · rename_i positive
   cases he : heldLabel "chemical-entity" entity with
   | error e => rw [he] at accepted; cases accepted
   | ok e =>
    rw [he] at accepted
    have kept := topologyRetains e rows ⟨rows.length,positive⟩ ⟨"chemical-class","organometallic",rfl,rfl⟩ result accepted
    cases kept
    exact ⟨rfl,rfl,rfl⟩
 · cases accepted
theorem forceRowsIdentity (entity : String) (rows : List Incidence) (result : Topology)
 (accepted : forceRows entity rows=.ok result) : result.entity.label=entity := by
 unfold forceRows at accepted
 split at accepted
 · rename_i positive
   cases he : heldLabel "chemical-entity" entity with
   | error e => rw [he] at accepted; cases accepted
   | ok e =>
    rw [he] at accepted
    have named : e.label=entity := by
     unfold heldLabel at he
     split at he
     · split at he
       · cases he; rfl
       · cases he
     · cases he
    have kept := topologyRetains e rows ⟨rows.length,positive⟩ ⟨"chemical-class","organometallic",rfl,rfl⟩ result accepted
    cases kept
    exact named
 · cases accepted
theorem appendIdentity (t result : Topology) (i : Incidence)
 (accepted : appendDirect t i=.ok result) : result.entity.label=t.entity.label :=
 forceRowsIdentity t.entity.label (t.incidences++[i]) result accepted
theorem appendRetains (t result : Topology) (i : Incidence)
 (accepted : appendDirect t i=.ok result) : result.incidences=t.incidences++[i] :=
 (forceRowsRetains t.entity.label (t.incidences++[i]) result accepted).1
theorem appendCount (t result : Topology) (i : Incidence)
 (accepted : appendDirect t i=.ok result) : result.directCount.value=t.incidences.length+1 := by
 have h := (forceRowsRetains t.entity.label (t.incidences++[i]) result accepted).2.1
 exact h.trans (SFT.Foundation.CommonRefinement.appendLength t.incidences [i])
theorem countedSuccessor (t result : Topology) (i : Incidence)
 (coherent : t.directCount.value=t.incidences.length)
 (accepted : appendDirect t i=.ok result) : result.directCount.value=t.directCount.value+1 :=
 (appendCount t result i accepted).trans (congrArg (fun n => n+1) coherent.symm)
theorem appendClassification (t result : Topology) (i : Incidence)
 (accepted : appendDirect t i=.ok result) : result.classification.label="organometallic" :=
 (forceRowsRetains t.entity.label (t.incidences++[i]) result accepted).2.2
def electronWords (rows : List Incidence) : List (List HeldLabel) := rows.map (fun row => row.electrons)
theorem appendElectrons (t result : Topology) (i : Incidence)
 (accepted : appendDirect t i=.ok result) : electronWords result.incidences=electronWords t.incidences++[i.electrons] := by
 rw [appendRetains t result i accepted]
 have step : ∀ rows : List Incidence, electronWords (rows++[i])=electronWords rows++[i.electrons] := by
  intro rows
  induction rows with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.electrons) ih
 exact step t.incidences
end SFT.Chemistry.OrganometallicBondDerivation
