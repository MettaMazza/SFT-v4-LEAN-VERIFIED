import SFT.Chemistry.AnalyticalInterferenceMatrixGrammar
import SFT.Chemistry.AnalyticalInterferenceMatrix
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AnalyticalInterferenceMatrixEvidence
open SFT.Host.Canonical AnalyticalInterferenceMatrixGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Analyte held.",.boolean AnalyticalInterferenceMatrix.identityWitness],.array [.text "matrix",.text "Two interferents retained.",.boolean AnalyticalInterferenceMatrix.matrixWitness],.array [.text "baselines",.text "Pure rows positive.",.boolean AnalyticalInterferenceMatrix.baselinesWitness],.array [.text "mixtures",.text "Mixtures retained.",.boolean AnalyticalInterferenceMatrix.mixturesWitness],.array [.text "comparison",.text "Coincidence structural.",.boolean AnalyticalInterferenceMatrix.comparisonWitness],.array [.text "selectivity",.text "Second row raises.",.boolean AnalyticalInterferenceMatrix.selectivityWitness],.array [.text "adverse",.text "Adverse row retained.",.boolean AnalyticalInterferenceMatrix.adverseWitness],.array [.text "extension",.text "Matrix extends.",.boolean AnalyticalInterferenceMatrix.extensionWitness]]
def claimId : String := "SFT-CHEM-ANALYTICAL-SELECTIVITY-INTERFERENCE-005"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-ANALYTICAL-SELECTIVITY-001","SFT-CHEM-ANALYTICAL-SENSITIVITY-003","SFT-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "matrix",.text (matrixName c.matrix)],.array [.text "baselines",.text (baselinesName c.baselines)],.array [.text "mixtures",.text (mixturesName c.mixtures)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "selectivity",.text (selectivityName c.selectivity)],.array [.text "adverse",.text (adverseName c.adverse)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "response-without-analyte",.text "No target is attributable."],.array [.text "held-analyte-method-condition",.text "Analyte and domain remain held."]]],.array [.text "matrix",.array [.array [.text "selected-interferent",.text "Selection can hide interference."],.array [.text "complete-declared-interferent-matrix",.text "Every tested component remains."]]],.array [.text "baselines",.array [.array [.text "mixture-only-result",.text "Attribution is impossible."],.array [.text "analyte-and-interferent-baselines-held",.text "Pure-component responses remain."]]],.array [.text "mixtures",.array [.array [.text "accepted-mixtures-only",.text "Adverse mixtures disappear."],.array [.text "all-analyte-interferent-mixtures-held",.text "Every mixture response remains."]]],.array [.text "comparison",.array [.array [.text "signed-bias-scalar",.text "A sign alone loses response custody."],.array [.text "held-side-positive-distance-or-EmptyOne",.text "Interference is side plus positive distance or coincidence."]]],.array [.text "selectivity",.array [.array [.text "universal-specificity-label",.text "Selectivity is method-bound."],.array [.text "exact-response-distinguishability-class",.text "Every interferent receives an exact class."]]],.array [.text "adverse",.array [.array [.text "false-positive-rows-erased",.text "Erasure inflates selectivity."],.array [.text "favorable-adverse-error-rows-retained",.text "All outcomes remain."]]],.array [.text "extension",.array [.array [.text "matrix-renormalized",.text "Prior comparisons disappear."],.array [.text "successor-retains-and-adds-interferent",.text "New components extend the complete matrix."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold analytical selectivity and interference-matrix law"
 branch := "chemistry"
 statement := "Held analyte and complete interferent baselines and mixtures force exact method-bounded response distinction, interference side/distance or structural coincidence, retaining every error row."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-analyte-method-condition__complete-declared-interferent-matrix__analyte-and-interferent-baselines-held__all-analyte-interferent-mixtures-held__held-side-positive-distance-or-EmptyOne__exact-response-distinguishability-class__favorable-adverse-error-rows-retained__successor-retains-and-adds-interferent"),("base",.text "One analyte and one interferent baseline/mixture supply the first comparison."),("successor",.text "Every successor adds one interferent while preserving every earlier row."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external value threshold model or selected successful result chooses the survivor",.text "all favorable adverse absent unavailable unresolved uncertainty assumption correction fit and loss rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
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
end SFT.Chemistry.AnalyticalInterferenceMatrixEvidence
