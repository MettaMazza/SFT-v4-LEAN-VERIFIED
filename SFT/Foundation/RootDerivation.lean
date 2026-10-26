import SFT.Foundation.Root
/-! Record-level Root derivation from root_theorem.py candidate_records,
decision_record, completeness_record and closure_record. SourceRecord preserves
exactly the three source dictionary fields on their annotated generated domain.
Strings are source record metadata, not scientific parameters. Theorems quantify
all such records, not only the two stored records. -/
namespace SFT.Foundation.Root.Derivation

structure SourceRecord where
  candidateId : String
  presented : Bool
  exactForm : String

structure SourceDecision where
  candidateId : String
  survives : Bool
  reason : String

def generatedRecord (c : Candidate) : SourceRecord :=
  ⟨candidateId c, presented c, exactForm c⟩

def decisionRecord (r : SourceRecord) : SourceDecision :=
  ⟨r.candidateId, r.presented,
    if r.presented then "Presentation supplies the witnessed occurrence required by the theorem."
    else "Without a presentation there is no counterexample object to admit."⟩

-- The source generation relation itself determines the classifier.
def classify (r : SourceRecord) : Candidate :=
  match r.presented with
  | false => .c0
  | true => .c1

theorem classificationPreservesPresentation (r : SourceRecord) :
    presented (classify r) = r.presented := by
  cases r with
  | mk id p form => cases p <;> rfl

theorem generatedClassificationInverse (c : Candidate) : classify (generatedRecord c) = c := by
  cases c <;> rfl

theorem recordClassificationExhaustive (r : SourceRecord) : classify r ∈ candidates :=
  candidatesComplete (classify r)

theorem classificationExact (r s : SourceRecord) :
    classify r = classify s ↔ r.presented = s.presented := by
  constructor
  · intro h
    exact (classificationPreservesPresentation r).symm.trans
      ((congrArg presented h).trans (classificationPreservesPresentation s))
  · intro h
    unfold classify
    rw [h]

theorem decisionAgreesWithClassification (r : SourceRecord) :
    (decisionRecord r).survives = survives (classify r) :=
  (classificationPreservesPresentation r).symm

theorem everyAcceptedRecordHasSurvivorClass (r : SourceRecord) :
    (decisionRecord r).survives = true ↔ classify r = survivor := by
  rw [decisionAgreesWithClassification]
  exact uniqueSurvivor (classify r)

theorem generatedDecisionPreserved (c : Candidate) :
    decisionRecord (generatedRecord c) = ⟨candidateId c, survives c, decisionReason c⟩ := by
  cases c <;> rfl

-- The source's occurrence witness is presentation at its operational boundary.
-- This is not a new ontological object or an assumption about unexpressed domains.
def witnessedOccurrence (r : SourceRecord) : Prop := r.presented = true

def unpresentedAbsence (r : SourceRecord) : Prop := r.presented = false

theorem acceptanceIffWitnessedOccurrence (r : SourceRecord) :
    (decisionRecord r).survives = true ↔ witnessedOccurrence r := ⟨fun h => h, fun h => h⟩

theorem admittedRecordCannotBeUnpresented (r : SourceRecord)
    (h : (decisionRecord r).survives = true) : ¬ unpresentedAbsence r := by
  intro absent
  exact Bool.noConfusion (h.symm.trans absent)

theorem unpresentedRecordExcluded (r : SourceRecord) (h : unpresentedAbsence r) :
    (decisionRecord r).survives = false := h

theorem decisionIndependentOfMetadata (r : SourceRecord) (id form : String) :
    (decisionRecord {r with candidateId := id, exactForm := form}).survives =
    (decisionRecord r).survives := rfl

theorem reasonIndependentOfMetadata (r : SourceRecord) (id form : String) :
    (decisionRecord {r with candidateId := id, exactForm := form}).reason =
    (decisionRecord r).reason := rfl

theorem deletingPresentationExcludesRecord (r : SourceRecord) :
    (decisionRecord {r with presented := false}).survives = false := rfl

end SFT.Foundation.Root.Derivation
