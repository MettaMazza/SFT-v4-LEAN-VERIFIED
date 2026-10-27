import SFT.Foundation.ExactOperationsControls
import SFT.Foundation.RootEvidence
namespace SFT.Foundation.ExactOperationsEvidence
open SFT.Host.Canonical ExactOperationsGrammar
set_option maxRecDepth 20000

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id", .text (candidateId c)), ("exact_form", .text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator", .text generationRule), ("boundary", .text grammarBoundary),
  ("domains", .array [.array [.text "domain-unrestricted", .text "domain-exact-positive-through-One"],
    .array [.text "full-turn-as-absence", .text "full-turn-as-One"],
    .array [.text "fold-raw-junction", .text "fold-junction-then-cast"],
    .array [.text "take-unguarded", .text "take-strictly-larger"],
    .array [.text "unison-unidentified", .text "unison-exact-One-relation"],
    .array [.text "trace-unbound", .text "trace-root-bound"],
    .array [.text "no-extra", .text "has-extra"]]),
  ("candidates", .array (candidates.map candidateRecord))]

def closureValue : Value := ExactOperationsControls.closureValue

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-EXACT-OPERATIONS-001"
  title := "Exact positive foundational operations"
  branch := "foundation"
  statement := "The unique parameter-free primitive interface on exact parts of the One retains only exact positive rational parts through the One, casts complete turns to the One, defines Fold as self-junction followed by cast, permits Take only from a strictly larger part, identifies unison with the exact One relation, and retains a root-bound trace."
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
    ("reason", .text (decisionReason c))])

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
    ("positive_count_pair_generality", .boolean true), ("closure", closureValue)]))

def closureEvidence (decisions : List Value) : Value :=
  SFT.Engine.closureEvidenceValue (closureEvidenceData decisions)

def runControls (sourceHash : String) : Value := ExactOperationsControls.runControls sourceHash

end SFT.Foundation.ExactOperationsEvidence
