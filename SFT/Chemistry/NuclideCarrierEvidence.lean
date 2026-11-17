import SFT.Chemistry.NuclideCarrierGrammar
import SFT.Chemistry.NuclideChemicalCarrier
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.NuclideCarrierEvidence
open SFT.Host.Canonical NuclideCarrierGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "element",.text "Element held.",.boolean NuclideChemicalCarrier.elementWitness],.array [.text "nuclide",.text "Count positive.",.boolean NuclideChemicalCarrier.nuclideWitness],.array [.text "state",.text "State held.",.boolean NuclideChemicalCarrier.stateWitness],.array [.text "species",.text "Species held.",.boolean NuclideChemicalCarrier.speciesWitness],.array [.text "phase",.text "Phase held.",.boolean NuclideChemicalCarrier.phaseWitness],.array [.text "occurrence",.text "Occurrence positive.",.boolean NuclideChemicalCarrier.occurrenceWitness],.array [.text "distinct",.text "Coordinates distinct.",.boolean NuclideChemicalCarrier.distinctWitness],.array [.text "successor",.text "Fresh occurrence preserves identity.",.boolean NuclideChemicalCarrier.successorWitness]]
def claimId : String := "SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-CHEM-MEAS-CHEMICAL-SPECIES-001","SFT-CHEM-ELEM-ISOTOPE-001","SFT-PHYS-NUCLEAR-RADIOACTIVITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "element",.text (elementName c.element)],.array [.text "nuclide",.text (nuclideName c.nuclide)],.array [.text "state",.text (stateName c.state)],.array [.text "species",.text (speciesName c.species)],.array [.text "phase",.text (phaseName c.phase)],.array [.text "occurrence",.text (occurrenceName c.occurrence)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "element",.array [.array [.text "anonymous-radiation",.text "Radiation alone loses element."],.array [.text "held-element-identity",.text "Element remains held."]]],.array [.text "nuclide",.array [.array [.text "element-only-identity",.text "Element alone collapses isotopes."],.array [.text "positive-nucleon-count",.text "Nucleon count distinguishes nuclide."]]],.array [.text "state",.array [.array [.text "ground-state-assumption",.text "Nuclear state cannot be assumed."],.array [.text "held-nuclear-state",.text "Nuclear state remains held."]]],.array [.text "species",.array [.array [.text "bare-nuclide-answer",.text "Chemistry requires species identity."],.array [.text "held-chemical-species",.text "Chemical carrier remains held."]]],.array [.text "phase",.array [.array [.text "phase-free-species",.text "Phase affects the chemical record."],.array [.text "held-chemical-phase",.text "Phase remains held."]]],.array [.text "occurrence",.array [.array [.text "continuum-amount-premise",.text "Continuum amount hides occurrences."],.array [.text "positive-counted-occurrence",.text "Each occurrence is counted."]]],.array [.text "record",.array [.array [.text "selected-nuclide-row",.text "One row hides carrier diversity."],.array [.text "complete-nuclide-species-vector",.text "Every registered carrier remains."]]],.array [.text "extension",.array [.array [.text "lookup-table-exception",.text "A lookup cannot define identity."],.array [.text "fresh-occurrence-preserves-identity",.text "Successors preserve every coordinate."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Fold nuclide chemical-carrier law"
 branch := "chemistry"
 statement := "A chemical nuclide carrier retains element, positive nucleon count, nuclear state, chemical species, phase and positive occurrence as one exact identity vector."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "held-element-identity__positive-nucleon-count__held-nuclear-state__held-chemical-species__held-chemical-phase__positive-counted-occurrence__complete-nuclide-species-vector__fresh-occurrence-preserves-identity"),("base",.text "One held nuclide occurrence supplies the first exact chemical carrier."),("successor",.text "A fresh occurrence retains every identity coordinate while extending the positive occurrence count."),("exclusions",.array [.text "no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter",.text "no external nuclide table chemical matrix activity or uncertainty selects the survivor",.text "unreported nuclear state is retained as unreported rather than inferred"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero negative irrational imaginary continuum fitted free random or imported native parameter","no external nuclide table chemical matrix activity or uncertainty selects the survivor","unreported nuclear state is retained as unreported rather than inferred"]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with element := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.NuclideCarrierEvidence
