import SFT.Materials.MaterialCarrierRetention
namespace SFT.Materials.PlasticReorganization

structure State (C : Type) where
 material : MaterialCarrier.Record C
 phaseIdentity : String

structure Change (C : Type) where
 adjacency : List (String × String × String)
 observationBoundary : String
 observations : List (String × String)
 defectTrace : List SFT.Host.Canonical.Value
 defectHeld : defectTrace ≠ []
 yieldBoundary : SFT.Host.Canonical.Value

def applyChange {C : Type} (s : State C) (change : Change C) : State C :=
 ⟨⟨s.material.constituents,change.adjacency,change.observationBoundary,change.observations⟩,s.phaseIdentity⟩

theorem allContentRetained {C : Type} (s : State C) (change : Change C) :
 (applyChange s change).material.constituents = s.material.constituents := rfl

theorem phaseIdentityRetained {C : Type} (s : State C) (change : Change C) :
 (applyChange s change).phaseIdentity = s.phaseIdentity := rfl

theorem actualAdjacencyRetained {C : Type} (s : State C) (change : Change C) :
 (applyChange s change).material.bonding = change.adjacency := rfl

theorem changedCanonicalOrganization {C : Type} (s : State C) (change : Change C)
 (changed : change.adjacency ≠ s.material.bonding) :
 (applyChange s change).material ≠ s.material := by
 intro same
 exact changed (congrArg MaterialCarrier.Record.bonding same)

theorem recordedReleaseDoesNotRestore {C : Type} (s : State C) (change : Change C)
 (changed : change.adjacency ≠ s.material.bonding) : applyChange s change ≠ s := by
 intro same
 exact changedCanonicalOrganization s change changed (congrArg State.material same)

def history {C : Type} (s : State C) : List (Change C) → State C
 | [] => s
 | step::rest => history (applyChange s step) rest

theorem everyFiniteHistoryRetainsContent {C : Type} (s : State C) (steps : List (Change C)) :
 (history s steps).material.constituents = s.material.constituents := by
 induction steps generalizing s with
 | nil => rfl
 | cons step rest ih => exact ih (applyChange s step)

theorem everyFiniteHistoryRetainsPhase {C : Type} (s : State C) (steps : List (Change C)) :
 (history s steps).phaseIdentity = s.phaseIdentity := by
 induction steps generalizing s with
 | nil => rfl
 | cons step rest ih => exact ih (applyChange s step)

structure Row (C : Type) where
 before : State C
 releasedChange : Change C
 changed : releasedChange.adjacency ≠ before.material.bonding

def record {C : Type} (r : Row C) := (r,applyChange r.before r.releasedChange)

theorem defectRecordRetained {C : Type} (r : Row C) :
 (record r).1.releasedChange.defectTrace = r.releasedChange.defectTrace := rfl

theorem yieldBoundaryRetained {C : Type} (r : Row C) :
 (record r).1.releasedChange.yieldBoundary = r.releasedChange.yieldBoundary := rfl

theorem plasticRowMeaning {C : Type} (r : Row C) :
 (record r).2.material.constituents = r.before.material.constituents ∧
 (record r).2.phaseIdentity = r.before.phaseIdentity ∧
 (record r).2.material.bonding ≠ r.before.material.bonding ∧
 (record r).2 ≠ r.before :=
 ⟨rfl,rfl,r.changed,recordedReleaseDoesNotRestore r.before r.releasedChange r.changed⟩

def records {C : Type} (rows : List (Row C)) := rows.map record

theorem base {C : Type} (r : Row C) : records [r] = [record r] := rfl

theorem successor {C : Type} (rows : List (Row C)) (next : Row C) :
 records (rows ++ [next]) = records rows ++ [record next] := by
 induction rows with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head)) ih

end SFT.Materials.PlasticReorganization
