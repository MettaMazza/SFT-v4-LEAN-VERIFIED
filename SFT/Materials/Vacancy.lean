import SFT.Materials.PointDefect
namespace SFT.Materials.Vacancy
-- MATERIALS_OBLIGATIONS[18]: the absence is the occupant state of a retained
-- reference site. It is not site deletion or a scalar amount.
inductive Occupant (Content : Type) where
 | emptyOne
 | occupied (content : Content)

structure SiteRecord (Content : Type) where
 site : String
 referenceOccupant : Content
 occupant : Occupant Content
 provenance : SFT.Host.Canonical.Value
 boundary : String

variable {Content : Type}
def vacate (record : SiteRecord Content) : SiteRecord Content :=
 {record with occupant := .emptyOne}
def isVacancy (record : SiteRecord Content) : Prop := record.occupant = .emptyOne

theorem vacancyExactly (record : SiteRecord Content) :
 isVacancy record ↔ ∃ original : Content, record =
 ⟨record.site,original,.emptyOne,record.provenance,record.boundary⟩ := by
 constructor
 · intro absent
   cases record with
   | mk site reference occupant provenance boundary =>
     change occupant=Occupant.emptyOne at absent
     cases absent
     exact ⟨reference,rfl⟩
 · intro ⟨original,eq⟩
   exact congrArg SiteRecord.occupant eq

theorem vacated (record : SiteRecord Content) : isVacancy (vacate record) := rfl

theorem siteRetained (record : SiteRecord Content) : (vacate record).site=record.site := rfl

theorem referenceRetained (record : SiteRecord Content) :
 (vacate record).referenceOccupant=record.referenceOccupant := rfl

theorem provenanceRetained (record : SiteRecord Content) :
 (vacate record).provenance=record.provenance ∧ (vacate record).boundary=record.boundary := ⟨rfl,rfl⟩

theorem absenceDistinctFromOccupied (content : Content) :
 Occupant.emptyOne ≠ Occupant.occupied content := by intro eq; cases eq

theorem occupiedNotVacancy (site : String) (reference content : Content)
 (provenance : SFT.Host.Canonical.Value) (boundary : String) :
 ¬ isVacancy (⟨site,reference,.occupied content,provenance,boundary⟩ : SiteRecord Content) := by
 intro eq
 cases eq

def vacancyLedger (records : List (SiteRecord Content)) : List (SiteRecord Content) := records.map vacate

theorem allReferenceSitesRetained (records : List (SiteRecord Content)) :
 (vacancyLedger records).map SiteRecord.site = records.map SiteRecord.site := by
 induction records with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons row.site) ih

theorem ledgerCountRetained (records : List (SiteRecord Content)) :
 (vacancyLedger records).length=records.length := SFT.Foundation.CommonRefinement.mapLength _ _

theorem repeatedVacancyNoSiteChange (record : SiteRecord Content) :
 vacate (vacate record)=vacate record := rfl

end SFT.Materials.Vacancy
