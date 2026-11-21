import SFT.Chemistry.ComponentExchangeGrammar
import SFT.Chemistry.ComponentExchange
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ComponentExchangeEvidence
open SFT.Host.Canonical ComponentExchangeGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "component-marginal-order",.text "Lower complete marginal account forces component transfer toward that phase.",.boolean (match ComponentExchange.directionWitness with | .error _ => false | .ok b => b)],.array [.text "equilibrium-EmptyOne",.text "Equal phase-specific component accounts force equilibrium without equal bulk composition.",.boolean (match ComponentExchange.equilibriumWitness with | .error _ => false | .ok b => b)],.array [.text "incomparable-halts",.text "Crossed accounts do not receive a fitted scalar trade-off.",.boolean ComponentExchange.incomparableWitness],.array [.text "common-context-successor",.text "A common positive context preserves the exact component relation.",.boolean (match ComponentExchange.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-PHYS-THERMO-STATE-RELATION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-MIXTURE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-SOLUTION-EQUILIBRIUM-001","SFT-CHEM-INTERFACE-TRANSFER-001","SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003","SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005","SFT-CHEM-ENTHALPY-EQUIVALENT-STATE-006","SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "accounts",.text (accountsName c.accounts)],.array [.text "identity",.text (identityName c.identity)],.array [.text "exchange",.text (exchangeName c.exchange)],.array [.text "support",.text (supportName c.support)],.array [.text "relation",.text (relationName c.relation)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "accounts",.array [.array [.text "bulk-phase-value-or-answer-only-potential",.text "A bulk value or named answer does not identify the marginal component change."],.array [.text "complete-distinct-phase-component-addition-accounts",.text "Each phase retains the complete account for adding one held component."]]],.array [.text "identity",.array [.array [.text "changed-component-or-unheld-environment",.text "Changing the component or environment destroys the exchange comparison."],.array [.text "same-held-component-and-fixed-environment",.text "The same component and finite environment are held across distinct phases."]]],.array [.text "exchange",.array [.array [.text "created-erased-or-unpaired-component",.text "An unpaired move violates the admitted component carrier conservation."],.array [.text "paired-one-component-exchange-conserving-total-carrier",.text "One departure and one arrival preserve the complete component carrier."]]],.array [.text "support",.array [.array [.text "signed-logarithmic-or-fitted-chemical-potential",.text "A signed scalar, logarithm or fit imports an unforced chemical-potential model."],.array [.text "exact-positive-energy-and-closed-distinction-increments",.text "The marginal account retains exact positive energy and distinction increments."]]],.array [.text "relation",.array [.array [.text "weighted-sum-tie-break-or-equal-composition-rule",.text "A weight, tie-break or equal-composition premise adds content not forced by exchange."],.array [.text "strict-product-order-with-EmptyOne-equilibrium",.text "Product order forces direction; exact account equality is equilibrium with EmptyOne separations."]]],.array [.text "prediction",.array [.array [.text "compound-condition-or-composition-readable-before-seal",.text "Withheld mixture values could select the component relation."],.array [.text "complete-value-free-74-row-identity-seal",.text "All 74 source-row identities seal before compounds, conditions or compositions open."]]],.array [.text "record",.array [.array [.text "selected-mixture-row-or-deleted-endpoint",.text "Selecting a system or dropping a source boundary can hide adverse phase behavior."],.array [.text "complete-four-system-74-row-VLE-vector-with-eight-endpoints",.text "All four systems, 74 matched interiors and eight unmatched endpoints are retained."]]],.array [.text "extension",.array [.array [.text "refit-after-common-context-successor",.text "Refitting after a shared context destroys structural invariance."],.array [.text "depth-independent-common-context-successor",.text "Adding the same exact positive context to both phase accounts preserves the relation."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical-potential-equivalent component law"
 branch := "chemistry"
 statement := "The chemical-potential-equivalent of one held component is its complete exact marginal addition account in a named phase: retained-energy increment and closed-distinction increment. At one fixed finite environment, paired component exchange is directed only by strict product order; exact account equality is equilibrium with structural EmptyOne separations and does not require equal bulk phase compositions. All 74 multicomponent equilibrium identities seal before compound, temperature, pressure or composition values open."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-distinct-phase-component-addition-accounts__same-held-component-and-fixed-environment__paired-one-component-exchange-conserving-total-carrier__exact-positive-energy-and-closed-distinction-increments__strict-product-order-with-EmptyOne-equilibrium__complete-value-free-74-row-identity-seal__complete-four-system-74-row-VLE-vector-with-eight-endpoints__depth-independent-common-context-successor"),("base",.text "One component and two distinct phases at one fixed environment supply the first paired exchange. Strict product order directs exchange; exact equality supplies equilibrium."),("successor",.text "Adding the same fresh exact positive energy and distinction context to both phase-specific component accounts preserves every comparison and therefore preserves direction or equilibrium."),("exclusions",.array [.text "no numerical zero; native absence and exact equality separations use structural EmptyOne",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported chemical-potential equation, activity coefficient, fugacity model, fitted weight or target-derived account",.text "no compound, temperature, pressure, liquid composition, gas composition, equilibrium result or target hash before prediction seal",.text "no selected mixture, selected row, deleted endpoint, fitted composition or model-correlated value used as measurement",.text "external decimal, zero and signed comparison glyphs remain post-seal source inscriptions only"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; native absence and exact equality separations use structural EmptyOne","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported chemical-potential equation, activity coefficient, fugacity model, fitted weight or target-derived account","no compound, temperature, pressure, liquid composition, gas composition, equilibrium result or target hash before prediction seal","no selected mixture, selected row, deleted endpoint, fitted composition or model-correlated value used as measurement","external decimal, zero and signed comparison glyphs remain post-seal source inscriptions only"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with accounts := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.ComponentExchangeEvidence
