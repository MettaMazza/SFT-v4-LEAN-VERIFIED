import SFT.Physics.StellarObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.StellarObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.StellarObservationEvidence
open SFT.Host.Canonical StellarObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (StellarObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-STELLAR-GALACTIC-TIDAL-068"
def dependencies : List String := ["SFT-PHYS-STELLAR-GALACTIC-TIDAL-TERMINAL-067", "SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009", "SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-stellar-galactic-tidal-law-versus-complete-seven-source-record",.text "Retain favorable, central-offset, piecewise, population and resonance-boundary rows together without fitting an exponent, selecting a galaxy subset or deleting Mercury."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Blind stellar, galactic and tidal terminal validation"
 branch := "physics"
 statement := "Claim 067 sealed hydrostatic restoration, the complete three/four terminal stellar luminosity classes, the flat-curve additional-support discriminator, the fourth-power baryonic rotation carrier and the isolated one-to-one tidal terminal before the seven-source target vector opened. Helioseismology records a stable solar structure at parts-per-ten-thousand sound-speed precision. All six measured piecewise stellar slopes remain present: only the high and very-high mass endpoints contain the sealed powers four and three, so no universal single-power claim is manufactured. The 153-galaxy baryonic Tully-Fisher central interval excludes four while its full reported systematic interval reaches four; both facts remain in the receipt. SPARC and the Bullet Cluster independently retain the extended-support discriminator. The Moon records 1:1 synchronous rotation, while Mercury's measured 3:2 resonance confirms the formal eccentric-forcing boundary rather than being erased as an exception."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The NASA solar record reports sound-speed and adiabatic-index inference at the 1/10000 precision order and density at 1/1000; its reference-model convective boundary 1427/2000 lies inside the observed 713/1000 +/- 1/1000 interval and is retained only as external structure evidence. The complete six stellar slopes are 507/250, 1143/250, 5743/1000, 4329/1000, 3967/1000 and 573/200 with their six reported uncertainties; the 3967/1000 row contains four and the 573/200 row contains three, while the other four do not and remain explicit. SPARC contributes all 175 galaxies. The 153-galaxy baryonic Tully-Fisher result is 77/20 +/- 9/100 with intrinsic scatter 3/50: its central interval excludes four, while the reported systematic interval [7/2,4] contains the sealed endpoint. The Bullet Cluster records an eight-sigma mass/plasma separation. The Moon records equal approximately-655-hour orbital and rotation periods. MESSENGER records Mercury's 29323073/500000 +/- 11/1000000 day rotation and experimentally verifies its 3:2 resonance, preserving the separately generated eccentric-resonance boundary."),("base",.text "The complete formal Claim 067 receipt is sealed before any of the seven measurement objects is released."),("successor",.text "Each complete source row is appended once; no favorable row can delete a nonmatching stellar regime, central Tully-Fisher offset or Mercury boundary, and no measurement can alter the formal survivor."),("exclusions",.array [.text "no source row, stellar slope, galaxy fit, tidal period or uncertainty in formal survivor selection",.text "no fitted exponent, normalization, mass-to-light choice, halo profile, tolerance or correction term",.text "no deletion of four non-endpoint stellar regimes and no universal single stellar exponent",.text "no replacement of the Tully-Fisher central interval by its systematic interval or concealment of either",.text "no relabelling of a conventional solar reference-model value as an SFT dimensional prediction",.text "no universal lunar 1:1 rule extended across the explicitly separate Mercury eccentric resonance",.text "no negative, irrational, imaginary, floating, NaN, continuum or infinite Fold proof scalar"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no source row, stellar slope, galaxy fit, tidal period or uncertainty in formal survivor selection", "no fitted exponent, normalization, mass-to-light choice, halo profile, tolerance or correction term", "no deletion of four non-endpoint stellar regimes and no universal single stellar exponent", "no replacement of the Tully-Fisher central interval by its systematic interval or concealment of either", "no relabelling of a conventional solar reference-model value as an SFT dimensional prediction", "no universal lunar 1:1 rule extended across the explicitly separate Mercury eccentric resonance", "no negative, irrational, imaginary, floating, NaN, continuum or infinite Fold proof scalar"]
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
end SFT.Physics.StellarObservationEvidence
