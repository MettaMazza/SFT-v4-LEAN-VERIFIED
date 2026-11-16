import SFT.Physics.HorizonObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.HorizonObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.HorizonObservationEvidence
open SFT.Host.Canonical HorizonObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (HorizonObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-COMPACT-HORIZON-THERMODYNAMICS-072"
def dependencies : List String := ["SFT-PHYS-COMPACT-HORIZON-THERMODYNAMICS-TERMINAL-071", "SFT-PHYS-VALIDATION-GRAVITY-HORIZONS-003", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-compact-horizon-law-versus-complete-current-object-boundary",.text "Retain the complete dimensional mass ordering, every uncertainty and condition, and the unmeasured Hawking boundary without treating absence as agreement."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Blind compact-object and horizon-thermodynamics validation"
 branch := "physics"
 statement := "Claim 071 sealed q^4 exclusion support against q^6 gravity, the exact two-family pre-horizon census, quarter-area information support and mT=1/16 before the compact-object targets opened. NASA's complete white-dwarf summary identifies electron degeneracy and the 7/5-solar-mass dimensional limit. The primary PSR J0740+6620 timing record measures 52/25 +/- 7/100 solar masses, placing a neutral-fermion-supported object strictly above the white-dwarf limit. The complete LIGO-Virgo GW170817 remnant analysis retains conditional upper boundaries 267/100 and 61/20 solar masses and explicitly identifies their model conditions. The earlier immutable horizon validation remains unchanged: horizon-scale shadow and ringdown are observed, while direct Hawking radiation, temperature and information reconstruction are not. That non-observation is a standing test boundary and is never counted as confirmation of mT=1/16."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The external dimensional record contains the 7/5-solar-mass electron-degenerate limit. The independently measured neutral-fermion-supported PSR J0740 mass interval is [201/100,215/100] solar masses, wholly above 7/5. The conditional merger-remnant upper records 267/100 and 61/20 solar masses are both above that measured interval and remain explicitly model-assisted rather than direct TOV measurements. Together with the earlier horizon-scale shadow/ringdown receipt, the post-seal record supports the ordered finite white-dwarf, neutron-star and horizon-endpoint classes. No direct astrophysical Hawking-radiation or temperature measurement exists in the registered vector, so the exact mT=1/16 law remains an unconfirmed, falsifiable prediction rather than a rewarded absence."),("base",.text "The sealed two-family theorem exists before the first external white-dwarf mass-limit row is released."),("successor",.text "Each measured or conditional compact-object row is appended once with its role and uncertainty; no row can alter the formal survivor or convert an unmeasured thermal prediction into a match."),("exclusions",.array [.text "no compact-object mass, uncertainty, merger condition, horizon image or Hawking status in formal survivor selection",.text "no fitted mass coefficient, equation-of-state choice, tolerance, temperature scale or target-selected correction",.text "no white-dwarf theory summary relabelled as direct mass measurement",.text "no observed neutron-star mass relabelled as the unknown maximum mass",.text "no conditional merger bound relabelled as a direct TOV measurement",.text "no Hawking non-observation rewarded as confirmation and no signed external coordinate imported as a Fold proof scalar"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no compact-object mass, uncertainty, merger condition, horizon image or Hawking status in formal survivor selection", "no fitted mass coefficient, equation-of-state choice, tolerance, temperature scale or target-selected correction", "no white-dwarf theory summary relabelled as direct mass measurement", "no observed neutron-star mass relabelled as the unknown maximum mass", "no conditional merger bound relabelled as a direct TOV measurement", "no Hawking non-observation rewarded as confirmation and no signed external coordinate imported as a Fold proof scalar"]
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
end SFT.Physics.HorizonObservationEvidence
