import SFT.Materials.PropertyContext
namespace SFT.Materials.PropertyRelation
open PropertyContext SFT.Host.Canonical
variable {C : Type}

-- MATERIALS_OBLIGATIONS[5]: the conditional stimulus/response relation.
def holds (record : Record C) (stimulus response : Value) : Prop :=
 (stimulus,response)∈record.relation

def sameRelation (a b : Record C) : Prop :=
 ∀ stimulus response, holds a stimulus response ↔ holds b stimulus response

def reproduces (a b : Record C) : Prop := a.boundary=b.boundary ∧ sameRelation a b

def initial (boundary : Boundary C) (stimulus response : Value) : Record C :=
 ⟨boundary,[(stimulus,response)]⟩

theorem initialHeld (boundary : Boundary C) (stimulus response : Value) :
 holds (initial boundary stimulus response) stimulus response := .head _

theorem repeatPreservesRelation (record : Record C) (row : Value × Value)
 (held : row∈record.relation) : sameRelation record (append record row) := by
 intro stimulus response
 constructor
 · intro old; exact List.mem_append_left _ old
 · intro extended
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases (stimulus,response) record.relation [row] extended with
   | inl old => exact old
   | inr repeated =>
     cases repeated with
     | head => exact held
     | tail _ h => cases h

theorem repeatedObservationReproduces (record : Record C) (row : Value × Value)
 (held : row∈record.relation) : reproduces record (append record row) :=
 ⟨rfl,repeatPreservesRelation record row held⟩

theorem reproductionTransitive (a b c : Record C)
 (ab : reproduces a b) (bc : reproduces b c) : reproduces a c :=
 ⟨ab.1.trans bc.1,fun u v => (ab.2 u v).trans (bc.2 u v)⟩

theorem finiteRepetition (record : Record C) (rows : List (Value × Value))
 (sourceBound : ∀ row∈rows, row∈record.relation) : reproduces record (appendMany record rows) := by
 induction rows generalizing record with
 | nil => exact ⟨rfl,fun _ _ => Iff.rfl⟩
 | cons row rest ih =>
   apply reproductionTransitive record (append record row)
   · exact repeatedObservationReproduces record row (sourceBound row (.head _))
   · apply ih
     intro next member
     exact List.mem_append_left _ (sourceBound next (.tail _ member))

theorem unrecordedResponseChangesRelation (record : Record C) (stimulus response : Value)
 (absent : ¬holds record stimulus response) : ¬ sameRelation record (append record (stimulus,response)) := by
 intro same
 exact absent ((same stimulus response).mpr (List.mem_append_right _ (.head _)))

theorem changedBoundaryExcluded (a b : Record C) (changed : a.boundary≠b.boundary) :
 ¬ reproduces a b := fun h => changed h.1

-- Conditional relations retain all supplied response records; no single-output
-- or scalar response restriction is added to the source's accepted domain.
theorem everyRecordedResponseHeld (record : Record C) (stimulus left right : Value)
 (hl : (stimulus,left)∈record.relation) (hr : (stimulus,right)∈record.relation) :
 holds record stimulus left ∧ holds record stimulus right := ⟨hl,hr⟩

def admitted (record : Record C) : Prop :=
 MaterialCarrier.admitted record.boundary.material ∧ record.relation≠[]

theorem initialAdmitted (boundary : Boundary C) (stimulus response : Value)
 (material : MaterialCarrier.admitted boundary.material) : admitted (initial boundary stimulus response) :=
 by
 refine ⟨material,?_⟩
 intro h
 cases h

theorem extensionAdmitted (record : Record C) (row : Value × Value)
 (positive : admitted record) : admitted (append record row) := by
 refine ⟨positive.1,?_⟩
 intro empty
 cases old : record.relation with
 | nil => exact positive.2 old
 | cons first rest =>
   change record.relation++[row]=[] at empty
   rw [old] at empty
   cases empty

theorem finiteAdmission (record : Record C) (rows : List (Value × Value))
 (positive : admitted record) : admitted (appendMany record rows) := by
 induction rows generalizing record with
 | nil => exact positive
 | cons first rest ih => exact ih (append record first) (extensionAdmitted record first positive)
end SFT.Materials.PropertyRelation
