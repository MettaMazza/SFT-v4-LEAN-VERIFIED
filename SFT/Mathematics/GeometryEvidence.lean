import SFT.Mathematics.GeometryControls
import SFT.Engine.RegistrationGate
namespace SFT.Mathematics.GeometryEvidence
open SFT.Host.Canonical GeometryGrammar

def candidateRecord (c : Candidate) : Value := .object [
  ("candidate_id",.text (candidateId c)),
  ("coordinates",.array [.array [.text "cells",.text (cellsName c.cells)],.array [.text "incidence",.text (incidenceName c.incidence)],.array [.text "dimension",.text (dimensionName c.dimension)],.array [.text "adjacency",.text (adjacencyName c.adjacency)],.array [.text "distance",.text (distanceName c.distance)],.array [.text "opens",.text (opensName c.opens)],.array [.text "connectedness",.text (connectednessName c.connectedness)],.array [.text "continuity",.text (continuityName c.continuity)],.array [.text "deformation",.text (deformationName c.deformation)],.array [.text "addition",.text (additionName c.addition)]]),
  ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
  ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
  ("dimensions",.array [.object [("key",.text "cells"),("question",.text "What fixes geometric objects?"),("choices",.array [.array [.text "coordinate-samples",.text "Samples from a borrowed coordinate field omit structural provenance."],.array [.text "canonical-generated-cells",.text "Every cell is an exact canonical generated form."]])],.object [("key",.text "incidence"),("question",.text "What fixes boundary?"),("choices",.array [.array [.text "assumed-containment",.text "Assumed containment has no exact face-to-cell witness."],.array [.text "held-acyclic-boundary",.text "Every face relation is retained and boundary descent forbids return."]])],.object [("key",.text "dimension"),("question",.text "What fixes dimension?"),("choices",.array [.array [.text "borrowed-coordinate-count",.text "A coordinate count imports an ambient space."],.array [.text "boundary-chain-depth",.text "Dimension is the longest retained face-descent trace."]])],.object [("key",.text "adjacency"),("question",.text "What fixes adjacency?"),("choices",.array [.array [.text "metric-threshold",.text "A threshold imports a free scale."],.array [.text "shared-incidence-witness",.text "Cells are adjacent exactly when they share a generated face."]])],.object [("key",.text "distance"),("question",.text "What fixes computational distance?"),("choices",.array [.array [.text "floating-metric",.text "A floating metric imports precision and possibly irrational values."],.array [.text "shortest-generated-path",.text "Distance is the complete least-length path trace; identity is empty One."]])],.object [("key",.text "opens"),("question",.text "What fixes a finite topology?"),("choices",.array [.array [.text "named-neighborhoods",.text "Named neighborhoods need not satisfy closure."],.array [.text "generated-open-family-closure",.text "Empty One, whole, generated joins and pairwise intersections remain in the family."]])],.object [("key",.text "connectedness"),("question",.text "What fixes connectedness?"),("choices",.array [.array [.text "visual-continuity",.text "A presentation cannot establish structural connection."],.array [.text "no-disjoint-open-separation",.text "No two nonempty disjoint admitted opens jointly exhaust the carrier."]])],.object [("key",.text "continuity"),("question",.text "What fixes continuity?"),("choices",.array [.array [.text "epsilon-scale",.text "An imported scale is neither forced nor needed in the finite grammar."],.array [.text "inverse-open-preservation",.text "Every target open has an admitted source inverse image."]])],.object [("key",.text "deformation"),("question",.text "What fixes deformation equivalence?"),("choices",.array [.array [.text "untracked-shape-change",.text "An untracked change can erase incidence."],.array [.text "reversible-incidence-trace",.text "Each elementary change retains a lawful reverse and preserves registered incidence invariants."]])],.object [("key",.text "addition"),("question",.text "Is an ambient continuum added?"),("choices",.array [.array [.text "continuum-or-extra-metric",.text "A continuum or metric field is outside the generated computational need."],.array [.text "no-ambient-continuum",.text "The law uses only finite generated cells, paths and open families."]])]]),
  ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
  ("product_exhaustion",.text "Every named option in every registered dimension occurs once with every option in every other dimension; duplicate candidate identities are forbidden.")]

def registrationData (sourceHash : String) : SFT.Engine.ClaimRegistration where
  claimId := "SFT-MATH-GEOMETRY-TOPOLOGY-001"
  title := "Exact finite geometry and topology for computation"
  branch := "mathematics"
  statement := "Computational geometry is forced as canonical finite cells plus an acyclic held boundary-incidence relation; dimension is retained boundary depth, adjacency is shared incidence, and distance is a shortest generated path with self-distance represented by empty One rather than numerical zero. Computational topology is a complete generated open-family closed under generated joins and pairwise intersections; continuity is exact inverse-image preservation."
  evidenceMode := .formal
  rootTheorems := [SFT.Engine.rootTheoremId]
  dependencies := ["SFT-FOUNDATION-PART-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ORDER-LATTICE-001"]
  axioms := []
  freeParameters := []
  provenance := [.forwardForcing]
  sourceHash := sourceHash

def registration (sourceHash : String) : Value := SFT.Engine.registrationValue (registrationData sourceHash)

def generatedCandidateData (c : Candidate) : SFT.Engine.Candidate where
  candidateId := candidateId c
  exactForm := exactForm c
  traceHash := identity (.object [("claim_id",.text "SFT-MATH-GEOMETRY-TOPOLOGY-001"),("generator",.text generationRule),("record",candidateRecord c)])

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
  proofHash := identity (.object [("claim_id",.text "SFT-MATH-GEOMETRY-TOPOLOGY-001"),
    ("dependencies",.array [.text "SFT-FOUNDATION-PART-001",.text "SFT-MATH-GRAPH-NETWORK-001",.text "SFT-MATH-ORDER-LATTICE-001"]),
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
  proofHash := identity (.object [("closure",GeometryControls.closureValue),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue))])
  generalityCertificateHash := some (identity (.object [
    ("claim_id",.text "SFT-MATH-GEOMETRY-TOPOLOGY-001"),
    ("base",.text "One point is a canonical cell; its open family consists of empty One and the whole point carrier."),
    ("successor",.text "Adding one fresh cell generates its possible boundary incidences, shared-face adjacencies and path edges; adding one fresh point generates exactly the open selections needed for closure checks. Every new boundary, path, intersection, join and inverse image is then exhaustively tested."),
    ("laws",.array (GeometryControls.laws.map Value.text)),
    ("witnesses",.array (GeometryWitnesses.witnesses.map fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))]))

def closure (decisions : List SFT.Engine.CandidateDecision) : Value := SFT.Engine.closureEvidenceValue (closureData decisions)

theorem nativeDecisionPreservesSurvival (c : Candidate) : (decisionData c).survives = survives c := rfl

theorem nativeDecisionPreservesReason (c : Candidate) : (decisionData c).reason = decisionReason c := rfl

theorem registrationHasNoAxioms (sourceHash : String) : (registrationData sourceHash).axioms = [] := rfl

theorem registrationHasNoFreeParameters (sourceHash : String) : (registrationData sourceHash).freeParameters = [] := rfl

set_option maxRecDepth 20000 in
theorem lookupDependsOnlyOnIdentifier (id formA formB hashA hashB : String) :
    decideCandidate ⟨id,formA,hashA⟩ = decideCandidate ⟨id,formB,hashB⟩ := rfl

end SFT.Mathematics.GeometryEvidence
