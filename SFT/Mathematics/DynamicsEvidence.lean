import SFT.Mathematics.DynamicsControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.DynamicsEvidence
open SFT.Host.Canonical DynamicsGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "states",.text (statesName c.states)],.array [.text "transitions",.text (transitionsName c.transitions)],.array [.text "trajectory",.text (trajectoryName c.trajectory)],.array [.text "time",.text (timeName c.time)],.array [.text "fixed",.text (fixedName c.fixed)],.array [.text "return",.text (returnsName c.returns)],.array [.text "basin",.text (basinName c.basin)],.array [.text "reversibility",.text (reversibilityName c.reversibility)],.array [.text "stability",.text (stabilityName c.stability)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "states"),("question",.text "What fixes dynamical state?"),("choices",.array [.array [.text "partial-or-aliased-state",.text "Omitted or aliased states change possible evolution."],.array [.text "complete-canonical-states",.text "Every generated state occurs once with canonical identity."]])],.object [("key",.text "transitions"),("question",.text "What fixes evolution?"),("choices",.array [.array [.text "opaque-update-rule",.text "An opaque update hides which relation cells exist."],.array [.text "held-state-relation",.text "Every allowed state transition is a retained generated pair."]])],.object [("key",.text "trajectory"),("question",.text "What witnesses an evolution?"),("choices",.array [.array [.text "endpoint-only",.text "Endpoints erase intervening states and cannot prove reachability."],.array [.text "complete-transition-trace",.text "Every adjacent transition is retained in order."]])],.object [("key",.text "time"),("question",.text "What fixes elapsed computation?"),("choices",.array [.array [.text "continuous-clock-parameter",.text "A free real clock imports scale and continuum."],.array [.text "positive-transition-count",.text "Elapsed time is the exact trace of generated transitions; identity is empty One."]])],.object [("key",.text "fixed"),("question",.text "What fixes a stationary form?"),("choices",.array [.array [.text "visual-sameness",.text "Presentation similarity does not prove dynamical identity."],.array [.text "retained-identity-transition",.text "A fixed form has an explicit self relation."]])],.object [("key",.text "return"),("question",.text "What fixes recurrence or cycle?"),("choices",.array [.array [.text "periodic-assertion",.text "A period name without a trace omits return structure."],.array [.text "explicit-first-return-trace",.text "A retained nonempty path returns to a prior canonical state."]])],.object [("key",.text "basin"),("question",.text "What fixes a basin or attractor?"),("choices",.array [.array [.text "sampled-neighborhood",.text "Sampling cannot establish reachability for the registered perturbation class."],.array [.text "complete-reachability-selection",.text "Every registered state is exhaustively tested for reachability to the invariant form."]])],.object [("key",.text "reversibility"),("question",.text "How is reversal possible after merging?"),("choices",.array [.array [.text "infer-unrecorded-predecessor",.text "A merged image does not identify which predecessor occurred."],.array [.text "retained-predecessor-record",.text "The exact source-to-image distinction is held alongside the step."]])],.object [("key",.text "stability"),("question",.text "What fixes stability?"),("choices",.array [.array [.text "epsilon-parameter",.text "A chosen epsilon imports a free scale."],.array [.text "registered-perturbation-closure",.text "Every explicitly generated perturbation form satisfies the invariant reachability condition."]])],.object [("key",.text "addition"),("question",.text "Is another dynamical law added?"),("choices",.array [.array [.text "extra-force-or-random-law",.text "An added force, differential equation or random update is not supplied by the state relation."],.array [.text "no-extra-dynamic-law",.text "All properties follow from exact finite transition structure."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-DYNAMICAL-SYSTEMS-001"
  title := "Exact generated finite dynamical systems"
  branch := "mathematics"
  statement := "An admitted dynamical system is a complete canonical state carrier with a held transition relation. A trajectory retains every state and transition; time is the positive transition trace and the identity trajectory is empty One. Fixed forms, returns, recurrence, basins, reversibility and stability are admitted only through exhaustive generated witnesses. Merged predecessors remain recoverable only when their exact records are retained."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-OPTIMIZATION-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-DYNAMICAL-SYSTEMS-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-DYNAMICAL-SYSTEMS-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FORM-ENFORCEMENT-001",.text "SFT-MATH-GRAPH-NETWORK-001",.text "SFT-MATH-OPTIMIZATION-001"]),
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
  proofHash := identity (.object [("closure",DynamicsControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-DYNAMICAL-SYSTEMS-001"),
    ("base",.text "One state supplies its identity trajectory; no transition time or predecessor ambiguity is introduced."),
    ("successor",.text "Adding one transition appends one exact state pair to every extended trajectory. Fixed, return, basin, predecessor and stability obligations change only for paths that use the new relation and are rechecked completely."),
    ("laws",.array (DynamicsControls.laws.map Value.text)),
    ("witnesses",.array (DynamicsWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

def why : String := "Computation and natural modelling both require change through state. Exact transitions expose the laws of time, recurrence and information loss without importing continuous equations or stochastic causes."

def derivation : String := "Graph paths supply evolution; optimization supplies complete invariant and basin selection; canonical forms supply state identity. Ten choices force the finite transition-and-record dynamics kernel."

def check : String := "Execute all 1,024 kernels, verify state closure, trajectories, time identity, fixed and return traces, merged predecessor records and perturbation stability, then independently regenerate the census."

def limitations : String := "This closes exact finite dynamical systems. Continuum differential models may later appear only as measured or finite approximation correspondences, never as premises of this theorem."

def correspondenceTerms : List String := ["state space","trajectory","fixed point","cycle","attractor","reversibility","stability"]

end SFT.Mathematics.DynamicsEvidence
