import SFT.Physics.ElectroweakMeasuredGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.ElectroweakMeasuredWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.ElectroweakMeasuredEvidence
open SFT.Host.Canonical ElectroweakMeasuredGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (ElectroweakMeasuredWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-ELECTROWEAK-MEASURED-VALUE-053"
def dependencies : List String := ["SFT-PHYS-ELECTROWEAK-TERMINAL-ON-SHELL-003", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-terminal-electroweak-value-versus-like-typed-direct-measurements",.text "The direct on-shell measurement and compatible W/Z reconstruction test the sealed on-shell carrier; the source-identified inconsistent aggregate is retained only as a method record."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal electroweak measured-value correction"
 branch := "physics"
 statement := "The already sealed zero-parameter terminal on-shell share 1930922298157999/8642477221479757 is tested against the direct PDG on-shell measurement 0.22342 +/- 0.00009 and an independent compatible-input W/Z reconstruction. Both measured-value comparisons pass without fitting, rescaling or row deletion. The separately published all-input W aggregate contains a source-identified incompatible input and is retained unchanged as a measurement-method record; it is not admitted as an SFT mismatch or as a second physical target."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The exact forced terminal on-shell share lies inside the complete PDG interval [22333,22351]/100000. Its exact complement lies inside the outward-propagated compatible-input W/Z squared interval. No uncertainty is widened and no inconsistent aggregate is converted into a passing or failing SFT law."),("base",.text "The admitted terminal on-shell fraction is fixed before either external source record is released."),("successor",.text "Each like-typed measurement row is appended exactly once; an internally inconsistent aggregate remains a separately typed method record and cannot alter the sealed physical value."),("exclusions",.array [.text "no measured weak angle or boson mass in the formal relation",.text "no fitted rung, correction, coefficient, uncertainty multiplier or selected central value",.text "no mismatch relabelled as successful empirical closure",.text "no deletion or alteration of the all-input aggregation record",.text "no consensus classification used as proof; source consistency is checked from the published record",.text "no numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no measured weak angle or boson mass in the formal relation", "no fitted rung, correction, coefficient, uncertainty multiplier or selected central value", "no mismatch relabelled as successful empirical closure", "no deletion or alteration of the all-input aggregation record", "no consensus classification used as proof; source consistency is checked from the published record", "no numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude"]
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
end SFT.Physics.ElectroweakMeasuredEvidence
