import SFT.Physics.LandauerDemonLedgerControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.LandauerDemonLedgerEvidence
open SFT.Host.Canonical LandauerDemonLedgerGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "support",.text (supportName c.support)],.array [.text "image",.text (imageName c.image)],.array [.text "distinction",.text (distinctionName c.distinction)],.array [.text "throw",.text (throwName c.throw)],.array [.text "reverse",.text (reverseName c.reverse)],.array [.text "sorting",.text (sortingName c.sorting)],.array [.text "memory",.text (memoryName c.memory)],.array [.text "environment",.text (environmentName c.environment)],.array [.text "thermal",.text (thermalName c.thermal)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "support"),("question",.text "Which reset support is generated?"),("choices",.array [.array [.text "sampled-memory-state",.text "A sampled state cannot establish a two-to-one reset."],.array [.text "complete-two-preimage-fibre",.text "Both exact Fold predecessors are retained."]])],.object [("key",.text "image"),("question",.text "What is the ready image?"),("choices",.array [.array [.text "selected-reset-state",.text "A selected state has no Fold trace."],.array [.text "common-half-One-image",.text "Quarter-One and three-quarter-One both Fold to half-One."]])],.object [("key",.text "distinction"),("question",.text "How much information is closed?"),("choices",.array [.array [.text "unquantified-information-loss",.text "An unquantified loss cannot balance a cycle."],.array [.text "exactly-one-binary-distinction",.text "Two held alternatives merging to one image close one predecessor label."]])],.object [("key",.text "throw"),("question",.text "What is the native erasure carrier?"),("choices",.array [.array [.text "free-or-vanishing-cost",.text "A free or vanishing cost violates the exact fibre separation."],.array [.text "half-One-preimage-separation",.text "The two reset predecessors are separated by exactly half-One."]])],.object [("key",.text "reverse"),("question",.text "What makes reset reversible?"),("choices",.array [.array [.text "infer-erased-predecessor",.text "The common image cannot identify its source."],.array [.text "retain-one-predecessor-label",.text "One of the two exact labels reconstructs the source."]])],.object [("key",.text "sorting"),("question",.text "What does the demon gain?"),("choices",.array [.array [.text "unrecorded-sorting-gain",.text "An unrecorded distinction is outside the closed system."],.array [.text "one-held-gas-distinction",.text "The sort transfers one speed-class distinction into memory."]])],.object [("key",.text "memory"),("question",.text "How is the decision stored?"),("choices",.array [.array [.text "memory-without-two-states",.text "A one-state memory cannot encode the decision."],.array [.text "two-label-Fold-memory",.text "The memory uses the complete lower/upper predecessor fibre."]])],.object [("key",.text "environment"),("question",.text "What happens on reset?"),("choices",.array [.array [.text "erased-without-external-record",.text "That would destroy the predecessor distinction from the closed ledger."],.array [.text "one-environment-reverse-label",.text "The environment retains the one label closed by the memory observation."]])],.object [("key",.text "thermal"),("question",.text "When is physical energy introduced?"),("choices",.array [.array [.text "import-kT-log-two-as-premise",.text "A conventional thermal formula cannot select the Fold law."],.array [.text "postseal-dimensional-correspondence",.text "The exact distinction/throw law is sealed before experimental thermal translation."]])],.object [("key",.text "extension"),("question",.text "May an extra cost rule enter?"),("choices",.array [.array [.text "free-cost-or-demon-exception",.text "A free exception defeats closure."],.array [.text "no-extra-rule",.text "Fibre cardinality, separation and record conservation exhaust the cycle."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-THERMO-LANDAUER-DEMON-TERMINAL-018"
  title := "Exact one-distinction erasure cost and Maxwell-demon ledger"
  branch := "physics"
  statement := "The Fold reset maps the two held preimages quarter-One and three-quarter-One to the common ready image half-One.  It therefore closes exactly one binary distinction and has native separation half-One.  Reversal is possible exactly when one of the two predecessor labels is retained.  A Maxwell sorting cycle gains one gas distinction, stores it in the demon's two-label memory, and on reset must export one reverse label to the environment.  The complete closed ledger therefore contains no free unrecorded gain.  This is the exact model-native erasure law; dimensional thermal-energy correspondence is tested only after sealing."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FOLD-DYNAMICS-001", "SFT-FOUNDATION-HALF-ONE-001", "SFT-INFO-CONSERVATION-LOSS-001", "SFT-INFO-ENTROPY-UNCERTAINTY-001", "SFT-COMP-CPLX-REVERSIBILITY-COST-001", "SFT-PHYS-THERMO-IRREVERSIBILITY-001", "SFT-PHYS-THERMO-SECOND-LAW-001", "SFT-PHYS-THERMO-HEAT-WORK-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.array [.text "SFT-PHYS-THERMO-LANDAUER-DEMON-TERMINAL-018",.text generationRule,candidateRecord c])

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
  proofHash := identity (.array [.text "SFT-PHYS-THERMO-LANDAUER-DEMON-TERMINAL-018",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := identity (.array [LandauerDemonLedgerControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity LandauerDemonLedgerControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 100000
set_option maxHeartbeats 100000000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.LandauerDemonLedgerEvidence
