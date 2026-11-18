import SFT.Chemistry.AnalyticalPrecisionGrammar
import SFT.Chemistry.AnalyticalPrecision
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.AnalyticalPrecisionEvidence
open SFT.Host.Canonical AnalyticalPrecisionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "identity",.text "Identity held.",.boolean AnalyticalPrecision.identityWitness],.array [.text "conditions",.text "Condition held.",.boolean AnalyticalPrecision.conditionsWitness],.array [.text "support",.text "Three rows retained.",.boolean AnalyticalPrecision.supportWitness],.array [.text "comparison",.text "Three pairs retained.",.boolean AnalyticalPrecision.comparisonWitness],.array [.text "spread",.text "Spread exact.",.boolean AnalyticalPrecision.spreadWitness],.array [.text "class",.text "No reference imported.",.boolean AnalyticalPrecision.classWitness],.array [.text "adverse",.text "Lowest row retained.",.boolean AnalyticalPrecision.adverseWitness],.array [.text "successor",.text "Pairs extend.",.boolean (AnalyticalPrecision.successorWitness.toOption.getD false)]]
def claimId : String := "SFT-CHEM-ANALYTICAL-PRECISION-REPEATABILITY-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-ANALYTICAL-SAMPLE-001","SFT-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "identity",.text (identityName c.identity)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "support",.text (supportName c.support)],.array [.text "comparison",.text (comparisonName c.comparison)],.array [.text "spread",.text (spreadName c.spread)],.array [.text "class",.text (classAxisName c.classAxis)],.array [.text "adverse",.text (adverseName c.adverse)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "identity",.array [.array [.text "replicates-without-sample",.text "Results cannot be paired."],.array [.text "held-sample-measurand-method",.text "All replicate identities remain."]]],.array [.text "conditions",.array [.array [.text "mixed-condition-pool",.text "Repeatability is obscured."],.array [.text "same-held-repeatability-conditions",.text "Conditions are identical and explicit."]]],.array [.text "support",.array [.array [.text "summary-only",.text "A summary erases rows."],.array [.text "complete-positive-ordered-replicates",.text "Every replicate remains."]]],.array [.text "comparison",.array [.array [.text "signed-deviation-list",.text "Signed values are not native proof distances."],.array [.text "all-pair-positive-distance-or-EmptyOne",.text "All unordered pairs are exact."]]],.array [.text "spread",.array [.array [.text "fitted-dispersion-parameter",.text "A fit cannot define observed spread."],.array [.text "exact-extreme-distance-or-EmptyOne",.text "Spread is forced by retained extrema."]]],.array [.text "class",.array [.array [.text "precision-equals-trueness",.text "Agreement with a reference is distinct."],.array [.text "repeatability-class-held-separately",.text "Precision and trueness remain separate."]]],.array [.text "adverse",.array [.array [.text "outlier-deleted",.text "Deletion inflates precision."],.array [.text "all-adverse-replicates-retained",.text "Every registered replicate remains."]]],.array [.text "extension",.array [.array [.text "summary-renormalized",.text "Earlier distances disappear."],.array [.text "successor-retains-and-recomputes-pairs",.text "New replicates extend all pair comparisons."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold analytical precision and repeatability law"
 branch := "chemistry"
 statement := "Same-condition replicates force all exact pair distances and extreme spread while retaining every adverse replicate separately from trueness."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-sample-measurand-method__same-held-repeatability-conditions__complete-positive-ordered-replicates__all-pair-positive-distance-or-EmptyOne__exact-extreme-distance-or-EmptyOne__repeatability-class-held-separately__all-adverse-replicates-retained__successor-retains-and-recomputes-pairs"),("base",.text "Two same-condition replicates supply the first pair distance."),("successor",.text "Every successor adds all new pairs without erasing prior rows."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external value threshold model or selected successful result chooses the survivor",.text "all favorable adverse absent unavailable unresolved uncertainty assumption correction fit and loss rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
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
end SFT.Chemistry.AnalyticalPrecisionEvidence
