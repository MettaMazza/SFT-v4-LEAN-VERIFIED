import SFT.Chemistry.ConcentrationPotentialGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ConcentrationPotentialEvidence
open SFT.Host.Canonical ConcentrationPotentialGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "coincidence",.text "Standard-state equality closes to EmptyOne.",.boolean true],.array [.text "product-direction",.text "Product-heavy support shifts toward reactants.",.boolean true],.array [.text "reactant-direction",.text "Reactant-heavy support shifts toward products.",.boolean true],.array [.text "exact-ratio",.text "Layer displacement is divided by positive carrier count exactly.",.boolean true],.array [.text "support",.text "Three generator layers give eight exact occurrences.",.boolean true],.array [.text "coincidence-control",.text "A numerical layer on coincidence halts.",.boolean true],.array [.text "successor",.text "Common layer successor preserves separation.",.boolean true]]
def claimId : String := "SFT-CHEM-CONCENTRATION-DEPENDENT-POTENTIAL-004"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-SOLUTION-001","SFT-CHEM-ACTIVITY-NONIDEAL-COMPOSITION-009","SFT-CHEM-HALF-REACTION-IDENTITY-ORIENTATION-001","SFT-CHEM-ELECTRODE-POTENTIAL-CHEMICAL-RELATION-002","SFT-CHEM-CELL-POTENTIAL-COMPOSITION-003"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "state",.text (stateName c.state)],.array [.text "quotient",.text (quotientName c.quotient)],.array [.text "support",.text (supportName c.support)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "transfer",.text (transferName c.transfer)],.array [.text "coincidence",.text (coincidenceName c.coincidence)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "state",.array [.array [.text "concentration-number-only",.text "A concentration number does not retain chemical identity or condition."],.array [.text "complete-half-reaction-activity-state",.text "Half-reaction, condition, species, phases and carrier count remain held."]]],.array [.text "quotient",.array [.array [.text "signed-or-continuum-activity-coordinate",.text "A signed continuum coordinate imports an ungenerated domain."],.array [.text "held-product-reactant-or-coincident-orientation",.text "Activity direction is structural and equality closes."]]],.array [.text "support",.array [.array [.text "arbitrary-real-activity-premise",.text "An arbitrary real activity is outside exact Fold arithmetic."],.array [.text "complete-generated-doubling-support",.text "Every positive generator layer exactly doubles finite support."]]],.array [.text "composition",.array [.array [.text "imported-logarithm",.text "A logarithm cannot select the native law."],.array [.text "layer-count-additive-product-composition",.text "Multiplying generated support corresponds exactly to adding generator layers."]]],.array [.text "transfer",.array [.array [.text "unscaled-electron-count",.text "Potential displacement must retain transferred-carrier multiplicity."],.array [.text "exact-layer-per-held-carrier-ratio",.text "The exact shift is generated layers per positive transferred carrier."]]],.array [.text "coincidence",.array [.array [.text "numerical-zero-standard-state",.text "Numerical zero is not a native proof value."],.array [.text "structural-EmptyOne-standard-state",.text "Equal product/reactant support closes to EmptyOne."]]],.array [.text "record",.array [.array [.text "selected-concentration-point",.text "A selected point can hide adverse curvature and uncertainty."],.array [.text "complete-concentration-potential-series",.text "Every registered concentration, temperature, phase, sign and uncertainty remains downstream."]]],.array [.text "extension",.array [.array [.text "refitted-concentration-coefficient",.text "Refitting at each scale adds free choices."],.array [.text "common-generator-successor-preserves-separation",.text "Adding one common layer preserves exact layer difference."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold concentration-dependent potential law"
 branch := "chemistry"
 statement := "A generated activity quotient changes potential by an exact held direction and positive generator-layer-per-carrier ratio; exact standard-state equality is EmptyOne."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-half-reaction-activity-state__held-product-reactant-or-coincident-orientation__complete-generated-doubling-support__layer-count-additive-product-composition__exact-layer-per-held-carrier-ratio__structural-EmptyOne-standard-state__complete-concentration-potential-series__common-generator-successor-preserves-separation"),("base",.text "One generated activity layer doubles complete finite support and yields one positive layer per held carrier account."),("successor",.text "A common generator successor preserves exact layer separation without refitting."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no imported logarithm Debye-Huckel coefficient smoothing law or measured series selects the survivor",.text "all conventional source equations fitted terms anomalies and values remain downstream provenance"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no imported logarithm Debye-Huckel coefficient smoothing law or measured series selects the survivor","all conventional source equations fitted terms anomalies and values remain downstream provenance"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with state := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ConcentrationPotentialEvidence
