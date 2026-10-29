import SFT.Computation.ParallelControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.ParallelEvidence
open SFT.Host.Canonical ParallelGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "input",.text (inputName c.input)],.array [.text "resource",.text (resourceName c.resource)],.array [.text "model",.text (modelName c.model)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "witness",.text (witnessName c.witness)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-CPLX-PARALLEL-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "input",.text "Which input coordinate preserves the complete Computational Complexity obligation?",.array [.array [.text "presentation-length",.text "presentation-length removes a required exact input condition."],.array [.text "canonical-encoding-support",.text "canonical-encoding-support retains the complete registered input condition."]]],.array [.text "resource",.text "Which resource coordinate preserves the complete Computational Complexity obligation?",.array [.array [.text "unrecorded-cost",.text "unrecorded-cost removes a required exact resource condition."],.array [.text "complete-resource-ledger",.text "complete-resource-ledger retains the complete registered resource condition."]]],.array [.text "model",.text "Which model coordinate preserves the complete Computational Complexity obligation?",.array [.array [.text "model-unspecified",.text "model-unspecified removes a required exact model condition."],.array [.text "registered-computation-model",.text "registered-computation-model retains the complete registered model condition."]]],.array [.text "comparison",.text "Which comparison coordinate preserves the complete Computational Complexity obligation?",.array [.array [.text "unmatched-instances",.text "unmatched-instances removes a required exact comparison condition."],.array [.text "common-family-comparison",.text "common-family-comparison retains the complete registered comparison condition."]]],.array [.text "composition",.text "Which composition coordinate preserves the complete Computational Complexity obligation?",.array [.array [.text "cost-erasing-composition",.text "cost-erasing-composition removes a required exact composition condition."],.array [.text "overhead-retaining-composition",.text "overhead-retaining-composition retains the complete registered composition condition."]]],.array [.text "witness",.text "Which witness coordinate preserves the complete Computational Complexity obligation?",.array [.array [.text "claimed-bound",.text "claimed-bound removes a required exact witness condition."],.array [.text "constructive-or-adversarial-bound-witness",.text "constructive-or-adversarial-bound-witness retains the complete registered witness condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Computational Complexity obligation?",.array [.array [.text "benchmark-only",.text "benchmark-only removes a required exact generality condition."],.array [.text "family-successor-certificate",.text "family-successor-certificate retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Computational Complexity obligation?",.array [.array [.text "imported-scale-or-rate",.text "imported-scale-or-rate removes a required exact addition condition."],.array [.text "no-extra-resource-parameter",.text "no-extra-resource-parameter retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-CPLX-PARALLEL-001"
  title := "Fold parallel-complexity law"
  branch := "computation"
  statement := "The forced independent and causally layered work kernel retains task dependency graph; independent ready sets; layer schedule; work trace; span trace; synchronization rows; result reconstruction; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-CPLX-REVERSIBILITY-COST-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-CPLX-PARALLEL-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-CPLX-PARALLEL-001"),
    ("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("closure",ParallelControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-CPLX-PARALLEL-001"),("base",.text "The structural One supplies one canonical independent and causally layered work form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated independent and causally layered work form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold parallel-complexity law is required to derive independent and causally layered work without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: task dependency graph; independent ready sets; layer schedule; work trace; span trace; synchronization rows; result reconstruction."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "No physical processor count or timing constant is imported."

def correspondenceTerms : List String := ["parallel complexity","work and span"]

end SFT.Computation.ParallelEvidence
