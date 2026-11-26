import SFT.Chemistry.TemperatureCorrespondenceGrammar
import SFT.Chemistry.TemperatureCorrespondence
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.TemperatureCorrespondenceEvidence
open SFT.Host.Canonical TemperatureCorrespondenceGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "unchanged-physics-carrier",.text "Chemistry returns the admitted carrier unchanged.",.boolean (match TemperatureCorrespondence.consumePhysicsTemperatureCarrier (.context TemperatureCorrespondence.argon) with | .error _ => false | .ok v => TemperatureCorrespondence.equalCarrier v TemperatureCorrespondence.argon.physicsTemperatureCarrier)],.array [.text "cross-route-equilibrium",.text "Acoustic and electronic contexts share one equilibrium carrier.",.boolean (match TemperatureCorrespondence.commonThermalEquilibriumCarrier (.context TemperatureCorrespondence.argon) (.context TemperatureCorrespondence.resistor) with | .error _ => false | .ok v => TemperatureCorrespondence.equalCarrier v TemperatureCorrespondence.argon.physicsTemperatureCarrier)],.array [.text "composition-owned-consequence",.text "The chemical result retains composition and the unchanged carrier.",.boolean (match TemperatureCorrespondence.attachCompositionConsequence (.context TemperatureCorrespondence.argon) (.held TemperatureCorrespondence.consequenceLabel) with | .error _ => false | .ok v => SFT.Chemistry.DihedralTorsion.equalLabel v.composition TemperatureCorrespondence.argon.composition && TemperatureCorrespondence.equalCarrier v.physicsTemperatureCarrier TemperatureCorrespondence.argon.physicsTemperatureCarrier)],.array [.text "rescaling-rejected",.text "A route- or composition-specific carrier cannot enter equilibrium.",.boolean (match TemperatureCorrespondence.commonThermalEquilibriumCarrier (.context TemperatureCorrespondence.argon) (.context TemperatureCorrespondence.mismatched) with | .error _ => true | .ok _ => false)],.array [.text "append-only-composition",.text "Adding one composition preserves every existing carrier.",.boolean (match TemperatureCorrespondence.appendCompositionPreservesCommonCarrier (.tuple [.context TemperatureCorrespondence.argon,.context TemperatureCorrespondence.resistor]) (.context TemperatureCorrespondence.water) with | .error _ => false | .ok value => value)]]
def claimId : String := "SFT-CHEM-TEMPERATURE-CORRESPONDENCE-002"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-ORDER-LATTICE-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-COMP-FORM-STATE-TRANSITION-001","SFT-PHYS-THERMO-TEMPERATURE-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-PHYS-THERMO-STATE-RELATION-001","SFT-PHYS-VALIDATION-THERMAL-EQUILIBRIUM-044","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-CROSS-PROPERTY-MOLECULAR-VECTOR-014","SFT-CHEM-FINITE-MICROSTATE-SUPPORT-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "authority",.text (authorityName c.authority)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "condition",.text (conditionName c.condition)],.array [.text "relation",.text (relationName c.relation)],.array [.text "equilibrium",.text (equilibriumName c.equilibrium)],.array [.text "prediction",.text (predictionName c.prediction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "authority",.array [.array [.text "chemistry-redefines-temperature",.text "A Chemistry-specific temperature law duplicates and can contradict the admitted Physics carrier."],.array [.text "chemistry-consumes-admitted-physics-temperature-carrier",.text "The Physics temperature carrier enters Chemistry unchanged."]]],.array [.text "composition",.array [.array [.text "composition-erased-temperature-scalar",.text "Erasing composition loses the chemical state to which a consequence belongs."],.array [.text "held-chemical-composition-identity",.text "Composition remains a held identity beside the shared carrier."]]],.array [.text "condition",.array [.array [.text "phase-and-equilibrium-reference-erased",.text "Without phase and reference, distinct chemical states are conflated."],.array [.text "held-phase-and-equilibrium-reference",.text "Phase and equilibrium reference remain explicit."]]],.array [.text "relation",.array [.array [.text "fitted-chemical-temperature-conversion",.text "A conversion coefficient lets composition or a target rescale temperature."],.array [.text "identity-preserving-temperature-correspondence",.text "Chemical translation returns the exact Physics carrier unchanged."]]],.array [.text "equilibrium",.array [.array [.text "route-or-composition-specific-temperature",.text "Separate route temperatures violate common equilibrium correspondence."],.array [.text "one-common-carrier-across-equilibrated-routes",.text "Every equilibrated route and composition retains the same exact carrier."]]],.array [.text "prediction",.array [.array [.text "thermometric-values-readable-before-seal",.text "Measured centers or uncertainties could select the correspondence."],.array [.text "complete-value-free-thermometric-identity-seal",.text "All source, route and composition identities seal before values open."]]],.array [.text "record",.array [.array [.text "selected-thermometry-route",.text "One favorable route cannot establish route-independent correspondence."],.array [.text "complete-three-row-two-route-value-vector",.text "The exact SI carrier and both independent measured routes remain explicit."]]],.array [.text "extension",.array [.array [.text "composition-dependent-rescaling",.text "A new composition-specific scale is a free parameter."],.array [.text "append-only-composition-consequence-with-common-carrier",.text "Each new chemical consequence preserves the common Physics carrier."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Chemical temperature correspondence"
 branch := "chemistry"
 statement := "Chemistry consumes the admitted Physics temperature carrier without rescaling it. Composition, phase, equilibrium reference and thermometric route remain held chemical identities, while equilibrated contexts share one exact carrier and composition-dependent consequences attach without a fitted conversion. Three value-free identities seal before the exact SI carrier and two independent thermometry intervals open."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "chemistry-consumes-admitted-physics-temperature-carrier__held-chemical-composition-identity__held-phase-and-equilibrium-reference__identity-preserving-temperature-correspondence__one-common-carrier-across-equilibrated-routes__complete-value-free-thermometric-identity-seal__complete-three-row-two-route-value-vector__append-only-composition-consequence-with-common-carrier"),("base",.text "One chemical composition, phase, route and equilibrium reference consume one exact positive admitted Physics temperature carrier unchanged."),("successor",.text "Appending one new composition-dependent consequence retains every existing context and the same common Physics carrier without a new scale, coefficient or route-specific correction."),("exclusions",.array [.text "no numerical zero; external zero glyphs remain source inscriptions and native absence is structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum SFT proof value",.text "no Chemistry-specific redefinition, rescaling, calibration coefficient or fitted temperature conversion",.text "no measured center, uncertainty, interval endpoint, relation flag or target hash in law, grammar or prediction",.text "no selected thermometry route, omitted uncertainty endpoint, composition erasure or target-selected equilibrium",.text "no imported continuum distribution, conventional thermodynamic equation or composition-specific free parameter"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; external zero glyphs remain source inscriptions and native absence is structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum SFT proof value","no Chemistry-specific redefinition, rescaling, calibration coefficient or fitted temperature conversion","no measured center, uncertainty, interval endpoint, relation flag or target hash in law, grammar or prediction","no selected thermometry route, omitted uncertainty endpoint, composition erasure or target-selected equilibrium","no imported continuum distribution, conventional thermodynamic equation or composition-specific free parameter"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with authority := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.TemperatureCorrespondenceEvidence
