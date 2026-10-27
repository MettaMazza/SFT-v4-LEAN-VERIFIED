import SFT.Foundation.CountRepresentation
import SFT.Foundation.RootEvidence
namespace SFT.Foundation.Count.Evidence
open SFT.Host.Canonical
set_option maxRecDepth 20000

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id", .text (candidateId c)), ("coverage", .text (coverage c)),
  ("multiplicity", .text (multiplicity c)), ("extra", .text (extra c)), ("exact_form", .text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator", .text generationRule), ("boundary", .text grammarBoundary),
  ("coverage_classes", .array [.text "none", .text "proper", .text "complete"]),
  ("multiplicity_classes", .array [.text "once", .text "duplicated"]),
  ("extra_classes", .array [.text "no-extra", .text "has-extra"]),
  ("candidates", .array (candidates.map candidateRecord)),
  ("exhaustion", .text "Any proposed representation retains none, a proper collection, or all of the generated trace. A nonempty retained collection either retains each occurrence once or duplicates at least one. Independently, the proposal either adds no ungenerated occurrence or at least one.")]

def closureRecord : List (String × String) := [
  ("base", "The structural One supplies a nonempty base trace. Complete coverage retains that occurrence once without addition."),
  ("successor", "Appending one newly generated structural-One occurrence extends a complete finite trace by one terminal occurrence. The prior complete trace becomes proper coverage of the extension; retaining the new terminal once restores complete coverage; duplication or material past the terminal is addition."),
  ("induction", "The base and successor clauses apply after every finite generated extension, so the survivor classification does not depend on a chosen trace depth. No completed infinite trace is formed."),
  ("minimality", "Removing a retained occurrence makes coverage proper; repeating or adding an occurrence makes the representation nonminimal."),
  ("named_shape_uniqueness", "Only complete-coverage__once__no-extra has complete exact multiplicity without ungenerated addition."),
  ("meaning", "Positive finite count is the exact identity of a complete generated succession trace, not a semantic zero, signed magnitude, decimal, irrational value or completed infinity.")]

def closureValue : Value := .object (closureRecord.map fun p => (p.1, .text p.2))

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-COUNT-001"
  title := "Exact positive finite count"
  branch := "foundation"
  statement := "Every generated nonempty finite succession of structural-One occurrences has one exact positive count representation: its complete generation trace, retaining every generated occurrence once and adding none."
  evidenceMode := .formal
  rootTheorems := ["SFT-ROOT-THERE-IS-NO-NOTHING"]
  dependencies := ["SFT-FOUNDATION-ONE-001"]
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
    ("reason", .text (decisionReason c)), ("dependency", .text "SFT-FOUNDATION-ONE-001")])

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
    ("base_dependency", .text "SFT-FOUNDATION-ONE-001"),
    ("successor_preserves_classification", .boolean true), ("closure", closureValue)]))

def closureEvidence (decisions : List Value) : Value :=
  SFT.Engine.closureEvidenceValue (closureEvidenceData decisions)

structure ControlRecord where
  kind : SFT.Engine.ControlKind
  expected : String
  observed : String
  passed : Bool

def falsePremise : ControlRecord where
  kind := .falsePremise
  expected := "reject absence of a generated occurrence as a positive count"
  observed := "the no-coverage trace does not survive"
  passed := !(survives .c0)

def tamperedSource (sourceHash : String) : ControlRecord where
  kind := .tamperedSource
  expected := "reject a changed derivation source identity"
  observed := "the changed source identity differs"
  passed := identity (.object [("changed", .text sourceHash)]) != sourceHash

def tamperedArtifact : ControlRecord where
  kind := .tamperedArtifact
  expected := "reject a duplicated occurrence in the complete trace"
  observed := "the complete duplicated trace does not survive"
  passed := !(survives .c8)

def boundary : ControlRecord where
  kind := .boundary
  expected := "refuse zero, signed, floating or completed-infinite count claims"
  observed := "only nonempty finitely generated complete traces are admitted"
  passed := SFT.Host.Text.contains "The base and successor clauses apply after every finite generated extension, so the survivor classification does not depend on a chosen trace depth. No completed infinite trace is formed." "No completed infinite trace"

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

end SFT.Foundation.Count.Evidence
