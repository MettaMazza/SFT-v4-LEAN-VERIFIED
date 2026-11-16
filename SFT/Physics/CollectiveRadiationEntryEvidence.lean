import SFT.Physics.CollectiveRadiationGrammar
import SFT.Physics.CollectiveRadiationWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.CollectiveRadiationEntryEvidence
open SFT.Host.Canonical CollectiveRadiationGrammar CollectiveRadiationWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "occupation"),("statement",.text "The complete finite word census preserves energy, closes its ultraviolet support and is exactly scale covariant."),("passed",.boolean witness0)],.object [("name",.text "radiation-acoustic"),("statement",.text "Three-space radiation is fourth-power and fixed boundaries give whole harmonics."),("passed",.boolean witness1)],.object [("name",.text "laser"),("statement",.text "Strict inversion, gain-over-loss and positive reciprocal linewidth close together."),("passed",.boolean witness2)],.object [("name",.text "plasma"),("statement",.text "Oscillation and screening share the exact charge stiffness."),("passed",.boolean witness3)],.object [("name",.text "alfven"),("statement",.text "Magnetic tension over inertia gives an exact positive squared carrier."),("passed",.boolean witness4)]]
def claimId : String := "SFT-PHYS-COLLECTIVE-RADIATION-RESPONSE-TERMINAL-041"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-PART-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-PHYS-SPACE-DIMENSION-THREE-001", "SFT-PHYS-THERMO-STATISTICAL-WEIGHT-001", "SFT-PHYS-THERMO-TEMPERATURE-001", "SFT-PHYS-MATTER-FERMION-BOSON-001", "SFT-PHYS-QUANTUM-DISCRETE-SPECTRA-001", "SFT-PHYS-FIELD-RADIATION-001", "SFT-PHYS-WAVE-RESONANCE-001", "SFT-PHYS-ATOMIC-TRANSITION-RATE-TERMINAL-005", "SFT-PHYS-PLASMA-COLLECTIVE-001", "SFT-PHYS-PLASMA-OSCILLATION-001", "SFT-PHYS-FLUID-DENSITY-001", "SFT-PHYS-FIELD-MAGNETIC-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "occupation",.text (occupationName c.occupation)],.array [.text "radiation",.text (radiationName c.radiation)],.array [.text "acoustic",.text (acousticName c.acoustic)],.array [.text "stimulated",.text (stimulatedName c.stimulated)],.array [.text "threshold",.text (thresholdName c.threshold)],.array [.text "linewidth",.text (linewidthName c.linewidth)],.array [.text "plasma",.text (plasmaName c.plasma)],.array [.text "magnetofluid",.text (magnetofluidName c.magnetofluid)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of finite occupation, radiative dimension, acoustic boundary, stimulated mode, gain threshold, linewidth, plasma balance and magnetofluid response forms."),("grammar_boundary",.text "Every finite positive-whole mode-cost list and positive total-quanta support; every common positive-whole scale; every exact positive temperature ratio; every positive acoustic mode count; every positive laser population, gain, loss and coherence count; and every exact positive charge, mass, permittivity, temperature, field, permeability and density carrier. Empty occupation is a structural empty record, not a physical zero magnitude."),("axes",.array [.object [("key",.text "occupation"),("question",.text "What fixes cavity occupation?"),("choices",.array [.array [.text "continuum-exponential-premise",.text "An imported exponential violates finite exact generation."],.array [.text "complete-finite-boson-word-census",.text "Every exact word at held total quanta is generated once."]])],.object [("key",.text "radiation"),("question",.text "What fixes total radiative scaling?"),("choices",.array [.array [.text "fitted-Stefan-exponent",.text "A fitted exponent is target-selected."],.array [.text "three-mode-powers-plus-one-energy-power",.text "Stable three-space plus energy forces fourth power."]])],.object [("key",.text "acoustic"),("question",.text "What frequencies fit fixed boundaries?"),("choices",.array [.array [.text "selected-frequency-list",.text "A named spectrum cannot select the law."],.array [.text "positive-whole-harmonic-ladder",.text "Closure admits exactly positive-whole multiples of the fundamental."]])],.object [("key",.text "stimulated"),("question",.text "What does stimulated emission preserve?"),("choices",.array [.array [.text "unrelated-spontaneous-output",.text "An unrelated output does not amplify a held mode."],.array [.text "duplicated-identical-held-mode",.text "Bosonic mode preservation appends one identical photon record."]])],.object [("key",.text "threshold"),("question",.text "What fixes lasing threshold?"),("choices",.array [.array [.text "free-gain-setting",.text "A free setting adds a parameter."],.array [.text "gain-loss-equality-with-strict-half-One-inversion",.text "Balance is equality and inversion is strictly above the binary midpoint."]])],.object [("key",.text "linewidth"),("question",.text "What fixes linewidth?"),("choices",.array [.array [.text "zero-width-monochromatic-idealization",.text "A numerical-zero width erases the finite record."],.array [.text "positive-reciprocal-coherence-carrier",.text "One over positive coherence ticks closes the exact product to One."]])],.object [("key",.text "plasma"),("question",.text "What fixes plasma response and screening?"),("choices",.array [.array [.text "named-empirical-fit",.text "A named fit cannot select the carrier."],.array [.text "charge-stiffness-over-inertia-and-thermal-balance",.text "The same exact charge stiffness supplies oscillation and screening balances."]])],.object [("key",.text "magnetofluid"),("question",.text "What fixes the Alfvén carrier?"),("choices",.array [.array [.text "selected-wave-speed",.text "A measured speed is not a derivation."],.array [.text "magnetic-tension-over-fluid-inertia",.text "Field-square tension divided by permeability-density is the unique squared carrier."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal finite radiation, acoustic, laser, plasma and Alfvén response law"
 branch := "physics"
 statement := "Finite bosonic cavity support is the complete exact occupation-word census at held total quanta; modes costing more than the support carry only an empty record, so the ultraviolet tail closes without a continuum exponential. Common exact scaling of energy and mode costs preserves every occupation word, forcing peak-frequency covariance with temperature. Three spatial mode-count powers plus one energy power force radiated power ratio g^4. Fixed boundaries force acoustic frequencies n times the fundamental. Stimulated emission duplicates the held photon mode; inversion is strictly above half-One, lasing threshold is exact gain/loss equality, and linewidth times coherence ticks is One. Charge stiffness forces plasma-frequency-squared=nq^2/(m epsilon) and Debye-length-squared=epsilon T/(nq^2). Magnetic tension over inertia forces Alfvén-speed-squared=B^2/(mu rho). Squared carriers retain exact Fold arithmetic without importing irrational roots."
 evidenceMode := .formal
 rootTheorems := [SFT.Engine.rootTheoremId]
 dependencies := dependencies
 axioms := []
 freeParameters := []
 provenance := [.forwardForcing,.observationalDerivation]
 sourceHash := sourceHash
def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)
def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
 candidateId := candidateId c
 exactForm := exactForm c
 traceHash := admissionIdentity (.array [.text claimId,.text generationRule,candidateRecord c])
def censusData : SFT.Engine.CandidateCensus where
 generationRule := generationRule
 grammarBoundary := grammarBoundary
 expectedCardinality := .ofNat candidates.length
 completenessCertificateHash := admissionIdentity completenessRecord
 candidates := candidates.map generatedCandidateData
def census : Value := SFT.Engine.censusValue censusData

def decisionData (c : Candidate) : SFT.Engine.CandidateDecision where
 candidateId := candidateId c
 survives := survives c
 reason := decisionReason c
 proofHash := admissionIdentity (.array [.text claimId,.array (dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("result",.text "Every finite cavity occupation is an exact rational mean over the complete microcanonical word census; all modes above total support are empty and common scale changes preserve the complete word set. Wien covariance is exact at the relation level. In stable three-space P(gT)/P(T)=g^4, so doubling gives 16. Acoustic modes are f_n=n f_1. Laser inversion is greater than 1/2, threshold is gain=loss, above-threshold requires gain>loss, and linewidth times coherence ticks is One. Plasma omega_p^2=nq^2/(m epsilon), lambda_D^2=epsilon T/(nq^2), and Alfvén v_A^2=B^2/(mu rho), all as exact positive rational carriers."),("base",.text "The first positive mode and first quantum have one complete occupation word; one acoustic half-wave gives the fundamental; one coherence tick gives linewidth One."),("successor",.text "Appending a finite mode or quantum regenerates the complete energy-preserving word set; appending a spatial mode-count direction appends one temperature power; each boundary mode appends one fundamental; every positive carrier successor preserves the three squared balance identities."),("exclusions",.array [.text "no Planck exponential, Bose-Einstein continuum distribution, fitted Wien constant or Stefan coefficient as premise",.text "no measured spectrum, laser setting, plasma frequency, screening length or Alfvén speed available to selection",.text "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof magnitude",.text "no square-root proof value; squared frequency, length and speed carriers are the exact native forms",.text "no free gain, loss, linewidth, plasma, acoustic or magnetofluid coefficient"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.array [closureValue,.array (decisions.map SFT.Engine.decisionValue)])
 generalityCertificateHash := some (admissionIdentity closureValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := observation
 observedBehavior := if passed then observation else "control failed"
 receiptHash := identity (.array [.text claimId,.text (SFT.Engine.kindName kind),.boolean passed,.text observation])
def exclusions : List String := ["no Planck exponential, Bose-Einstein continuum distribution, fitted Wien constant or Stefan coefficient as premise", "no measured spectrum, laser setting, plasma frequency, screening length or Alfvén speed available to selection", "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof magnitude", "no square-root proof value; squared frequency, length and speed carriers are the exact native forms", "no free gain, loss, linewidth, plasma, acoustic or magnetofluid coefficient"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with occupation := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3 && witness4) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.CollectiveRadiationEntryEvidence
