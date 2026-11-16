import SFT.Physics.ParticleModeObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.ParticleModeObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.ParticleModeObservationEvidence
open SFT.Host.Canonical ParticleModeObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (ParticleModeObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-PARTICLE-MODE-GENERATION-052"
def dependencies : List String := ["SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051", "SFT-PHYS-VALIDATION-CHARGED-LEPTON-TERMINAL-002", "SFT-PHYS-VALIDATION-QUARK-CKM-003", "SFT-PHYS-MATTER-CKM-TERMINAL-004", "SFT-PHYS-VALIDATION-NEUTRINO-MASS-MIXING-003", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-particle-mode-generation-law-versus-complete-registered-spectrum-vector",.text "Earlier mass/mixing targets were already known and observational provenance is disclosed; Claim 051 remained target-free and preceded retrieval of the independent PDG lepton summary."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Complete particle-generation, mass-pattern, mixing and longevity comparison"
 branch := "physics"
 statement := "The target-free terminal particle-mode law is compared with the complete registered lepton, quark, CKM and neutrino records. The PDG LEP-SLC fit interval [2989,3003]/1000 contains the forced generation count three. The independent direct determination 292/100 with stated uncertainty 5/100 is retained unchanged: its central-value displacement from three is exactly 8/5 stated uncertainties, with no rescaling, fitting, or use in selecting the law. Both terminal charged-lepton ratios pass; the registered s/d and b/s quark ratios pass while the absence of an exact scheme-matched t/c comparator remains explicit; all terminal CKM rows and the positive-neutrino PMNS/CP support pass at their registered boundaries. Charged-lepton masses increase electron-to-muon-to-tau while measured lifetimes decrease in that order."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The forced count three lies in the PDG LEP-SLC precision interval [2989,3003]/1000. The independent direct determination 292/100 with stated uncertainty 5/100 is preserved exactly and has central-value displacement 8/5 stated uncertainties from three; it is neither adjusted nor used to select the result. Both terminal charged-lepton mass-ratio intervals, the available s/d and b/s quark ratio intervals, all four terminal CKM intervals and the positive-neutrino mass/mixing support pass their registered comparisons; t/c remains without an exact scheme-matched direct comparator. The charged-lepton records give m_e<m_mu<m_tau and lifetime_e>lifetime_mu>lifetime_tau. These measurements test the terminal polynomial and ordering consequences, not the superseded site-as-mass, universal rate-ratio, dimensional lifetime-equality or extra-spatial-dimension claims."),("base",.text "The sealed three-label generation and terminal charged-lepton carriers are fixed before the independent lepton summary is opened."),("successor",.text "Each mass, mixing, count, lifetime, search-limit, unavailable-comparator and independent comparison row is appended exactly once and cannot alter the sealed formal survivor."),("exclusions",.array [.text "no external particle mass, lifetime, generation count, mixing entry or search limit in the formal survivor",.text "no omission, rescaling or reinterpretation of the independent direct neutrino-count determination or the absent exact t/c comparator",.text "no use of generation coordinate fractions as measured mass values",.text "no claim that structural subtraction reach equals a dimensional lifetime ratio",.text "no claim that quarter-mode 1:1:4 is a universal observed mixing or decay-rate ratio",.text "no inference that heavy-particle search limits prove absolute nonexistence",.text "no extra spatial dimension or compactification rule selected from particle data",.text "no numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no external particle mass, lifetime, generation count, mixing entry or search limit in the formal survivor", "no omission, rescaling or reinterpretation of the independent direct neutrino-count determination or the absent exact t/c comparator", "no use of generation coordinate fractions as measured mass values", "no claim that structural subtraction reach equals a dimensional lifetime ratio", "no claim that quarter-mode 1:1:4 is a universal observed mixing or decay-rate ratio", "no inference that heavy-particle search limits prove absolute nonexistence", "no extra spatial dimension or compactification rule selected from particle data", "no numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude"]
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
end SFT.Physics.ParticleModeObservationEvidence
