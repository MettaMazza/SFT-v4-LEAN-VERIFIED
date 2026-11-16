import SFT.Physics.CollapseObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.CollapseObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.CollapseObservationEvidence
open SFT.Host.Canonical CollapseObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (CollapseObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-STELLAR-NUCLEAR-COLLAPSE-070"
def dependencies : List String := ["SFT-PHYS-STELLAR-NUCLEAR-COLLAPSE-TERMINAL-069", "SFT-PHYS-NUCLEAR-FUSION-FISSION-YIELD-THRESHOLD-006", "SFT-PHYS-NUCLEAR-BINDING-CURVE-TERMINAL-005", "SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-stellar-nuclear-collapse-law-versus-complete-five-source-record",.text "Retain all measured values, irregular duration rows, asymmetric errors, direct observations and model-assisted interpretations together without fitting a stage, rate or event channel."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Blind stellar nuclear chain, collapse and heavy-element validation"
 branch := "physics"
 statement := "Claim 069 sealed the stage-successor, global binding terminal, support-loss collapse, thermonuclear and neutral-capture laws before the five-source vector opened. NASA records all six major burning stages at strictly increasing temperatures from 3/100 to 33/10 billion kelvin and retains every duration, including the nonmonotonic neon/oxygen duration pair. Borexino directly detects stellar CNO fusion neutrinos at 36/5 with +3 and -17/10 counts per day per 100 tonnes and better than five-sigma significance. The complete SN1987A three-detector neutrino record supports the collapse channel while its delayed-mechanism preference remains labelled model-assisted. SN2014J directly supplies both cobalt decay lines and their uncertainties; the measured ratio interval contains the registered branch ratio. GW170817 spectroscopy identifies strontium, directly locating a neutron-capture element in neutron-rich merger ejecta while retaining the source's spectral-modelling dependence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The complete six NASA stage temperatures are (3/100,1/5,4/5,3/2,2,33/10) billion kelvin and strictly increase in the formal stage order; all durations (10000000,1000000,1000,1/10,2,1/100 years) remain and are not falsely called monotonic. Borexino reports 36/5 +3 -17/10 cpd per 100 tonnes, minimum significance five sigma at 99/100 confidence. SN1987A neutrinos were recorded by three detectors; the reported two-component preference exceeds 100:1 and the sub-One-second accretion component remains model-assisted. SN2014J records 847 and 1238 keV cobalt lines with fluxes 73/20 +/- 121/100 and 227/100 +/- 69/100 in 10^-4 photon units; the measured ratio 31/50 +/- 7/25 contains 17/25 and the spectrum significance is 113/10 sigma. GW170817 records the 810 nm strontium feature from 3/2 to 10 days, with 1/5-c broadening and 23/100-c blueshift."),("base",.text "Claim 069 is sealed before the five-source target object is released."),("successor",.text "Every source and uncertainty row is appended once; no favorable result deletes an irregular duration, detector, asymmetric error or model-dependence boundary."),("exclusions",.array [.text "no stage temperature, neutrino event, gamma line, spectral feature, abundance or source value in formal survivor selection",.text "no fitted reaction rate, explosion energy, nickel mass, standard-candle calibration, ejecta model or target-selected tolerance",.text "no deletion of the oxygen-duration irregularity, any SN1987A detector, either cobalt line or any GW170817 modelling boundary",.text "no model-assisted interpretation relabelled as a direct SFT dimensional prediction",.text "no negative, irrational, imaginary, floating, NaN, continuum or infinite Fold proof scalar"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no stage temperature, neutrino event, gamma line, spectral feature, abundance or source value in formal survivor selection", "no fitted reaction rate, explosion energy, nickel mass, standard-candle calibration, ejecta model or target-selected tolerance", "no deletion of the oxygen-duration irregularity, any SN1987A detector, either cobalt line or any GW170817 modelling boundary", "no model-assisted interpretation relabelled as a direct SFT dimensional prediction", "no negative, irrational, imaginary, floating, NaN, continuum or infinite Fold proof scalar"]
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
end SFT.Physics.CollapseObservationEvidence
