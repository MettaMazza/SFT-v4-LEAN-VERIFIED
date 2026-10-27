import SFT.Mathematics.GraphWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.GraphGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Nodes where
  | rejected | admitted

def nodesName : Nodes → String
  | .rejected => "partial-or-aliased-nodes"
  | .admitted => "complete-canonical-nodes"

inductive Edges where
  | rejected | admitted

def edgesName : Edges → String
  | .rejected => "free-endpoint-list"
  | .admitted => "held-pair-cell-relation"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "signed-edge-weight"
  | .admitted => "held-endpoint-order"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "endpoint-only"
  | .admitted => "complete-adjacent-trace"

inductive Connectivity where
  | rejected | admitted

def connectivityName : Connectivity → String
  | .rejected => "assumed-connected"
  | .admitted => "generated-path-witness"

inductive Cycle where
  | rejected | admitted

def cycleName : Cycle → String
  | .rejected => "repeated-label-only"
  | .admitted => "explicit-return-path"

inductive Cut where
  | rejected | admitted

def cutName : Cut → String
  | .rejected => "borrowed-scalar-threshold"
  | .admitted => "held-crossing-selection"

inductive Balance where
  | rejected | admitted

def balanceName : Balance → String
  | .rejected => "unaccounted-net-value"
  | .admitted => "ingress-egress-pairing"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-network-rule"
  | .admitted => "no-extra-network-rule"

structure Candidate where
  nodes : Nodes
  edges : Edges
  orientation : Orientation
  path : Path
  connectivity : Connectivity
  cycle : Cycle
  cut : Cut
  balance : Balance
  addition : Addition

def sourceFields (c : Candidate) : List String := [nodesName c.nodes, edgesName c.edges, orientationName c.orientation, pathName c.path, connectivityName c.connectivity, cycleName c.cycle, cutName c.cut, balanceName c.balance, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "nodes=" (nodesName c.nodes), SFT.Host.Text.append "edges=" (edgesName c.edges), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "connectivity=" (connectivityName c.connectivity), SFT.Host.Text.append "cycle=" (cycleName c.cycle), SFT.Host.Text.append "cut=" (cutName c.cut), SFT.Host.Text.append "balance=" (balanceName c.balance), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-nodes__held-pair-cell-relation__held-endpoint-order__complete-adjacent-trace__generated-path-witness__explicit-return-path__held-crossing-selection__ingress-egress-pairing__no-extra-network-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (nodesName c.nodes) "complete-canonical-nodes" &&
  SFT.Host.Text.equal (edgesName c.edges) "held-pair-cell-relation" &&
  SFT.Host.Text.equal (orientationName c.orientation) "held-endpoint-order" &&
  SFT.Host.Text.equal (pathName c.path) "complete-adjacent-trace" &&
  SFT.Host.Text.equal (connectivityName c.connectivity) "generated-path-witness" &&
  SFT.Host.Text.equal (cycleName c.cycle) "explicit-return-path" &&
  SFT.Host.Text.equal (cutName c.cut) "held-crossing-selection" &&
  SFT.Host.Text.equal (balanceName c.balance) "ingress-egress-pairing" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-network-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (nodesName c.nodes) "complete-canonical-nodes") then "Missing or aliased nodes change the graph carrier." else
  if !(SFT.Host.Text.equal (edgesName c.edges) "held-pair-cell-relation") then "A free list can contain ungenerated endpoints or duplicate relations." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "held-endpoint-order") then "A signed weight imports negative magnitude and does not identify endpoints." else
  if !(SFT.Host.Text.equal (pathName c.path) "complete-adjacent-trace") then "Endpoints alone omit the intervening adjacency requirements." else
  if !(SFT.Host.Text.equal (connectivityName c.connectivity) "generated-path-witness") then "An assertion without a path omits the connecting structure." else
  if !(SFT.Host.Text.equal (cycleName c.cycle) "explicit-return-path") then "A repeated label without a transition trace does not prove return." else
  if !(SFT.Host.Text.equal (cutName c.cut) "held-crossing-selection") then "A scalar threshold imports an external coordinate." else
  if !(SFT.Host.Text.equal (balanceName c.balance) "ingress-egress-pairing") then "A net signed value hides unmatched tokens." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-network-rule") then "An extra weight, metric or random law is not supplied by the graph dependencies." else
  "The graph/network kernel is complete canonical nodes with held ordered pair-cell edges, complete adjacent paths, witnessed reachability and return, held crossing cuts, ingress/egress pairing and no extra rule."

def generationRule : String := "Generate the complete product of node coverage, edge provenance, orientation, path trace, connectivity, cycle return, cut support, internal balance and extra-network-rule status."
def grammarBoundary : String := "All finite graphs and networks generated from canonical finite form carriers, held pair-cell relations, complete path traces, return relations and exact positive flow-token pairings."

def candidates : List Candidate :=
  ([Nodes.rejected,Nodes.admitted]).flatMap fun nodes =>
  ([Edges.rejected,Edges.admitted]).flatMap fun edges =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Connectivity.rejected,Connectivity.admitted]).flatMap fun connectivity =>
  ([Cycle.rejected,Cycle.admitted]).flatMap fun cycle =>
  ([Cut.rejected,Cut.admitted]).flatMap fun cut =>
  ([Balance.rejected,Balance.admitted]).flatMap fun balance =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨nodes,edges,orientation,path,connectivity,cycle,cut,balance,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk nodes edges orientation path connectivity cycle cut balance addition =>
    have hnodes : nodes ∈ [Nodes.rejected,Nodes.admitted] := by
      cases nodes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hedges : edges ∈ [Edges.rejected,Edges.admitted] := by
      cases edges <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconnectivity : connectivity ∈ [Connectivity.rejected,Connectivity.admitted] := by
      cases connectivity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcycle : cycle ∈ [Cycle.rejected,Cycle.admitted] := by
      cases cycle <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcut : cut ∈ [Cut.rejected,Cut.admitted] := by
      cases cut <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbalance : balance ∈ [Balance.rejected,Balance.admitted] := by
      cases balance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ nodes _ hnodes
    apply CommonRefinement.memFlatMap _ _ edges _ hedges
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ connectivity _ hconnectivity
    apply CommonRefinement.memFlatMap _ _ cycle _ hcycle
    apply CommonRefinement.memFlatMap _ _ cut _ hcut
    apply CommonRefinement.memFlatMap _ _ balance _ hbalance
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk nodes edges orientation path connectivity cycle cut balance addition =>
    cases nodes <;> cases edges <;> cases orientation <;> cases path <;> cases connectivity <;> cases cycle <;> cases cut <;> cases balance <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk nodes edges orientation path connectivity cycle cut balance addition =>
    cases nodes <;> cases edges <;> cases orientation <;> cases path <;> cases connectivity <;> cases cycle <;> cases cut <;> cases balance <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.nodes = .admitted ∧ c.edges = .admitted ∧ c.orientation = .admitted ∧ c.path = .admitted ∧ c.connectivity = .admitted ∧ c.cycle = .admitted ∧ c.cut = .admitted ∧ c.balance = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk nodes edges orientation path connectivity cycle cut balance addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
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

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
    rw [h] at field
    cases field

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
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

theorem cycle_rejected_rejected (c : Candidate) (h : c.cycle = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cycle eq
    rw [h] at field
    cases field

theorem cut_rejected_rejected (c : Candidate) (h : c.cut = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cut eq
    rw [h] at field
    cases field

theorem balance_rejected_rejected (c : Candidate) (h : c.balance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.balance eq
    rw [h] at field
    cases field

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.Mathematics.GraphGrammar
