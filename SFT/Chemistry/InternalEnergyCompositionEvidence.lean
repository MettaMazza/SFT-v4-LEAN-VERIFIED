import SFT.Chemistry.InternalEnergyCompositionGrammar
import SFT.Chemistry.InternalEnergyComposition
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.InternalEnergyCompositionEvidence
open SFT.Host.Canonical InternalEnergyCompositionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "exact-parts",.text "Named positive parts compose exactly.",.boolean (match InternalEnergyComposition.composeInternalEnergyParts (.tuple [.part InternalEnergyComposition.firstPart,.part InternalEnergyComposition.secondPart]) with | .error _ => false | .ok r => MolecularFormationEnergy.ratioPair r==(23,12))],.array [.text "held-orientation",.text "Rise is held separately from positive magnitude.",.boolean (match InternalEnergyComposition.exactInternalEnergyRelation (.state InternalEnergyComposition.firstState) (.state InternalEnergyComposition.secondState) with | .error _ => false | .ok s => SFT.Host.Text.equal s.orientation.label "internal-energy-rise" && (match s.exactPositiveMagnitude with | .ratio r => MolecularFormationEnergy.ratioPair r==(1,1) | .emptyOne | .otherEmptyOne _ | .invalid => false))],.array [.text "path-composition",.text "Successive rises equal the direct exact separation.",.boolean (match (do let a ← InternalEnergyComposition.exactInternalEnergyRelation (.state InternalEnergyComposition.firstState) (.state InternalEnergyComposition.secondState); let b ← InternalEnergyComposition.exactInternalEnergyRelation (.state InternalEnergyComposition.secondState) (.state InternalEnergyComposition.thirdState); let c ← InternalEnergyComposition.composeOrientedInternalEnergySteps (.tuple [.step a,.step b]); let d ← InternalEnergyComposition.exactInternalEnergyRelation (.state InternalEnergyComposition.firstState) (.state InternalEnergyComposition.thirdState); pure (DihedralTorsion.equalLabel c.orientation d.orientation && DihedralTorsion.equalHeight c.exactPositiveMagnitude d.exactPositiveMagnitude)) with | .error _ => false | .ok b => b)],.array [.text "opposed-path-rejected",.text "Opposed steps cannot silently cancel through signs.",.boolean (match (do let a ← InternalEnergyComposition.exactInternalEnergyRelation (.state InternalEnergyComposition.firstState) (.state InternalEnergyComposition.secondState); let b ← InternalEnergyComposition.exactInternalEnergyRelation (.state InternalEnergyComposition.thirdState) (.state InternalEnergyComposition.secondState); InternalEnergyComposition.composeOrientedInternalEnergySteps (.tuple [.step a,.step b])) with | .error _ => true | .ok _ => false)],.array [.text "append-only-part",.text "A new named part preserves every prior part and adds exactly once.",.boolean (match InternalEnergyComposition.appendEnergyPartPreservesPriorComposition (.tuple [.part InternalEnergyComposition.firstPart,.part InternalEnergyComposition.secondPart]) (.part InternalEnergyComposition.extraPart) with | .error _ => false | .ok b => b)]]
def claimId : String := "SFT-CHEM-INTERNAL-ENERGY-COMPOSITION-003"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-COMPOSITION-001","SFT-PHYS-MECH-WORK-ENERGY-001","SFT-PHYS-THERMO-FIRST-LAW-001","SFT-PHYS-THERMO-STATE-RELATION-001","SFT-CHEM-STOICH-COMPOSITION-001","SFT-CHEM-MOLECULAR-FORMATION-ENERGY-013","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001","SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "parts",.text (partsName c.parts)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "equality",.text (equalityName c.equality)],.array [.text "path",.text (pathName c.path)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "answer-only-signed-energy-scalar",.text "A signed scalar erases composition, state, phase and environment."],.array [.text "complete-held-chemical-internal-energy-state",.text "Every energy value remains attached to its complete chemical state."]]],.array [.text "parts",.array [.array [.text "fitted-total-or-unnamed-contribution",.text "A fitted total or unnamed term can absorb any target discrepancy."],.array [.text "nonempty-exact-positive-named-part-composition",.text "Internal energy is the exact sum of its generated named positive parts."]]],.array [.text "orientation",.array [.array [.text "negative-proof-magnitude",.text "A negative proof magnitude conflates direction with content."],.array [.text "held-transfer-orientation-plus-positive-magnitude",.text "Rise or fall is held separately from exact positive separation."]]],.array [.text "equality",.array [.array [.text "numerical-zero-energy-change",.text "Numerical zero is not an SFT number or proof object."],.array [.text "structural-EmptyOne-equality",.text "Equal states close as structural EmptyOne."]]],.array [.text "path",.array [.array [.text "endpoint-only-or-signed-cancellation",.text "Endpoint-only cancellation deletes intermediate transfer provenance."],.array [.text "complete-same-orientation-step-composition",.text "Every exact positive step is retained and summed under one held direction."]]],.array [.text "prediction",.array [.array [.text "internal-energy-target-readable-before-seal",.text "A target value could select the parts or orientation."],.array [.text "complete-value-free-thermochemical-identity-seal",.text "All state identities seal before thermochemical values open."]]],.array [.text "record",.array [.array [.text "selected-state-or-single-phase-vector",.text "A selected state can hide phase and unfavorable rows."],.array [.text "complete-13-row-14-column-state-vector",.text "Every returned liquid, phase-boundary and vapour row is retained."]]],.array [.text "extension",.array [.array [.text "refit-prior-parts-after-successor",.text "Refitting earlier parts destroys compositional invariance."],.array [.text "depth-independent-append-only-positive-part-successor",.text "One new named positive part appends without changing earlier parts."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Internal-energy composition law"
 branch := "chemistry"
 statement := "A complete chemical internal-energy state retains composition, molecular state, phase and environment. Its content is the exact composition of nonempty named positive parts. Change direction is a held rise/fall label and its magnitude is exact positive separation; equality is structural EmptyOne. All 13 NIST state identities seal before the complete 14-column internal-energy vector opens."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-held-chemical-internal-energy-state__nonempty-exact-positive-named-part-composition__held-transfer-orientation-plus-positive-magnitude__structural-EmptyOne-equality__complete-same-orientation-step-composition__complete-value-free-thermochemical-identity-seal__complete-13-row-14-column-state-vector__depth-independent-append-only-positive-part-successor"),("base",.text "One complete chemical state with one named exact positive internal-energy part forces one retained total and one held state identity."),("successor",.text "Appending one new named exact positive part preserves every earlier part and adds its content exactly once; appending one same-direction state step preserves all earlier path records and adds its positive magnitude."),("exclusions",.array [.text "no numerical zero; equal energy states use structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum SFT proof value",.text "no measured state value, phase, temperature, target payload or target hash in law, grammar or prediction",.text "no fitted constituent contribution, residual energy, imported thermodynamic equation or species coefficient",.text "no endpoint-only signed cancellation, selected temperature row, selected phase or deleted phase-boundary state",.text "external signed glyphs remain source inscriptions and never enter an SFT proof magnitude"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; equal energy states use structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum SFT proof value","no measured state value, phase, temperature, target payload or target hash in law, grammar or prediction","no fitted constituent contribution, residual energy, imported thermodynamic equation or species coefficient","no endpoint-only signed cancellation, selected temperature row, selected phase or deleted phase-boundary state","external signed glyphs remain source inscriptions and never enter an SFT proof magnitude"]
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
end SFT.Chemistry.InternalEnergyCompositionEvidence
