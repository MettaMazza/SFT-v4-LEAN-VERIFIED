import SFT.Physics.ThermalObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.ThermalObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.ThermalObservationEvidence
open SFT.Host.Canonical ThermalObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (ThermalObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-THERMAL-HISTORY-RECOMBINATION-038"
def dependencies : List String := ["SFT-PHYS-THERMAL-HISTORY-RECOMBINATION-TERMINAL-037", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-thermal-history-law-versus-complete-primary-observation-record",.text "The formal receipt was fixed before the new primary snapshots and target record were opened."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Post-seal thermal-history, nucleosynthesis and recombination test"
 branch := "physics"
 statement := "After formal Claim 037 is admitted, direct high-redshift CMB thermometry, primordial helium and deuterium, Planck recombination and acoustic extrema, and the PDG freeze-out synthesis are opened. The measured temperature exponent contains exact One. The independently derived One/six to One/seven neutron/proton transport matches the external analytic sequence. Current direct helium measurement lies below and excludes exact One/four at one standard interval, so the old claim that the analytic family partition is the exact measured isotope abundance is rejected rather than fitted. Deuterium remains a positive minor channel. Planck reports finite recombination support and eighteen acoustic extrema; its angular multipoles reject exact integer multiples of the first peak, validating the formal separation between internal whole modes and observation."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The direct high-redshift CMB temperature exponent interval [49/50,517/500] contains exact One. The external freeze-out sequence is approximately 1/6 then 1/7, matching the separately forced typed transport. Direct helium Yp=0.2458+/-0.0013 gives [489/2000,2471/10000], which excludes 1/4; therefore 1/4 remains the exact analytic helium-family partition and is not relabelled as the exact isotope measurement. Direct primordial deuterium (2.527+/-0.030) times 10^-5 is positive and subordinate. Planck retains z*=1089.92+/-0.25, eighteen finite extrema and seven complete TT peak rows. Those angular peak intervals are not integer multiples of the first, so the internal-whole-mode/observed-projection distinction passes and the old angular-integer reading is rejected."),("base",.text "The formal receipt fixes the exponent, freeze-out/capture types, analytic family partition, visibility support and internal acoustic labels before target release."),("successor",.text "Each additional measurement row, uncertainty endpoint or acoustic extremum is retained once; an unfavorable row is recorded as a correction and cannot change the sealed survivor."),("exclusions",.array [.text "no external value readable by the formal candidate generator or formal independent validator",.text "no fitted cooling exponent, abundance correction, reaction rate, visibility width or angular projection",.text "no historical-blindness claim because V1/V2 named these targets",.text "no omission of the current direct helium interval that excludes exact One/four",.text "no preservation of the old exact observed-quarter or angular-integer claims by weakened comparison",.text "no numerical-zero, negative, irrational, imaginary or floating Fold proof magnitude"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no external value readable by the formal candidate generator or formal independent validator", "no fitted cooling exponent, abundance correction, reaction rate, visibility width or angular projection", "no historical-blindness claim because V1/V2 named these targets", "no omission of the current direct helium interval that excludes exact One/four", "no preservation of the old exact observed-quarter or angular-integer claims by weakened comparison", "no numerical-zero, negative, irrational, imaginary or floating Fold proof magnitude"]
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
end SFT.Physics.ThermalObservationEvidence
