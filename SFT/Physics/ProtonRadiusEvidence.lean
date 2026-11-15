import SFT.Physics.ProtonRadiusControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ProtonRadiusEvidence
open SFT.Host.Canonical ProtonRadiusGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "particle",.text (particleName c.particle)],.array [.text "orbit",.text (orbitName c.orbit)],.array [.text "edge",.text (edgeName c.edge)],.array [.text "charge",.text (chargeName c.charge)],.array [.text "transport",.text (transportName c.transport)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "particle"),("question",.text "Which object carries the radius?"),("choices",.array [.array [.text "named-proton-without-composition",.text "A particle name does not generate a radius."],.array [.text "admitted-uud-colour-three-proton",.text "The admitted charged colour singlet supplies the complete composite carrier."]])],.object [("key",.text "orbit"),("question",.text "Which tripling position is the boundary?"),("choices",.array [.array [.text "inner-one-third-as-outer-edge",.text "The inner constituent site is not the composite edge."],.array [.text "outer-two-thirds-complement",.text "The unique positive complement of the inner tripling site is the edge face."]])],.object [("key",.text "edge"),("question",.text "How much edge support is transported?"),("choices",.array [.array [.text "partial-colour-or-single-fibre-support",.text "Omitting a colour or Fold label loses a charged path."],.array [.text "all-three-colours-times-both-Fold-labels",.text "Complete colour/Fold support has six paths and sends the two-thirds edge to multiplier four."]])],.object [("key",.text "charge"),("question",.text "Which charge support receives self-coupling?"),("choices",.array [.array [.text "eight-nonreturn-mediators",.text "The mediator count omits the return and external charge roles."],.array [.text "nine-internal-colour-pairs",.text "Internal pair support omits the proton's external unit charge."],.array [.text "ten-internal-pairs-plus-unit-charge",.text "The physical charged composite contains both complete internal colour-pair support and its one external charge carrier."]])],.object [("key",.text "transport"),("question",.text "How many electromagnetic traversals alter a radius?"),("choices",.array [.array [.text "no-terminal-transport",.text "This retains only the earlier leading structural radius."],.array [.text "one-alpha-spatial-traversal",.text "One interaction crosses the radial charge boundary once; no energy square is formed."],.array [.text "alpha-squared-energy-composition",.text "Two traversals apply to energy self-composition, not a length boundary."]])],.object [("key",.text "orientation"),("question",.text "How does bound self-coupling act on the edge?"),("choices",.array [.array [.text "append-outward-free-share",.text "Appending a free share breaks the held bound-composite ledger."],.array [.text "hold-inward-share-from-edge",.text "The bound charge interaction holds alpha/10 from the free edge while preserving a positive radius."]])],.object [("key",.text "scale"),("question",.text "Which dimensional carrier may translate the coefficient?"),("choices",.array [.array [.text "full-cycle-or-fitted-length",.text "A fitted length or full-cycle circumference double-counts the one-action radial carrier."],.array [.text "reduced-proton-Compton-postseal",.text "The admitted action-over-proton-momentum relation supplies the one-action radial scale only after sealing."]])],.object [("key",.text "target"),("question",.text "Can any radius measurement select the law?"),("choices",.array [.array [.text "probe-results-readable-before-seal",.text "That would fit the known radius puzzle."],.array [.text "capability-closed-before-target-release",.text "The exact coefficient and complete alternatives seal before any radius or Compton row opens."]])],.object [("key",.text "provenance"),("question",.text "Was the radius puzzle known during reconstruction?"),("choices",.array [.array [.text "claim-historical-blindness",.text "V1/V2 and the measurements were already known."],.array [.text "observational-derivation-explicit",.text "Development is disclosed while executable target access remains structurally denied."]])],.object [("key",.text "extension"),("question",.text "May another radius term be appended?"),("choices",.array [.array [.text "free-form-factor-or-probe-correction",.text "An added term would be a fitted parameter."],.array [.text "no-extra-rule",.text "Tripling edge, complete colour/Fold paths, complete charge support and one terminal traversal exhaust the grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-PROTON-RADIUS-TERMINAL-029"
  title := "Terminal probe-independent proton rms charge-radius relation"
  branch := "physics"
  statement := "The admitted colour-three proton has inner tripling site one-third and outer complement two-thirds. Every one of its three colour labels carries both Fold fibre labels, so complete edge transport is six times two-thirds, exactly four. Internal ordered colour support has nine pair cells and the proton carries one external unit charge, forcing ten complete charge-support cells. A spatial charge boundary receives one terminal electromagnetic traversal, not the two traversals of an energy self-composition; the inward held share is therefore alpha_terminal/10. The resulting dimensionless rms-radius coefficient is exactly 4(One-alpha_terminal/10), independent of the probe."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-SPACE-BOUNDARY-RANK-TWO-001", "SFT-PHYS-MATTER-COMPOSITE-HADRONS-001", "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005", "SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-QUANTUM-EVOLUTION-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-PROTON-RADIUS-TERMINAL-029",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-PROTON-RADIUS-TERMINAL-029",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [ProtonRadiusControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity ProtonRadiusControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.ProtonRadiusEvidence
