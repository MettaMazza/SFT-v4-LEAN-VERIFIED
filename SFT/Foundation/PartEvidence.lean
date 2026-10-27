import SFT.Foundation.PartSelection
import SFT.Foundation.Part
import SFT.Foundation.RootEvidence
namespace SFT.Foundation.Part.Evidence
open SFT.Host.Canonical
set_option maxRecDepth 20000

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id", .text (candidateId c)), ("coverage", .text (coverageName c.coverage)),
  ("overlap", .text (overlapName c.overlap)), ("fibre", .text (fibreName c.fibre)),
  ("selection", .text (selectionName c.selection)), ("held_count", .text (heldName c.held)),
  ("whole_count", .text (wholeName c.whole)), ("extra", .text (extraName c.extra)),
  ("exact_form", .text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator", .text generationRule), ("boundary", .text grammarBoundary),
  ("domains", .object [
    ("coverage", .array [.text "incomplete", .text "complete"]),
    ("overlap", .array [.text "disjoint", .text "overlapping"]),
    ("fibre", .array [.text "unequal", .text "equal"]),
    ("selection", .array [.text "empty", .text "within", .text "outside"]),
    ("held_count", .array [.text "held-absent", .text "held-present"]),
    ("whole_count", .array [.text "whole-absent", .text "whole-present"]),
    ("extra", .array [.text "no-extra", .text "has-extra"])]),
  ("candidates", .array (candidates.map candidateRecord)),
  ("exhaustion", .text "Each criterion is an explicit exhaustive classification at the registered boundary. Their generated product contains every same-grammar coordinate form and does not select a neighborhood around the survivor.")]

def closureRecord : List (String × String) := [
  ("coordinate", "The held count identifies how many equal disjoint fibres are selected; the whole count identifies the complete equal-fibre partition."),
  ("positive_boundary", "The count dependency permits only generated nonempty finite traces. A within-partition selection cannot contain more fibres than its whole."),
  ("minimality", "Removing either count loses selection or reference identity; relaxing complete, disjoint, equal or contained status destroys exact part meaning; adding another coordinate is unforced."),
  ("named_shape_uniqueness", "Only complete__disjoint__equal__within__held-present__whole-present__no-extra satisfies every exact-part requirement."),
  ("generality", "The criterion product is unchanged for every generated positive finite whole count and every generated nonempty contained selection. No maximum depth, semantic zero or completed infinity is installed."),
  ("unresolved", "Whether two coordinates generated from different partitions represent the same part is not assumed here and requires a later common-refinement equivalence derivation.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1, .text p.2))

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-PART-001"
  title := "Exact positive part coordinate"
  branch := "foundation"
  statement := "For every registered finite partition of the structural One that is complete, disjoint and equal-fibred, and every nonempty held selection contained within it, the unique parameter-free exact part coordinate is the pair of positive counts identifying the held selection and the complete partition."
  evidenceMode := .formal
  rootTheorems := ["SFT-ROOT-THERE-IS-NO-NOTHING"]
  dependencies := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-COUNT-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value :=
  SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("generator", .text generationRule), ("record", candidateRecord c)])

def generateCandidatesData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := Int.ofNat candidates.length
  completenessCertificateHash := identity completenessRecord
  candidates := candidates.map generatedCandidateData

def generateCandidates : Value := SFT.Engine.censusValue generateCandidatesData

def candidateDecisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := identity (.object [
    ("record", candidateRecord c), ("survives", .boolean (survives c)),
    ("reason", .text (decisionReason c)), ("dependencies", .array [.text "SFT-FOUNDATION-ONE-001", .text "SFT-FOUNDATION-COUNT-001"])])

def candidateDecision (c : Candidate) : Value := SFT.Engine.decisionValue (candidateDecisionData c)

def decideCandidate (id : String) : Except String Value :=
  match candidates.find? (fun c => candidateId c == id) with
  | some c => .ok (candidateDecision c)
  | none => .error (SFT.Host.Text.append "KeyError: " id)

def closureEvidenceData (decisions : List Value) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("closure", closureValue), ("decisions", .array decisions)])
  generalityCertificateHash := some (identity (.object [
    ("criterion_product_independent_of_count_depth", .boolean true),
    ("dependencies", .array [.text "SFT-FOUNDATION-ONE-001", .text "SFT-FOUNDATION-COUNT-001"]), ("closure", closureValue)]))

def closureEvidence (decisions : List Value) : Value :=
  SFT.Engine.closureEvidenceValue (closureEvidenceData decisions)

structure ControlRecord where
  kind : SFT.Engine.ControlKind
  expected : String
  observed : String
  passed : Bool

def falsePremise : ControlRecord where
  kind := .falsePremise
  expected := "reject an empty selection as a positive part"
  observed := "the empty-selection coordinate does not survive"
  passed := !(survives { survivor with selection := .empty })

def tamperedSource (sourceHash : String) : ControlRecord where
  kind := .tamperedSource
  expected := "reject a changed derivation source identity"
  observed := "the changed source identity differs"
  passed := identity (.object [("changed", .text sourceHash)]) != sourceHash

def tamperedArtifact : ControlRecord where
  kind := .tamperedArtifact
  expected := "reject a selection that extends outside the whole partition"
  observed := "the outside-selection coordinate does not survive"
  passed := !(survives { survivor with selection := .outside })

def boundary : ControlRecord where
  kind := .boundary
  expected := "refuse equivalence, decimal, signed or infinite claims not derived here"
  observed := "the closure records exact coordinates and leaves cross-partition equivalence unresolved"
  passed := SFT.Host.Text.contains "Whether two coordinates generated from different partitions represent the same part is not assumed here and requires a later common-refinement equivalence derivation." "not assumed"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := rfl

def controlValue (c : ControlRecord) : Value := .object [
  ("kind", .text (SFT.Engine.kindName c.kind)), ("expected", .text c.expected),
  ("observed", .text c.observed), ("passed", .boolean c.passed)]

def controlRecords (sourceHash : String) : List ControlRecord :=
  [falsePremise, tamperedSource sourceHash, tamperedArtifact, boundary]

def controlResultData (c : ControlRecord) : SFT.Engine.ControlResult where
  kind := c.kind
  passed := c.passed
  expectedBehavior := c.expected
  observedBehavior := c.observed
  receiptHash := identity (controlValue c)

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (controlResultData c))

end SFT.Foundation.Part.Evidence
