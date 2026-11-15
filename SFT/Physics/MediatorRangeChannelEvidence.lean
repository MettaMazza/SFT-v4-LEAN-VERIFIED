import SFT.Physics.MediatorRangeChannelControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.MediatorRangeChannelEvidence
open SFT.Host.Canonical MediatorRangeChannelGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "channel",.text (channelName c.channel)],.array [.text "mass",.text (massName c.mass)],.array [.text "transfer",.text (transferName c.transfer)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "range",.text (rangeName c.range)],.array [.text "ordering",.text (orderingName c.ordering)],.array [.text "massless",.text (masslessName c.massless)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "carrier"),("question",.text "What carries mediation?"),("choices",.array [.array [.text "untracked-field-value",.text "An untracked value cannot conserve transferred support."],.array [.text "held-forward-and-rest-carriers",.text "Every forward and captured-rest part remains explicitly held."]])],.object [("key",.text "channel"),("question",.text "Which channel is preserved?"),("choices",.array [.array [.text "named-unbroken-channel",.text "A name does not prove completion."],.array [.text "combination-reassembling-the-One",.text "Only complete channel support reaches the invariant One."]])],.object [("key",.text "mass"),("question",.text "What distinguishes massive from massless?"),("choices",.array [.array [.text "assigned-mass-label",.text "An assigned label imports the classification."],.array [.text "positive-shortfall-or-empty-record",.text "Proper parts have positive One-shortfall; completed One has structural empty mass."]])],.object [("key",.text "transfer"),("question",.text "How does massive forward support evolve?"),("choices",.array [.array [.text "sink-or-imported-exponential",.text "A sink loses support and an exponential is not generated."],.array [.text "exact-positive-forward-to-rest-transfer",.text "Each act moves one mass share into a retained rest carrier."]])],.object [("key",.text "conservation"),("question",.text "What happens to total support?"),("choices",.array [.array [.text "forward-loss-without-ledger",.text "That violates closed transfer."],.array [.text "forward-plus-rest-reassembles-One",.text "Every retained row exactly reconstructs the One."]])],.object [("key",.text "range"),("question",.text "What fixes massive range?"),("choices",.array [.array [.text "selected-cutoff-distance",.text "A selected cutoff is a free parameter."],.array [.text "positive-trace-and-reciprocal-mass-scale",.text "The finite native trace and One-over-mass scale are both exact."]])],.object [("key",.text "ordering"),("question",.text "How do masses order ranges?"),("choices",.array [.array [.text "independent-range-order",.text "Independent ordering can contradict the carrier."],.array [.text "larger-mass-shorter-range",.text "Reciprocal order reverses every positive mass ordering."]])],.object [("key",.text "massless"),("question",.text "How does an empty mass record propagate?"),("choices",.array [.array [.text "finite-hard-stop",.text "No generated positive mass exists to supply a stop."],.array [.text "held-forward-and-positive-finite-radius",.text "Forward support is retained and inverse-square response is positive at every finite radius."]])],.object [("key",.text "comparison"),("question",.text "When are physical mediators named?"),("choices",.array [.array [.text "W-Z-photon-selected-before-law",.text "Named targets cannot select the discriminator."],.array [.text "inherit-sealed-electroweak-and-range-records",.text "The formal law composes already sealed W/Z and mediator-range comparisons."]])],.object [("key",.text "extension"),("question",.text "May another profile enter?"),("choices",.array [.array [.text "free-Yukawa-or-cutoff-rule",.text "A free profile or cutoff adds a parameter."],.array [.text "no-extra-rule",.text "Completion, shortfall, exact transfer and reciprocal order exhaust the grammar."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-MEDIATOR-RANGE-CHANNEL-TERMINAL-020"
  title := "Preserved/broken Fold channels and inverse mediator range"
  branch := "physics"
  statement := "A complete channel combination that reassembles the One has the structural empty mass record and retains its forward carrier at every generated finite step.  Every proper broken channel has a positive mass shortfall.  Repeated positive transfer of that share from forward to co-located rest support conserves the One and leaves a finite positive forward trace; the following act is the empty boundary rather than numerical zero.  Independently, the characteristic normalized range scale is One divided by mass, so every larger positive mediator mass has shorter range.  A massless inverse-square carrier remains positive at every finite radius.  This forces the exact preserved/massless versus broken/massive discriminator without importing a Yukawa exponential or asserting a hard physical zero beyond the range scale."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-FOUNDATION-PART-EQUIVALENCE-001", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002", "SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003", "SFT-PHYS-VALIDATION-ELECTROWEAK-TERMINAL-003", "SFT-PHYS-NUCLEAR-RESIDUAL-FORCE-TERMINAL-005", "SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-PHYS-SPACETIME-LIMIT-SPEED-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-MEDIATOR-RANGE-CHANNEL-TERMINAL-020",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-MEDIATOR-RANGE-CHANNEL-TERMINAL-020",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [MediatorRangeChannelControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity MediatorRangeChannelControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.MediatorRangeChannelEvidence
