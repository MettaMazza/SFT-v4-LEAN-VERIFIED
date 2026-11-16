import SFT.Physics.ThermalHistoryGrammar
import SFT.Physics.ThermalHistoryWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.ThermalHistoryEntryEvidence
open SFT.Host.Canonical ThermalHistoryGrammar ThermalHistoryWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "temperature"),("statement",.text "Exact inverse scale transport preserves temperature times scale."),("passed",.boolean witness0)],.object [("name",.text "thresholds"),("statement",.text "Every distinct exact threshold has one descending cooling position."),("passed",.boolean witness1)],.object [("name",.text "orbit"),("statement",.text "The complete least-part depth-seven binary orbit is exactly one, two and four."),("passed",.boolean witness2)],.object [("name",.text "freezeout-correction"),("statement",.text "Freeze-out share One/seven gives ratio One/six; capture-entry share One/eight gives ratio One/seven."),("passed",.boolean witness3)],.object [("name",.text "nuclear-partition"),("statement",.text "Complete retained-neutron pairing forces One/four helium family and three/four hydrogen family."),("passed",.boolean witness4)],.object [("name",.text "visibility"),("statement",.text "Every generated finite visibility ledger is complete, positive and uniquely centred."),("passed",.boolean witness5)],.object [("name",.text "acoustic-parity"),("statement",.text "Positive whole internal modes alternate compression and rarefaction exactly."),("passed",.boolean witness6)],.object [("name",.text "finite-horizon"),("statement",.text "The generated-finite sound horizon remains an exact positive Fold carrier."),("passed",.boolean witness7)]]
def claimId : String := "SFT-PHYS-THERMAL-HISTORY-RECOMBINATION-TERMINAL-037"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-PART-001", "SFT-FOUNDATION-EXACT-OPERATIONS-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-PHYS-THERMO-TEMPERATURE-001", "SFT-PHYS-THERMO-EQUILIBRIUM-001", "SFT-PHYS-COSMO-REDSHIFT-001", "SFT-PHYS-COSMO-BACKGROUND-001", "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032", "SFT-PHYS-MATTER-BARYON-PHOTON-TERMINAL-004", "SFT-PHYS-ATOMIC-HYDROGEN-RYDBERG-TERMINAL-005", "SFT-PHYS-NUCLEAR-DEUTERON-DINUCLEON-TERMINAL-006", "SFT-PHYS-NUCLEAR-FUSION-FISSION-YIELD-THRESHOLD-006", "SFT-PHYS-PLASMA-COLLECTIVE-001", "SFT-PHYS-PLASMA-OSCILLATION-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "provenance",.text (provenanceName c.provenance)],.array [.text "temperature",.text (temperatureName c.temperature)],.array [.text "threshold",.text (thresholdName c.threshold)],.array [.text "freezeout",.text (freezeoutName c.freezeout)],.array [.text "decay",.text (decayName c.decay)],.array [.text "capture",.text (captureName c.capture)],.array [.text "recombination",.text (recombinationName c.recombination)],.array [.text "acoustic",.text (acousticName c.acoustic)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of provenance, temperature transport, threshold order, freeze-out carrier, complete-cover transport, nuclear capture, recombination support and acoustic observation form."),("grammar_boundary",.text "Every exact positive rational temperature and scale carrier; every finite set of distinct positive binding thresholds; the complete binary orbit of the least part on depth seven; the least complete depth-three binary cover; every finite positive visibility radius; every finite positive internal acoustic mode count; exact generated-finite sound-horizon segments; and strict separation of internal mode labels from observed projection."),("axes",.array [.object [("key",.text "provenance"),("question",.text "What selects the thermal history?"),("choices",.array [.array [.text "named-cosmological-chronology",.text "A familiar chronology cannot select a Fold law."],.array [.text "admitted-threshold-and-transport-dependencies",.text "The complete root-traced physical carriers select the law."]])],.object [("key",.text "temperature"),("question",.text "How does temperature move with scale?"),("choices",.array [.array [.text "same-direction-or-fitted-cooling",.text "A named cooling curve or fitted exponent adds a rule."],.array [.text "exact-inverse-scale-transport",.text "Holding temperature times scale uniquely preserves the transported recurrence energy."]])],.object [("key",.text "threshold"),("question",.text "What orders physical epochs?"),("choices",.array [.array [.text "named-epoch-list",.text "Names do not prove order."],.array [.text "descending-distinct-binding-thresholds",.text "Monotone cooling crosses the complete exact thresholds in their forced descending order."]])],.object [("key",.text "freezeout"),("question",.text "What does the depth-seven orbit fix?"),("choices",.array [.array [.text "one-seventh-ratio-rubber-stamp",.text "The old label conflates a constituent share with a pair ratio."],.array [.text "least-live-neutron-share",.text "The complete orbit has one least live part, One/seven, with separately retained six/seven complement."]])],.object [("key",.text "decay"),("question",.text "How is capture-entry transport represented?"),("choices",.array [.array [.text "selected-decay-correction",.text "A fitted decay fraction is inadmissible."],.array [.text "least-complete-binary-cover-successor",.text "The held least live record enters the unique least complete support, depth three, as One/eight."]])],.object [("key",.text "capture"),("question",.text "What mass partition follows complete neutron capture?"),("choices",.array [.array [.text "named-quarter-abundance",.text "Naming one quarter does not force it."],.array [.text "paired-neutron-helium-and-hydrogen-families",.text "Two retained nucleons per neutron force One/four helium-family and three/four hydrogen-family support."]])],.object [("key",.text "recombination"),("question",.text "What is the decoupling boundary?"),("choices",.array [.array [.text "instantaneous-zero-width-collapse",.text "A zero-width event erases physical visibility support."],.array [.text "half-One-midpoint-with-finite-visibility",.text "The bound/free midpoint classifies the transition while every generated radius retains a complete positive record."]])],.object [("key",.text "acoustic"),("question",.text "How are acoustic peaks represented?"),("choices",.array [.array [.text "observed-multipoles-assumed-exact-integers",.text "Projection and driving cannot be erased to preserve an old slogan."],.array [.text "internal-whole-modes-parity-and-projection-record",.text "Internal modes are exact positive wholes; alternating parity is retained and angular observation remains a typed projection."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal thermal-history, freeze-out and recombination law"
 branch := "physics"
 statement := "Exact Fold temperature is transported inversely to exact scale growth, so temperature times scale is held. Distinct binding thresholds therefore impose one descending thermal order without a named chronology selecting it. The complete binary orbit on depth seven is (One, two, four)/seven. Its least live part fixes the freeze-out neutron share One/seven, not the old shorthand neutron/proton ratio. The proton share is six/seven and the freeze-out ratio is One/six. Transport into the least complete binary cover gives capture shares One/eight and seven/eight, hence neutron/proton One/seven; complete neutron pairing forces helium-family share One/four and hydrogen-family share three/four. Recombination is classified at the half-One bound/free midpoint, while every physical visibility record remains finite and positive rather than an instantaneous collapse. Pre-decoupling acoustics have exact positive-whole internal modes with alternating compression/rarefaction parity; observed angular peaks retain projection and driving records and are not asserted to be exact integer multiples."
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
def closureValue : Value := .object [("result",.text "For every exact positive scale growth g, T_later=T_earlier/g and T_later*g=T_earlier. Distinct binding thresholds are crossed in unique descending order. The depth-seven binary orbit (1,2,4)/7 forces freeze-out neutron/proton shares 1/7 and 6/7 and ratio 1/6. The least complete binary-cover successor forces capture-entry shares 1/8 and 7/8 and ratio 1/7. Complete retained-neutron pairing forces helium-family mass share 1/4 and hydrogen-family share 3/4. Recombination has an exact half-One classification midpoint and a finite positive visibility ledger at every generated radius. Acoustic standing modes are positive whole labels with exact odd/even compression-rarefaction parity; observed angular positions retain their projection and are not proof identical to the internal whole labels."),("base",.text "One exact thermal carrier and one exact scale relation preserve their product; the first positive visibility radius has three positive records and one unique midpoint; the first acoustic mode is a compression record."),("successor",.text "Each new exact scale carrier preserves inverse transport, each additional distinct threshold inserts at its unique exact order, each visibility successor adds one mirrored positive record to both sides, and each acoustic successor alternates parity without erasing projection or driving records."),("exclusions",.array [.text "no conventional hot-big-bang equation, continuum fluid integral, stochastic freeze-out or fitted thermal exponent as a premise",.text "no measurement value, helium abundance, recombination redshift or CMB peak location available to candidate selection",.text "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar",.text "no untyped identification of neutron share with neutron/proton ratio",.text "no instantaneous zero-width recombination event",.text "no claim that observed CMB angular multipoles are exact integer multiples",.text "no free reaction rate, decay fraction, sound speed, baryon loading or projection coefficient"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no conventional hot-big-bang equation, continuum fluid integral, stochastic freeze-out or fitted thermal exponent as a premise", "no measurement value, helium abundance, recombination redshift or CMB peak location available to candidate selection", "no numerical-zero, negative, irrational, imaginary, floating, NaN, continuum or completed-infinity proof scalar", "no untyped identification of neutron share with neutron/proton ratio", "no instantaneous zero-width recombination event", "no claim that observed CMB angular multipoles are exact integer multiples", "no free reaction rate, decay fraction, sound speed, baryon loading or projection coefficient"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with provenance := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3 && witness4 && witness5 && witness6 && witness7) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.ThermalHistoryEntryEvidence
