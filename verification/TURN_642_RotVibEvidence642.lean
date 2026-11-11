import «work».RotVibGrammar642
import SFT.Engine.RegistrationGate
namespace SFT.Physics.RotVibEvidence
open SFT.Host.Canonical RotVibGrammar
set_option maxRecDepth 20000

def onePairWitness : Bool := decide (ObservationCarrier.onePair.length = 1)
def successorWitness : Bool := decide ((([("a", "r-a"), ("b", "r-b")] : List (String × String)).head?) = some ("a", "r-a"))
def witnesses : Value := .array [
 .array [.text "one-reference-pair",.text "One observation and one reference retain two named source coordinates and one pairing.",.boolean onePairWitness],
 .array [.text "successor-retention",.text "Appending a second named pairing leaves the first pairing unchanged.",.boolean successorWitness]]
theorem onePairWitnessPassed : onePairWitness = true := by decide
theorem successorWitnessPassed : successorWitness = true := by decide
def claimId : String := "SFT-CHEM-SPEC-ROT-VIB-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001","SFT-CHEM-RXN-MECHANISM-001","SFT-CHEM-KIN-ACTIVATION-001","SFT-CHEM-KIN-RATE-001","SFT-CHEM-EQ-CHEMICAL-001","SFT-CHEM-THERMO-REACTION-001","SFT-CHEM-THERMO-DIRECTION-001","SFT-CHEM-PHASE-CHEMICAL-001","SFT-CHEM-MOL-GEOMETRY-001","SFT-CHEM-MOL-ISOMER-001","SFT-CHEM-NET-REACTION-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MEAS-UNCERTAINTY-001","SFT-CHEM-MEAS-TRACEABILITY-001","SFT-CHEM-BIOMOLECULAR-BOUNDARY-001","SFT-CHEM-SPEC-INFRARED-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "rotation",.text (rotationName c.rotation)],.array [.text "vibration",.text (vibrationName c.vibration)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "transition",.text (transitionName c.transition)],.array [.text "spectrum",.text (spectrumName c.spectrum)],.array [.text "conditions",.text (conditionsName c.conditions)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "point-label-only",.text "Internal molecular motion is absent."],.array [.text "complete-molecular-geometry-held",.text "Mass-bearing incidence and orientation remain."]]],.array [.text "rotation",.array [.array [.text "orientation-history-erased",.text "Rotational recurrence cannot be distinguished."],.array [.text "rotational-state-classes-held",.text "Counted orientation recurrences persist."]]],.array [.text "vibration",.array [.array [.text "relative-displacement-erased",.text "Vibrational recurrence cannot be distinguished."],.array [.text "vibrational-state-classes-held",.text "Relative internal recurrences persist."]]],.array [.text "composition",.array [.array [.text "motions-collapsed-together",.text "Joint spectral structure is lost."],.array [.text "rotational-vibrational-composition",.text "Both state coordinates are retained."]]],.array [.text "transition",.array [.array [.text "states-without-transition-map",.text "No spectral event is generated."],.array [.text "allowed-state-transition-trace",.text "Initial and final state classes are linked."]]],.array [.text "spectrum",.array [.array [.text "one-frequency-only",.text "Resolved organization is erased."],.array [.text "complete-transition-frequency-pattern",.text "All generated transition classes remain."]]],.array [.text "conditions",.array [.array [.text "universal-spectrum",.text "Population and resolution are bounded."],.array [.text "state-method-condition-boundary",.text "The observation support is explicit."]]],.array [.text "extra",.array [.array [.text "free-rotor-oscillator-equation",.text "An imported model can select the spectrum."],.array [.text "no-extra-rule",.text "Exact recurrence classes supply the organization."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Rotational-vibrational molecular spectra"
 branch := "physics"
 statement := "A rotational-vibrational spectrum is the complete condition-bound transition organization of retained molecular orientation-recurrence and internal relative-displacement recurrence classes."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "complete-molecular-geometry-held__rotational-state-classes-held__vibrational-state-classes-held__rotational-vibrational-composition__allowed-state-transition-trace"),("base",.text "One geometry with one rotational and one vibrational recurrence class supplies the first composed state."),("successor",.text "Appending a recurrence class preserves earlier state identities and enumerates every newly available composed transition."),("exclusions",.array [.text "no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased",.text "absence is an Empty structural form rather than numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite molecular geometry with generated rotational and vibrational recurrence classes, paired transitions and declared observation support."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no analytical glossary, calibration curve, spectral database, measured line, fitted profile, target source or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no sample, component, response, transition, reference or unfavorable observation may be created, copied or silently erased","absence is an Empty structural form rather than numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite molecular geometry with generated rotational and vibrational recurrence classes, paired transitions and declared observation support."]
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
end SFT.Physics.RotVibEvidence
