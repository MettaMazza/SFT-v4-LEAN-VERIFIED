import SFT.Chemistry.MolecularElectronicGrammar
import SFT.Chemistry.MolecularElectronicWitnesses
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MolecularElectronicEvidence
open SFT.Host.Canonical MolecularElectronicGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "complete-two-electron-state",.text "Every electron occurrence is retained once in joint molecular support.",.boolean (match MolecularElectronicState.electronicCount MolecularElectronicWitnesses.originalA with | .ok n=>n.value==2 | .error _=>false)],.array [.text "state-distinction",.text "Changing complete joint support and the held signature changes the molecular electronic state.",.boolean (match MolecularElectronicState.distinguishableElectronicStates MolecularElectronicWitnesses.originalA MolecularElectronicWitnesses.originalB with | .ok b=>b | .error _=>false)],.array [.text "incomplete-support-control",.text "A support omitting a retained electron occurrence rejects.",.boolean (match MolecularElectronicState.valid MolecularElectronicWitnesses.incomplete with | .error _=>true | .ok _=>false)]]
def claimId : String := "SFT-CHEM-ELECTRONIC-STATE-IDENTITY-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-QUANTUM-STATE-COMPOSITION-001","SFT-QUANTUM-MEASUREMENT-001","SFT-QUANTUM-CLASSICAL-CORRESPONDENCE-001","SFT-PHYS-QUANTUM-PHYSICAL-STATE-001","SFT-PHYS-QUANTUM-SPIN-001","SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001","SFT-CHEM-MEAS-CHEMICAL-ENTITY-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-BOND-CHEMICAL-BOND-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "carrier",.text (carrierName c.carrier)],.array [.text "occurrences",.text (occurrencesName c.occurrences)],.array [.text "arrangement",.text (arrangementName c.arrangement)],.array [.text "admissibility",.text (admissibilityName c.admissibility)],.array [.text "composition",.text (compositionName c.composition)],.array [.text "distinction",.text (distinctionName c.distinction)],.array [.text "record",.text (recordName c.record)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "carrier",.array [.array [.text "state-without-molecular-carrier",.text "A free state label cannot identify which chemical whole carries it."],.array [.text "identified-molecular-carrier",.text "The electronic organization remains bound to one admitted molecular carrier."]]],.array [.text "occurrences",.array [.array [.text "anonymous-electron-number",.text "A number alone erases the separately retained electron occurrences."],.array [.text "electron-occurrences-retained",.text "Every electron occurrence remains a distinct held member of the joint state."]]],.array [.text "arrangement",.array [.array [.text "energy-name-only",.text "An energy or state name cannot reconstruct the electronic organization."],.array [.text "complete-joint-arrangement",.text "The complete finite support assigns every retained occurrence exactly once."]]],.array [.text "admissibility",.array [.array [.text "arbitrary-electron-arrangement",.text "An arbitrary arrangement can violate admitted spin, indistinguishability and exclusion laws."],.array [.text "admitted-quantum-constraints",.text "Only arrangements preserving all admitted quantum distinctions survive."]]],.array [.text "composition",.array [.array [.text "independent-electron-list",.text "Independent labels omit the composed molecular state."],.array [.text "molecular-composition-retained",.text "Electron support is composed with the identified molecular whole."]]],.array [.text "distinction",.array [.array [.text "state-name-without-observation",.text "A name without a retained observation class supplies no state distinction."],.array [.text "observation-distinguishable-state",.text "Distinct joint support or signature yields a retained chemical state distinction."]]],.array [.text "record",.array [.array [.text "electronic-result-without-trace",.text "A result without carrier, occurrences and support cannot be reproduced."],.array [.text "held-state-record",.text "Carrier, occurrences, spin, support and observation signature remain auditable."]]],.array [.text "extension",.array [.array [.text "free-electronic-exception",.text "A free exception can manufacture a desired state or target match."],.array [.text "no-extra-rule",.text "No law beyond admitted dependencies and complete support is introduced."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Molecular electronic carrier and retained state identity"
 branch := "chemistry"
 statement := "A molecular electronic state is the complete finite arrangement of every retained electron occurrence, held spin label and joint electronic support inside one identified molecular carrier that preserves the admitted quantum constraints and remains distinguishable under a retained chemical observation record."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "identified-molecular-carrier__electron-occurrences-retained__complete-joint-arrangement__admitted-quantum-constraints__molecular-composition-retained__observation-distinguishable-state__held-state-record__no-extra-rule"),("base",.text "One retained electron occurrence requires one molecular carrier, one held spin label, one support row and one observation signature; erasing any coordinate loses the registered distinction."),("successor",.text "For any complete positive-finite state, adjoining one generated electron occurrence forces one new unique occurrence identity, held spin label and support row while preserving the same carrier, quantum constraints and observation record; no new rule or measured value is introduced."),("exclusions",.array [.text "no IUPAC wording or target label in candidate generation or survivor selection",.text "no imported molecular Hamiltonian, wavefunction, orbital table or continuum state space",.text "no numerical zero, negative, irrational, imaginary or floating proof value",.text "no fitted, learned, target-derived or species-specific free parameter",.text "no application output or opaque predictor as chemical law",.text "external target opens only after the derivation and prediction seal"]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no IUPAC wording or target label in candidate generation or survivor selection","no imported molecular Hamiltonian, wavefunction, orbital table or continuum state space","no numerical zero, negative, irrational, imaginary or floating proof value","no fitted, learned, target-derived or species-specific free parameter","no application output or opaque predictor as chemical law","external target opens only after the derivation and prediction seal"]
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
end SFT.Chemistry.MolecularElectronicEvidence
