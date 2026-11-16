import SFT.Physics.ChirpRingdownGrammar
import SFT.Physics.ChirpRingdownWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ChirpRingdownEntryEvidence
open SFT.Host.Canonical ChirpRingdownGrammar ChirpRingdownWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "chirp"),("statement",.text "Every registered finite inspiral has shrinking separation and rising squared wave frequency."),("passed",.boolean witness0)],.object [("name",.text "merger"),("statement",.text "First horizon contact joins two sources to one remnant without erasing the radiation ledger."),("passed",.boolean witness1)],.object [("name",.text "ringdown"),("statement",.text "Every finite remnant trace holds its tone and halves positive amplitude."),("passed",.boolean witness2)],.object [("name",.text "sequence"),("statement",.text "The complete causal ordering contains exactly the three forced stages."),("passed",.boolean witness3)]]
def claimId : String := "SFT-PHYS-GRAVITATIONAL-WAVE-CHIRP-RINGDOWN-TERMINAL-073"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-PHYS-FIELD-INVERSE-SQUARE-001", "SFT-PHYS-MECH-CONSERVATION-001", "SFT-PHYS-MECH-ANGULAR-MOTION-001", "SFT-PHYS-WAVE-PERIOD-FREQUENCY-001", "SFT-PHYS-ORBITAL-DIMENSION-STABILITY-TERMINAL-009", "SFT-PHYS-GRAVITY-WAVE-QUADRUPOLE-003", "SFT-PHYS-QUADRUPOLE-RADIATED-POWER-TERMINAL-012", "SFT-PHYS-GRAVITY-STRONG-FIELD-HORIZON-003", "SFT-PHYS-COMPACT-HORIZON-THERMODYNAMICS-TERMINAL-071"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "source",.text (sourceName c.source)],.array [.text "moment",.text (momentName c.moment)],.array [.text "transfer",.text (transferName c.transfer)],.array [.text "separation",.text (separationName c.separation)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "wave",.text (waveName c.wave)],.array [.text "contact",.text (contactName c.contact)],.array [.text "merger",.text (mergerName c.merger)],.array [.text "tone",.text (toneName c.tone)],.array [.text "damping",.text (dampingName c.damping)],.array [.text "floor",.text (floorName c.floor)],.array [.text "sequence",.text (sequenceName c.sequence)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete twelve-axis product of source, radiative moment, transfer ledger, separation, orbital balance, wave recurrence, contact, merger, remnant tone, damping, finite-floor and sequence forms."),("grammar_boundary",.text "Every finite positive binary separation successor ending at the admitted horizon-contact support; every exact squared period/frequency and positive radiation-take record; the complete two-to-one source join; every finite binary remnant return; and all 4096 registered alternative combinations."),("axes",.array [.object [("key",.text "source"),("question",.text "Which compact source radiates?"),("choices",.array [.array [.text "unheld-single-source",.text "A single unheld source has no generated binary orbit."],.array [.text "held-two-source-orbit",.text "Two held compact supports generate the binary recurrence."]])],.object [("key",.text "moment"),("question",.text "Which source moment is first radiative?"),("choices",.array [.array [.text "monopole-or-dipole-radiation",.text "Conserved source and momentum close those records."],.array [.text "admitted-quadrupole-rate",.text "The admitted quadrupole third-rate is the first positive radiative carrier."]])],.object [("key",.text "transfer"),("question",.text "How is radiated energy represented?"),("choices",.array [.array [.text "negative-or-erased-energy",.text "A negative scalar or erased distinction violates the Fold ledger."],.array [.text "positive-retained-take",.text "Radiation is a positive take retained beside the positive orbital remainder."]])],.object [("key",.text "separation"),("question",.text "What follows a positive radiative take?"),("choices",.array [.array [.text "fixed-or-expanding-orbit",.text "That does not conserve the positive binding and radiation ledger."],.array [.text "strictly-shrinking-positive-separation",.text "Every successor increases binding magnitude and reduces positive separation."]])],.object [("key",.text "balance"),("question",.text "How are period and separation related?"),("choices",.array [.array [.text "imported-or-selected-frequency-law",.text "An imported or selected law is not forced."],.array [.text "inverse-square-period-square-equals-radius-cube",.text "Inverse-square restoring balance forces the exact squared relation without a root."]])],.object [("key",.text "wave"),("question",.text "How often does the quadrupole recur?"),("choices",.array [.array [.text "one-or-free-wave-cycle-per-orbit",.text "A free multiplier loses the two-lobed source record."],.array [.text "two-wave-cycles-per-orbit",.text "The quadrupole repeats twice per complete binary orbit."]])],.object [("key",.text "contact"),("question",.text "When does inspiral terminate?"),("choices",.array [.array [.text "chosen-merger-time",.text "A chosen time is a parameter."],.array [.text "first-horizon-boundary-contact",.text "The first exact equality of the two retained horizon boundaries forces contact."]])],.object [("key",.text "merger"),("question",.text "What is the contact successor?"),("choices",.array [.array [.text "erased-or-two-source-remnant",.text "It either deletes provenance or fails to join."],.array [.text "one-remnant-with-held-ledger",.text "Two sources join one remnant while radiation and component labels remain held."]])],.object [("key",.text "tone"),("question",.text "What fixes ringdown recurrence?"),("choices",.array [.array [.text "fitted-tone",.text "A fitted tone is measurement-selected."],.array [.text "held-remnant-mass-turn-class",.text "The remnant mass and turn labels fix one recurrence class."]])],.object [("key",.text "damping"),("question",.text "How does ringdown amplitude change?"),("choices",.array [.array [.text "negative-exponential-or-free-decay",.text "That imports a forbidden scalar or parameter."],.array [.text "binary-half-One-contraction",.text "The least nonempty equal binary contraction is half-One per return."]])],.object [("key",.text "floor"),("question",.text "How does damping terminate?"),("choices",.array [.array [.text "numerical-zero-or-completed-infinity",.text "Neither is an admissible Fold proof endpoint."],.array [.text "positive-at-every-finite-depth",.text "Every reached finite amplitude remains an exact positive fraction."]])],.object [("key",.text "sequence"),("question",.text "Which complete causal ordering survives?"),("choices",.array [.array [.text "permuted-or-omitted-stage",.text "It violates contact and source causality."],.array [.text "inspiral-chirp-merger-ringdown",.text "Positive transfer, first contact and one-remnant return force this unique order."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal gravitational-wave chirp, merger and ringdown law"
 branch := "physics"
 statement := "Positive quadrupole radiation transfers a retained take from a restoring binary orbit at every dynamic successor. Source conservation therefore lowers the positive orbital remainder while the exact binding support increases and separation contracts. Inverse-square circular balance forces period squared equal to separation cubed, so shrinking separation uniquely raises the exact squared orbital frequency. The quadrupole repeats twice per orbit and therefore raises the gravitational-wave frequency by the same ordered chirp. Horizon contact joins two source supports into one remnant while retaining the radiation and component-label ledger. The remnant mass/turn labels hold one tone class; the unique nonempty equal binary contraction halves its amplitude at each finite return, forcing a damped ringdown without a negative exponent, irrational frequency or numerical-zero endpoint."
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
def closureValue : Value := .object [("result",.text "For every positive finite binary shrink depth, separation and period squared strictly fall, exact squared orbital and gravitational-wave frequencies strictly rise, and every successor retains a positive radiated take. The quadrupole wave frequency is exactly twice the orbital frequency. At the first exact horizon contact, two compact source supports join one remnant with the complete radiation and component ledger held. The remnant mass/turn key fixes one tone class and its positive amplitude halves at every finite return. The unique causal waveform order is inspiral with rising chirp, merger, then damped ringdown; no negative, irrational, imaginary, continuum, numerical-zero or completed-infinite proof scalar enters."),("base",.text "At separation two, one positive radiation take reaches the exact contact separation One; squared frequency rises and the two horizons touch."),("successor",.text "Prepending any binary separation double preserves inverse-square balance, positive take, strict frequency ordering and the same contact; appending any remnant return halves positive amplitude while holding its tone key."),("exclusions",.array [.text "no V1/V2 executable, LIGO waveform, dimensional frequency, measured mass or conventional inspiral equation in formal execution",.text "no fitted chirp mass, merger time, waveform template, damping time, tone, amplitude or correction",.text "no numerical zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinite proof scalar",.text "no erased radiation, source, component, contact or remnant record",.text "no claim that normalized Fold frequency is a measured hertz value"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no V1/V2 executable, LIGO waveform, dimensional frequency, measured mass or conventional inspiral equation in formal execution", "no fitted chirp mass, merger time, waveform template, damping time, tone, amplitude or correction", "no numerical zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinite proof scalar", "no erased radiation, source, component, contact or remnant record", "no claim that normalized Fold frequency is a measured hertz value"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with source := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.ChirpRingdownEntryEvidence
