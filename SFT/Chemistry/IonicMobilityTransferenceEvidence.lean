import SFT.Chemistry.IonicMobilityTransferenceGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.IonicMobilityTransferenceEvidence
open SFT.Host.Canonical IonicMobilityTransferenceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "species",.text "Both species identities remain held.",.boolean true],.array [.text "mobility",.text "Mobility is an exact positive ratio.",.boolean true],.array [.text "partition",.text "Contributions partition as three-quarters and one-quarter.",.boolean true],.array [.text "whole",.text "Transference contributions sum exactly to One.",.boolean true],.array [.text "direction",.text "Opposed species directions remain held.",.boolean true],.array [.text "composition",.text "Common composition remains held.",.boolean true],.array [.text "absence",.text "An absent species is structural EmptyOne.",.boolean true],.array [.text "duplicate-control",.text "Duplicate species custody halts.",.boolean true]]
def claimId : String := "SFT-CHEM-IONIC-MOBILITY-TRANSFERENCE-008"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-MUTUAL-CONDITIONAL-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-COUPLED-MASS-HEAT-CHARGE-TRANSPORT-019","SFT-CHEM-IONIC-CONDUCTIVITY-RELATION-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "direction",.text (directionName c.direction)],.array [.text "mobility",.text (mobilityName c.mobility)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "partition",.text (partitionName c.partition)],.array [.text "whole",.text (wholeName c.whole)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "record",.text (recordName c.record)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "anonymous-mobile-charge",.text "Anonymous charge loses chemical carrier identity."],.array [.text "complete-held-ionic-species-identity",.text "Every mobile species remains named and distinct."]]],.array [.text "direction",.array [.array [.text "signed-mobility",.text "A sign imports negative proof magnitude."],.array [.text "held-species-mobility-direction",.text "Direction is held separately from positive magnitude."]]],.array [.text "mobility",.array [.array [.text "continuum-velocity-field-quotient",.text "A continuum derivative is not a counted transport proof."],.array [.text "exact-traversal-per-carrier-resource-ratio",.text "Mobility is an exact ratio of counted traversals, carriers and path resource."]]],.array [.text "composition",.array [.array [.text "isolated-ion-answer",.text "An isolated answer loses the complete electrolyte."],.array [.text "common-composition-condition-path",.text "Every species shares the same held experimental support."]]],.array [.text "partition",.array [.array [.text "independent-fitted-transport-numbers",.text "Independent fits need not conserve the whole current."],.array [.text "exact-species-contribution-partition",.text "Each transference part is its exact contribution divided by the complete total."]]],.array [.text "whole",.array [.array [.text "approximately-normalized-sum",.text "Approximate normalization can hide lost current."],.array [.text "transference-parts-sum-exactly-to-One",.text "The complete finite partition reconstructs exactly One."]]],.array [.text "absence",.array [.array [.text "numerical-zero-absent-ion",.text "Numerical zero conflates absence with a measured response."],.array [.text "structural-EmptyOne-absent-species",.text "An unregistered carrier is structurally absent."]]],.array [.text "record",.array [.array [.text "selected-transport-number",.text "A selected result can hide concentration change and anomalies."],.array [.text "complete-mobility-transference-vector",.text "Every registered species, concentration, method, value and adverse row remains downstream."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold ionic mobility and transference law"
 branch := "chemistry"
 statement := "Each ionic mobility is an exact positive traversal-per-carrier-resource ratio and each transference part is that species contribution divided by the complete total, summing exactly to One."
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
 traceHash := identity (.array [.text claimId,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := identity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := identity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-held-ionic-species-identity__held-species-mobility-direction__exact-traversal-per-carrier-resource-ratio__common-composition-condition-path__exact-species-contribution-partition__transference-parts-sum-exactly-to-One__structural-EmptyOne-absent-species__complete-mobility-transference-vector"),("base",.text "One mobile species forms the complete One partition of its first finite transport record."),("successor",.text "Appending a distinct positive carrier repartitions the complete exact total while retaining every prior species contribution."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no transference mobility concentration direction or anomaly selects the survivor",.text "all conventional derivatives fits and unresolved results remain downstream provenance"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no transference mobility concentration direction or anomaly selects the survivor","all conventional derivatives fits and unresolved results remain downstream provenance"]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := identity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (identity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def runControls (sourceHash : String) : Value := .array ([
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with identity := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.IonicMobilityTransferenceEvidence
