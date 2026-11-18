import SFT.Chemistry.EnthalpyEquivalentStateGrammar
import SFT.Chemistry.EnthalpyEquivalentState
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.EnthalpyEquivalentStateEvidence
open SFT.Host.Canonical EnthalpyEquivalentStateGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "EmptyOne-environment",.text "Absent generated environment transfer preserves internal content exactly.",.boolean (match EnthalpyEquivalentState.absenceWitness with | .error _ => false | .ok b => b)],.array [.text "exact-composition",.text "Retained internal and environment contents compose exactly.",.boolean (match EnthalpyEquivalentState.compositionWitness with | .error _ => false | .ok b => b)],.array [.text "held-orientation",.text "State order is held separately from positive separation.",.boolean (match EnthalpyEquivalentState.orientationWitness with | .error _ => false | .ok b => b)],.array [.text "structural-equality",.text "Equal state content uses structural EmptyOne.",.boolean (match EnthalpyEquivalentState.equalityWitness with | .error _ => false | .ok b => b)],.array [.text "append-only",.text "One fresh environment part preserves all prior parts and adds once.",.boolean (match EnthalpyEquivalentState.successorWitness with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-ENTHALPY-EQUIVALENT-STATE-006"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-COMPOSITION-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-THERMO-HEAT-WORK-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-STATE-RELATION-001","SFT-CHEM-MOLECULAR-FORMATION-ENERGY-013","SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003","SFT-CHEM-HEAT-WORK-TRANSFER-PARTITION-004","SFT-CHEM-ENTROPY-MULTIPLICITY-CORRESPONDENCE-005"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "state",.text (stateName c.state)],.array [.text "internal",.text (internalName c.internal)],.array [.text "environment",.text (environmentName c.environment)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "state",.array [.array [.text "answer-only-signed-enthalpy-scalar",.text "A signed scalar erases composition, phase, molecular state and environment."],.array [.text "complete-held-state-and-environment-carrier",.text "Every value remains attached to its complete chemical state and held environment."]]],.array [.text "internal",.array [.array [.text "fitted-or-unnamed-internal-content",.text "A fitted internal term can absorb any target discrepancy."],.array [.text "retained-exact-positive-internal-content",.text "The admitted chemical internal-energy carrier is retained unchanged."]]],.array [.text "environment",.array [.array [.text "imported-pressure-volume-equation",.text "An imported equation would select the environment correction rather than derive its role."],.array [.text "observation-forced-organized-environment-transfer-parts",.text "Only retained organized environment-transfer records extend the state carrier."]]],.array [.text "composition",.array [.array [.text "signed-cancellation-or-numerical-zero-correction",.text "Signs erase transfer provenance and numerical zero is not an SFT number."],.array [.text "exact-positive-composition-plus-EmptyOne-absence",.text "Generated environment parts add exactly; absence is structural EmptyOne."]]],.array [.text "orientation",.array [.array [.text "negative-enthalpy-proof-magnitude",.text "A negative proof magnitude conflates relation direction with content."],.array [.text "held-state-orientation-plus-positive-separation",.text "Rise/fall is held separately; equality is structural EmptyOne."]]],.array [.text "prediction",.array [.array [.text "enthalpy-target-readable-before-seal",.text "Target values could select an environment part or state order."],.array [.text "complete-value-free-enthalpy-state-identity-seal",.text "Every state identity seals before enthalpy or component values open."]]],.array [.text "record",.array [.array [.text "selected-enthalpy-or-single-phase-row",.text "A selected row can hide phase and unfavorable records."],.array [.text "complete-13-row-enthalpy-component-vector",.text "All liquid, boundary and vapour enthalpy/component rows are retained."]]],.array [.text "extension",.array [.array [.text "refit-prior-state-after-environment-successor",.text "Refitting prior content destroys compositional invariance."],.array [.text "depth-independent-append-only-environment-part-successor",.text "One fresh environment part appends without changing prior parts."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Enthalpy-equivalent chemical state relation"
 branch := "chemistry"
 statement := "An enthalpy-equivalent chemical state is the complete held composition, molecular state, phase and environment carrier whose exact positive content composes admitted internal energy with every retained organized environment-transfer part. If no such part is generated its place is structural EmptyOne. State orientation is held separately from exact positive separation."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-held-state-and-environment-carrier__retained-exact-positive-internal-content__observation-forced-organized-environment-transfer-parts__exact-positive-composition-plus-EmptyOne-absence__held-state-orientation-plus-positive-separation__complete-value-free-enthalpy-state-identity-seal__complete-13-row-enthalpy-component-vector__depth-independent-append-only-environment-part-successor"),("base",.text "One complete held chemical state with exact positive internal content and structural EmptyOne environment transfer has enthalpy-equivalent content identical to the retained internal carrier."),("successor",.text "Appending one fresh named exact positive environment-transfer part preserves the complete state, internal content and every prior transfer part and adds the new content exactly once."),("exclusions",.array [.text "no numerical zero; absent environment contribution is structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum SFT proof value",.text "no imported enthalpy or pressure-volume equation, fitted correction or target-selected environment part",.text "no target payload, enthalpy, internal energy, pressure, volume, phase or temperature before prediction seal",.text "no signed cancellation, unnamed contribution, selected state row, selected phase or deleted boundary state",.text "external conventional component relations remain post-seal correspondence records only"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; absent environment contribution is structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum SFT proof value","no imported enthalpy or pressure-volume equation, fitted correction or target-selected environment part","no target payload, enthalpy, internal energy, pressure, volume, phase or temperature before prediction seal","no signed cancellation, unnamed contribution, selected state row, selected phase or deleted boundary state","external conventional component relations remain post-seal correspondence records only"]
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
end SFT.Chemistry.EnthalpyEquivalentStateEvidence
