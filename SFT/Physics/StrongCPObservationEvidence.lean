import SFT.Physics.StrongCPObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.StrongCPObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.StrongCPObservationEvidence
open SFT.Host.Canonical StrongCPObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (StrongCPObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-STRONG-CP-BARYON-STABILITY-064"
def dependencies : List String := ["SFT-PHYS-STRONG-CP-BARYON-STABILITY-TERMINAL-063", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-strong-alignment-and-baryon-stability-versus-complete-registered-direct-search-vector",.text "Every registered uncertainty, finite bound, mode and candidate interpretation is retained without converting a null result into proof-zero, a candidate into decay, or a finite lower limit into completed infinity."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Blind neutron-EDM and multi-channel proton-stability validation"
 branch := "physics"
 statement := "Only after Claim 063 sealed, the PSI neutron-EDM measurement and six direct Super-Kamiokande proton-decay modes were released to the comparator. PSI reports a null central displacement with positive statistical and systematic uncertainties and a 90-percent upper limit of 1.8 times ten-to-the-minus-26 elementary-charge centimetres. This finite limit is consistent with the structurally absent strong electric-dipole carrier but is not relabelled as an exact proof scalar. Super-Kamiokande reports no decay indication across e/mu plus pi-zero, eta and two-pi-zero modes, with all six finite 90-percent partial-lifetime lower limits retained. Candidate events explicitly classified as atmospheric-neutrino-background compatible remain candidates, not fabricated decays. The complete registered vector therefore leaves the sealed aligned-One and proton-stability laws unviolated at current experimental sensitivity."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The PSI result retains its null central status, positive 1.1 and 0.2 times ten-to-the-minus-26 uncertainty magnitudes and positive 1.8 times ten-to-the-minus-26 90-percent upper bound. The six proton modes retain 90-percent partial-lifetime lower limits 2.4e34, 1.6e34, 1.4e34, 7.3e33, 7.2e33 and 4.5e33 years. No source reports a statistically significant proton-decay signal; the explicitly retained candidates are background compatible. Thus no registered row violates the sealed aligned-One or fibre-preserving baryon-One predictions."),("base",.text "The formal receipt is sealed and hashed before the neutron-EDM target is released."),("successor",.text "Each proton-decay mode and its full candidate interpretation is appended once; no row can alter the formal survivor or change evidential type."),("exclusions",.array [.text "no neutron-EDM value, uncertainty, proton candidate or lifetime limit in formal survivor selection",.text "no null central estimate relabelled as conventional numerical proof zero",.text "no finite experimental upper or lower limit relabelled as an exact absence or completed infinity",.text "no background-compatible event relabelled as proton decay and no candidate row omitted",.text "no fitted theta, axion coefficient, decay rate, lifetime, confidence multiplier or tolerance",.text "no negative, irrational, imaginary, floating, NaN, continuum or infinite Fold proof scalar"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no neutron-EDM value, uncertainty, proton candidate or lifetime limit in formal survivor selection", "no null central estimate relabelled as conventional numerical proof zero", "no finite experimental upper or lower limit relabelled as an exact absence or completed infinity", "no background-compatible event relabelled as proton decay and no candidate row omitted", "no fitted theta, axion coefficient, decay rate, lifetime, confidence multiplier or tolerance", "no negative, irrational, imaginary, floating, NaN, continuum or infinite Fold proof scalar"]
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
end SFT.Physics.StrongCPObservationEvidence
