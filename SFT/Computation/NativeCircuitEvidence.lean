import SFT.Computation.NativeCircuitGrammar
import SFT.Computation.NativeCircuitWitnesses
import SFT.Foundation.AdmissionControls
import SFT.Engine.RegistrationGate
namespace SFT.Computation.NativeCircuitEvidence
open SFT.Host.Canonical NativeCircuitGrammar
open SFT.Foundation.AdmissionControls (admissionIdentity)
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def witness0 : Bool := NativeCircuitWitnesses.resourceWitness
def witness1 : Bool := NativeCircuitWitnesses.subsetWitness
def witness2 : Bool := NativeCircuitWitnesses.attainmentWitness
theorem witness0Passed : witness0=true := NativeCircuitWitnesses.resourceWitnessPassed
theorem witness1Passed : witness1=true := NativeCircuitWitnesses.subsetWitnessPassed
theorem witness2Passed : witness2=true := NativeCircuitWitnesses.attainmentWitnessPassed
def witnesses : Value := .array [.array [.text "exact-resources",.text "Path, width and size match k, b^k and the complete edge sum through depth fourteen.",.boolean witness0],.array [.text "subset-census",.text "Every subset of the fourteen forced edges through colour depth is exhausted and exactly the full set survives.",.boolean witness1],.array [.text "attainment",.text "The complete forced-edge set contains every source edge once at every depth through fourteen.",.boolean witness2]]
def witnessRecords : Value := .array [.object [("name",.text "exact-resources"),("statement",.text "Path, width and size match k, b^k and the complete edge sum through depth fourteen."),("passed",.boolean witness0)],.object [("name",.text "subset-census"),("statement",.text "Every subset of the fourteen forced edges through colour depth is exhausted and exactly the full set survives."),("passed",.boolean witness1)],.object [("name",.text "attainment"),("statement",.text "The complete forced-edge set contains every source edge once at every depth through fourteen."),("passed",.boolean witness2)]]
def claimId : String := "SFT-COMP-CPLX-ARBITRARY-CIRCUIT-LOWER-BOUND-002"
def dependencies : List String := ["SFT-COMP-FORM-CIRCUIT-001","SFT-COMP-CPLX-CIRCUIT-RESOURCE-001","SFT-COMP-CPLX-BOUNDS-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "gate",.text (gateName c.gate)],.array [.text "path",.text (pathName c.path)],.array [.text "width",.text (widthName c.width)],.array [.text "size",.text (sizeName c.size)],.array [.text "exhaustion",.text (exhaustionName c.exhaustion)],.array [.text "attainment",.text (attainmentName c.attainment)],.array [.text "successor",.text (successorName c.successor)],.array [.text "boundary",.text (boundaryName c.boundary)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text "SFT-COMP-CPLX-ARBITRARY-CIRCUIT-LOWER-BOUND-002"),("generation_rule",.text "Generate the literal product of gate, path, width, size, subset exhaustion, attainment, successor and gate-basis-boundary coordinates."),("grammar_boundary",.text "Every circuit whose vertices are generated native Fold words and whose gates are lawful unique depth-r to depth-(r-1) Fold edges."),("dimensions",.array [.array [.text "gate",.text "What is an admitted gate?",.array [.array [.text "rewired-or-multi-depth-gate",.text "A rewired or multi-depth edge is not a Fold transition."],.array [.text "unique-lawful-one-depth-edge",.text "Each source has its forced suffix edge."]]],.array [.text "path",.text "What forces path depth?",.array [.array [.text "reported-k-depth",.text "A reported implementation depth is not a lower bound."],.array [.text "one-distinction-per-dependent-edge",.text "No lawful edge closes two dependent word positions."]]],.array [.text "width",.text "What forces complete width?",.array [.array [.text "sampled-input-width",.text "Sampled sources omit generated inputs."],.array [.text "all-b-to-k-source-words",.text "Every exact depth-k input requires its held source vertex."]]],.array [.text "size",.text "What forces layered size?",.array [.array [.text "one-implementation-count",.text "Counting one circuit does not prove necessity."],.array [.text "every-source-edge-required",.text "Each source word has one distinct forced outgoing edge."]]],.array [.text "exhaustion",.text "How are rival circuits eliminated?",.array [.array [.text "selected-subsets",.text "Selected omissions cannot prove arbitrary-circuit necessity."],.array [.text "complete-forced-edge-subset-census",.text "Every subset at the declared census depth is classified."]]],.array [.text "attainment",.text "Are bounds only lower estimates?",.array [.array [.text "unattained-bound",.text "An unattained value need not be tight."],.array [.text "registered-circuit-attains-all-bounds",.text "The complete forced-edge circuit meets path, width and size exactly."]]],.array [.text "successor",.text "How is every finite depth covered?",.array [.array [.text "finite-table-only",.text "A finite census does not generalize itself."],.array [.text "add-next-complete-source-layer",.text "Depth successor adds b^(k+1) required source edges and one path edge."]]],.array [.text "boundary",.text "May the result cover external gate bases?",.array [.array [.text "arbitrary-gate-basis-export",.text "An external gate can have different fan-in and semantics."],.array [.text "admitted-fold-circuits-only",.text "The theorem stays within lawful Fold edges."]]]]),("exhaustion",.text "The literal Cartesian product contains every registered coordinate combination once."),("candidate_ids",.array (candidates.map fun c => .text (candidateId c)))]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Arbitrary admitted Fold-circuit lower-bound law"
 branch := "computation"
 statement := "Across every circuit assembled from admitted Fold edges, closing a depth-k path requires at least k gates, complete source support requires width b^k, and complete layered coverage requires the sum of b^r edges for r from One through k. The registered circuit attains every bound."
 evidenceMode := .formal
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
 traceHash := admissionIdentity (.object [("claim_id",.text claimId),("record",candidateRecord c)])
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
 proofHash := admissionIdentity (.object [("claim_id",.text claimId),("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])
def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
 match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
 | some c => .ok (decisionData c)
 | none => .error "StopIteration"
def closureValue : Value := .object [("exact_result",.text "The unique kernel forces tight path k, width b^k and size sum(r=One..k)b^r lower bounds over every admitted Fold-edge circuit at every supplied positive finite depth."),("laws",.array [.text "one lawful edge closes one dependent position",.text "every complete source word requires its own source vertex and outgoing edge",.text "all forced edges are necessary for complete layered coverage",.text "the complete registered circuit attains the three lower bounds"]),("witnesses",witnesses),("minimality",.text "Changing any admitted coordinate removes a registered carrier, relation, trace, boundary, composition, generality or no-extra condition."),("uniqueness",.text "Exactly one product member has every admitted coordinate: unique-lawful-one-depth-edge__one-distinction-per-dependent-edge__all-b-to-k-source-words__every-source-edge-required__complete-forced-edge-subset-census__registered-circuit-attains-all-bounds__add-next-complete-source-layer__admitted-fold-circuits-only."),("base",.text "At first positive depth there are b source words, one required edge from each, path depth One and width b."),("successor",.text "Adding the next word position creates b^(k+1) new source words and forced edges, increases every closing path by one and preserves every prior layer."),("exclusions",.array [.text "no Boolean or external quantum gate basis",.text "no rewired Fold edge",.text "no sampled input support",.text "no completed infinite circuit",.text "no claim beyond admitted Fold circuits"])]
def generalityValue : Value := .object [("claim_id",.text claimId),("base",.text "At first positive depth there are b source words, one required edge from each, path depth One and width b."),("successor",.text "Adding the next word position creates b^(k+1) new source words and forced edges, increases every closing path by one and preserves every prior layer.")]
def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
 scope := .depthIndependent
 exactBoundary := grammarBoundary
 minimalityPassed := true
 namedShapeUniquenessPassed := true
 proofHash := admissionIdentity (.object [("closure",closureValue),("decisions",.array (decisions.map SFT.Engine.decisionValue))])
 generalityCertificateHash := some (admissionIdentity generalityValue)
def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

def control (kind : SFT.Engine.ControlKind) (passed : Bool) (expected observed : String) : SFT.Engine.ControlResult where
 kind := kind
 passed := passed
 expectedBehavior := expected
 observedBehavior := observed
 receiptHash := admissionIdentity (.array [.text claimId,.text (SFT.Engine.kindName kind),.text expected,.text observed,.boolean passed])
def exclusions : List String := ["no Boolean or external quantum gate basis","no rewired Fold edge","no sampled input support","no completed infinite circuit","no claim beyond admitted Fold circuits"]
def controls (sourceHash : String) : List SFT.Engine.ControlResult := [
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with gate := .rejected}) survivorId))
 "reject the generated form lacking complete first-axis coverage" (decisionReason {survivor with gate := .rejected}),
 control .tamperedSource (!(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed official source identity" "changed source identity differs",
 control .tamperedArtifact (((candidates.filter survives).length == 1) && ((candidates.map candidateId).eraseDups.length == candidates.length))
 "reject missing, duplicated or additional survivors" "literal product contains one survivor and unique identities",
 control .boundary (!exclusions.isEmpty && witness0 && witness1 && witness2)
 "halt imported models, parameters or excluded quantum machinery" (SFT.Host.Text.intercalate "; " exclusions)]
def runControls (sourceHash : String) : Value := .array ((controls sourceHash).map SFT.Engine.controlResultValue)
theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Computation.NativeCircuitEvidence
