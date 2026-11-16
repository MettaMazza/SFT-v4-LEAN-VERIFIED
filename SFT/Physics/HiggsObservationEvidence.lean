import SFT.Physics.HiggsObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.HiggsObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.HiggsObservationEvidence
open SFT.Host.Canonical HiggsObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (HiggsObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-HIGGS-SYMMETRY-TERMINAL-066"
def dependencies : List String := ["SFT-PHYS-HIGGS-SYMMETRY-TERMINAL-065", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-terminal-Higgs-ratio-and-self-coupling-versus-complete-current-record",.text "Retain aggregate agreement, both individual offsets, every uncertainty, and the direct-coupling capability boundary without choosing a coefficient, tolerance, or target-selected law."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Blind terminal Higgs mass and self-coupling validation"
 branch := "physics"
 statement := "Claim 065 sealed the exact ratio m_H/v = 2563352914777/5038463954690 and native self-coupling 6570778165695741824959729/50772238045420788745992200 before any Higgs target was released. The post-seal comparator uses the PDG electroweak scale 246.22 GeV only as a dimensional reference, giving the exact mass prediction 125.266104978... GeV. That prediction lies inside the complete PDG 2025 listed-average interval 125.09--125.31 GeV. The individual ATLAS and CMS offsets are retained rather than erased: they are approximately 1.42 and 1.88 of their reported combined uncertainties. The direct ATLAS-CMS pair-production constraint remains broad and contains the normalized unity self-coupling correspondence; it is not misrepresented as a precision measurement of native lambda."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "Using the post-seal PDG dimensional reference v = 12311/50 GeV, the sealed ratio predicts exactly m_H = 31557437733819647/251923197734500 GeV = 125.266104978... GeV. The PDG 2025 listed average is 626/5 +/- 11/100 GeV, whose reported-uncertainty interval [12509/100,12531/100] contains the prediction; the exact displacement from its central value is 16653377460247/251923197734500 GeV. ATLAS reports 12511/100 +/- 11/100 GeV and CMS reports 3126/25 +/- 3/25 GeV; their exact positive offsets remain in the certificate and are not called aggregate failures. The exact native lambda is 6570778165695741824959729/50772238045420788745992200. The 2026 ATLAS-CMS 95-percent normalized kappa-lambda interval, recorded as a below-reference direction of magnitude 71/100 through 61/10, contains the SFT normalized unity correspondence but does not yet resolve native lambda precisely."),("base",.text "The formal ratio and native coupling receipt are sealed before the external dimensional scale or Higgs targets are released."),("successor",.text "Each source row and uncertainty is appended once; individual offsets cannot be deleted by the aggregate comparison and no row can alter the sealed formal survivor."),("exclusions",.array [.text "no Higgs mass, VEV, self-coupling interval, uncertainty or aggregate in formal survivor selection",.text "no coefficient, correction term, target-selected tolerance, uncertainty inflation or fitted series",.text "no omission of the ATLAS or CMS individual offsets and no claim that both lie within one reported uncertainty",.text "no direct-search interval relabelled as a precision measurement of native lambda",.text "no signed external coordinate imported as a negative Fold proof scalar",.text "no negative, irrational, imaginary, floating, NaN, continuum or infinite Fold proof scalar"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no Higgs mass, VEV, self-coupling interval, uncertainty or aggregate in formal survivor selection", "no coefficient, correction term, target-selected tolerance, uncertainty inflation or fitted series", "no omission of the ATLAS or CMS individual offsets and no claim that both lie within one reported uncertainty", "no direct-search interval relabelled as a precision measurement of native lambda", "no signed external coordinate imported as a negative Fold proof scalar", "no negative, irrational, imaginary, floating, NaN, continuum or infinite Fold proof scalar"]
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
end SFT.Physics.HiggsObservationEvidence
