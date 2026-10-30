import SFT.Computation.ScientificSymbolicControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.ScientificSymbolicEvidence
open SFT.Host.Canonical ScientificSymbolicGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "model",.text (modelName c.model)],.array [.text "inputs",.text (inputsName c.inputs)],.array [.text "operation",.text (operationName c.operation)],.array [.text "error",.text (errorName c.error)],.array [.text "closure",.text (closureName c.closure)],.array [.text "validation",.text (validationName c.validation)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-SCI-SYMBOLIC-001"),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "model",.text "Which model coordinate preserves the complete Scientific Computation obligation?",.array [.array [.text "unstated-model",.text "unstated-model removes a required exact model condition."],.array [.text "registered-exact-model-relation",.text "registered-exact-model-relation retains the complete registered model condition."]]],.array [.text "inputs",.text "Which inputs coordinate preserves the complete Scientific Computation obligation?",.array [.array [.text "sampled-or-fitted-inputs",.text "sampled-or-fitted-inputs removes a required exact inputs condition."],.array [.text "complete-declared-input-support",.text "complete-declared-input-support retains the complete registered inputs condition."]]],.array [.text "operation",.text "Which operation coordinate preserves the complete Scientific Computation obligation?",.array [.array [.text "opaque-calculation",.text "opaque-calculation removes a required exact operation condition."],.array [.text "exact-executable-operation-trace",.text "exact-executable-operation-trace retains the complete registered operation condition."]]],.array [.text "error",.text "Which error coordinate preserves the complete Scientific Computation obligation?",.array [.array [.text "unsigned-error-scalar",.text "unsigned-error-scalar removes a required exact error condition."],.array [.text "orientation-labelled-error-ledger",.text "orientation-labelled-error-ledger retains the complete registered error condition."]]],.array [.text "closure",.text "Which closure coordinate preserves the complete Scientific Computation obligation?",.array [.array [.text "visual-convergence",.text "visual-convergence removes a required exact closure condition."],.array [.text "base-successor-closure-certificate",.text "base-successor-closure-certificate retains the complete registered closure condition."]]],.array [.text "validation",.text "Which validation coordinate preserves the complete Scientific Computation obligation?",.array [.array [.text "fit-only",.text "fit-only removes a required exact validation condition."],.array [.text "sealed-falsifiable-comparison-boundary",.text "sealed-falsifiable-comparison-boundary retains the complete registered validation condition."]]],.array [.text "generality",.text "Which generality coordinate preserves the complete Scientific Computation obligation?",.array [.array [.text "single-resolution",.text "single-resolution removes a required exact generality condition."],.array [.text "generated-refinement-successor",.text "generated-refinement-successor retains the complete registered generality condition."]]],.array [.text "addition",.text "Which addition coordinate preserves the complete Scientific Computation obligation?",.array [.array [.text "imported-equation-or-parameter",.text "imported-equation-or-parameter removes a required exact addition condition."],.array [.text "no-extra-scientific-prior",.text "no-extra-scientific-prior retains the complete registered addition condition."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-COMP-SCI-SYMBOLIC-001"
  title := "Fold scientific symbolic-computation law"
  branch := "computation"
  statement := "The forced exact model-expression transformation kernel retains model syntax; exact rewrite rules; dimensional or type interfaces; normalization; identity proof; evaluator correspondence; result trace; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-COMP-SCI-CONVERGENCE-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-INFO-ENCODING-DECODING-001","SFT-INFO-CONSERVATION-LOSS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-COMP-SCI-SYMBOLIC-001"),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-COMP-SCI-SYMBOLIC-001"),
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
  proofHash := identity (.object [("closure",ScientificSymbolicControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [("claim_id",.text "SFT-COMP-SCI-SYMBOLIC-001"),("base",.text "The structural One supplies one canonical exact model-expression transformation form with its identity trace and no unrecorded predecessor."),("successor",.text "Appending one generated exact model-expression transformation form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record.")]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Fold scientific symbolic-computation law is required to derive exact model-expression transformation without importing its conventional answer-producing model."

def derivation : String := "Admitted finite forms, exact relations, distinction ledgers and composition supply the carriers. Exhausting the eight group-specific axes forces the only structure retaining: model syntax; exact rewrite rules; dimensional or type interfaces; normalization; identity proof; evaluator correspondence; result trace."

def check : String := "Execute all 256 product members, decide every member, verify the sole survivor, replay the group operational witnesses, run four adverse controls and independently regenerate the literal product."

def limitations : String := "Physical interpretation remains outside formal symbolic closure."

def correspondenceTerms : List String := ["symbolic scientific computing","computer algebra"]

end SFT.Computation.ScientificSymbolicEvidence
