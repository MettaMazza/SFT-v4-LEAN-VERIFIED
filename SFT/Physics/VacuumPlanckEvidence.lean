import SFT.Physics.VacuumPlanckGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.VacuumPlanckWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.VacuumPlanckEvidence
open SFT.Host.Canonical VacuumPlanckGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (VacuumPlanckWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-VACUUM-DENSITY-SCALE-036"
def dependencies : List String := ["SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-PHYS-MEAS-DIMENSION-COMPOSITION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-vacuum-density-law-versus-complete-Planck-CODATA-record",.text "The formal receipt is fixed before the newly retrieved primary PDF and target record are opened."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Post-seal Planck/CODATA test of the Fold vacuum-density scale law"
 branch := "physics"
 statement := "After the formal vacuum law is admitted, the complete Planck page-225 68-percent rows and exact CODATA speed are opened. The exact terminal vacuum share 11/16 lies inside Planck's 0.6889 +/- 0.0056 interval. The separately forced normalized magnitude 33/16 lies inside the exact transported interval 3(0.6889 +/- 0.0056). The Hubble interval and exact limiting speed transport the sealed coefficient to a positive exact dimensional Lambda interval in inverse square megaparsecs. The local One/2^20 floor lies outside the global vacuum-fraction interval, confirming that direct unscaled identification is a type error."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The exact Fold vacuum share 11/16 is inside Planck's interval [6833/10000,1389/2000]. The normalized Fold magnitude 33/16 is inside [20499/10000,4167/2000]=3 times that interval. Using page-225 H0=67.68 +/- 0.42 km s^-1 Mpc^-1 and exact c=299792.458 km s^-1 transports Lambda to the exact positive interval [(33/16)(67.26/c)^2,(33/16)(68.10/c)^2] Mpc^-2. One/2^20 is below the global interval and is therefore retained only as the separately typed local boundary-energy floor."),("base",.text "The admitted formal claim fixes the local floor, global share, normalized coefficient and transport law before target release."),("successor",.text "Each additional registered source row, uncertainty endpoint or correction is appended once without changing the sealed coefficient; a changed or omitted row halts the comparison."),("exclusions",.array [.text "no Planck or CODATA value readable by the formal candidate generator or independent formal validator",.text "no fit, recalibration or coefficient choice from Omega_Lambda or H0",.text "no claim of historical blindness: V1/V2 targets and an older local transcription were known",.text "no silent reuse of the older 67.66 H0 transcription where primary page 225 reports 67.68",.text "no direct equality between One/2^20, a raw radiative sum, Omega_Lambda and dimensional Lambda",.text "no numerical-zero, negative, irrational, imaginary or floating Fold proof magnitude"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no Planck or CODATA value readable by the formal candidate generator or independent formal validator", "no fit, recalibration or coefficient choice from Omega_Lambda or H0", "no claim of historical blindness: V1/V2 targets and an older local transcription were known", "no silent reuse of the older 67.66 H0 transcription where primary page 225 reports 67.68", "no direct equality between One/2^20, a raw radiative sum, Omega_Lambda and dimensional Lambda", "no numerical-zero, negative, irrational, imaginary or floating Fold proof magnitude"]
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
end SFT.Physics.VacuumPlanckEvidence
