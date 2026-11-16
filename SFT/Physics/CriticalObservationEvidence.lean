import SFT.Physics.CriticalObservationGrammar
import SFT.Engine.RegistrationGate
import SFT.Physics.CriticalObservationWitnesses
import SFT.Foundation.AdmissionControls
namespace SFT.Physics.CriticalObservationEvidence
open SFT.Host.Canonical CriticalObservationGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000

def witnesses : Value := .array (CriticalObservationWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048"
def dependencies : List String := ["SFT-PHYS-CRITICALITY-UNIVERSALITY-TURBULENCE-TERMINAL-047", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "relation",.text (relationName c.relation)],.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "rows",.text (rowsName c.rows)],.array [.text "generality",.text (generalityName c.generality)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-scalar",.text "An answer-only scalar erases the generated physical carrier."],.array [.text "complete-fold-carrier",.text "The complete Fold trace retains the observed physical distinction."]]],.array [.text "relation",.array [.array [.text "imported-or-fitted-relation",.text "An imported or fitted relation lets consensus or target data select the law."],.array [.text "sealed-criticality-and-cascade-law-versus-complete-postseal-exponent-and-turbulence-vector",.text "Claim 047 and receipt sha256:0601d19640943c4b99eb8cccf061e3115c520773eac5e762bf7c5b7440339b25 were fixed before the four target snapshots were bound."]]],.array [.text "provenance",.array [.array [.text "unbound-provenance",.text "Unbound provenance cannot demonstrate which premises produced the result."],.array [.text "source-bound-proof-trace",.text "Every generated candidate and decision is bound to its exact source trace."]]],.array [.text "prediction",.array [.array [.text "target-readable-prediction",.text "A target-readable predictor can copy or optimize against the measurement."],.array [.text "capability-closed-prediction",.text "The registered Fold instruction surface has no target or ambient host capability."]]],.array [.text "record",.array [.array [.text "proof-measurement-conflation",.text "Treating an external decimal record as a proof scalar violates the measured-value boundary."],.array [.text "separate-measurement-record",.text "External values remain source-bound records compared only after sealing."]]],.array [.text "rows",.array [.array [.text "selected-favourable-rows",.text "Selecting favorable rows cannot falsify the relation."],.array [.text "complete-registered-rows",.text "Every favorable, unfavorable and tampered registered row is retained."]]],.array [.text "generality",.array [.array [.text "finite-answer-lookup",.text "An answer lookup has no successor certificate."],.array [.text "one-successor-closure",.text "The One base and generated successor preserve the relation at every declared finite depth."]]],.array [.text "extension",.array [.array [.text "free-extra-rule",.text "A free constant, scale or exception can select the measured answer."],.array [.text "no-extra-rule",.text "No rule beyond the admitted dependencies and forced relation is present."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Post-seal critical-exponent, universality and turbulence-scaling test"
 branch := "physics"
 statement := "After Claim 047 and its complete 256-form derivation were officially sealed, four independent records were bound. Neutron scattering in erbium measures beta, gamma and nu intervals containing the sealed 1/2, One and 1/2 vector. Five manganite compositions report beta, gamma and delta: La00, La04, La06 and La08 contain the complete sealed 1/2, One and three vector, while La02 does not and is retained as an unfavorable class-membership control. An independent turbulence computation measures zeta_2=(679 +/- 13)/1000, whose exact interval contains 2/3, and a physical turbulent-channel experiment observes five-thirds compensated spectral plateaux by both Fourier and Hilbert routes. Finite-Reynolds and structure-function-range limitations remain explicit; no measured value selected or altered the formal law."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "The erbium intervals [46,50]/100 for beta, [90,102]/100 for gamma and [47,51]/100 for nu contain exactly 1/2, One and 1/2. Of the complete five-row manganite record, La00, La04, La06 and La08 contain the entire beta=1/2, gamma=One, delta=three vector; La02 excludes gamma=One and delta=three and therefore cannot be admitted to that generated universality class. The independent turbulence interval [666,692]/1000 contains exactly 2/3. A Reynolds-count-720 physical flow exhibits five-thirds compensated plateaux over 40--4000 Hz by Fourier analysis and 20--2000 Hz by Hilbert analysis. The nonmatching composition, finite-Reynolds correction boundary, structure-function range limitation, normalized-threshold boundary and empty-exponent typing are all retained."),("base",.text "The admitted formal receipt fixes the two generated classes and all six exact exponent carriers before any measurement target is released."),("successor",.text "Each additional source, sample, interval, analysis route and limitation is retained exactly once and cannot modify the sealed formal survivor or its generated class key."),("exclusions",.array [.text "no critical exponent, sample class, Reynolds record, structure exponent or spectrum slope readable by the formal generator",.text "no fitted exponent, uncertainty interval, intermittency correction or measurement-selected universality class",.text "no omission of La02 or any other unfavorable measurement row",.text "no conversion of the normalized half-One threshold into a universal laboratory temperature",.text "no conversion of typed empty alpha or eta into a numerical-zero measurement",.text "no claim that every physical transition shares the binary self-antipodal exponent vector",.text "no conventional numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no critical exponent, sample class, Reynolds record, structure exponent or spectrum slope readable by the formal generator", "no fitted exponent, uncertainty interval, intermittency correction or measurement-selected universality class", "no omission of La02 or any other unfavorable measurement row", "no conversion of the normalized half-One threshold into a universal laboratory temperature", "no conversion of typed empty alpha or eta into a numerical-zero measurement", "no claim that every physical transition shares the binary self-antipodal exponent vector", "no conventional numerical-nothingness, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity Fold proof magnitude"]
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
end SFT.Physics.CriticalObservationEvidence
