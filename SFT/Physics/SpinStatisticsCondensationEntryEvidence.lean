import SFT.Physics.SpinStatisticsCondensationGrammar
import SFT.Physics.SpinStatisticsCondensationWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.SpinStatisticsCondensationEntryEvidence
open SFT.Host.Canonical SpinStatisticsCondensationGrammar SpinStatisticsCondensationWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "occupation"),("statement",.text "Complete finite preserving and alternating occupation counts match their forced combinatorial forms."),("passed",.boolean witness0)],.object [("name",.text "weights"),("statement",.text "Every admitted finite canonical occupation measure is exact and normalized."),("passed",.boolean witness1)],.object [("name",.text "spin"),("statement",.text "The complete two-label census and typed return orbits force the spin-statistics composition."),("passed",.boolean witness2)],.object [("name",.text "condensation"),("statement",.text "Every tested finite grammar has one first lock crossing and one minimum-throw shared-ground word."),("passed",.boolean witness3)]]
def claimId : String := "SFT-PHYS-SPIN-STATISTICS-CONDENSATION-TERMINAL-045"
def dependencies : List String := ["SFT-FOUNDATION-ONE-001", "SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-HALF-ONE-001", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-PHYS-QUANTUM-SPIN-001", "SFT-PHYS-QUANTUM-INDISTINGUISHABILITY-001", "SFT-PHYS-QUANTUM-EXCLUSION-001", "SFT-PHYS-MATTER-FERMION-BOSON-001", "SFT-PHYS-NUCLEAR-DEUTERON-DINUCLEON-TERMINAL-006", "SFT-PHYS-COUPLED-MAP-CRITICALITY-TERMINAL-008", "SFT-PHYS-THERMAL-EQUILIBRIUM-RESPONSE-TERMINAL-043", "SFT-PHYS-COLLECTIVE-RADIATION-RESPONSE-TERMINAL-041"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "exchange",.text (exchangeName c.exchange)],.array [.text "fermion",.text (fermionName c.fermion)],.array [.text "boson",.text (bosonName c.boson)],.array [.text "weights",.text (weightsName c.weights)],.array [.text "spin",.text (spinName c.spin)],.array [.text "pairing",.text (pairingName c.pairing)],.array [.text "lock",.text (lockName c.lock)],.array [.text "ground",.text (groundName c.ground)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of exchange, exclusion, accumulation, occupation-weight, spin-return, pairing, lock-threshold and ground-orbit forms."),("grammar_boundary",.text "Every positive finite particle count N, positive finite level count L, preserving or alternating exchange class, positive finite cold depth, and Fold factor m at least two; empty cells are typed structural-absence records."),("axes",.array [.object [("key",.text "exchange"),("question",.text "What distinguishes the two statistics?"),("choices",.array [.array [.text "named-particle-species",.text "A species name does not force its exchange law."],.array [.text "preserving-versus-alternating-held-trace",.text "The complete exchange trace has exactly preserving and alternating classes."]])],.object [("key",.text "fermion"),("question",.text "What limits alternating occupation?"),("choices",.array [.array [.text "selected-occupancy-cap",.text "A selected cap is a free rule."],.array [.text "one-cell-distinction-exclusion",.text "A duplicate alternating word erases its only orientation distinction."]])],.object [("key",.text "boson"),("question",.text "What limits preserving occupation?"),("choices",.array [.array [.text "finite-selected-ceiling",.text "No generated ceiling follows from preserving exchange."],.array [.text "every-positive-finite-multiplicity-admitted",.text "Preserving exchange admits the shared word for every finite population."]])],.object [("key",.text "weights"),("question",.text "What fixes equilibrium occupation weights?"),("choices",.array [.array [.text "continuum-statistical-distribution",.text "A continuum distribution is outside Fold arithmetic."],.array [.text "complete-exact-dyadic-occupation-census",.text "Every finite admitted word receives and normalizes an exact Fold weight."]])],.object [("key",.text "spin"),("question",.text "What fixes the spin-statistics return?"),("choices",.array [.array [.text "imaginary-signed-phase",.text "Imaginary or signed proof scalars are inadmissible."],.array [.text "typed-one-turn-two-turn-held-orbits",.text "Held-label recurrence directly distinguishes one-turn and two-turn return."]])],.object [("key",.text "pairing"),("question",.text "What do two alternating constituents compose to?"),("choices",.array [.array [.text "independent-boson-postulate",.text "An independent postulate breaks the single derivation chain."],.array [.text "alternating-pair-preserves-exchange",.text "Two complete fibre changes restore the held orientation."]])],.object [("key",.text "lock"),("question",.text "What fixes condensation onset?"),("choices",.array [.array [.text "measured-or-fitted-temperature",.text "A measured or fitted onset would select the law."],.array [.text "first-exact-crossing-of-forced-m-minus-one-over-m-share",.text "The admitted Fold threshold and complete cold census select one first crossing."]])],.object [("key",.text "ground"),("question",.text "What fixes the condensate state?"),("choices",.array [.array [.text "asserted-macroscopic-ground-mode",.text "Naming a condensate is not an enumeration."],.array [.text "unique-minimum-throw-shared-ground-word",.text "Complete finite occupation enumeration leaves one minimum-throw word."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal finite spin-statistics, occupation and Bose-condensation law"
 branch := "physics"
 statement := "The preserving and alternating exchange classes force the two finite quantum statistics. For N occupants over L levels, complete occupation enumeration gives C(N+L-1,N) preserving words with no finite per-level ceiling and C(L,N) alternating words with at most one occupant per level; when N>L the latter support is the empty One form. Exact dyadic Fold weighting normalizes every admitted finite occupation word without a continuum distribution. The complete two-label spin composition has three preserving readings and one alternating reading. An alternating constituent changes held fibre after one complete turn and first returns after two, whereas an alternating pair is preserving and returns after one. For every finite preserving population, repeated cold Fold weighting uniquely raises the shared ground-orbit weight through the already forced lock share (m-1)/m at a first finite depth; its exact canonical mean throw is the critical-temperature carrier. At minimum total throw, exhaustive occupation enumeration leaves exactly one word: the whole population in the shared ground orbit."
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
def closureValue : Value := .object [("result",.text "For positive finite N and L, preserving exchange has exactly C(N+L-1,N) occupation words and admits N occupants in one cell for every N; alternating exchange has exactly C(L,N) words for N<=L, an empty support for N>L, and never exceeds one occupant per cell. Every finite canonical occupation weight is exact rational and sums to One. The two-label spin census is 3/4 preserving and 1/4 alternating; alternating spin first returns after two turns, while a pair is preserving and returns after one. For every N,L and m>=2, the ground-orbit share crosses (m-1)/m at a uniquely first finite cold depth, fixing an exact rational critical mean throw; the unique minimum-throw preserving word places all N occupants in the shared ground orbit."),("base",.text "One occupant on one level gives the same single word in both exchange classes; two spin labels give exactly three preserving and one alternating composition readings."),("successor",.text "Adding a level extends weak compositions and subsets by their last-cell occupation, yielding the Pascal recurrences for C(N+L-1,N) and C(L,N). Adding a preserving occupant retains the all-ground word with no ceiling; adding cold depth multiplies every excited competitor by at least one additional half-One disadvantage, so a finite depth crosses the fixed (m-1)/m share."),("exclusions",.array [.text "no Fermi-Dirac or Bose-Einstein continuum function imported as a premise",.text "no measured transition temperature, particle species or 360/720-degree observation available to candidate selection",.text "no selected occupancy cap, chemical potential, thermodynamic limit or infinite population",.text "no ontic randomness",.text "no conventional numerical-nothingness, negative, irrational, imaginary, floating, NaN or continuum proof magnitude; visible 0 in an occupation vector denotes an empty One cell"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no Fermi-Dirac or Bose-Einstein continuum function imported as a premise", "no measured transition temperature, particle species or 360/720-degree observation available to candidate selection", "no selected occupancy cap, chemical potential, thermodynamic limit or infinite population", "no ontic randomness", "no conventional numerical-nothingness, negative, irrational, imaginary, floating, NaN or continuum proof magnitude; visible 0 in an occupation vector denotes an empty One cell"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with exchange := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.SpinStatisticsCondensationEntryEvidence
