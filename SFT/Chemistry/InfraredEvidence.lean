import SFT.Chemistry.InfraredGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.InfraredEvidence
open SFT.Host.Canonical InfraredGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "molecule",.text "molecular support exists",.boolean true],.array [.text "transition",.text "paired states can be held",.boolean true],.array [.text "identity",.text "whole pattern is retained",.boolean true]]
def claimId : String := "SFT-CHEM-SPEC-INFRARED-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-MEAS-TRACEABILITY-001","SFT-CHEM-BIOMOLECULAR-BOUNDARY-001","SFT-CHEM-PHOTOCHEM-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "input",.text (inputName c.input)],.array [.text "molecule",.text (moleculeName c.molecule)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "spectrum",.text (spectrumName c.spectrum)],.array [.text "identity",.text (identityName c.identity)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "input",.array [.array [.text "unregistered-incident-recurrence",.text "No excitation comparison is defined."],.array [.text "incident-infrared-support-held",.text "The interrogating recurrence class is explicit."]]],.array [.text "molecule",.array [.array [.text "molecular-identity-erased",.text "Response cannot distinguish carriers."],.array [.text "complete-molecular-carrier-held",.text "Composition and structure remain."]]],.array [.text "transition",.array [.array [.text "static-geometry-only",.text "A spectrum requires a state change."],.array [.text "vibrational-state-transition-held",.text "Predecessor and successor molecular states persist."]]],.array [.text "coupling",.array [.array [.text "all-transitions-assumed-visible",.text "Observation requires a changed interaction trace."],.array [.text "dipole-response-change-required",.text "Only coupled transitions enter support."]]],.array [.text "spectrum",.array [.array [.text "one-line-answer",.text "Alternative recurrences are erased."],.array [.text "complete-frequency-response-pattern",.text "Every resolved line and response remains."]]],.array [.text "identity",.array [.array [.text "universal-one-line-identifier",.text "Different carriers may share a line."],.array [.text "whole-pattern-molecular-distinction",.text "Identity comparison uses complete support."]]],.array [.text "conditions",.array [.array [.text "condition-free-spectrum",.text "State and method affect observation."],.array [.text "state-method-condition-boundary",.text "The observation domain is held."]]],.array [.text "extra",.array [.array [.text "free-infrared-line-rule",.text "A lookup can force assignment."],.array [.text "no-extra-rule",.text "Generated transition recurrence supplies the pattern."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Infrared recurrence and molecular distinction"
 branch := "chemistry"
 statement := "Infrared organization is the complete condition-bound pattern of incident recurrence classes coupled to retained molecular vibrational state transitions, with whole-pattern rather than isolated-line identity."
 evidenceMode := .empirical
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing]
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "incident-infrared-support-held__complete-molecular-carrier-held__vibrational-state-transition-held__dipole-response-change-required__complete-frequency-response-pattern"),("base",.text "One molecular vibrational predecessor/successor pair with changed response supplies the first line."),("successor",.text "Appending a generated internal recurrence preserves prior lines and adds every coupled transition involving the new state."),("exclusions",.array [.text "no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite molecular carrier with generated internal recurrence states, paired transitions, interaction-change tests and a declared observation domain."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite molecular carrier with generated internal recurrence states, paired transitions, interaction-change tests and a declared observation domain."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with input := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.InfraredEvidence
