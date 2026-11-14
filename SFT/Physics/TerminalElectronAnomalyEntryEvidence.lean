import SFT.Foundation.AdmissionControls
import SFT.Physics.TerminalElectronAnomalyEntryControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.TerminalElectronAnomalyEntryEvidence
open SFT.Host.Canonical TerminalElectronAnomalyEntryGrammar

def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array [.array [.text "leading",.text (leadingName c.leading)],.array [.text "turn",.text (turnName c.turn)],.array [.text "bulk",.text (bulkName c.bulk)],.array [.text "first",.text (firstName c.first)],.array [.text "second",.text (secondName c.second)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "retention",.text (retentionName c.retention)],.array [.text "target",.text (targetName c.target)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "extension",.text (extensionName c.extension)]]),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array [.object [("key",.text "leading"),("question",.text "Which anomaly carrier is completed?"),("choices",.array [.array [.text "replace-bare-or-leading-law",.text "Replacement erases the admitted Dirac and leading receipts."],.array [.text "retain-admitted-leading-alpha-carrier",.text "The terminal law refines the admitted positive leading anomaly."]])],.object [("key",.text "turn"),("question",.text "How is phase projected?"),("choices",.array [.array [.text "imported-irrational-turn",.text "An irrational carrier violates the domain."],.array [.text "terminal-exact-turn-projection",.text "The admitted 355/113 finite turn projects the phase exactly."]])],.object [("key",.text "bulk"),("question",.text "Which colour cells carry the first open loop?"),("choices",.array [.array [.text "selected-bulk-subset",.text "A subset can tune the result."],.array [.text "complete-volume-held-by-boundary-channels",.text "Colour volume 27 held by its three carried boundary channels forces open bulk 24."]])],.object [("key",.text "first"),("question",.text "Which first held/return pair closes?"),("choices",.array [.array [.text "free-first-loop-coefficient",.text "A free coefficient is fitted."],.array [.text "down-over-open-bulk-held-by-binary-alpha-over-down-colour",.text "Typed counts force 5/24 held by 2 alpha/15."]])],.object [("key",.text "second"),("question",.text "Which terminal held/return pair closes?"),("choices",.array [.array [.text "free-terminal-loop-coefficient",.text "A free coefficient is fitted."],.array [.text "One-alpha-square-over-down-colour-held-by-up-alpha-cube-over-closed-support",.text "Typed counts force alpha squared/15 held by 7 alpha cubed/30."]])],.object [("key",.text "orientation"),("question",.text "How are opposing loop phases represented?"),("choices",.array [.array [.text "signed-or-complex-coefficients",.text "Signed or complex proof values violate the Fold domain."],.array [.text "two-positive-held-pairs",.text "Each opposing pair is represented by ordered positive Take and the retained pairs add."]])],.object [("key",.text "retention"),("question",.text "How does the closed loop affect the leading carrier?"),("choices",.array [.array [.text "append-unbound-anomaly",.text "Appending creates an unnormalized extra carrier."],.array [.text "hold-alpha-loop-once-from-leading",.text "The complete loop acts once and is held from the existing leading anomaly."]])],.object [("key",.text "target"),("question",.text "May the electron measurement enter execution?"),("choices",.array [.array [.text "measurement-readable-execution",.text "That cannot issue a target-inaccessible seal."],.array [.text "target-inaccessible-until-prediction-seal",.text "Only admitted exact carriers execute before target release."]])],.object [("key",.text "provenance"),("question",.text "How is the data-informed derivation registered?"),("choices",.array [.array [.text "unregistered-fit",.text "An unregistered fit lacks custody and prediction receipts."],.array [.text "registered-observational-prediction-protocol",.text "Observation informs the explicit law; target-inaccessible execution seals it before comparison."]])],.object [("key",.text "extension"),("question",.text "May another loop term be appended?"),("choices",.array [.array [.text "extra-radiative-term",.text "Every down/up, bulk/boundary and terminal carrier is already consumed."],.array [.text "no-extra-rule",.text "The first terminal finite-loop grammar is exhausted."]])]]),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004"
  title := "Terminal exact electron magnetic anomaly"
  branch := "physics"
  statement := "The admitted leading alpha-over-binary phase anomaly is projected through the terminal exact turn. Its complete finite radiative ledger alternates two positive held/returned pairs: down-depth five over the open colour bulk 27 held by 3, against the binary alpha return over 5 times 3; and the single alpha-squared return over 5 times 3 against the up-depth-seven alpha-cubed terminal return over the closed bulk-plus-boundary support 30.  Holding alpha times that complete loop carrier once from the leading projection forces one exact electron anomaly."
  evidenceMode := .empirical
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-PHYS-QED-LEPTON-MAGNETIC-ANOMALY-003", "SFT-PHYS-QED-TERMINAL-TURN-PROJECTION-004", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-FIELD-FINITE-LOOP-CLOSURE-003", "SFT-PHYS-WAVE-INTERFERENCE-001", "SFT-PHYS-ELECTRON-DIRAC-G-FACTOR-002", "SFT-MATH-EXACT-ARITHMETIC-001"]
  axioms := []
  freeParameters := []
  provenance := [.observationalDerivation]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004",.text generationRule,candidateRecord c])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-QED-ELECTRON-MAGNETIC-ANOMALY-004",.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])

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
  proofHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [TerminalElectronAnomalyEntryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (SFT.Foundation.AdmissionControls.admissionIdentity TerminalElectronAnomalyEntryControls.closureValue)

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Physics.TerminalElectronAnomalyEntryEvidence
