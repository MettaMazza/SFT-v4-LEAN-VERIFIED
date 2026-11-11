import SFT.Chemistry.SpeciesClass
namespace SFT.Chemistry.SubstanceIdentity

-- Composition and property values are the retained source records. The
-- structural result is uniform in their exact generated representation.
structure Constituent (Composition : Type) where
 entity : EntityIdentity.Entity
 composition : Composition

structure Record (Composition Property Source Phase : Type) where
 composition : Composition
 constituents : List (Constituent Composition)
 properties : List Property
 source : Source
 phase : Option Phase

variable {C P S H : Type}

def admitted (record : Record C P S H) : Prop :=
 record.constituents ≠ [] ∧ record.properties ≠ [] ∧
 ∀ row, row ∈ record.constituents → row.composition = record.composition

def initial (row : Constituent C) (property : P) (source : S) (phase : Option H) : Record C P S H :=
 ⟨row.composition,[row],[property],source,phase⟩

theorem initialAdmitted (row : Constituent C) (property : P) (source : S) (phase : Option H) :
 admitted (initial row property source phase) := by
 refine ⟨(fun h => nomatch h), (fun h => nomatch h), ?_⟩
 intro member held
 cases held with
 | head => rfl
 | tail _ impossible => cases impossible

def appendProperty (record : Record C P S H) (row : P) : Record C P S H :=
 {record with properties := record.properties ++ [row]}

def appendConstituent (record : Record C P S H) (row : Constituent C) : Record C P S H :=
 {record with constituents := record.constituents ++ [row]}

theorem propertyRetained (record : Record C P S H) (new prior : P)
 (held : prior ∈ record.properties) : prior ∈ (appendProperty record new).properties :=
 List.mem_append_left _ held

theorem constituentRetained (record : Record C P S H) (new prior : Constituent C)
 (held : prior ∈ record.constituents) : prior ∈ (appendConstituent record new).constituents :=
 List.mem_append_left _ held

theorem propertySuccessorBoundary (record : Record C P S H) (row : P) :
 (appendProperty record row).composition = record.composition ∧
 (appendProperty record row).source = record.source ∧
 (appendProperty record row).phase = record.phase ∧
 (appendProperty record row).constituents = record.constituents := ⟨rfl,rfl,rfl,rfl⟩

theorem constituentSuccessorBoundary (record : Record C P S H) (row : Constituent C) :
 (appendConstituent record row).composition = record.composition ∧
 (appendConstituent record row).source = record.source ∧
 (appendConstituent record row).phase = record.phase ∧
 (appendConstituent record row).properties = record.properties := ⟨rfl,rfl,rfl,rfl⟩

theorem propertySuccessorAdmitted (record : Record C P S H) (row : P)
 (valid : admitted record) : admitted (appendProperty record row) := by
 refine ⟨valid.1, ?_, valid.2.2⟩
 intro empty
 have held : row ∈ (appendProperty record row).properties := List.mem_append_right _ (List.Mem.head _)
 rw [empty] at held
 cases held

theorem constituentSuccessorAdmitted (record : Record C P S H) (row : Constituent C)
 (valid : admitted record) (same : row.composition = record.composition) :
 admitted (appendConstituent record row) := by
 refine ⟨?_,valid.2.1,?_⟩
 · intro empty
   have held : row ∈ (appendConstituent record row).constituents := List.mem_append_right _ (List.Mem.head _)
   rw [empty] at held
   cases held
 · intro prior held
   have cases := SFT.Foundation.Count.TraceDerivation.memAppendCases prior record.constituents [row] held
   cases cases with
   | inl old => exact valid.2.2 prior old
   | inr fresh =>
     cases fresh with
     | head => exact same
     | tail _ impossible => cases impossible

theorem unrecordedVariableCompositionRejected (record : Record C P S H) (row : Constituent C)
 (different : row.composition ≠ record.composition) : ¬ admitted (appendConstituent record row) := by
 intro valid
 exact different (valid.2.2 row (List.mem_append_right _ (List.Mem.head _)))

def sameIdentity (a b : Record C P S H) : Prop :=
 a.composition = b.composition ∧
 (∀ entity, entity ∈ a.constituents.map Constituent.entity ↔ entity ∈ b.constituents.map Constituent.entity) ∧
 a.properties = b.properties ∧ a.source = b.source ∧ a.phase = b.phase

theorem leastRequiredIdentity (relation : Record C P S H → Record C P S H → Prop)
 (retains : ∀ a b, relation a b → a.composition = b.composition ∧
 (∀ entity, entity ∈ a.constituents.map Constituent.entity ↔ entity ∈ b.constituents.map Constituent.entity) ∧
 a.properties = b.properties ∧ a.source = b.source ∧ a.phase = b.phase)
 (a b : Record C P S H) (same : relation a b) : sameIdentity a b := retains a b same

theorem propertyDifferenceRetained (a b : Record C P S H) (different : a.properties ≠ b.properties) :
 ¬ sameIdentity a b := fun same => different same.2.2.1

theorem sourceDifferenceRetained (a b : Record C P S H) (different : a.source ≠ b.source) :
 ¬ sameIdentity a b := fun same => different same.2.2.2.1

theorem phaseDifferenceRetained (a b : Record C P S H) (different : a.phase ≠ b.phase) :
 ¬ sameIdentity a b := fun same => different same.2.2.2.2

def appendProperties : Record C P S H → List P → Record C P S H
 | record, [] => record
 | record, row :: rest => appendProperties (appendProperty record row) rest

theorem finitePropertiesAdmitted (record : Record C P S H) (rows : List P) (valid : admitted record) :
 admitted (appendProperties record rows) := by
 induction rows generalizing record with
 | nil => exact valid
 | cons row rest ih => exact ih _ (propertySuccessorAdmitted record row valid)

theorem finitePropertiesRetained (record : Record C P S H) (rows : List P) (prior : P)
 (held : prior ∈ record.properties) : prior ∈ (appendProperties record rows).properties := by
 induction rows generalizing record with
 | nil => exact held
 | cons row rest ih => exact ih _ (propertyRetained record row prior held)

theorem finiteBoundaryRetained (record : Record C P S H) (rows : List P) :
 (appendProperties record rows).composition = record.composition ∧
 (appendProperties record rows).source = record.source ∧
 (appendProperties record rows).phase = record.phase := by
 induction rows generalizing record with
 | nil => exact ⟨rfl,rfl,rfl⟩
 | cons row rest ih => exact ih (appendProperty record row)

inductive History : Record C P S H → Record C P S H → Prop where
 | base (record : Record C P S H) (valid : admitted record) : History record record
 | property {first prior : Record C P S H} (history : History first prior) (row : P) :
   History first (appendProperty prior row)
 | constituent {first prior : Record C P S H} (history : History first prior)
   (row : Constituent C) (same : row.composition = prior.composition) :
   History first (appendConstituent prior row)

theorem historyAdmitted {first last : Record C P S H} (history : History first last) : admitted last := by
 induction history with
 | base valid => exact valid
 | property prior row ih => exact propertySuccessorAdmitted _ row ih
 | constituent prior row same ih => exact constituentSuccessorAdmitted _ row ih same

theorem historyBoundary {first last : Record C P S H} (history : History first last) :
 last.composition = first.composition ∧ last.source = first.source ∧ last.phase = first.phase := by
 induction history with
 | base => exact ⟨rfl,rfl,rfl⟩
 | property prior row ih => exact ih
 | constituent prior row same ih => exact ih

theorem historyRetainsProperties {first last : Record C P S H} (history : History first last)
 (row : P) (held : row ∈ first.properties) : row ∈ last.properties := by
 induction history with
 | base => exact held
 | property prior new ih => exact propertyRetained _ new row ih
 | constituent prior new same ih => exact ih

theorem historyRetainsConstituents {first last : Record C P S H} (history : History first last)
 (row : Constituent C) (held : row ∈ first.constituents) : row ∈ last.constituents := by
 induction history with
 | base => exact held
 | property prior new ih => exact ih
 | constituent prior new same ih => exact constituentRetained _ new row ih

end SFT.Chemistry.SubstanceIdentity
