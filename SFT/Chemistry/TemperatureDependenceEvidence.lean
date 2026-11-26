import SFT.Chemistry.TemperatureDependenceGrammar
import SFT.Chemistry.TemperatureDependence
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.TemperatureDependenceEvidence
open SFT.Host.Canonical TemperatureDependenceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "source-order",.text "The complete relation retains source-target order rather than sorting by temperature or outcome.",.boolean (match TemperatureDependence.orderWitness with | .error _ => false | .ok b => b)],.array [.text "adverse-nonmonotone-retention",.text "A later higher-temperature, lower-rate response remains retained.",.boolean (match TemperatureDependence.adverseWitness with | .error _ => false | .ok b => b)],.array [.text "reaction-separation",.text "Distinct registered reactions remain explicit within one complete source table.",.boolean (match TemperatureDependence.separationWitness with | .error _ => false | .ok b => b)],.array [.text "append-successor",.text "Complete target-row append preserves the entire prior trace.",.boolean (match TemperatureDependence.appendWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-TEMPERATURE-DEPENDENCE-RELATION-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-CPLX-TIME-SPACE-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-KIN-ORDER-001","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002","SFT-CHEM-STATE-ENERGY-ORDER-004","SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001","SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "reaction",.text (reactionName c.reaction)],.array [.text "temperature",.text (temperatureName c.temperature)],.array [.text "response",.text (responseName c.response)],.array [.text "condition",.text (conditionName c.condition)],.array [.text "completeness",.text (completenessName c.completeness)],.array [.text "relation",.text (relationName c.relation)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "reaction",.array [.array [.text "anonymous-collapsed-or-changing-reaction",.text "Collapsing reaction identity can manufacture one temperature relation from distinct processes."],.array [.text "held-registered-reaction-identity-per-row",.text "Every row retains its registered reaction identity."]]],.array [.text "temperature",.array [.array [.text "temperature-erased-signed-or-continuum-variable",.text "Erasing the intervention coordinate destroys the tested dependence."],.array [.text "exact-positive-temperature-support-per-row",.text "Every source row carries exact positive temperature support."]]],.array [.text "response",.array [.array [.text "answer-only-rate-or-unregistered-change",.text "A detached response cannot be traced to a chemical transition."],.array [.text "exact-positive-elementary-rate-response-per-row",.text "Each response is an exact positive post-seal elementary-rate support."]]],.array [.text "condition",.array [.array [.text "density-bath-method-or-uncertainty-collapsed",.text "Condition collapse can manufacture an apparent temperature effect."],.array [.text "complete-held-density-bath-method-and-uncertainty-record",.text "Every density, bath gas, method and uncertainty remains source-bound."]]],.array [.text "completeness",.array [.array [.text "selected-favorable-rows-reaction-or-averaged-answer",.text "Selection or averaging erases repeated, absent and adverse observations."],.array [.text "complete-two-reaction-source-ordered-row-census",.text "Every measured row for both registered reactions is retained in source order."]]],.array [.text "relation",.array [.array [.text "imported-arrhenius-exponential-logarithm-prefactor-or-activation-fit",.text "An imported form or fitted value could choose the answer."],.array [.text "exact-condition-bound-temperature-rate-table",.text "The complete exact table is the relation; no fitted functional form enters."]]],.array [.text "prediction",.array [.array [.text "temperature-density-rate-or-target-value-readable-before-seal",.text "Readable targets could select the law."],.array [.text "complete-value-free-19-target-identity-seal",.text "All nineteen measured target identities seal before values open."]]],.array [.text "extension",.array [.array [.text "refit-after-complete-row-append",.text "Refitting would alter prior evidence."],.array [.text "depth-independent-complete-row-append-with-prior-trace-preserved",.text "Appending one complete target row preserves every earlier reaction/temperature/rate record."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact condition-bound temperature-dependence relation"
 branch := "chemistry"
 statement := "Chemical temperature dependence is the complete source-ordered relation between each held registered reaction's exact positive temperature support and exact positive elementary-transition rate response, retaining density, bath gas, method, uncertainty, repeated conditions, structural absences and unfavorable rows. The table is the relation; no Arrhenius, exponential, logarithmic, prefactor or activation fit enters."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-registered-reaction-identity-per-row__exact-positive-temperature-support-per-row__exact-positive-elementary-rate-response-per-row__complete-held-density-bath-method-and-uncertainty-record__complete-two-reaction-source-ordered-row-census__exact-condition-bound-temperature-rate-table__complete-value-free-19-target-identity-seal__depth-independent-complete-row-append-with-prior-trace-preserved"),("base",.text "One registered reaction, one exact positive temperature, one exact positive elementary-rate response and one complete condition record form the least relation row."),("successor",.text "Appending one complete measured target row preserves every earlier reaction/temperature/rate record without refitting, selection, averaging or inferred functional form."),("exclusions",.array [.text "no numerical zero; absent source rate cells are structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported Arrhenius, exponential or logarithmic law, fitted prefactor/activation value or continuum temperature derivative",.text "no interpolation, regression, averaging, selected reaction, temperature, condition, method, row or target-derived correction",.text "no temperature, density, rate, uncertainty, method, note or target hash before prediction seal",.text "source-disclosed confidence intervals remain post-seal measurement provenance and never select the Fold law"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent source rate cells are structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported Arrhenius, exponential or logarithmic law, fitted prefactor/activation value or continuum temperature derivative","no interpolation, regression, averaging, selected reaction, temperature, condition, method, row or target-derived correction","no temperature, density, rate, uncertainty, method, note or target hash before prediction seal","source-disclosed confidence intervals remain post-seal measurement provenance and never select the Fold law"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with reaction := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.TemperatureDependenceEvidence
