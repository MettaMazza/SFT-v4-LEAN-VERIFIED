import SFT.Materials.Vacancy
namespace SFT.Materials.InterstitialSubstitution
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
variable {Content : Type}

-- MATERIALS_OBLIGATIONS[19]: an added occupied site versus a changed
-- occupant at a retained reference site. Input labels/content are held data.
structure AddedSite (Content : Type) (reference : List (String × Content)) where
 site : String
 occupant : Content
 fresh : site ∉ reference.map Prod.fst
 provenance : SFT.Host.Canonical.Value
 boundary : String

def insert {reference : List (String × Content)} (record : AddedSite Content reference) :=
 reference ++ [(record.site,record.occupant)]

theorem referenceRowsRetained {reference : List (String × Content)}
 (record : AddedSite Content reference) (row : String × Content) (held : row∈reference) :
 row∈insert record := memAppendLeft _ _ _ held

theorem newOccupiedRowRetained {reference : List (String × Content)}
 (record : AddedSite Content reference) : (record.site,record.occupant)∈insert record :=
 memAppendRight _ _ _ (.head _)

theorem oneOccupiedRelationAdded {reference : List (String × Content)}
 (record : AddedSite Content reference) : (insert record).length=reference.length+1 := by
 unfold insert
 rw [appendLength]
 rfl

def substitute (record : Vacancy.SiteRecord Content) (content : Content) : Vacancy.SiteRecord Content :=
 {record with occupant := .occupied content}

theorem substitutionRetainsSite (record : Vacancy.SiteRecord Content) (content : Content) :
 (substitute record content).site=record.site := rfl

theorem substitutionRetainsReference (record : Vacancy.SiteRecord Content) (content : Content) :
 (substitute record content).referenceOccupant=record.referenceOccupant := rfl

theorem substitutionRetainsProvenance (record : Vacancy.SiteRecord Content) (content : Content) :
 (substitute record content).provenance=record.provenance ∧
 (substitute record content).boundary=record.boundary := ⟨rfl,rfl⟩

theorem changedOccupantExactly (record : Vacancy.SiteRecord Content) (content : Content) :
 (substitute record content).occupant ≠ .occupied record.referenceOccupant ↔
 content≠record.referenceOccupant := by
 constructor
 · intro changed same
   cases same
   exact changed rfl
 · intro different same
   exact different (Vacancy.Occupant.occupied.inj same)

theorem substitutionIsOccupied (record : Vacancy.SiteRecord Content) (content : Content) :
 ¬ Vacancy.isVacancy (substitute record content) := by
 intro absent
 cases absent

theorem insertedAndRetainedSitesDistinct {reference : List (String × Content)}
 (added : AddedSite Content reference) (replacement : Vacancy.SiteRecord Content)
 (retained : replacement.site∈reference.map Prod.fst) : added.site≠replacement.site := by
 intro same
 exact added.fresh (same.symm ▸ retained)

theorem repeatedReplacementSame (record : Vacancy.SiteRecord Content) (first second : Content) :
 substitute (substitute record first) second=substitute record second := rfl
end SFT.Materials.InterstitialSubstitution
