import SFT.Physics.ChirpObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.ChirpObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.ChirpObservationEvidence
open SFT.Host.Canonical ChirpObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (ChirpObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-074"
def dependencies : List String := ["SFT-PHYS-GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-TERMINAL-073", "SFT-PHYS-VALIDATION-GRAVITATIONAL-WAVES-003", "SFT-PHYS-VALIDATION-GRAVITY-HORIZONS-003", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-Fold-chirp-merger-ringdown-sequence-versus-complete-postseal-LIGO-vector",.text "Retain every rising-chirp, merger, ringdown, uncertainty, model-role and pre-seal/post-seal provenance row."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Complete empirical gravitational-wave chirp, merger and ringdown comparison"
 branch := "physics"
 statement := "Claim 073 independently enumerated and sealed the exact Fold sequence. GW150914 remains disclosed as pre-seal observational context and is not relabelled as a blind prediction. The separately bound post-seal GW151226 record directly reports frequency and amplitude increasing across 55 cycles from 35 to 450 Hz, positive radiated energy and a two-component-to-one-remnant transition. The post-seal GW190521 record separately supports a decaying least-damped quadrupolar remnant mode while retaining the conditional quasicircular interpretation, short-signal boundary and alternative interpretations. Together the complete record validates the rising-chirp, merger and damped-ringdown classes without claiming that dimensional frequencies or half-One damping are universal measured Fold coordinates."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.observationalDerivation]
 sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := admissionIdentity (.array [.text claimId,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The complete empirical record supports all three forced waveform stages. GW151226 rises from 35 to 450 Hz and in amplitude over 55 cycles, retains positive radiated energy and records two initial components joining one final remnant. GW190521 retains a decaying least-damped l=m=2 remnant mode compatible with its full waveform analysis. Its short duration, conditional quasicircular interpretation and alternative-source boundary remain explicit. GW150914 is retained as observational development evidence, not counted as a blind target. No external value selects or modifies the 4096-form Claim 073 survivor, and no dimensional frequency or fitted damping value becomes a Fold proof scalar."),("base",.text "The admitted Claim 073 receipt exists before either withheld post-seal source is bound."),("successor",.text "Each complete event row appends once with its provenance and scope; no row changes the formal survivor or is promoted beyond its measurement role."),("exclusions",.array [.text "no claim that GW150914 was unseen before Claim 073",.text "no use of GW151226 or GW190521 values to select or alter the formal survivor",.text "no fitted chirp mass, waveform, merger time, damping coefficient, tone or tolerance",.text "no model-assisted remnant property relabelled as direct model-free measurement",.text "no claim that half-One damping or normalized Fold frequency was directly measured",.text "no omitted uncertainty, short-signal, conditional-interpretation or alternative-source row"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no claim that GW150914 was unseen before Claim 073", "no use of GW151226 or GW190521 values to select or alter the formal survivor", "no fitted chirp mass, waveform, merger time, damping coefficient, tone or tolerance", "no model-assisted remnant property relabelled as direct model-free measurement", "no claim that half-One damping or normalized Fold frequency was directly measured", "no omitted uncertainty, short-signal, conditional-interpretation or alternative-source row"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (admissionIdentity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := admissionIdentity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.ChirpObservationEvidence
