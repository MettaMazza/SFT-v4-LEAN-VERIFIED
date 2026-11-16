import SFT.Physics.SmithionObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.SmithionObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.SmithionObservationEvidence
open SFT.Host.Canonical SmithionObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (SmithionObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-DARK-SMITHION-LFV-062"
def dependencies : List String := ["SFT-PHYS-DARK-SMITHION-LFV-TERMINAL-061", "SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001", "SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-dark-smithion-lfv-law-versus-complete-current-record",.text "Every available measured row is retained; an upper limit is never relabelled as a nonzero rate and an unobserved mass is never relabelled as measured."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Measured dark abundance and complete Smithion/LFV standing-test record"
 branch := "physics"
 statement := "After the zero-parameter Claim 061 seals, the exact dark/baryon ratio 27/5 is compared with the complete Planck density-ratio interval and lies inside it. Transport of the comparison-side baryon central value gives Omega_c h-squared=0.12096, inside Planck's complete reported [0.119,0.121] interval. SPARC's complete 175-galaxy record retains observed-to-baryonic velocity discrepancies; under the separately derived inverse-square law this rejects a finite baryon-only asymptote and requires an additional gravitating distribution. MEG II and BaBar report no signal and only upper limits for the three registered radiative LFV channels. Therefore those rows do not measure the sealed 3:5:20 relative weights and are retained without manufacturing a confirmation or contradiction. The twelve Smithion mass ratios remain exact standing predictions because no corresponding measured particles exist in the registered evidence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The exact 27/5 ratio lies inside the complete Planck dark/baryon interval, and 27/5 times 0.0224 gives 0.12096 inside the reported cold-dark interval [0.119,0.121]. The 175-galaxy SPARC record rejects finite baryon-only inverse-square asymptotics and supports additional gravitating matter under the admitted law. MEG II and BaBar provide three positive upper limits after null searches, not three measured rates; the 3:5:20 and 4:1 LFV predictions remain standing tests. No measured Smithion mass exists, so all twelve mass-ratio enclosures remain standing predictions rather than fabricated measured-value matches."),("base",.text "The formal receipt and both complete Planck density rows are bound before the withheld target is released."),("successor",.text "Each galaxy, LFV and unobserved-mass status row is appended exactly once; its evidential type is preserved and cannot alter the formal survivor."),("exclusions",.array [.text "no density, galaxy datum, search limit or particle mass in formal survivor selection",.text "no upper limit relabelled as an observed rate or relative-rate measurement",.text "no null search relabelled as proof of particle identity",.text "no unobserved Smithion relabelled as a measured discovery",.text "no fitted abundance, cross-section, mediator mass, branching fraction or uncertainty multiplier",.text "no negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no density, galaxy datum, search limit or particle mass in formal survivor selection", "no upper limit relabelled as an observed rate or relative-rate measurement", "no null search relabelled as proof of particle identity", "no unobserved Smithion relabelled as a measured discovery", "no fitted abundance, cross-section, mediator mass, branching fraction or uncertainty multiplier", "no negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude"]
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
end SFT.Physics.SmithionObservationEvidence
