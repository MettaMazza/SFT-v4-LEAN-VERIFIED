import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.NetworkGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Nodes where
  | rejected | admitted

def nodesName : Nodes → String
  | .rejected => "anonymous-node-count"
  | .admitted => "finite-molecular-node-set"

inductive Edges where
  | rejected | admitted

def edgesName : Edges → String
  | .rejected => "implicit-relatedness"
  | .admitted => "registered-interaction-edges"

inductive Connectivity where
  | rejected | admitted

def connectivityName : Connectivity → String
  | .rejected => "disconnected-union-called-one"
  | .admitted => "connected-maximal-component"

inductive Paths where
  | rejected | admitted

def pathsName : Paths → String
  | .rejected => "selected-path-only"
  | .admitted => "complete-reachability-census"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "unbounded-network-name"
  | .admitted => "finite-maximal-boundary"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "network-erases-molecules"
  | .admitted => "node-identities-retained"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "network-answer-only"
  | .admitted => "complete-network-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-connectivity-edge"
  | .admitted => "no-extra-rule"

structure Candidate where
  nodes : Nodes
  edges : Edges
  connectivity : Connectivity
  paths : Paths
  boundary : Boundary
  composition : Composition
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [nodesName c.nodes, edgesName c.edges, connectivityName c.connectivity, pathsName c.paths, boundaryName c.boundary, compositionName c.composition, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "nodes=" (nodesName c.nodes), SFT.Host.Text.append "edges=" (edgesName c.edges), SFT.Host.Text.append "connectivity=" (connectivityName c.connectivity), SFT.Host.Text.append "paths=" (pathsName c.paths), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "finite-molecular-node-set__registered-interaction-edges__connected-maximal-component__complete-reachability-census__finite-maximal-boundary__node-identities-retained__complete-network-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (nodesName c.nodes) "finite-molecular-node-set" &&
  SFT.Host.Text.equal (edgesName c.edges) "registered-interaction-edges" &&
  SFT.Host.Text.equal (connectivityName c.connectivity) "connected-maximal-component" &&
  SFT.Host.Text.equal (pathsName c.paths) "complete-reachability-census" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "finite-maximal-boundary" &&
  SFT.Host.Text.equal (compositionName c.composition) "node-identities-retained" &&
  SFT.Host.Text.equal (recordName c.record) "complete-network-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (nodesName c.nodes) "finite-molecular-node-set") then "A count cannot recover molecular identities." else
  if !(SFT.Host.Text.equal (edgesName c.edges) "registered-interaction-edges") then "An implicit relation cannot be audited." else
  if !(SFT.Host.Text.equal (connectivityName c.connectivity) "connected-maximal-component") then "Disconnected components are not one connected whole." else
  if !(SFT.Host.Text.equal (pathsName c.paths) "complete-reachability-census") then "One favorable path cannot establish network connectivity." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "finite-maximal-boundary") then "An unbounded name does not enumerate a finite object." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "node-identities-retained") then "Nodes remain chemical carriers, not anonymous points." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-network-trace") then "A connectivity answer cannot reproduce the network." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "Adding an ungenerated edge can force connectedness." else
  "finite-molecular-node-set__registered-interaction-edges__connected-maximal-component__complete-reachability-census__finite-maximal-boundary"

def generationRule : String := "Generate the literal product of the registered molecular-network nodes, edges, connectivity, paths, boundary, composition, record and extension choices."
def grammarBoundary : String := "Every finite generated set of molecular nodes and registered interaction edges whose maximal declared component is connected, with complete node, edge, path and boundary provenance."

def candidates : List Candidate :=
  ([Nodes.rejected,Nodes.admitted]).flatMap fun nodes =>
  ([Edges.rejected,Edges.admitted]).flatMap fun edges =>
  ([Connectivity.rejected,Connectivity.admitted]).flatMap fun connectivity =>
  ([Paths.rejected,Paths.admitted]).flatMap fun paths =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨nodes,edges,connectivity,paths,boundary,composition,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk nodes edges connectivity paths boundary composition record extension =>
    have hnodes : nodes ∈ [Nodes.rejected,Nodes.admitted] := by
      cases nodes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hedges : edges ∈ [Edges.rejected,Edges.admitted] := by
      cases edges <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconnectivity : connectivity ∈ [Connectivity.rejected,Connectivity.admitted] := by
      cases connectivity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpaths : paths ∈ [Paths.rejected,Paths.admitted] := by
      cases paths <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ nodes _ hnodes
    apply CommonRefinement.memFlatMap _ _ edges _ hedges
    apply CommonRefinement.memFlatMap _ _ connectivity _ hconnectivity
    apply CommonRefinement.memFlatMap _ _ paths _ hpaths
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk nodes edges connectivity paths boundary composition record extension =>
    cases nodes <;> cases edges <;> cases connectivity <;> cases paths <;> cases boundary <;> cases composition <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk nodes edges connectivity paths boundary composition record extension =>
    cases nodes <;> cases edges <;> cases connectivity <;> cases paths <;> cases boundary <;> cases composition <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.nodes = .admitted ∧ c.edges = .admitted ∧ c.connectivity = .admitted ∧ c.paths = .admitted ∧ c.boundary = .admitted ∧ c.composition = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk nodes edges connectivity paths boundary composition record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem nodes_rejected_rejected (c : Candidate) (h : c.nodes = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.nodes eq
    rw [h] at field
    cases field

theorem edges_rejected_rejected (c : Candidate) (h : c.edges = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.edges eq
    rw [h] at field
    cases field

theorem connectivity_rejected_rejected (c : Candidate) (h : c.connectivity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.connectivity eq
    rw [h] at field
    cases field

theorem paths_rejected_rejected (c : Candidate) (h : c.paths = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.paths eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.NetworkGrammar
