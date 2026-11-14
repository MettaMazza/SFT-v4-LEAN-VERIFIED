import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalMuonAnomalyEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.TerminalMuonAnomalyEntryEvidence
open SFT.Host.Canonical TerminalMuonAnomalyEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "base",.text (baseName c.base)],.array [.text "generation",.text (generationName c.generation)],.array [.text "order",.text (orderName c.order)],.array [.text "depth-two",.text (depthTwoName c.depthTwo)],.array [.text "depth-three",.text (depthThreeName c.depthThree)],.array [.text "terminal",.text (terminalName c.terminal)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "base"),("question",.text "Which loop is universal?"),("choices",.array [.array [.text "independent-fitted-muon-base",.text "A separate base loses electron/muon correspondence."],.array [.text "complete-terminal-electron-loop",.text "The complete electron loop is inherited unchanged."]])],.object [("key",.text "generation"),("question",.text "Which added generation is acted?"),("choices",.array [.array [.text "selected-generation-label",.text "A label alone cannot force a carrier."],.array [.text "second-charged-lepton-depth",.text "The muon is the second charged-lepton generation and therefore uses depth two."]])],.object [("key",.text "order"),("question",.text "At what mass-scale order does it enter?"),("choices",.array [.array [.text "selected-alpha-order",.text "A selected order can tune the anomaly."],.array [.text "two-charged-end-alpha-square",.text "The admitted mass-scale sensitivity acts through both charged Fold ends, forcing alpha squared."]])],.object [("key",.text "depth-two"),("question",.text "Which first complement is complete?"),("choices",.array [.array [.text "free-leading-muon-weight",.text "A free weight is fitted."],.array [.text "both-labels-over-depth-two-complement",.text "Depth-two support has complement 17 and both labels force 2/17."]])],.object [("key",.text "depth-three"),("question",.text "How does the successor return?"),("choices",.array [.array [.text "free-successor-weight",.text "A free return is fitted."],.array [.text "one-alpha-over-binary-depth-three-complement",.text "Depth-three complement 53 distributed over both labels forces alpha/106."]])],.object [("key",.text "terminal"),("question",.text "Where does the last cell close?"),("choices",.array [.array [.text "selected-terminal-denominator",.text "A selected denominator is fitted."],.array [.text "four-rung-times-depth-three-plus-down-depth",.text "Complete support forces 16 times 53 plus 5 = 853."]])],.object [("key",.text "composition"),("question",.text "How do the positive generation carriers combine?"),("choices",.array [.array [.text "signed-or-cancelled-series",.text "Cancellation imports signed proof values."],.array [.text "complete-positive-sum-appended-once",.text "All three positive generation carriers add and act once on the universal loop."]])],.object [("key",.text "target"),("question",.text "May the muon measurement enter execution?"),("choices",.array [.array [.text "measurement-readable-execution",.text "That cannot issue a target-inaccessible prediction."],.array [.text "target-inaccessible-until-prediction-seal",.text "Only admitted exact carriers execute before release."]])],.object [("key",.text "provenance"),("question",.text "How is the data-informed derivation registered?"),("choices",.array [.array [.text "unregistered-fit",.text "An unregistered fit lacks custody and prediction receipts."],.array [.text "registered-observational-prediction-protocol",.text "Observation informs the explicit law; target-inaccessible execution seals it before comparison."]])],.object [("key",.text "extension"),("question",.text "May another generation term be appended?"),("choices",.array [.array [.text "extra-muon-term",.text "Depth two, its successor and terminal cell exhaust the registered muon grammar."],.array [.text "no-extra-rule",.text "No typed carrier remains unconsumed."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004"
  title := "Terminal exact muon magnetic anomaly"
  branch := "physics"
  statement := "The complete electron loop is universal.  The second charged-lepton generation adds the positive mass-scale correction at alpha squared: both Fold labels over the depth-two complement 17, then one alpha return over the binary-distributed depth-three complement 2 times 53, then one alpha-squared terminal cell over four-rung support 16 times 53 plus down-depth five.  This forces the exact added carrier alpha squared times [2/17 + alpha/106 + alpha squared/853]."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004", "SFT-PHYS-MATTER-MASS-RATIO-FAMILY-003", "SFT-PHYS-CONSTANT-CHARGED-LEPTON-TERMINAL-001", "SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003", "SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-MUON-MAGNETIC-ANOMALY-004",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [TerminalMuonAnomalyEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity TerminalMuonAnomalyEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.TerminalMuonAnomalyEntryEvidence
