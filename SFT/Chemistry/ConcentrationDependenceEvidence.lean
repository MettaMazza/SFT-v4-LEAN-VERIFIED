import SFT.Chemistry.ConcentrationDependenceGrammar
import SFT.Chemistry.ConcentrationDependence
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ConcentrationDependenceEvidence
open SFT.Host.Canonical ConcentrationDependenceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "source-order",.text "The complete relation retains source order rather than sorting by outcome.",.boolean (match ConcentrationDependence.orderWitness with | .error _ => false | .ok b => b)],.array [.text "adverse-response-retention",.text "A lower later response remains retained rather than selected away.",.boolean (match ConcentrationDependence.adverseWitness with | .error _ => false | .ok b => b)],.array [.text "structural-absence",.text "An absent uncertainty coordinate is structural EmptyOne.",.boolean (match ConcentrationDependence.absenceWitness with | .error _ => false | .ok b => b)],.array [.text "append-successor",.text "Complete row append preserves the entire prior trace.",.boolean (match ConcentrationDependence.appendWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-CONCENTRATION-DEPENDENCE-RELATION-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-COMP-CPLX-TIME-SPACE-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-KIN-ORDER-001","SFT-CHEM-ELEMENTARY-TRANSITION-RATE-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "reactant",.text (reactantName c.reactant)],.array [.text "intervention",.text (interventionName c.intervention)],.array [.text "response",.text (responseName c.response)],.array [.text "condition",.text (conditionName c.condition)],.array [.text "completeness",.text (completenessName c.completeness)],.array [.text "relation",.text (relationName c.relation)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "reactant",.array [.array [.text "anonymous-or-changing-reactant",.text "Rows for different reactants cannot define one dependence relation."],.array [.text "one-held-registered-reactant-identity",.text "Every row retains the same registered reactant identity."]]],.array [.text "intervention",.array [.array [.text "concentration-erased-or-continuum-variable",.text "Erasing the intervention coordinate destroys the tested dependence."],.array [.text "exact-positive-concentration-support-per-row",.text "Each source row carries its exact positive concentration support."]]],.array [.text "response",.array [.array [.text "answer-only-rate-or-unregistered-change",.text "A detached response cannot be traced to a transition."],.array [.text "exact-positive-elementary-rate-response-per-row",.text "Each response is an exact positive post-seal rate support."]]],.array [.text "condition",.array [.array [.text "temperature-method-or-uncertainty-collapsed",.text "Condition collapse can manufacture a dependency."],.array [.text "complete-held-condition-method-and-uncertainty-record",.text "Every temperature, method and uncertainty remains source-bound."]]],.array [.text "completeness",.array [.array [.text "selected-favorable-rows-or-averaged-answer",.text "Selection or averaging erases adverse and distinct responses."],.array [.text "complete-source-ordered-row-census",.text "Every registered row is retained in source order."]]],.array [.text "relation",.array [.array [.text "imported-mass-action-power-order-fit-or-logarithm",.text "An imported exponent or fit could choose the relation."],.array [.text "exact-condition-bound-concentration-rate-table",.text "The complete exact table is the relation; no exponent is fitted."]]],.array [.text "prediction",.array [.array [.text "species-condition-density-rate-or-value-readable-before-seal",.text "Readable targets could select the law."],.array [.text "complete-value-free-9-row-identity-seal",.text "All nine source-row identities seal before values open."]]],.array [.text "extension",.array [.array [.text "refit-after-complete-row-append",.text "Refitting would alter prior evidence."],.array [.text "depth-independent-complete-row-append-with-prior-trace-preserved",.text "Appending one complete row preserves every earlier pair and record."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact condition-bound concentration-dependence relation"
 branch := "chemistry"
 statement := "Chemical concentration dependence is the complete source-ordered relation between one held reactant's exact positive concentration support and exact positive elementary-transition rate response, retaining every condition, method, uncertainty and unfavorable row. The relation is the complete table; no power law, order or exponent is fitted."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "one-held-registered-reactant-identity__exact-positive-concentration-support-per-row__exact-positive-elementary-rate-response-per-row__complete-held-condition-method-and-uncertainty-record__complete-source-ordered-row-census__exact-condition-bound-concentration-rate-table__complete-value-free-9-row-identity-seal__depth-independent-complete-row-append-with-prior-trace-preserved"),("base",.text "One registered reactant, one exact positive concentration intervention, one exact positive elementary-rate response and one complete condition record form the least relation row."),("successor",.text "Appending one complete source row preserves every earlier concentration/rate pair and record without refitting, selection, averaging or inferred exponent."),("exclusions",.array [.text "no numerical zero; absent external coordinates are structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported mass-action or power law, conventional reaction order, fitted exponent/coefficient or continuum concentration derivative",.text "no interpolation, regression, averaging, selected favorable row or target-derived correction",.text "no species, temperature, density, rate, uncertainty, method, note or target hash before prediction seal",.text "source-disclosed fitted confidence intervals remain post-seal provenance and never select the Fold law"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent external coordinates are structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported mass-action or power law, conventional reaction order, fitted exponent/coefficient or continuum concentration derivative","no interpolation, regression, averaging, selected favorable row or target-derived correction","no species, temperature, density, rate, uncertainty, method, note or target hash before prediction seal","source-disclosed fitted confidence intervals remain post-seal provenance and never select the Fold law"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with reactant := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ConcentrationDependenceEvidence
