import SFT.Foundation.One
import SFT.Foundation.RootDerivation
/-! Source one.py ROOT_COVERAGE, EXTRA_COVERAGE, candidate_records,
completeness_record and closure_record. The enums encode exactly the declared
source relation values. No occurrence carrier or numerical One is introduced. -/
namespace SFT.Foundation.One.Derivation

inductive RootCoverage where
  | none | proper | complete

inductive ExtraCoverage where
  | noExtra | hasExtra

def coverageName : RootCoverage → String
  | .none => "none"
  | .proper => "proper"
  | .complete => "complete"

def extraName : ExtraCoverage → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure SourceRecord where
  candidateId : String
  rootCoverage : RootCoverage
  extraCoverage : ExtraCoverage
  exactForm : String

def classifyRelations : RootCoverage → ExtraCoverage → Candidate
  | .none, .noExtra => .c0
  | .none, .hasExtra => .c1
  | .proper, .noExtra => .c2
  | .proper, .hasExtra => .c3
  | .complete, .noExtra => .c4
  | .complete, .hasExtra => .c5

def rootRelation : Candidate → RootCoverage
  | .c0 | .c1 => .none
  | .c2 | .c3 => .proper
  | .c4 | .c5 => .complete

def extraRelation : Candidate → ExtraCoverage
  | .c0 | .c2 | .c4 => .noExtra
  | .c1 | .c3 | .c5 => .hasExtra

def generatedRecord (c : Candidate) : SourceRecord :=
  ⟨candidateId c, rootRelation c, extraRelation c, exactForm c⟩

def classify (r : SourceRecord) : Candidate := classifyRelations r.rootCoverage r.extraCoverage

def survivesRecord (r : SourceRecord) : Bool :=
  coverageName r.rootCoverage == "complete" && extraName r.extraCoverage == "no-extra"

def reasonRecord (r : SourceRecord) : String :=
  if coverageName r.rootCoverage == "none" then "It does not retain the admitted root occurrence." else
  if coverageName r.rootCoverage == "proper" then "It presupposes a cut and fails to retain the complete admitted identity." else
  if extraName r.extraCoverage == "has-extra" then "It introduces material not supplied by the sole admitted dependency." else
  "It retains the complete admitted occurrence without omission or addition."

def generatedProduct : List Candidate :=
  ([RootCoverage.none,.proper,.complete]).flatMap fun c =>
    ([ExtraCoverage.noExtra,.hasExtra]).map (classifyRelations c)

theorem generatedProductPreserved : generatedProduct = candidates := rfl

theorem relationsPreserved (c : RootCoverage) (e : ExtraCoverage) :
    rootRelation (classifyRelations c e) = c ∧ extraRelation (classifyRelations c e) = e := by
  cases c <;> cases e <;> exact ⟨rfl,rfl⟩

theorem generatedClassificationInverse (c : Candidate) : classify (generatedRecord c) = c := by
  cases c <;> rfl

theorem recordClassificationExhaustive (r : SourceRecord) : classify r ∈ generatedProduct := by
  rw [generatedProductPreserved]
  exact candidatesComplete (classify r)

theorem decisionAgreesWithClassification (r : SourceRecord) :
    survivesRecord r = survives (classify r) := by
  cases r with
  | mk id cov ext form => cases cov <;> cases ext <;> rfl

theorem reasonAgreesWithClassification (r : SourceRecord) :
    reasonRecord r = decisionReason (classify r) := by
  cases r with
  | mk id cov ext form => cases cov <;> cases ext <;> rfl

theorem acceptedIffCompleteWithoutAddition (r : SourceRecord) :
    survivesRecord r = true ↔ r.rootCoverage = .complete ∧ r.extraCoverage = .noExtra := by
  cases r with
  | mk id cov ext form =>
    cases cov <;> cases ext <;> constructor
    all_goals intro h
    all_goals first | exact ⟨rfl,rfl⟩ | rfl | cases h
    all_goals rename_i h1 h2
    all_goals first | cases h1 | cases h2
    all_goals cases h2

theorem acceptedIffExactSelfWhole (r : SourceRecord) :
    survivesRecord r = true ↔ classify r = survivor := by
  rw [decisionAgreesWithClassification]
  exact uniqueSurvivor (classify r)

theorem generatedDecisionPreserved (c : Candidate) :
    survivesRecord (generatedRecord c) = survives c ∧
    reasonRecord (generatedRecord c) = decisionReason c := by
  cases c <;> exact ⟨rfl,rfl⟩

theorem omissionRejected (r : SourceRecord) :
    survivesRecord {r with rootCoverage := .none} = false := by
  cases r with
  | mk id cov ext form => cases ext <;> rfl

theorem fragmentationRejected (r : SourceRecord) :
    survivesRecord {r with rootCoverage := .proper} = false := by
  cases r with
  | mk id cov ext form => cases ext <;> rfl

theorem unforcedAdditionRejected (r : SourceRecord) :
    survivesRecord {r with extraCoverage := .hasExtra} = false := by
  cases r with
  | mk id cov ext form => cases cov <;> rfl

theorem decisionIndependentOfMetadata (r : SourceRecord) (id form : String) :
    survivesRecord {r with candidateId := id, exactForm := form} = survivesRecord r := rfl

theorem reasonIndependentOfMetadata (r : SourceRecord) (id form : String) :
    reasonRecord {r with candidateId := id, exactForm := form} = reasonRecord r := rfl

theorem generatedFieldsPreserved (c : Candidate) :
    coverageName (generatedRecord c).rootCoverage = coverage c ∧
    extraName (generatedRecord c).extraCoverage = extra c ∧
    (generatedRecord c).candidateId = candidateId c ∧
    (generatedRecord c).exactForm = exactForm c := by
  cases c <;> exact ⟨rfl,rfl,rfl,rfl⟩

end SFT.Foundation.One.Derivation
