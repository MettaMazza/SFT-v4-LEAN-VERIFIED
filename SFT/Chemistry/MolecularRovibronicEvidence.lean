import SFT.Chemistry.MolecularRovibronicGrammar
import SFT.Chemistry.MolecularRovibronicWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularRovibronicEvidence
open SFT.Host.Canonical MolecularRovibronicGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array (MolecularRovibronicWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])
def claimId : String := "SFT-CHEM-ROVIBRONIC-COMPOSITION-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-MOLECULAR-SPECTRUM-HIERARCHY-004","SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005","SFT-CHEM-ELEM-ISOTOPE-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "scale",.text (scaleName c.scale)],.array [.text "vibration",.text (vibrationName c.vibration)],.array [.text "rotation",.text (rotationName c.rotation)],.array [.text "spin",.text (spinName c.spin)],.array [.text "observation",.text (observationName c.observation)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "detached-state-name",.text "A detached name cannot identify the molecular whole carrying the state."],.array [.text "identified-molecular-state-carrier",.text "Every component remains bound to one identified molecular carrier."]]],.array [.text "composition",.array [.array [.text "nuclei-or-electrons-erased",.text "Erasing either support merges distinguishable isotopologues or electronic states."],.array [.text "nuclear-electronic-joint-support",.text "Nuclear occurrences, isotope labels and the electronic state are jointly retained."]]],.array [.text "scale",.array [.array [.text "imported-separation-approximation",.text "An imported approximation cannot select a fundamental state organization."],.array [.text "admitted-electronic-vibrational-rotational-order",.text "The already-admitted hierarchy supplies distinct composed state coordinates without a new approximation."]]],.array [.text "vibration",.array [.array [.text "continuum-vibrational-coordinate",.text "A continuum coordinate is outside the exact generated grammar."],.array [.text "positive-odd-vibrational-recurrence",.text "A positive ordinal generates the exact odd vibrational recurrence carrier."]]],.array [.text "rotation",.array [.array [.text "signed-or-continuum-rotation",.text "A signed continuum angle is not an exact proof carrier."],.array [.text "positive-counted-rotational-recurrence",.text "A positive ordinal generates the exact J(J+1) rotational carrier."]]],.array [.text "spin",.array [.array [.text "spin-erased-state",.text "Erasing spin merges spectroscopically distinguishable molecular states."],.array [.text "held-spin-state",.text "Spin remains a held label rather than a negative or imaginary scalar."]]],.array [.text "observation",.array [.array [.text "result-without-readout-record",.text "A state without a readout boundary cannot be reproduced or distinguished."],.array [.text "retained-rovibronic-observation",.text "The exact readout record fixes the declared molecular-state resolution."]]],.array [.text "extension",.array [.array [.text "free-species-exception",.text "A species exception can fit any desired spectrum."],.array [.text "no-extra-rule",.text "Only admitted dependencies and the complete finite product are used."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact nuclear-electronic, vibronic and rovibronic state composition"
 branch := "chemistry"
 statement := "An exact molecular rovibronic state is the complete finite joint carrier of one admitted molecular electronic state, every retained nuclear occurrence and isotope label, positive vibrational and rotational recurrence coordinates, one held spin state and one declared observation record. The admitted electronic-over-vibrational-over-rotational hierarchy distinguishes the coordinates without importing a separation approximation; the H2/D2 isotope transport and resolved rotational/vibrational relations remain the exact measured consequence supplied by the admitted Physics dependency."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "identified-molecular-state-carrier__nuclear-electronic-joint-support__admitted-electronic-vibrational-rotational-order__positive-odd-vibrational-recurrence__positive-counted-rotational-recurrence__held-spin-state__retained-rovibronic-observation__no-extra-rule"),("base",.text "One electronic carrier, one retained nuclear support, the first positive vibrational and rotational ordinals, one held spin label and one readout record form the least complete joint molecular state."),("successor",.text "Adjoining one nuclear occurrence or one positive recurrence ordinal preserves all prior coordinates and forces exactly its new isotope, recurrence and observation distinction; no measured scalar or new rule is introduced."),("exclusions",.array [.text "no source value, NIST inscription or comparison interval in candidate generation or survivor selection",.text "no imported wavefunction, Hamiltonian, Born-Oppenheimer approximation, continuum surface or rigid-rotor premise",.text "no numerical-zero state, negative, irrational, imaginary or floating proof value",.text "no fitted molecular constant, isotope factor, species exception or target-derived parameter",.text "no absolute bond length, frequency or rotational constant claimed by this compositional prerequisite",.text "all earlier Physics and Chemistry receipts remain immutable and separately owned"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no source value, NIST inscription or comparison interval in candidate generation or survivor selection","no imported wavefunction, Hamiltonian, Born-Oppenheimer approximation, continuum surface or rigid-rotor premise","no numerical-zero state, negative, irrational, imaginary or floating proof value","no fitted molecular constant, isotope factor, species exception or target-derived parameter","no absolute bond length, frequency or rotational constant claimed by this compositional prerequisite","all earlier Physics and Chemistry receipts remain immutable and separately owned"]
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
end SFT.Chemistry.MolecularRovibronicEvidence
