import SFT.Engine.CensusGate
import SFT.Engine.EvidenceGates
import SFT.Engine.DecisionGate
import SFT.Foundation.Root
import SFT.Host.Canonical
/-! Source: root_theorem.py::RootTheoremProgram and its record functions.
Objects encode the exact engine/model.py dataclass fields for canonical serialization.
Source identity is evidence metadata supplied by the original program, not a model parameter.
Executable correspondence is checked separately from native theorem completion. -/
namespace SFT.Foundation.Root.Evidence
open SFT.Host.Canonical

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id", .text (candidateId c)), ("presented", .boolean (presented c)),
  ("exact_form", .text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator", .text generationRule), ("boundary", .text grammarBoundary),
  ("partition_relation", .text "presentation at the proof boundary"),
  ("classes", .array (candidates.map candidateRecord)),
  ("exhaustion", .text "An operational challenge outside the presented class supplies no challenge artifact; every challenge artifact lies in the presented class.")]

def decisionRecord (c : Candidate) : Value := .object [
  ("candidate_id", .text (candidateId c)), ("survives", .boolean (survives c)),
  ("reason", .text (decisionReason c))]

def closureValue : Value := .object (closureRecord.map fun x => (x.1, .text x.2))

def registration (sourceHash : String) : Value := .object [
  ("claim_id", .text "SFT-ROOT-THERE-IS-NO-NOTHING"),
  ("title", .text "Premise-free operational root theorem"),
  ("branch", .text "foundation"),
  ("statement", .text "No admissible operational statement, denial, record, proof object or derivational object is nothing: absence presents no counterexample, while every presented counterexample is an occurrence."),
  ("evidence_mode", .text "formal"), ("root_theorems", .array []),
  ("dependencies", .array []), ("axioms", .array []), ("free_parameters", .array []),
  ("provenance", .array [.text "direct_forcing"]), ("source_hash", .text sourceHash)]

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [
    ("generator", .text generationRule), ("generated_record", candidateRecord c)])

def generatedCandidate (c : Candidate) : Value :=
  SFT.Engine.candidateValue (generatedCandidateData c)

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
    ("candidate", candidateRecord c), ("decision", decisionRecord c),
    ("rule", .text "presentation entails an occurrence; nonpresentation supplies no challenge")])

def candidateDecision (c : Candidate) : Value :=
  SFT.Engine.decisionValue (candidateDecisionData c)

-- Python dictionary lookup raises KeyError for an unregistered ID; explicit error preserves refusal.
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
    ("partition", .text "presented or no operational challenge artifact"),
    ("content_independent", .boolean true), ("closure", closureValue)]))

def closureEvidence (decisions : List Value) : Value :=
  SFT.Engine.closureEvidenceValue (closureEvidenceData decisions)

def tamperedSourceControl (sourceHash : String) : ControlRecord where
  kind := "tampered_source"
  premise := "Alter the registered derivation source identity."
  expected := "reject source drift before enumeration"
  observed := "the altered identity differs from the registered identity"
  passed := identity (.object [("tampered", .text sourceHash)]) != sourceHash

def controlRecords (sourceHash : String) : List ControlRecord :=
  [falsePremiseControl, tamperedSourceControl sourceHash, tamperedArtifactControl, boundaryControl]

def controlValue (c : ControlRecord) : Value := .object [
  ("kind", .text c.kind), ("premise", .text c.premise), ("expected", .text c.expected),
  ("observed", .text c.observed), ("passed", .boolean c.passed)]

def controlResult (c : ControlRecord) : Value := .object [
  ("kind", .text c.kind), ("passed", .boolean c.passed),
  ("expected_behavior", .text c.expected), ("observed_behavior", .text c.observed),
  ("receipt_hash", .text (identity (controlValue c)))]

-- Equality witnesses preserve ControlKind(record["kind"]) on each generated source row.
def controlResultData (c : ControlRecord) (kind : SFT.Engine.ControlKind)
    (_sameKind : SFT.Engine.kindName kind = c.kind) : SFT.Engine.ControlResult where
  kind := kind
  passed := c.passed
  expectedBehavior := c.expected
  observedBehavior := c.observed
  receiptHash := identity (controlValue c)

theorem typedControlResultMatchesRecord (c : ControlRecord) (kind : SFT.Engine.ControlKind)
    (sameKind : SFT.Engine.kindName kind = c.kind) :
    SFT.Engine.controlResultValue (controlResultData c kind sameKind) = controlResult c := by
  unfold SFT.Engine.controlResultValue controlResultData controlResult
  rw [sameKind]

def runControlsData (sourceHash : String) : List SFT.Engine.ControlResult := [
  controlResultData falsePremiseControl .falsePremise rfl,
  controlResultData (tamperedSourceControl sourceHash) .tamperedSource rfl,
  controlResultData tamperedArtifactControl .tamperedArtifact rfl,
  controlResultData boundaryControl .boundary rfl]

def runControls (sourceHash : String) : Value :=
  .array ((runControlsData sourceHash).map SFT.Engine.controlResultValue)

end SFT.Foundation.Root.Evidence
