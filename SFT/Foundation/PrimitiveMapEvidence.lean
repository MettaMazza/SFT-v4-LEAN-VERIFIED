import SFT.Foundation.PrimitiveMapControls
import SFT.Engine.RegistrationGate
namespace SFT.Foundation.PrimitiveMapEvidence
open SFT.Host.Canonical PrimitiveMapGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),("size",.integer (Int.ofNat (word c).length)),
  ("rank",.integer (Int.ofNat (rank c))),
  ("word",.array ((word c).map fun p => .text (PrimitiveMaps.primitiveName p))),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generator",.text generationRule),("boundary",.text grammarBoundary),
  ("primitive_normal_forms",.array (primitives.map fun p => .text (PrimitiveMaps.primitiveName p))),
  ("normalization",.text "At normalized primitive cost through two source occurrences, total parameter-free self-map expressions reduce operationally to x, x-times-x, the One, or cast(x joined x); raw junction is not total, guarded removal is not total, multiplication by One is identity and closed whole expressions cast to One."),
  ("rank",.text "For each size, base-four digit words in primitive order give every ordered composition exactly once."),
  ("counts",.object [("size_one",.integer 4),("size_two",.integer 16),("size_three",.integer 64),("total",.integer 84)]),
  ("candidates",.array (candidates.map candidateRecord))]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-FOUNDATION-PRIMITIVE-MAP-UNIQUENESS-001"
  title := "Mechanically enumerated primitive Fold-map uniqueness"
  branch := "foundation"
  statement := "Within the explicit normalized zero-parameter self-map grammar, the four primitive operational classes are identity, square, constant One and Fold; only Fold is both noninjective and nonstatically recurrent. Base-four enumeration executes all 84 ordered words through size three, while positive-size induction proves no larger composition can displace Fold as the unique least-size generator."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-EXACT-OPERATIONS-001","SFT-FOUNDATION-FOLD-DYNAMICS-001"]
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
  proofHash := identity (.object [("closure",PrimitiveMapControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("positive_word_size_induction",.boolean true),("closure",PrimitiveMapControls.closureValue)]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Foundation.PrimitiveMapEvidence
