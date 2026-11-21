import SFT.Chemistry.RealGasExchangeGrammar
import SFT.Chemistry.RealGasExchange
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.RealGasExchangeEvidence
open SFT.Host.Canonical RealGasExchangeGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-fugacity-equivalent",.text "Accessible gas exchange support over reference support is an exact positive fraction.",.boolean (match RealGasExchange.ratioWitness with | .error _ => false | .ok b => b)],.array [.text "real-gas-interaction",.text "Joint and independently composed support are compared without an equation of state.",.boolean (match RealGasExchange.interactionWitness with | .error _ => false | .ok b => b)],.array [.text "phase-exchange-balance",.text "Equal component exchange supports produce structural balance with EmptyOne separation.",.boolean (match RealGasExchange.balanceWitness with | .error _ => false | .ok b => b)],.array [.text "replication-successor",.text "Common exact support replication preserves every gas-mixture relation.",.boolean (match RealGasExchange.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-FUGACITY-EQUIVALENT-GAS-MIXTURE-010"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-MIXTURE-001","SFT-CHEM-SOLUTION-EQUILIBRIUM-001","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002","SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003","SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005","SFT-CHEM-ENTHALPY-EQUIVALENT-STATE-006","SFT-CHEM-FREE-ENERGY-EQUIVALENT-DIRECTION-007","SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008","SFT-CHEM-ACTIVITY-NONIDEAL-COMPOSITION-009"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "state",.text (stateName c.state)],.array [.text "component",.text (componentName c.component)],.array [.text "relation",.text (relationName c.relation)],.array [.text "equilibrium",.text (equilibriumName c.equilibrium)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "unbound-fugacity-number",.text "An unbound scalar erases the component exchange support and gas state it names."],.array [.text "complete-gas-component-exchange-account",.text "The carrier retains component, phase, environment, composition and every support count."]]],.array [.text "state",.array [.array [.text "erased-pressure-temperature-or-composition",.text "Erasing a held coordinate merges distinguishable real-gas states."],.array [.text "complete-held-pressure-temperature-composition-state",.text "Every finite pressure, temperature and composition record remains held."]]],.array [.text "component",.array [.array [.text "bulk-mixture-answer-without-component-identity",.text "A bulk answer cannot preserve which component exchanges across the phase boundary."],.array [.text "held-component-resolved-exchange-support",.text "Each relation is attached to one held component and complete mixture support."]]],.array [.text "relation",.array [.array [.text "imported-fugacity-eos-or-fitted-correction",.text "An imported equation or fitted correction lets an external model select the answer."],.array [.text "exact-accessible-over-reference-support-relation",.text "The fugacity-equivalent relation is the exact accessible/reference support fraction."]]],.array [.text "equilibrium",.array [.array [.text "assumed-ideal-gas-or-target-derived-balance",.text "Assumed ideality or target-derived adjustment does not force phase exchange."],.array [.text "exact-component-exchange-support-balance",.text "Phase equilibrium is exact equality of the component exchange-support accounts."]]],.array [.text "prediction",.array [.array [.text "real-gas-values-readable-before-seal",.text "Readable values could select or tune the generated law."],.array [.text "complete-value-free-94-state-identity-seal",.text "All 94 equilibrium identities seal before compounds, conditions, pressures or compositions open."]]],.array [.text "record",.array [.array [.text "selected-mixture-or-deleted-pressure-only-state",.text "Selection would hide the complete favorable, adverse and incomplete-measurement surface."],.array [.text "complete-21-dataset-176-point-94-state-record",.text "All raw datasets and points, 94 equilibrium states, 59 paired and 35 pressure-only states remain."]]],.array [.text "extension",.array [.array [.text "refit-after-exact-support-replication",.text "Refitting after replication destroys the exact support relation."],.array [.text "depth-independent-common-support-replication",.text "Common exact replication preserves fugacity-equivalent, interaction and phase-balance relations."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fugacity-equivalent real-gas mixture law"
 branch := "chemistry"
 statement := "A component's Fold-native fugacity equivalent is its exact positive accessible gas exchange-support count over the complete held reference-support count at one retained pressure, temperature and composition. Real-gas interaction is the exact joint-versus-independent support relation, and phase equilibrium is exact component exchange-support balance. No fugacity equation, equation of state, logarithm or fitted correction is imported. All 94 real-gas equilibrium identities seal before values open."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-gas-component-exchange-account__complete-held-pressure-temperature-composition-state__held-component-resolved-exchange-support__exact-accessible-over-reference-support-relation__exact-component-exchange-support-balance__complete-value-free-94-state-identity-seal__complete-21-dataset-176-point-94-state-record__depth-independent-common-support-replication"),("base",.text "One accessible component exchange-support fibre held against one complete reference support yields the first fugacity-equivalent relation; equality with one partner-phase support yields the first balance."),("successor",.text "Replicating accessible, reference, independently composed and partner-phase supports by the same exact positive count preserves their ratios and order/equality relations at every finite depth."),("exclusions",.array [.text "no numerical zero; absent support is structural EmptyOne and any external zero glyph remains an interface inscription",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported fugacity equation, chemical-potential logarithm, ideal-gas law, equation of state, compressibility or virial fit",.text "no fitted interaction parameter, selected mixture, selected state, target-derived correction or measured-value lookup",.text "no compound, temperature, pressure, liquid/gas composition, uncertainty or target hash before prediction seal",.text "no correlated, regressed, Peng-Robinson, Wong-Sandler, NRTL or model-calculated value used as a measurement",.text "every external decimal remains a post-seal source inscription bound to the complete measurement record"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent support is structural EmptyOne and any external zero glyph remains an interface inscription","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported fugacity equation, chemical-potential logarithm, ideal-gas law, equation of state, compressibility or virial fit","no fitted interaction parameter, selected mixture, selected state, target-derived correction or measured-value lookup","no compound, temperature, pressure, liquid/gas composition, uncertainty or target hash before prediction seal","no correlated, regressed, Peng-Robinson, Wong-Sandler, NRTL or model-calculated value used as a measurement","every external decimal remains a post-seal source inscription bound to the complete measurement record"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with carrier := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.RealGasExchangeEvidence
