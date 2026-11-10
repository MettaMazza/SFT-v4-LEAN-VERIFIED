import SFT.Physics.ThermoKineticTransport
import SFT.Physics.ThermoResponse
import SFT.Mathematics.GraphInduction
namespace SFT.Physics.CollectiveCoarseGrain
open SFT.Mathematics.GraphOperations
open SFT.Mathematics.ProbabilityObservations
open SFT.Mathematics.GeometryTopology
open SFT.InformationScience.EntropyPartition

-- V3 collective_matter_laws.COARSE_GRAIN retains its generated network and
-- declared observation. The partition is computed from that complete support.
structure NetworkObservation where
 nodes : List String
 edges : List Edge
 graph : GeneratedGraph
 generated : makeGraph nodes edges = .ok graph
 scale : String
 observation : Observation
 classes : Partition
 computed : exactPartition graph.nodes observation = .ok classes

def region (n : NetworkObservation) (label : String) := fibre n.graph.nodes n.observation label

def sameMacroClass (n : NetworkObservation) (left right : String) : Prop :=
 ∃ label, left ∈ region n label ∧ right ∈ region n label

def closedAdjacency (n : NetworkObservation) : Prop :=
 ∀ edge, edge ∈ n.graph.edges → sameMacroClass n edge.1 edge.2

theorem completeNetworkRetained (n : NetworkObservation) : n.graph = ⟨n.nodes,n.edges⟩ :=
 graphConstructorResult n.nodes n.edges n.graph n.generated

theorem exactRegion (n : NetworkObservation) (label state : String) :
 state ∈ region n label ↔ state ∈ n.graph.nodes ∧ image n.observation state = some label :=
 fibreMembership n.graph.nodes n.observation label state

theorem sameClassExactly (n : NetworkObservation) (left right : String) :
 sameMacroClass n left right ↔ ∃ label,
 left ∈ n.graph.nodes ∧ right ∈ n.graph.nodes ∧
 image n.observation left = some label ∧ image n.observation right = some label := by
 constructor
 · intro ⟨label,hl,hr⟩
   have l := (exactRegion n label left).mp hl
   have r := (exactRegion n label right).mp hr
   exact ⟨label,l.1,r.1,l.2,r.2⟩
 · intro ⟨label,hl,hr,il,ir⟩
   exact ⟨label,(exactRegion n label left).mpr ⟨hl,il⟩,(exactRegion n label right).mpr ⟨hr,ir⟩⟩

theorem everyCellHasUniqueClass (n : NetworkObservation) (cell : String) (held : cell ∈ n.graph.nodes) :
 ∃ label members, (label,members) ∈ n.classes ∧ cell ∈ members ∧
 ∀ other others, (other,others) ∈ n.classes → cell ∈ others → other = label ∧ others = members :=
 ThermoMicroMacro.eachMicrostateHasUniqueMacrostate n.graph.nodes n.observation n.classes n.computed cell held

theorem everyClassIsCompleteFibre (n : NetworkObservation) (label : String) (members : List String)
 (held : (label,members) ∈ n.classes) : members = region n label :=
 ((partitionMembership n.graph.nodes n.observation n.classes n.computed label members).mp held).2

theorem adjacentCellsShareObservation (n : NetworkObservation) (closed : closedAdjacency n)
 (edge : Edge) (held : edge ∈ n.graph.edges) :
 ∃ label, image n.observation edge.1 = some label ∧ image n.observation edge.2 = some label := by
 obtain ⟨label,_,_,hl,hr⟩ := (sameClassExactly n edge.1 edge.2).mp (closed edge held)
 exact ⟨label,hl,hr⟩

theorem distinctClassesCannotShareCell (n : NetworkObservation) (a b : String) (xs ys : List String)
 (hx : (a,xs) ∈ n.classes) (hy : (b,ys) ∈ n.classes) (different : a ≠ b)
 (cell : String) (left : cell ∈ xs) : ¬ cell ∈ ys := by
 intro right
 exact different (partitionDisjoint n.graph.nodes n.observation n.classes n.computed a b xs ys hx hy cell left right)

theorem sameClassReflexive (n : NetworkObservation) (cell : String) (held : cell ∈ n.graph.nodes) :
 sameMacroClass n cell cell := by
 obtain ⟨label,members,row,member,_⟩ := everyCellHasUniqueClass n cell held
 have exact := everyClassIsCompleteFibre n label members row
 rw [exact] at member
 exact ⟨label,member,member⟩

theorem sameClassSymmetric (n : NetworkObservation) (left right : String)
 (same : sameMacroClass n left right) : sameMacroClass n right left := by
 obtain ⟨label,hl,hr⟩ := same
 exact ⟨label,hr,hl⟩

theorem sameClassTransitive (n : NetworkObservation) (a b c : String)
 (ab : sameMacroClass n a b) (bc : sameMacroClass n b c) : sameMacroClass n a c := by
 obtain ⟨left,ha,hb⟩ := ab
 obtain ⟨right,hb',hc⟩ := bc
 have il := ((exactRegion n left b).mp hb).2
 have ir := ((exactRegion n right b).mp hb').2
 have equal : left = right := Option.some.inj (il.symm.trans ir)
 rw [← equal] at hc
 exact ⟨left,ha,hc⟩

abbrev oneCellBase := oneGraphAccepted
abbrev successorRetainsPaths := freshNodeRetainsPaths
abbrev successorRetainsObservationFibre := ThermoMicroMacro.successorFibre
abbrev localTransferConservation := @ThermoKineticTransport.allTransportCarriersConserved
abbrev exactSourceResponse := @ThermoResponse.exactChangeRatio
end SFT.Physics.CollectiveCoarseGrain
