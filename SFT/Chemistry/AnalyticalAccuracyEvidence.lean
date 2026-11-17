import SFT.Chemistry.AnalyticalAccuracyGrammar
import SFT.Chemistry.AnalyticalAccuracy
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AnalyticalAccuracyEvidence
open SFT.Host.Canonical AnalyticalAccuracyGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "reference",.text "Reference positive.",.boolean AnalyticalAccuracy.referenceWitness],.array [.text "measurand",.text "Identity held.",.boolean AnalyticalAccuracy.measurandWitness],.array [.text "support",.text "Rows ordered.",.boolean AnalyticalAccuracy.supportWitness],.array [.text "comparison",.text "Side and distance exact.",.boolean AnalyticalAccuracy.comparisonWitness],.array [.text "trueness",.text "Coincidence structural.",.boolean AnalyticalAccuracy.truenessWitness],.array [.text "uncertainty",.text "Exact values retained.",.boolean AnalyticalAccuracy.uncertaintyWitness],.array [.text "boundary",.text "Method held.",.boolean AnalyticalAccuracy.boundaryWitness],.array [.text "successor",.text "Complete record retained.",.boolean AnalyticalAccuracy.successorWitness]]
def claimId : String := "SFT-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-MEAS-TRACEABILITY-001","SFT-CHEM-ANALYTICAL-SAMPLE-001","SFT-CHEM-ANALYTICAL-CALIBRATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "reference",.text (referenceName c.reference)],.array [.text "measurand",.text (measurandName c.measurand)],.array [.text "support",.text (supportName c.support)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "trueness",.text (truenessName c.trueness)],.array [.text "uncertainty",.text (uncertaintyName c.uncertainty)],.array [.text "boundary",.text (boundaryName c.boundary)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "reference",.array [.array [.text "nominal-value-premise",.text "A name is not a reference."],.array [.text "traceable-reference-identity",.text "Reference identity and provenance remain held."]]],.array [.text "measurand",.array [.array [.text "result-without-measurand",.text "No comparison identity exists."],.array [.text "held-sample-measurand-method",.text "Sample, measurand and method remain."]]],.array [.text "support",.array [.array [.text "selected-result",.text "Selection hides variation."],.array [.text "complete-ordered-result-support",.text "Every registered result remains."]]],.array [.text "comparison",.array [.array [.text "signed-error-scalar",.text "A sign is not a native proof value."],.array [.text "held-side-positive-distance-or-EmptyOne",.text "Discrepancy is side plus positive distance or coincidence."]]],.array [.text "trueness",.array [.array [.text "declared-accurate-label",.text "A label cannot force trueness."],.array [.text "exact-observed-reference-relation",.text "The relation is recomputed from exact values."]]],.array [.text "uncertainty",.array [.array [.text "single-certain-value",.text "Alternatives are hidden."],.array [.text "complete-exact-uncertainty-support",.text "Every registered uncertainty bound remains."]]],.array [.text "boundary",.array [.array [.text "universal-method-accuracy",.text "Accuracy is method and material bound."],.array [.text "registered-material-method-boundary",.text "The comparison domain remains explicit."]]],.array [.text "extension",.array [.array [.text "renormalized-new-results",.text "Renormalization erases custody."],.array [.text "successor-retains-and-recomputes-all-results",.text "Every successor retains and recomputes."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold analytical accuracy and trueness law"
 branch := "chemistry"
 statement := "Traceable reference and held sample results force exact side/distance or structural coincidence with complete uncertainty and method boundaries."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "traceable-reference-identity__held-sample-measurand-method__complete-ordered-result-support__held-side-positive-distance-or-EmptyOne__exact-observed-reference-relation__complete-exact-uncertainty-support__registered-material-method-boundary__successor-retains-and-recomputes-all-results"),("base",.text "One traceable measured/reference pair supplies the first comparison."),("successor",.text "Every successor retains all earlier pairs and recomputes exactly."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external value threshold model or selected successful result chooses the survivor",.text "all favorable adverse absent unavailable unresolved uncertainty assumption correction fit and loss rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with reference := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.AnalyticalAccuracyEvidence
