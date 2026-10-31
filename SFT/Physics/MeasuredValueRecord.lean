import SFT.Host.Canonical
namespace SFT.Physics.MeasuredValueRecord
-- measurement_laws.py VALUE_RECORD: external inscriptions are held text.
-- No parser from the reported inscription to a proof-domain scalar is added.
structure Record where
  referenceIdentity : String
  numericalInscription : String
  observationProvenance : SFT.Host.Canonical.Value

def replaceInscription (r : Record) (s : String) : Record :=
  {r with numericalInscription := s}

theorem referenceRetained (r : Record) (s : String) :
    (replaceInscription r s).referenceIdentity = r.referenceIdentity := rfl

theorem provenanceRetained (r : Record) (s : String) :
    (replaceInscription r s).observationProvenance = r.observationProvenance := rfl

theorem inscriptionRetained (r : Record) (s : String) :
    (replaceInscription r s).numericalInscription = s := rfl

theorem differentReferencesDistinct (a b : Record)
    (different : a.referenceIdentity ≠ b.referenceIdentity) : a ≠ b :=
  fun equal => different (congrArg Record.referenceIdentity equal)

theorem differentInscriptionsDistinct (a b : Record)
    (different : a.numericalInscription ≠ b.numericalInscription) : a ≠ b :=
  fun equal => different (congrArg Record.numericalInscription equal)

theorem differentProvenanceDistinct (a b : Record)
    (different : a.observationProvenance ≠ b.observationProvenance) : a ≠ b :=
  fun equal => different (congrArg Record.observationProvenance equal)

theorem exactReconstruction (r : Record) :
    (⟨r.referenceIdentity,r.numericalInscription,r.observationProvenance⟩ : Record) = r := rfl
end SFT.Physics.MeasuredValueRecord
