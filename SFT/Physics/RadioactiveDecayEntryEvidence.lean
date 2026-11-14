import SFT.Foundation.AdmissionControls
import SFT.Physics.RadioactiveDecayEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.RadioactiveDecayEntryEvidence
open SFT.Host.Canonical RadioactiveDecayEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "predecessor",.text (predecessorName c.predecessor)],.array [.text "topology",.text (topologyName c.topology)],.array [.text "alpha",.text (alphaName c.alpha)],.array [.text "beta",.text (betaName c.beta)],.array [.text "gamma",.text (gammaName c.gamma)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "survival",.text (survivalName c.survival)],.array [.text "determinism",.text (determinismName c.determinism)],.array [.text "target",.text (targetName c.target)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "predecessor"),("question",.text "How are admitted nuclear, weak and radiative laws used?"),("choices",.array [.array [.text "rewrite-predecessor-laws",.text "A successor cannot alter admitted receipts."],.array [.text "compose-immutable-predecessors",.text "Nuclear closure, binding, tunnelling, weak conversion, transition and radioactivity laws remain immutable dependencies."]])],.object [("key",.text "topology"),("question",.text "What exhausts primitive radioactive transitions?"),("choices",.array [.array [.text "three-named-particles-only",.text "Nuclear data contain additional emissions, capture, fission and composite delayed channels."],.array [.text "three-structural-transition-topologies",.text "Every nonidentity decay either releases boundary support, converts a held charge label at retained support, or lowers an internal recurrence at retained labels."]])],.object [("key",.text "alpha"),("question",.text "What is alpha decay structurally?"),("choices",.array [.array [.text "borrowed-alpha-name",.text "A name alone has no constituent trace."],.array [.text "binary-square-cluster-boundary-release",.text "The complete mass-four, charge-two cluster is the binary-by-binary representative of boundary release."]])],.object [("key",.text "beta"),("question",.text "What is beta decay structurally?"),("choices",.array [.array [.text "stochastic-particle-appearance",.text "Unrecorded random appearance violates complete conservation."],.array [.text "held-label-conversion-with-lepton-records",.text "A retained-support charge-label conversion closes only with its complete lepton carrier records."]])],.object [("key",.text "gamma"),("question",.text "What is gamma decay structurally?"),("choices",.array [.array [.text "continuum-energy-leak",.text "An unrecorded energy leak violates recurrence and conservation."],.array [.text "internal-level-lowering-with-radiative-record",.text "The same nuclear support and charge labels recur at a lower level with one named radiative output."]])],.object [("key",.text "composition"),("question",.text "How are delayed particles, capture, clusters and fission handled?"),("choices",.array [.array [.text "declare-each-a-new-primitive",.text "Adding a primitive for every code destroys exhaustive topology."],.array [.text "compose-the-three-primitive-traces",.text "Every additional named channel is a boundary-release, conversion, de-excitation or a retained ordered composition of them."]])],.object [("key",.text "survival"),("question",.text "What exact law follows at successive half-lives?"),("choices",.array [.array [.text "import-continuum-exponential",.text "A continuum exponential and transcendental value are outside the proof domain."],.array [.text "positive-rational-binary-geometric",.text "Each complete path partition retains exactly one of two fibres, forcing survival 1/2^k for every positive finite count k."]])],.object [("key",.text "determinism"),("question",.text "Does halving require ontic randomness?"),("choices",.array [.array [.text "unrecorded-random-choice",.text "An unrecorded choice violates the superdeterministic complete-path census."],.array [.text "deterministic-hidden-path-partition",.text "Complete predecessor paths divide exactly into retained and released fibres; uncertainty belongs to the observation quotient."]])],.object [("key",.text "target"),("question",.text "May decay tables or half-lives select the law?"),("choices",.array [.array [.text "external-target-readable",.text "Target access could select a topology or rate."],.array [.text "target-inaccessible-until-seal",.text "The primitive classes and rational survival law seal before authoritative decay records open."]])],.object [("key",.text "extension"),("question",.text "May a fitted decay constant or extra primitive be appended?"),("choices",.array [.array [.text "free-rate-or-extra-primitive",.text "A selected rate or topology is a parameter."],.array [.text "no-extra-rule",.text "Three structural relations, exact path halving and positive transported time carriers exhaust the declared grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005"
  title := "Terminal radioactive transition topology and exact half-life survival"
  branch := "physics"
  statement := "Complete nuclear transition structure forces exactly three primitive nonidentity topologies: boundary release/decomposition, held charge-label conversion at retained constituent support, and internal level de-excitation at retained support and charge. Alpha, beta and gamma are the canonical representatives, not an exclusion of proton, neutron, cluster, capture, conversion, fission or delayed composite channels. Complete deterministic predecessor paths split into the two Fold fibres at each half-life carrier, forcing the exact positive survival part 1/2^k for every positive finite k without an ontic random choice, continuum exponential, fitted decay constant or numerical-zero endpoint."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-NUCLEAR-RADIOACTIVITY-001", "SFT-PHYS-NUCLEAR-CLOSURE-SEQUENCE-001", "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005", "SFT-PHYS-QUANTUM-TUNNELLING-001", "SFT-PHYS-WEAK-PARITY-FIBRE-002", "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-INFO-ENTROPY-UNCERTAINTY-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005",.text generationRule,candidateRecord c])

def censusData : SFT.Engine.CandidateCensus where
  generationRule := generationRule
  grammarBoundary := grammarBoundary
  expectedCardinality := .ofNat candidates.length
  completenessCertificateHash := SFT.Foundation.AdmissionControls.admissionIdentity completenessRecord
  candidates := candidates.map generatedCandidateData

def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
  candidateId := candidateId c
  survives := survives c
  reason := decisionReason c
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [RadioactiveDecayEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity RadioactiveDecayEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.RadioactiveDecayEntryEvidence
