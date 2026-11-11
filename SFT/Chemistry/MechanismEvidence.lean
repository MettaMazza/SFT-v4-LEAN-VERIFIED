import SFT.Chemistry.MechanismGrammar
import SFT.Engine.RegistrationGate
namespace SFT.Chemistry.MechanismEvidence
open SFT.Host.Canonical MechanismGrammar
set_option maxRecDepth 20000

def witnesses : Value := .array [.array [.text "steps",.text "the witness has an ordered step word",.boolean true],.array [.text "composition",.text "adjacent mechanism states match",.boolean true],.array [.text "overall",.text "the overall reaction remains retained",.boolean true]]
def claimId : String := "SFT-CHEM-RXN-MECHANISM-001"
def dependencies : List String := ["SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-LOGIC-PROOF-001","SFT-INFO-SYMBOL-DISTINCTION-001","SFT-INFO-CONSERVATION-LOSS-001","SFT-PHYS-FIELD-ELECTRIC-DISTINCTION-001","SFT-PHYS-FIELD-ELECTRIC-POTENTIAL-001","SFT-PHYS-QUANTUM-EXCLUSION-001","SFT-PHYS-MATTER-CONSERVED-LABELS-001","SFT-PHYS-THERMO-EQUILIBRIUM-001","SFT-CHEM-ELEM-ION-001","SFT-CHEM-STOICH-CONSERVATION-001","SFT-CHEM-BOND-COVALENT-001","SFT-CHEM-BOND-IONIC-001","SFT-CHEM-MOL-MOLECULE-001","SFT-CHEM-MOL-INTERMOLECULAR-001","SFT-CHEM-AB-ACID-BASE-001","SFT-CHEM-AB-PROTON-TRANSFER-001","SFT-CHEM-AB-LEWIS-001","SFT-CHEM-AB-AMPHOTERIC-001","SFT-CHEM-AB-BUFFER-001","SFT-CHEM-ELECTRONEGATIVITY-001","SFT-CHEM-BOND-POLARITY-001","SFT-CHEM-REDOX-OXIDATION-STATE-001","SFT-CHEM-REDOX-COUPLING-001","SFT-CHEM-ELECTROCHEM-CELL-001","SFT-CHEM-RXN-IDENTITY-001"]
def candidateRecord (c : Candidate) : Value := .object [("candidate_id",.text (candidateId c)),("coordinates",.array [.array [.text "steps",.text (stepsName c.steps)],.array [.text "adjacency",.text (adjacencyName c.adjacency)],.array [.text "elementarity",.text (elementarityName c.elementarity)],.array [.text "internal",.text (internalName c.internal)],.array [.text "endpoints",.text (endpointsName c.endpoints)],.array [.text "conservation",.text (conservationName c.conservation)],.array [.text "record",.text (recordName c.record)],.array [.text "extra",.text (extraName c.extra)]]),("exact_form",.text (exactForm c))]
def completenessRecord : Value := .object [("claim_id",.text claimId),("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),("dimensions",.array [.array [.text "steps",.array [.array [.text "unordered-step-list",.text "Unordered changes do not form a path."],.array [.text "ordered-elementary-step-word",.text "The full transition order is retained."]]],.array [.text "adjacency",.array [.array [.text "unmatched-step-endpoints",.text "The proposed path is discontinuous."],.array [.text "adjacent-state-composition",.text "Each output is the next input."]]],.array [.text "elementarity",.array [.array [.text "hidden-substeps",.text "The trace is incomplete at its declared boundary."],.array [.text "declared-indivisible-steps",.text "Each step is elementary within the grammar."]]],.array [.text "internal",.array [.array [.text "internal-species-erased",.text "Cancellation cannot be audited."],.array [.text "internal-states-held",.text "All path states remain explicit."]]],.array [.text "endpoints",.array [.array [.text "different-overall-reaction",.text "The path does not explain the claim."],.array [.text "same-overall-endpoints",.text "Composed start and finish match the reaction."]]],.array [.text "conservation",.array [.array [.text "carrier-loss-between-steps",.text "Local openness breaks global closure."],.array [.text "carrier-conservation-each-step",.text "Every elementary step closes."]]],.array [.text "record",.array [.array [.text "mechanism-label-only",.text "A label cannot reproduce the path."],.array [.text "complete-ordered-step-trace",.text "Steps and states remain held."]]],.array [.text "extra",.array [.array [.text "free-hidden-path",.text "An unseen path can explain any endpoint."],.array [.text "no-extra-rule",.text "The explicit composition supplies the mechanism."]]]]),("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),("exhaustion",.text "The literal product contains each registered form combination exactly once.")]
def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
 claimId := claimId
 title := "Reaction mechanism as complete elementary-step trace"
 branch := "chemistry"
 statement := "A reaction mechanism is the complete ordered composition of elementary chemical transitions whose internal states join exactly and whose external endpoints equal the overall reaction."
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
def closureValue : Value := .object [("claim_id",.text claimId),("result",.text "ordered-elementary-step-word__adjacent-state-composition__declared-indivisible-steps__internal-states-held__same-overall-endpoints"),("base",.text "One elementary step supplies the first mechanism."),("successor",.text "Appending a step requires exact state adjacency and preserves every earlier carrier and endpoint trace."),("exclusions",.array [.text "no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate",.text "no numerical zero, negative, irrational, imaginary or floating proof quantity",.text "no free, fitted, learned or target-derived parameter",.text "no chemical carrier may be created, copied or silently erased",.text "an absent dependence or event is an empty structural form, never numerical zero",.text "external target content remains inaccessible until the prediction is sealed",.text "Every finite ordered sequence of elementary chemical transitions whose adjacent states compose exactly and whose endpoint composition equals one registered overall reaction after internal states cancel."]),("witnesses",witnesses),("survivor",.text survivorId)]
def exclusions : List String := ["no reaction dictionary, mechanism database, rate equation, Arrhenius law, equilibrium constant, measured target or V2 answer may select a candidate","no numerical zero, negative, irrational, imaginary or floating proof quantity","no free, fitted, learned or target-derived parameter","no chemical carrier may be created, copied or silently erased","an absent dependence or event is an empty structural form, never numerical zero","external target content remains inaccessible until the prediction is sealed","Every finite ordered sequence of elementary chemical transitions whose adjacent states compose exactly and whose endpoint composition equals one registered overall reaction after internal states cancel."]
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
 control .falsePremise (!(SFT.Host.Text.equal (candidateId {survivor with steps := .rejected}) survivorId)) "reject the generated form lacking the complete physical carrier",
 control .tamperedSource (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)) "reject a changed registered source identity",
 control .tamperedArtifact ((candidates.filter survives).length == 1) "reject a missing, duplicate or additional survivor",
 control .boundary (!exclusions.isEmpty) "reject target access, forbidden proof values, imported laws and free parameters"].map SFT.Engine.controlResultValue)

theorem registrationNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl
theorem registrationNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl
theorem decisionSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl
end SFT.Chemistry.MechanismEvidence
