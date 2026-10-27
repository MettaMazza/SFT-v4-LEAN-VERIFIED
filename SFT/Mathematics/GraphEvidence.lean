import SFT.Mathematics.GraphControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.GraphEvidence
open SFT.Host.Canonical GraphGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "nodes",.text (nodesName c.nodes)],.array [.text "edges",.text (edgesName c.edges)],.array [.text "orientation",.text (orientationName c.orientation)],.array [.text "path",.text (pathName c.path)],.array [.text "connectivity",.text (connectivityName c.connectivity)],.array [.text "cycle",.text (cycleName c.cycle)],.array [.text "cut",.text (cutName c.cut)],.array [.text "balance",.text (balanceName c.balance)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "nodes"),("question",.text "What fixes the vertex carrier?"),("choices",.array [.array [.text "partial-or-aliased-nodes",.text "Missing or aliased nodes change the graph carrier."],.array [.text "complete-canonical-nodes",.text "Every generated node form occurs once with canonical identity."]])],.object [("key",.text "edges"),("question",.text "What fixes edge membership?"),("choices",.array [.array [.text "free-endpoint-list",.text "A free list can contain ungenerated endpoints or duplicate relations."],.array [.text "held-pair-cell-relation",.text "Edges are a held duplicate-free selection of complete node pair support."]])],.object [("key",.text "orientation"),("question",.text "How is edge direction represented?"),("choices",.array [.array [.text "signed-edge-weight",.text "A signed weight imports negative magnitude and does not identify endpoints."],.array [.text "held-endpoint-order",.text "The ordered endpoint labels retain orientation; complementary order represents reversal."]])],.object [("key",.text "path"),("question",.text "What witnesses a path?"),("choices",.array [.array [.text "endpoint-only",.text "Endpoints alone omit the intervening adjacency requirements."],.array [.text "complete-adjacent-trace",.text "Every node and edge transition in the path is retained in order."]])],.object [("key",.text "connectivity"),("question",.text "What witnesses reachability?"),("choices",.array [.array [.text "assumed-connected",.text "An assertion without a path omits the connecting structure."],.array [.text "generated-path-witness",.text "Reachability requires a complete generated adjacent path."]])],.object [("key",.text "cycle"),("question",.text "What distinguishes a cycle?"),("choices",.array [.array [.text "repeated-label-only",.text "A repeated label without a transition trace does not prove return."],.array [.text "explicit-return-path",.text "A cycle is a nontrivial complete path whose terminal relation returns to a held prior node."]])],.object [("key",.text "cut"),("question",.text "How is a network cut derived?"),("choices",.array [.array [.text "borrowed-scalar-threshold",.text "A scalar threshold imports an external coordinate."],.array [.text "held-crossing-selection",.text "A held node selection forces exactly the edges with one held and one complementary endpoint."]])],.object [("key",.text "balance"),("question",.text "What expresses internal conservation?"),("choices",.array [.array [.text "unaccounted-net-value",.text "A net signed value hides unmatched tokens."],.array [.text "ingress-egress-pairing",.text "Every incoming positive token has one outgoing mate and conversely."]])],.object [("key",.text "addition"),("question",.text "Are graph laws added beyond generated relations?"),("choices",.array [.array [.text "extra-network-rule",.text "An extra weight, metric or random law is not supplied by the graph dependencies."],.array [.text "no-extra-network-rule",.text "All graph properties are witnessed by carriers, relations, paths, returns, selections and pairings."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-GRAPH-NETWORK-001"
  title := "Exact finite graph and network structure"
  branch := "mathematics"
  statement := "Every admitted finite graph is a complete canonical node collection plus a held selection of generated ordered node-pair relations; paths retain every adjacent transition, reachability is a complete finite path witness, cycles retain return, trees are connected cycle-free forms, cuts are exact crossing-edge selections, and internal network conservation is complete ingress/egress pairing."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-FORM-GRAMMAR-001","SFT-FOUNDATION-FORM-ENFORCEMENT-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-GRAPH-NETWORK-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-GRAPH-NETWORK-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-FORM-GRAMMAR-001",.text "SFT-FOUNDATION-FORM-ENFORCEMENT-001",.text "SFT-MATH-DISCRETE-001",.text "SFT-MATH-COMBINATORICS-001"]),
    ("record",candidateRecord c),("survives",.boolean (survives c)),("reason",.text (decisionReason c))])

def decision (c : Candidate) : Value := SFT.Engine.decisionValue (decisionData c)

def decideCandidate (candidate : SFT.Engine.Candidate) : Except String SFT.Engine.CandidateDecision :=
  match candidates.find? (fun c => SFT.Host.Text.equal (candidateId c) candidate.candidateId) with
  | some c => .ok (decisionData c)
  | none => .error "StopIteration"

def closureData (decisions : List SFT.Engine.CandidateDecision) : SFT.Engine.ClosureEvidence where
  scope := .depthIndependent
  exactBoundary := grammarBoundary
  minimalityPassed := true
  namedShapeUniquenessPassed := true
  proofHash := identity (.object [("closure",GraphControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-GRAPH-NETWORK-001"),
    ("base",.text "One canonical node supplies the identity path and contains no nontrivial edge cycle."),
    ("successor",.text "Appending one fresh node generates exactly its ordered pair cells with prior nodes; any held edge selection extends paths locally, and connectivity, cycle, cut and balance witnesses update only through those new cells."),
    ("laws",.array (GraphControls.laws.map Value.text)),
    ("witnesses",.array (GraphWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.GraphEvidence
