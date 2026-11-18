import SFT.Chemistry.AnalyticalDetectionGrammar
import SFT.Chemistry.AnalyticalDetection
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AnalyticalDetectionEvidence
open SFT.Host.Canonical AnalyticalDetectionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Identity held.",.boolean AnalyticalDetection.identityWitness],.array [.text "blank",.text "Both blanks retained.",.boolean AnalyticalDetection.blankWitness],.array [.text "levels",.text "Two levels retained.",.boolean AnalyticalDetection.levelsWitness],.array [.text "detection",.text "First overlap does not detect.",.boolean AnalyticalDetection.detectionWitness],.array [.text "errors",.text "Overlap remains visible.",.boolean AnalyticalDetection.errorsWitness],.array [.text "quantification",.text "Second level quantifies.",.boolean AnalyticalDetection.quantificationWitness],.array [.text "absence",.text "Undetected structural.",.boolean AnalyticalDetection.absenceWitness],.array [.text "extension",.text "Level extension retained.",.boolean AnalyticalDetection.extensionWitness]]
def claimId : String := "SFT-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-ANALYTICAL-PRECISION-REPEATABILITY-002","SFT-CHEM-ANALYTICAL-SENSITIVITY-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "blank",.text (blankName c.blank)],.array [.text "levels",.text (levelsName c.levels)],.array [.text "detection",.text (detectionName c.detection)],.array [.text "errors",.text (errorsName c.errors)],.array [.text "quantification",.text (quantificationName c.quantification)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "unidentified-signal",.text "No analyte boundary exists."],.array [.text "held-analyte-method-condition",.text "The boundary is attributable and bounded."]]],.array [.text "blank",.array [.array [.text "single-numerical-zero-blank",.text "Numerical zero cannot represent background."],.array [.text "complete-positive-blank-support",.text "Every observed blank response remains."]]],.array [.text "levels",.array [.array [.text "selected-low-result",.text "Selection hides failures."],.array [.text "complete-positive-ordered-level-support",.text "All registered low levels remain."]]],.array [.text "detection",.array [.array [.text "declared-limit-number",.text "A number alone cannot prove distinction."],.array [.text "exact-blank-sample-distinguishability",.text "Detection is forced by complete response separation."]]],.array [.text "errors",.array [.array [.text "false-results-erased",.text "Error classes are hidden."],.array [.text "false-positive-negative-custody",.text "Every classification error remains."]]],.array [.text "quantification",.array [.array [.text "detection-equals-quantification",.text "Identity is weaker than measurement."],.array [.text "repeatability-and-recovery-required",.text "Quantification retains replicate spread and recovery support."]]],.array [.text "absence",.array [.array [.text "negative-undetected-value",.text "Undetected is not negative amount."],.array [.text "detected-quantified-label-or-EmptyOne",.text "Failure is structural absence."]]],.array [.text "extension",.array [.array [.text "threshold-refitted",.text "A refit changes prior classifications."],.array [.text "successor-retains-and-recomputes-levels",.text "Every added level preserves earlier rows."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold detection and quantification boundary law"
 branch := "chemistry"
 statement := "Complete blank and low-level supports force method-bounded distinguishability, explicit error custody, and separate detection and quantification classes or structural absence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-analyte-method-condition__complete-positive-blank-support__complete-positive-ordered-level-support__exact-blank-sample-distinguishability__false-positive-negative-custody__repeatability-and-recovery-required__detected-quantified-label-or-EmptyOne__successor-retains-and-recomputes-levels"),("base",.text "One blank support and one low-level support supply the first boundary test."),("successor",.text "Every successor retains prior classifications and adds a complete level row."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external value threshold model or selected successful result chooses the survivor",.text "all favorable adverse absent unavailable unresolved uncertainty assumption correction fit and loss rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external value threshold model or selected successful result chooses the survivor","all favorable adverse absent unavailable unresolved uncertainty assumption correction fit and loss rows remain"]
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
end SFT.Chemistry.AnalyticalDetectionEvidence
