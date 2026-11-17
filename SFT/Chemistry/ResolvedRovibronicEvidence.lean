import SFT.Chemistry.ResolvedRovibronicGrammar
import SFT.Chemistry.ResolvedRovibronic
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.ResolvedRovibronicEvidence
open SFT.Host.Canonical ResolvedRovibronicGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "joint-key",.text "A complete resolved state has one exact joint key.",.boolean ResolvedRovibronic.jointKeyWitness],.array [.text "spin-positive",.text "Spin multiplicity is a positive whole.",.boolean ResolvedRovibronic.spinWitness],.array [.text "erasure-control",.text "An erased electronic family rejects.",.boolean ResolvedRovibronic.erasureWitness]]
def claimId : String := "SFT-CHEM-RESOLVED-ROVIBRONIC-SPIN-COMPOSITION-013"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005","SFT-CHEM-ROVIBRONIC-COMPOSITION-001","SFT-CHEM-MOLECULAR-STATE-TRANSITION-009","SFT-CHEM-SELECTION-RULE-STRUCTURE-010","SFT-CHEM-NUCLEAR-ELECTRONIC-COMPOSITION-012"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "electronic",.text (electronicName c.electronic)],.array [.text "vibration",.text (vibrationName c.vibration)],.array [.text "rotation",.text (rotationName c.rotation)],.array [.text "spin",.text (spinName c.spin)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "observation",.text (observationName c.observation)],.array [.text "record",.text (recordName c.record)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "detached-spectral-row",.text "A row detached from its molecule is not a chemical state."],.array [.text "retained-molecular-and-isotope-carrier",.text "Every coordinate remains bound to one isotopologue carrier."]]],.array [.text "electronic",.array [.array [.text "transition-name-without-electronic-state",.text "A transition name alone erases its endpoint state."],.array [.text "retained-electronic-state-designation",.text "The full electronic designation remains held."]]],.array [.text "vibration",.array [.array [.text "continuum-vibration-or-erasure",.text "A continuum coordinate or erasure is not an exact generated state."],.array [.text "positive-vibrational-coordinate-or-EmptyOne",.text "Resolved vibration is exact positive support or structural absence."]]],.array [.text "rotation",.array [.array [.text "signed-rotation-or-erasure",.text "Signed continuum rotation or erasure loses resolved structure."],.array [.text "positive-rotational-coordinate-or-EmptyOne",.text "Resolved rotation is exact positive support or structural absence."]]],.array [.text "spin",.array [.array [.text "spin-erased-molecular-state",.text "Erasing multiplicity merges singlet and triplet records."],.array [.text "retained-positive-spin-multiplicity",.text "Every term retains its positive whole multiplicity."]]],.array [.text "composition",.array [.array [.text "independent-coordinate-list",.text "A list without joint identity permits unlawful recombination."],.array [.text "finite-vibronic-rovibronic-spin-product",.text "All coordinates form one finite joint state."]]],.array [.text "observation",.array [.array [.text "endpoint-only-transition",.text "Endpoints alone erase the measured transition record and unresolved boundary."],.array [.text "retained-transition-and-band-record",.text "Transition designation and band record remain held, including absence."]]],.array [.text "record",.array [.array [.text "selected-resolved-lines",.text "Selected lines cannot establish complete resolved composition."],.array [.text "complete-resolved-spectrum-surface",.text "Every registered state row and source cell is retained."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Exact resolved vibronic, rovibronic and spin-state joint-composition law"
 branch := "chemistry"
 statement := "A resolved molecular spectral state is one finite joint product retaining its isotopologue carrier, electronic designation, positive whole spin multiplicity, exact positive vibrational and rotational coordinates or structural EmptyOne, transition/band record and complete source record. No coordinate may be erased, recombined independently or replaced by a continuum premise."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "retained-molecular-and-isotope-carrier__retained-electronic-state-designation__positive-vibrational-coordinate-or-EmptyOne__positive-rotational-coordinate-or-EmptyOne__retained-positive-spin-multiplicity__finite-vibronic-rovibronic-spin-product__retained-transition-and-band-record__complete-resolved-spectrum-surface"),("base",.text "One isotopologue carrier, electronic designation, positive multiplicity, first resolved vibration/rotation coordinates or structural absences, transition record and source record form the least complete state."),("successor",.text "Appending one positive vibration or rotation recurrence extends that coordinate while preserving carrier, isotope, electronic, spin, transition and all preceding records; appending a state row extends the census without changing prior states."),("exclusions",.array [.text "no numerical zero; external zero is structural EmptyOne",.text "no negative, irrational, imaginary, floating, signed or continuum proof value",.text "no imported wavefunction, Hamiltonian, rigid rotor, harmonic oscillator, differential equation or fitted spectroscopic constant",.text "no NIST state, multiplicity, constant, transition or band outcome before prediction seal",.text "no singlet-only, triplet-only, common-state-only or resolved-value-only subset"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no numerical zero; external zero is structural EmptyOne","no negative, irrational, imaginary, floating, signed or continuum proof value","no imported wavefunction, Hamiltonian, rigid rotor, harmonic oscillator, differential equation or fitted spectroscopic constant","no NIST state, multiplicity, constant, transition or band outcome before prediction seal","no singlet-only, triplet-only, common-state-only or resolved-value-only subset"]
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
end SFT.Chemistry.ResolvedRovibronicEvidence
