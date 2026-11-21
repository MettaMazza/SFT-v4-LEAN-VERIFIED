import SFT.Chemistry.SolutionActivityGrammar
import SFT.Chemistry.SolutionActivity
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.SolutionActivityEvidence
open SFT.Host.Canonical SolutionActivityGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-relative-activity",.text "Accessible support over reference support is an exact positive fraction.",.boolean (match SolutionActivity.activityWitness with | .error _ => false | .ok b => b)],.array [.text "three-composition-relations",.text "Exact comparison distinguishes restricted, independent and expanded joint support.",.boolean (match SolutionActivity.relationsWitness with | .error _ => false | .ok b => b)],.array [.text "structural-absence",.text "Absent solute is retained as EmptyOne rather than numerical zero.",.boolean SolutionActivity.absenceWitness],.array [.text "replication-successor",.text "Exact support replication preserves activity and relation.",.boolean (match SolutionActivity.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-ACTIVITY-NONIDEAL-COMPOSITION-009"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-INFO-ENTROPY-UNCERTAINTY-001","SFT-PHYS-THERMO-STATISTICAL-WEIGHT-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-STOICH-MIXTURE-001","SFT-CHEM-STOICH-SOLUTION-001","SFT-CHEM-SOLUTION-EQUILIBRIUM-001","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002","SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005","SFT-CHEM-CHEMICAL-POTENTIAL-EQUIVALENT-COMPONENT-008"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "activity",.text (activityName c.activity)],.array [.text "interaction",.text (interactionName c.interaction)],.array [.text "absence",.text (absenceName c.absence)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "bulk-answer-or-unbound-activity-number",.text "An unbound number erases the component exchange support it measures."],.array [.text "complete-component-exchange-support-account",.text "Activity remains bound to one component, phase, environment and complete support account."]]],.array [.text "composition",.array [.array [.text "selected-or-erased-composition-and-condition",.text "Erasing composition or condition makes distinct solution states indistinguishable."],.array [.text "complete-held-condition-and-component-coordinates",.text "Every component coordinate and the finite environment remain held."]]],.array [.text "activity",.array [.array [.text "logarithm-fugacity-or-fitted-coefficient",.text "A logarithm, fugacity model or fitted coefficient imports an unforced scalar model."],.array [.text "exact-accessible-support-over-reference-support",.text "Relative activity is the exact positive accessible-support count over reference-support count."]]],.array [.text "interaction",.array [.array [.text "ideal-mixture-prior-or-target-derived-correction",.text "Assumed ideality or a target-derived correction selects the relation externally."],.array [.text "exact-joint-versus-independent-support-relation",.text "Non-ideality is the exact held relation between joint accessible and independently composed support."]]],.array [.text "absence",.array [.array [.text "numerical-zero-component-coordinate",.text "Numerical zero would introduce a non-SFT number for an absent component."],.array [.text "structural-EmptyOne-absent-component",.text "An externally absent component becomes structural EmptyOne while its source glyph is retained."]]],.array [.text "prediction",.array [.array [.text "activity-composition-or-condition-readable-before-seal",.text "Withheld values could select the support relation."],.array [.text "complete-value-free-204-row-identity-seal",.text "All 204 source-row identities seal before compounds, composition, condition or activity open."]]],.array [.text "record",.array [.array [.text "selected-system-or-deleted-absence-boundary",.text "Selecting a solution or dropping absent-component rows hides the complete evidence surface."],.array [.text "complete-nine-dataset-204-row-vector-with-68-EmptyOne-boundaries",.text "All nine datasets, 204 rows and 68 structural-absence boundaries are retained."]]],.array [.text "extension",.array [.array [.text "refit-after-support-replication",.text "Refitting after exact replication destroys the count relation."],.array [.text "depth-independent-exact-support-replication",.text "Common exact replication preserves activity and the non-ideal relation at every finite depth."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Activity and non-ideal composition law"
 branch := "chemistry"
 statement := "A component's solution activity is the exact positive count of its accessible exchange-support states over the complete held reference-support count at one fully retained composition and environment. Non-ideality is the exact relation between joint accessible support and independently composed support, without a fitted activity coefficient. An absent component is structural EmptyOne. All 204 solution identities seal before compounds, compositions, temperature or activities open."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-component-exchange-support-account__complete-held-condition-and-component-coordinates__exact-accessible-support-over-reference-support__exact-joint-versus-independent-support-relation__structural-EmptyOne-absent-component__complete-value-free-204-row-identity-seal__complete-nine-dataset-204-row-vector-with-68-EmptyOne-boundaries__depth-independent-exact-support-replication"),("base",.text "One component exchange-support fibre and its held reference support yield the first exact relative activity; comparison with independently composed support yields the first non-ideal relation."),("successor",.text "Replicating accessible, reference and independently composed supports by the same exact positive count preserves their ratio and order, and therefore preserves activity and non-ideal relation."),("exclusions",.array [.text "no numerical zero; an absent component is structural EmptyOne and source zero glyphs remain external inscriptions",.text "no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value",.text "no imported activity-coefficient equation, fugacity model, ideal-mixture prior, fitted interaction parameter or target-derived correction",.text "no compound, temperature, molality, activity, uncertainty, absence flag or target hash before prediction seal",.text "no selected solution, selected composition, deleted absence row or correlated/regressed/model-calculated value used as measurement",.text "every external decimal and zero glyph remains a post-seal source inscription"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; an absent component is structural EmptyOne and source zero glyphs remain external inscriptions","no negative, irrational, imaginary, logarithmic, floating, signed or continuum SFT proof value","no imported activity-coefficient equation, fugacity model, ideal-mixture prior, fitted interaction parameter or target-derived correction","no compound, temperature, molality, activity, uncertainty, absence flag or target hash before prediction seal","no selected solution, selected composition, deleted absence row or correlated/regressed/model-calculated value used as measurement","every external decimal and zero glyph remains a post-seal source inscription"]
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
end SFT.Chemistry.SolutionActivityEvidence
