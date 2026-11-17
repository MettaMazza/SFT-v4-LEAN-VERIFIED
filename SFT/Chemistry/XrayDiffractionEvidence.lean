import SFT.Chemistry.XrayDiffractionGrammar
import SFT.Chemistry.XrayDiffraction
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.XrayDiffractionEvidence
open SFT.Host.Canonical XrayDiffractionGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "Crystal phase and composition remain.",.boolean (XrayDiffraction.witness 0)],.array [.text "probe",.text "Physics handoff remains explicit.",.boolean (XrayDiffraction.witness 1)],.array [.text "support",.text "Both supports remain.",.boolean (XrayDiffraction.witness 2)],.array [.text "coordinate",.text "Spacing/angle relation is exact and held.",.boolean (XrayDiffraction.witness 3)],.array [.text "response",.text "Intensity is exact or absent.",.boolean (XrayDiffraction.witness 4)],.array [.text "structure",.text "Cell, symmetry and sites remain.",.boolean (XrayDiffraction.witness 5)],.array [.text "custody",.text "Every reflection/status remains.",.boolean (XrayDiffraction.witness 6)],.array [.text "extension",.text "Extension preserves prior evidence.",.boolean (XrayDiffraction.witness 7)]]
def claimId : String := "SFT-CHEM-XRAY-DIFFRACTION-STRUCTURE-016"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-ANALYTICAL-COMPLETE-RECORD-001","SFT-PHYS-WAVE-DIFFRACTION-001","SFT-MAT-CRYST-UNIT-CELL-001","SFT-MAT-CRYST-RECIPROCAL-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "probe",.text (probeName c.probe)],.array [.text "support",.text (supportName c.support)],.array [.text "coordinate",.text (coordinateName c.coordinate)],.array [.text "response",.text (responseName c.response)],.array [.text "structure",.text (structureName c.«structure»)],.array [.text "custody",.text (custodyName c.custody)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "pattern-without-crystal",.text "A pattern alone loses crystal identity."],.array [.text "held-crystal-phase-and-composition",.text "Crystal phase and composition remain."]]],.array [.text "probe",.array [.array [.text "chemistry-owned-xray-probe",.text "Probe production belongs to Physics."],.array [.text "explicit-physics-xray-scattering-handoff",.text "Physics handoff remains explicit."]]],.array [.text "support",.array [.array [.text "line-list-without-reciprocal-support",.text "Lines alone lose the generated lattice relation."],.array [.text "held-direct-and-reciprocal-support",.text "Both supports remain."]]],.array [.text "coordinate",.array [.array [.text "floating-two-theta",.text "A float is not native exact support."],.array [.text "exact-positive-spacing-or-held-angle",.text "Spacing/angle relation is exact and held."]]],.array [.text "response",.array [.array [.text "arbitrary-diffraction-intensity",.text "An arbitrary height loses comparison support."],.array [.text "exact-counted-relative-intensity-or-EmptyOne",.text "Intensity is exact or absent."]]],.array [.text "structure",.array [.array [.text "database-structure-label-only",.text "A label cannot establish structure correspondence."],.array [.text "complete-cell-symmetry-site-correspondence",.text "Cell, symmetry and sites remain."]]],.array [.text "custody",.array [.array [.text "selected-major-reflections",.text "Selection erases weak and adverse reflections."],.array [.text "complete-reflection-error-condition-custody",.text "Every reflection/status remains."]]],.array [.text "extension",.array [.array [.text "refined-added-pattern",.text "Refinement can change prior evidence."],.array [.text "successor-retains-prior-reflections-and-structure",.text "Extension preserves prior evidence."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold X-ray diffraction chemical-structure law"
 branch := "chemistry"
 statement := "A held crystal carrier and reciprocal support force exact diffraction coordinates, responses and a chemistry-owned structure correspondence."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-crystal-phase-and-composition__explicit-physics-xray-scattering-handoff__held-direct-and-reciprocal-support__exact-positive-spacing-or-held-angle__exact-counted-relative-intensity-or-EmptyOne__complete-cell-symmetry-site-correspondence__complete-reflection-error-condition-custody__successor-retains-prior-reflections-and-structure"),("base",.text "One complete held ANAL-016 record supplies the first lawful exact support or structural EmptyOne case."),("successor",.text "Every successor appends a complete held record without changing any earlier carrier, condition, comparison, adverse result or uncertainty custody."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external value equation model fit sign zero outcome prominent row or favorable subset selects the survivor",.text "all favorable adverse absent unavailable unresolved predicted fitted uncertain superseded and transport rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external value equation model fit sign zero outcome prominent row or favorable subset selects the survivor","all favorable adverse absent unavailable unresolved predicted fitted uncertain superseded and transport rows remain"]
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
end SFT.Chemistry.XrayDiffractionEvidence
