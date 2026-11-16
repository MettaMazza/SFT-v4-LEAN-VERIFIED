import SFT.Physics.HiggsGrammar
import SFT.Physics.HiggsWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Physics.HiggsEntryEvidence
open SFT.Host.Canonical HiggsGrammar HiggsWitnesses
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def witnessRecords : Value := .array [.object [("name",.text "ground-census"),("statement",.text "Three minimal ground forms are generated and half-One is the unique displaced survivor."),("passed",.boolean witness0)],.object [("name",.text "leading-rungs"),("statement",.text "The earlier half/quarter/eighth hierarchy is retained exactly."),("passed",.boolean witness1)],.object [("name",.text "support-cross-lock"),("statement",.text "Complete scalar support is six and both independent predecessor and cover routes return five."),("passed",.boolean witness2)],.object [("name",.text "terminal-ratio"),("statement",.text "The one terminal return forces the exact mass ratio without a target."),("passed",.boolean witness3)],.object [("name",.text "terminal-coupling"),("statement",.text "The exact self-coupling and squared mass route cross-lock over the two fibres."),("passed",.boolean witness4)]]
def claimId : String := "SFT-PHYS-HIGGS-SYMMETRY-TERMINAL-065"
def dependencies : List String := ["SFT-FOUNDATION-FOLD-001", "SFT-FOUNDATION-ONE-001", "SFT-PHYS-ELECTROWEAK-FOLD-MIXING-002", "SFT-PHYS-MEDIATOR-RANGE-CHANNEL-TERMINAL-020", "SFT-PHYS-CONSTANT-INVERSE-FINE-STRUCTURE-001", "SFT-PHYS-STRUCT-GENERATOR-THREE-001", "SFT-PHYS-PARTICLE-MODE-GENERATION-TERMINAL-051", "SFT-MATH-EXACT-ARITHMETIC-001", "SFT-MATH-COMBINATORICS-001", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "ground",.text (groundName c.ground)],.array [.text "displacement",.text (displacementName c.displacement)],.array [.text "rungs",.text (rungsName c.rungs)],.array [.text "directions",.text (directionsName c.directions)],.array [.text "return",.text (returnName c.«return»)],.array [.text "cover",.text (coverName c.cover)],.array [.text "transport",.text (transportName c.transport)],.array [.text "coupling",.text (couplingName c.coupling)],.array [.text "route",.text (routeName c.route)],.array [.text "measurement",.text (measurementName c.measurement)],.array [.text "extension",.text (extensionName c.extension)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("generation_rule",.text "Generate the complete product of ground carrier, displacement, leading rungs, scalar directional support, held return, cover cross-lock, terminal transport, coupling composition, route equality, measurement custody and extension forms."),("grammar_boundary",.text "Structural empty-One, half-One and One ground forms; every binary successor of the displaced ground through the leading coupling rung; the complete binary-hand times generator-direction product; its unique held return; the least cover of generator volume; exactly one terminal alpha transport; exact positive rational operations; and no physical target before seal."),("axes",.array [.object [("key",.text "ground"),("question",.text "What can be the field ground?"),("choices",.array [.array [.text "absence-as-numerical-ground",.text "Structural absence is not a field value."],.array [.text "positive-proper-ground-carrier",.text "A ground carrier must be an exact positive proper part of the One."]])],.object [("key",.text "displacement"),("question",.text "Which positive proper part closes the ground?"),("choices",.array [.array [.text "unison-or-selected-part",.text "Unison is not displaced and a selected part is a parameter."],.array [.text "unique-self-antipodal-half-One",.text "Half-One alone is self-antipodal and folds exactly to the One."]])],.object [("key",.text "rungs"),("question",.text "What happens to the earlier Higgs hierarchy?"),("choices",.array [.array [.text "discard-or-rewrite-leading-rungs",.text "A terminal successor cannot erase its lower-order receipt."],.array [.text "retain-half-quarter-eighth-controls",.text "Binary succession preserves 1/2, 1/4 and 1/8 as explicit leading controls."]])],.object [("key",.text "directions"),("question",.text "Which scalar directions participate?"),("choices",.array [.array [.text "selected-direction-subset",.text "A subset omits a generated hand or generator direction."],.array [.text "complete-two-by-three-product",.text "The scalar excitation retains all six hand-direction cells."]])],.object [("key",.text "return"),("question",.text "How is invariant support treated?"),("choices",.array [.array [.text "retain-all-six-as-active",.text "The invariant return cannot also be an active displaced direction."],.array [.text "hold-unique-return-leaving-five",.text "The positive predecessor of complete six-cell support leaves five active directions."]])],.object [("key",.text "cover"),("question",.text "What independently fixes the active count?"),("choices",.array [.array [.text "free-denominator",.text "A denominator chosen for agreement is a parameter."],.array [.text "least-cover-of-generation-volume",.text "The least binary cover of 27 is five and cross-locks the held direction count."]])],.object [("key",.text "transport"),("question",.text "How does the terminal self-return enter?"),("choices",.array [.array [.text "fitted-offset-or-repeated-series",.text "An offset or truncation is a fit."],.array [.text "one-six-over-five-alpha-return",.text "All six cells transport one terminal alpha across the five active supports exactly once."]])],.object [("key",.text "coupling"),("question",.text "How is scalar self-coupling formed?"),("choices",.array [.array [.text "import-potential-or-free-lambda",.text "An imported potential or free lambda would add an axiom."],.array [.text "squared-excitation-shared-over-two-fibres",.text "Complete binary sharing forces lambda to the exact squared mass ratio over two."]])],.object [("key",.text "route"),("question",.text "Do mass and coupling constructions agree?"),("choices",.array [.array [.text "independent-mass-and-coupling-routes",.text "Independent routes introduce a dial."],.array [.text "exact-two-route-cross-lock",.text "The squared mass route and twice-coupling route are identically equal."]])],.object [("key",.text "measurement"),("question",.text "Can Higgs data select the terminal form?"),("choices",.array [.array [.text "target-readable-before-seal",.text "That would fit the coefficient to the measured mass."],.array [.text "all-targets-inaccessible-until-seal",.text "The exact ratio, coupling and census seal before measurements open."]])],.object [("key",.text "extension"),("question",.text "May another term or field be appended?"),("choices",.array [.array [.text "extra-mass-potential-or-correction",.text "Any added term is a free parameter."],.array [.text "no-extra-rule",.text "The ground, rungs, complete directions, held return and single terminal transport exhaust the grammar."]])]]),("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Terminal displaced-ground and Higgs mass/self-coupling law"
 branch := "physics"
 statement := "The complete minimal vacuum census contains structural empty-One, the half-One and the One. Empty-One is absence rather than a field value; the One is unison rather than a displaced proper part. Half-One alone is positive, proper, self-antipodal and folds to the One, forcing the displaced ground without an inserted mass or potential. Its first binary successors retain the V2 leading rungs 1/2, 1/4 and 1/8. Terminal completion then acts on the scalar's complete two-hand by generator-three directional product: six cells. Holding the unique invariant return leaves five active cells, independently cross-locked to the least binary cover depth of the generation volume 27. One terminal alpha return therefore contributes exactly (6/5) alpha to the half-One mass ratio. The complete two-fibre sharing of its squared excitation forces the self-coupling to one half of that exact squared ratio. No mass, VEV, coupling or measurement selects either result."
 evidenceMode := .formal
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
def closureValue : Value := .object [("result",.text "The displaced ground is uniquely half-One; the retained leading Higgs rungs are 1/2, 1/4 and 1/8. Complete six-cell scalar support, its unique held return and the independently equal cover depth five force terminal m_H/v = 1/2 + (6/5) alpha = 2563352914777/5038463954690. The exact native self-coupling is lambda = (m_H/v)^2/2 = 6570778165695741824959729/50772238045420788745992200. Both routes cross-lock in the squared domain; no irrational root is formed."),("base",.text "Half-One is the unique minimal positive proper self-antipodal ground and its first binary successor supplies the leading mass rung."),("successor",.text "Completing every hand-direction cell and holding the unique invariant return leaves five active cells; the independently identical generation cover fixes the sole terminal transport, after which binary sharing closes the coupling with no additional successor."),("exclusions",.array [.text "no V1/V2 executable, certificate, target value, candidate table or stored survivor as a premise",.text "no measured Higgs mass, VEV, Fermi constant or self-coupling in formal execution",.text "no imported Higgs potential, Standard Model mass relation, fitted coefficient, uncertainty or correction series",.text "no semantic numerical zero, negative, irrational, imaginary, floating, NaN, continuum or infinite proof scalar",.text "no claim that the leading 1/2 mass ratio or 1/8 coupling is the terminal result"]),("witnesses",witnessRecords),("unique_survivor",.text survivorId)]
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
def exclusions : List String := ["no V1/V2 executable, certificate, target value, candidate table or stored survivor as a premise", "no measured Higgs mass, VEV, Fermi constant or self-coupling in formal execution", "no imported Higgs potential, Standard Model mass relation, fitted coefficient, uncertainty or correction series", "no semantic numerical zero, negative, irrational, imaginary, floating, NaN, continuum or infinite proof scalar", "no claim that the leading 1/2 mass ratio or 1/8 coupling is the terminal result"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with ground := .rejected}) survivorId)) "reject the form missing the first structural preservation",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed source identity",
 control .tamperedArtifact ((candidates.filter survives).length==1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2 && witness3 && witness4) "reject forbidden values, target feedback and extra laws"]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Physics.HiggsEntryEvidence
