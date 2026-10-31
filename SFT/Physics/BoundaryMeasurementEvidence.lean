import SFT.Physics.BoundaryMeasurementControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.BoundaryMeasurementEvidence
open SFT.Host.Canonical BoundaryMeasurementGrammar

def candidateRecord (c : Candidate) : SFT.Host.Canonical.Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "source",.text (sourceName c.source)],.array [.text "distance",.text (distanceName c.distance)],.array [.text "response",.text (responseName c.response)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "candidates",.text (candidatesName c.candidates)],.array [.text "selection",.text (selectionName c.selection)],.array [.text "stopping",.text (stoppingName c.stopping)],.array [.text "target",.text (targetName c.target)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : SFT.Host.Canonical.Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "source"),("question",.text "What fixes the compared carrier?"),("choices",.array [.array [.text "unbound-response-values",.text "Unbound responses may come from different sources or preparations."],.array [.text "one-retained-source-boundary",.text "Every comparison retains one source, boundary preparation and observation trace."]])],.object [("key",.text "distance"),("question",.text "How are distance changes represented?"),("choices",.array [.array [.text "floating-or-signed-distance",.text "Floating or signed distances are outside the exact positive proof domain."],.array [.text "exact-positive-distance-ratio",.text "Two retained positive supports produce an exact held ratio above the One."]])],.object [("key",.text "response"),("question",.text "How are measured responses represented?"),("choices",.array [.array [.text "point-answer-without-uncertainty",.text "A point answer discards unresolved measurement support."],.array [.text "complete-positive-response-ratio-interval",.text "All registered response and uncertainty endpoints enter one exact ordered ratio interval."]])],.object [("key",.text "scale"),("question",.text "How is unknown source scale handled?"),("choices",.array [.array [.text "fitted-source-amplitude",.text "A fitted amplitude is a free target-derived parameter."],.array [.text "same-source-ratio-cancellation",.text "Comparing one source at two distances cancels its unchanged scale by exact pairing."]])],.object [("key",.text "candidates"),("question",.text "How are growth exponents generated?"),("choices",.array [.array [.text "borrowed-or-fitted-exponent",.text "A borrowed exponent selects the answer before measurement."],.array [.text "positive-successor-power-family",.text "Start at the first positive count and generate each later power by one exact product."]])],.object [("key",.text "selection"),("question",.text "Which exponent is reported?"),("choices",.array [.array [.text "best-fit-or-first-match",.text "Best fit or first match can erase tied compatible alternatives."],.array [.text "all-interval-compatible-exponents",.text "Every generated power within the complete measured interval remains held."]])],.object [("key",.text "stopping"),("question",.text "When is the candidate family closed?"),("choices",.array [.array [.text "fixed-search-depth",.text "A fixed depth can hide a later compatible candidate."],.array [.text "monotonic-strict-excess-certificate",.text "Once a power exceeds the upper interval, multiplication by a ratio above the One excludes every successor."]])],.object [("key",.text "target"),("question",.text "Can the method read observations before sealing?"),("choices",.array [.array [.text "target-readable-method",.text "Target access can choose the exponent rule."],.array [.text "postseal-custodied-observations",.text "The complete method and inputs are sealed before the custodian releases observations."]])],.object [("key",.text "record"),("question",.text "What evidence is retained?"),("choices",.array [.array [.text "reported-exponent-only",.text "An exponent alone cannot reproduce generation, comparison or closure."],.array [.text "complete-ratio-power-decision-trace",.text "Distances, responses, intervals, powers, decisions and stopping witness remain held."]])],.object [("key",.text "extension"),("question",.text "May an extra dimensional rule be added?"),("choices",.array [.array [.text "free-dimension-rule",.text "An added spatial model can force a desired exponent."],.array [.text "no-extra-rule",.text "The exact ratios and positive power census supply the complete method."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered axis choice occurs once with every other axis choice.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-MEAS-BOUNDARY-GROWTH-001"
  title := "Exact source-boundary growth measurement discriminator"
  branch := "physics"
  statement := "Within a complete source-boundary dilution experiment, physical boundary-growth dimension is measured without a fitted exponent or logarithm by comparing exact positive distance and response ratios, generating every positive exponent by repeated composition, retaining the complete compatible family and closing all later candidates only after a monotonic strict-excess certificate."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-ORDER-LATTICE-001", "SFT-MATH-COMBINATORICS-001", "SFT-PHYS-MEAS-VALUE-RECORD-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-PHYS-MEAS-CAPABILITY-PREDICTION-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-HOSTILE-PACKAGE-001", "SFT-PHYS-FIELD-SOURCE-RESPONSE-001", "SFT-PHYS-FIELD-GEOMETRIC-DILUTION-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : SFT.Host.Canonical.Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-MEAS-BOUNDARY-GROWTH-001",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := identity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : SFT.Host.Canonical.Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := identity (.array [.text "SFT-PHYS-MEAS-BOUNDARY-GROWTH-001",.array ((registrationData "").dependencies.map SFT.Host.Canonical.Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

def decision (c : Candidate) : SFT.Host.Canonical.Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.array [BoundaryMeasurementControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity BoundaryMeasurementControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : SFT.Host.Canonical.Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.BoundaryMeasurementEvidence
