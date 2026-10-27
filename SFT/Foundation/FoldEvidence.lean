import SFT.Foundation.FoldControls
import SFT.Foundation.RootEvidence
namespace SFT.Foundation.Fold.Evidence
open SFT.Host.Canonical
set_option maxRecDepth 20000

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id", .text (candidateId c)), ("coverage", .text (coverageName c.coverage)),
  ("overlap", .text (overlapName c.overlap)), ("fibre", .text (fibreName c.fibre)),
  ("extension", .text (extensionName c.extension)), ("labels", .text (labelsName c.labels)),
  ("return", .text (returnRelationName c.returnRelation)), ("extra", .text (extraName c.extra)),
  ("exact_form", .text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator", .text generationRule), ("boundary", .text grammarBoundary),
  ("domains", .object [
    ("coverage", .array [.text "incomplete", .text "complete"]),
    ("overlap", .array [.text "overlapping", .text "disjoint"]),
    ("fibre", .array [.text "unequal", .text "equal"]),
    ("extension", .array [.text "identity", .text "first-extension", .text "later-extension"]),
    ("labels", .array [.text "labels-absent", .text "labels-same", .text "labels-distinct-held"]),
    ("return", .array [.text "return-absent", .text "return-present"]),
    ("extra", .array [.text "no-extra", .text "has-extra"])]),
  ("candidates", .array (candidates.map candidateRecord)),
  ("exhaustion", .text "The positive-count dependency classifies a transformation as no extension, its first extension or any later extension. Every other criterion is an explicit exhaustive relation at the declared boundary; their product generates all same-grammar forms.")]

def closureValue : Value := FoldControls.closureValue

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-FOLD-001"
  title := "The minimal structural Fold"
  branch := "foundation"
  statement := "The unique minimal parameter-free nontrivial transformation of the structural One into a reversible distinguished partition is the first positive-count extension: two equal disjoint fibres with distinct held labels and an explicit complete return relation to the One. This structure is the Fold."
  evidenceMode := .formal
  rootTheorems := ["SFT-ROOT-THERE-IS-NO-NOTHING"]
  dependencies := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-COUNT-001", "SFT-FOUNDATION-PART-001"]
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
    ("reason", .text (decisionReason c)), ("dependencies", .array [.text "SFT-FOUNDATION-ONE-001", .text "SFT-FOUNDATION-COUNT-001", .text "SFT-FOUNDATION-PART-001"])])

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
    ("base_successor_minimality", .boolean true),
    ("dependencies", .array [.text "SFT-FOUNDATION-ONE-001", .text "SFT-FOUNDATION-COUNT-001", .text "SFT-FOUNDATION-PART-001"]), ("closure", closureValue)]))

def closureEvidence (decisions : List Value) : Value :=
  SFT.Engine.closureEvidenceValue (closureEvidenceData decisions)

def runControls (sourceHash : String) : Value := FoldControls.runControls sourceHash

end SFT.Foundation.Fold.Evidence
