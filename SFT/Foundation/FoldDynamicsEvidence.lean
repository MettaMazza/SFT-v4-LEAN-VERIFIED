import SFT.Foundation.FoldDynamicsControls
import SFT.Engine.RegistrationGate
namespace SFT.Foundation.FoldDynamicsEvidence
open SFT.Host.Canonical FoldDynamicsGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator",.text generationRule),("boundary",.text grammarBoundary),
  ("domains",.array (([
    ["domain-leaking", "domain-closed"],
    ["fibre-not-two", "fibre-exactly-two"],
    ["phase-collision-absent", "phase-collision-present"],
    ["phase-involution-absent", "phase-involution-present"],
    ["uniform-division-broken", "uniform-division-preserved"],
    ["first-cycle-open", "first-cycle-two"],
    ["no-extra", "has-extra"]] : List (List String)).map fun xs => .array (xs.map Value.text))),
  ("candidates",.array (candidates.map candidateRecord))]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-FOLD-DYNAMICS-001"
  title := "Exact Fold dynamics and fibre law"
  branch := "foundation"
  statement := "Exact Fold is closed on every admitted part, has exactly two preimages related by half-One phase translation, identifies each phase-antipodal pair, preserves uniformity of every generated even division after duplicate images are identified, and its first nonstatic recurrent orbit is the two-cycle one-of-three to two-of-three."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-HALF-ONE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("generator",.text generationRule),("record",candidateRecord c)])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := identity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := identity (.object [("record",candidateRecord c),("survives",.boolean (survives c)),
    ("reason",.text (decisionReason c))])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error (SFT.Host.Text.append "KeyError: " candidate.candidateId)

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("closure",FoldDynamicsControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("arbitrary_rational_and_even_partition_proof",.boolean true),("closure",FoldDynamicsControls.closureValue)]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Foundation.FoldDynamicsEvidence
