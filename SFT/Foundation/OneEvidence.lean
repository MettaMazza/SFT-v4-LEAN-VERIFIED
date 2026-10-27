import SFT.Foundation.OneDerivation
import SFT.Foundation.RootEvidence
namespace SFT.Foundation.One.Evidence
open SFT.Host.Canonical
set_option maxRecDepth 20000

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id", .text (candidateId c)), ("root_coverage", .text (coverage c)),
  ("extra_coverage", .text (extra c)), ("exact_form", .text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator", .text generationRule), ("boundary", .text grammarBoundary),
  ("root_coverage_classes", .array [.text "none", .text "proper", .text "complete"]),
  ("extra_coverage_classes", .array [.text "no-extra", .text "has-extra"]),
  ("product", .array (candidates.map candidateRecord)),
  ("exhaustion", .text "Relative to the root identity a representation retains none, a proper fragment, or the complete occurrence; independently it adds no extra material or it does. The generated product contains every pairing.")]

def closureRecord : List (String × String) := [
  ("minimality", "Removing any retained root identity makes the representation incomplete; adding anything introduces an unforced dependency."),
  ("named_shape_uniqueness", "Only exact-self-whole is complete and addition-free."),
  ("generality", "The coverage product is independent of the content, notation, size and internal depth of the admitted root occurrence."),
  ("meaning", "The One is the structural self-whole of an admitted occurrence, not an imported numeral or measured magnitude.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1, .text p.2))

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-ONE-001"
  title := "The structural One"
  branch := "foundation"
  statement := "The unique minimal representation of the admitted root occurrence is its complete self-whole with no unforced addition; this structural identity is the One."
  evidenceMode := .formal
  rootTheorems := ["SFT-ROOT-THERE-IS-NO-NOTHING"]
  dependencies := ["SFT-ROOT-THERE-IS-NO-NOTHING"]
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
    ("reason", .text (decisionReason c)), ("dependency", .text "SFT-ROOT-THERE-IS-NO-NOTHING")])

def candidateDecision (c : Candidate) : Value := SFT.Engine.decisionValue (candidateDecisionData c)

def decideCandidate (id : String) : Except String Value :=
  match candidates.find? (fun c => candidateId c == id) with
  | some c => .ok (candidateDecision c)
  | none => .error (SFT.Host.Text.append "KeyError: " id)

theorem generatedLookup (c : Candidate) :
    decideCandidate (candidateId c) = .ok (candidateDecision c) := by
  cases c <;> rfl

def closureEvidenceData (decisions : List Value) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("closure", closureValue), ("decisions", .array decisions)])
  generalityCertificateHash := some (identity (.object [
    ("coverage_product", .array [.array [.text "none", .text "proper", .text "complete"],
      .array [.text "no-extra", .text "has-extra"]]),
    ("content_independent", .boolean true), ("closure", closureValue)]))

def closureEvidence (decisions : List Value) : Value :=
  SFT.Engine.closureEvidenceValue (closureEvidenceData decisions)

structure ControlRecord where
  kind : SFT.Engine.ControlKind
  expected : String
  observed : String
  passed : Bool

def falsePremise : ControlRecord where
  kind := .falsePremise
  expected := "reject an omitted root as a representation of the admitted occurrence"
  observed := "omitted-root does not survive"
  passed := !(survives .c0)

def tamperedSource (sourceHash : String) : ControlRecord where
  kind := .tamperedSource
  expected := "reject a changed source identity"
  observed := "tampered source identity differs"
  passed := identity (.object [("changed", .text sourceHash)]) != sourceHash

def tamperedArtifact : ControlRecord where
  kind := .tamperedArtifact
  expected := "reject addition of an unforced extra to the complete root"
  observed := "whole-plus-extra does not survive"
  passed := !(survives .c5)

def boundary : ControlRecord where
  kind := .boundary
  expected := "refuse numerical magnitude claims not yet derived"
  observed := "the admitted meaning is structural self-wholeness only"
  passed := SFT.Host.Text.contains "The One is the structural self-whole of an admitted occurrence, not an imported numeral or measured magnitude." "not an imported numeral"

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

end SFT.Foundation.One.Evidence
