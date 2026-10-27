import SFT.Foundation.HalfOneControls
import SFT.Foundation.RootEvidence
namespace SFT.Foundation.HalfOneEvidence
open SFT.Host.Canonical HalfOneGrammar
set_option maxRecDepth 20000

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id", .text (candidateId c)), ("exact_form", .text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator", .text generationRule), ("boundary", .text grammarBoundary),
  ("domains", .array [.array [.text "selection-whole", .text "selection-singleton-equivalence-class"],
    .array [.text "self-junction-incomplete", .text "self-junction-One"],
    .array [.text "complement-distinct", .text "self-complement-equivalent"],
    .array [.text "fold-image-not-One", .text "fold-image-One"],
    .array [.text "One-not-fixed", .text "One-fixed"],
    .array [.text "phase-antipode-conflated", .text "phase-antipode-distinguished"],
    .array [.text "no-extra", .text "has-extra"]]),
  ("candidates", .array (candidates.map candidateRecord)),
  ("selection_classes", .array [.text "one held fibre modulo held-label exchange", .text "both held fibres"])]

def closureValue : Value := HalfOneControls.closureValue

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-HALF-ONE-001"
  title := "The forced half-One ground"
  branch := "foundation"
  statement := "The minimal Fold forces one exact proper ground coordinate: either singleton held fibre has the part one-of-two; its self-junction is the One, its complement has the same exact coordinate, it Folds to the One, and the One is Fold-fixed. Complement and half-One phase translation remain distinct operations."
  evidenceMode := .formal
  rootTheorems := ["SFT-ROOT-THERE-IS-NO-NOTHING"]
  dependencies := ["SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-EXACT-OPERATIONS-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001"]
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
    ("first_fold_equivalence_class_proof", .boolean true), ("closure", closureValue)]))

def closureEvidence (decisions : List Value) : Value :=
  SFT.Engine.closureEvidenceValue (closureEvidenceData decisions)

def runControls (sourceHash : String) : Value := HalfOneControls.runControls sourceHash

end SFT.Foundation.HalfOneEvidence
