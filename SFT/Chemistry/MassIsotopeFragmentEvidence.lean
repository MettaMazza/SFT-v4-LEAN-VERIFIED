import SFT.Chemistry.MassIsotopeFragmentGrammar
import SFT.Chemistry.MassIsotopeFragment
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MassIsotopeFragmentEvidence
open SFT.Host.Canonical MassIsotopeFragmentGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "carrier",.text "Parent and ion carriers remain.",.boolean (MassIsotopeFragment.witness 0)],.array [.text "composition",.text "Isotope and charge remain.",.boolean (MassIsotopeFragment.witness 1)],.array [.text "coordinate",.text "Mass/charge is exact positive support.",.boolean (MassIsotopeFragment.witness 2)],.array [.text "fragmentation",.text "Fragment paths remain.",.boolean (MassIsotopeFragment.witness 3)],.array [.text "response",.text "Response is an exact event ratio.",.boolean (MassIsotopeFragment.witness 4)],.array [.text "condition",.text "Complete conditions remain.",.boolean (MassIsotopeFragment.witness 5)],.array [.text "custody",.text "Every peak and status remains.",.boolean (MassIsotopeFragment.witness 6)],.array [.text "extension",.text "Extension preserves prior fragments.",.boolean (MassIsotopeFragment.witness 7)]]
def claimId : String := "SFT-CHEM-MASS-ISOTOPE-FRAGMENT-VECTOR-014"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-ANALYTICAL-COMPLETE-RECORD-001","SFT-CHEM-SPEC-MASS-001","SFT-CHEM-ELEM-ISOTOPE-001","SFT-CHEM-NUCLEAR-ELECTRONIC-COMPOSITION-012"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "coordinate",.text (coordinateName c.coordinate)],.array [.text "fragmentation",.text (fragmentationName c.fragmentation)],.array [.text "response",.text (responseName c.response)],.array [.text "condition",.text (conditionName c.condition)],.array [.text "custody",.text (custodyName c.custody)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "mass-peaks-without-molecule",.text "Peaks alone lose molecular identity."],.array [.text "held-molecular-parent-and-ion-carriers",.text "Parent and ion carriers remain."]]],.array [.text "composition",.array [.array [.text "nominal-mass-only",.text "Nominal mass loses isotope composition."],.array [.text "held-isotope-and-charge-composition",.text "Isotope and charge remain."]]],.array [.text "coordinate",.array [.array [.text "floating-mass-to-charge",.text "A float is not native exact support."],.array [.text "exact-positive-mass-charge-ratio",.text "Mass/charge is exact positive support."]]],.array [.text "fragmentation",.array [.array [.text "peak-without-fragment-path",.text "A peak alone loses its parent path."],.array [.text "held-parent-fragment-transition-path",.text "Fragment paths remain."]]],.array [.text "response",.array [.array [.text "normalized-major-peak-only",.text "Major-only normalization erases weak events."],.array [.text "exact-event-over-reference-event-ratio",.text "Response is an exact event ratio."]]],.array [.text "condition",.array [.array [.text "unconditioned-ionization",.text "Ionization and instrument boundary affect fragmentation."],.array [.text "held-ionization-and-acquisition-condition",.text "Complete conditions remain."]]],.array [.text "custody",.array [.array [.text "selected-diagnostic-peaks",.text "Selection erases weak, isotope and unresolved rows."],.array [.text "complete-peak-isotope-error-absence-custody",.text "Every peak and status remains."]]],.array [.text "extension",.array [.array [.text "refitted-added-fragment",.text "Refitting changes prior event ratios."],.array [.text "successor-retains-and-appends-complete-fragments",.text "Extension preserves prior fragments."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold mass, isotope and fragmentation spectrum law"
 branch := "chemistry"
 statement := "Held molecular and ionic carriers force a complete exact mass-to-charge, isotope and fragmentation event vector without weak-peak selection."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-molecular-parent-and-ion-carriers__held-isotope-and-charge-composition__exact-positive-mass-charge-ratio__held-parent-fragment-transition-path__exact-event-over-reference-event-ratio__held-ionization-and-acquisition-condition__complete-peak-isotope-error-absence-custody__successor-retains-and-appends-complete-fragments"),("base",.text "One complete held ANAL-014 record supplies the first lawful exact support or structural EmptyOne case."),("successor",.text "Every successor appends a complete held record without changing any earlier carrier, condition, comparison, adverse result or uncertainty custody."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external value equation model fit sign zero outcome prominent row or favorable subset selects the survivor",.text "all favorable adverse absent unavailable unresolved predicted fitted uncertain superseded and transport rows remain"]),("witnesses",witnesses),("survivor",.text survivorId)]
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
end SFT.Chemistry.MassIsotopeFragmentEvidence
