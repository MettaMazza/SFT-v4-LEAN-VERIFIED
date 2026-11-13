import SFT.Mathematics.GraphOperations
import SFT.Physics.MechanicalWorkEnergy
namespace SFT.Materials.FractureAdvance
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Physics SFT.Mathematics.FoldScalar

structure Crack (Part Support State ClockState Clock : Type) where
 graph : GeneratedGraph
 generated : makeGraph graph.nodes graph.edges = .ok graph
 path : List String
 connected : pathIsValid graph path = true
 hasBond : adjacentPairs path ≠ []
 work : Edge → MechanicalWorkEnergy.Work Part Support State ClockState Clock
 resistance : Edge → Scalar
 geometry : SFT.Host.Canonical.Value
 rate : SFT.Host.Canonical.Value
 conditions : SFT.Host.Canonical.Value

def broken {P S T CS C : Type} (crack : Crack P S T CS C) := adjacentPairs crack.path

def remaining {P S T CS C : Type} (crack : Crack P S T CS C) : GeneratedGraph :=
 ⟨crack.graph.nodes,crack.graph.edges.filter (fun edge => !(has (broken crack) edge))⟩

theorem connectedBondsHeld {P S T CS C : Type} (crack : Crack P S T CS C) (edge : Edge)
 (held : edge ∈ broken crack) : edge ∈ crack.graph.edges :=
 (pathMeaning crack.graph crack.path).mp crack.connected |>.2.2 edge held

theorem remainingExactly {P S T CS C : Type} (crack : Crack P S T CS C) (edge : Edge) :
 edge ∈ (remaining crack).edges ↔ edge ∈ crack.graph.edges ∧ edge ∉ broken crack := by
 have selected := filterMemberIff (fun edge => !(has (broken crack) edge)) crack.graph.edges edge
 constructor
 · intro held
   have parts := selected.mp held
   refine ⟨parts.1,?_⟩
   intro removed
   have yes := (hasIff _ _).mpr removed
   rw [yes] at parts
   cases parts.2
 · intro parts
   apply selected.mpr
   refine ⟨parts.1,?_⟩
   cases h : has (broken crack) edge with
   | false => rfl
   | true => exact False.elim (parts.2 ((hasIff _ _).mp h))

theorem everyBrokenBondSeparated {P S T CS C : Type} (crack : Crack P S T CS C) (edge : Edge)
 (held : edge ∈ broken crack) : edge ∉ (remaining crack).edges :=
 fun retained => (remainingExactly crack edge).mp retained |>.2 held

theorem unbrokenBondRetained {P S T CS C : Type} (crack : Crack P S T CS C) (edge : Edge)
 (held : edge ∈ crack.graph.edges) (intact : edge ∉ broken crack) :
 edge ∈ (remaining crack).edges := (remainingExactly crack edge).mpr ⟨held,intact⟩

theorem materialSupportRetained {P S T CS C : Type} (crack : Crack P S T CS C) :
 (remaining crack).nodes = crack.graph.nodes := rfl

structure BoundaryPair where
 brokenBond : Edge
 firstSide : String
 secondSide : String

def boundaryPair (edge : Edge) : BoundaryPair := ⟨edge,edge.1,edge.2⟩

def newBoundary {P S T CS C : Type} (crack : Crack P S T CS C) :=
 (broken crack).map boundaryPair

theorem completeNewBoundary {P S T CS C : Type} (crack : Crack P S T CS C) :
 (newBoundary crack).map BoundaryPair.brokenBond = broken crack := by
 unfold newBoundary
 generalize broken crack = edges
 induction edges with
 | nil => rfl
 | cons edge rest ih => exact congrArg (List.cons edge) ih

theorem bothSidesRetained (edge : Edge) :
 (boundaryPair edge).firstSide = edge.1 ∧ (boundaryPair edge).secondSide = edge.2 := ⟨rfl,rfl⟩

def workRow {P S T CS C : Type} (crack : Crack P S T CS C) (edge : Edge) :=
 (edge,crack.work edge,MechanicalWorkEnergy.value (crack.work edge),crack.resistance edge)

def ledger {P S T CS C : Type} (crack : Crack P S T CS C) := (broken crack).map (workRow crack)

theorem completeWorkLedger {P S T CS C : Type} (crack : Crack P S T CS C) :
 (ledger crack).map Prod.fst = broken crack := by
 unfold ledger
 generalize broken crack = edges
 induction edges with
 | nil => rfl
 | cons edge rest ih => exact congrArg (List.cons edge) ih

theorem everyInteractionRetained {P S T CS C : Type} (crack : Crack P S T CS C) (edge : Edge) :
 (MechanicalWorkEnergy.interactionCells (crack.work edge)).map Prod.fst =
 MechanicalEvents.changes (crack.work edge).force.interval :=
 MechanicalWorkEnergy.retainsEveryTransferRow (crack.work edge)

theorem workUsesActualForceAndSeparation {P S T CS C : Type} (crack : Crack P S T CS C) (edge : Edge) :
 (workRow crack edge).2.2.1 =
 multiply (MechanicalForce.value (crack.work edge).force)
  (MechanicalWorkEnergy.displacementScalar (crack.work edge).displacement) := rfl

theorem declaredResistanceRetained {P S T CS C : Type} (crack : Crack P S T CS C) (edge : Edge) :
 (workRow crack edge).2.2.2 = crack.resistance edge := rfl

def record {P S T CS C : Type} (crack : Crack P S T CS C) :=
 (crack,remaining crack,newBoundary crack,ledger crack)

theorem geometryRateRetained {P S T CS C : Type} (crack : Crack P S T CS C) :
 (record crack).1.geometry = crack.geometry ∧ (record crack).1.rate = crack.rate ∧
 (record crack).1.conditions = crack.conditions := ⟨rfl,rfl,rfl⟩

def records {P S T CS C : Type} (cracks : List (Crack P S T CS C)) := cracks.map record

theorem base {P S T CS C : Type} (crack : Crack P S T CS C) :
 records [crack] = [record crack] := rfl

theorem successor {P S T CS C : Type} (cracks : List (Crack P S T CS C)) (next : Crack P S T CS C) :
 records (cracks ++ [next]) = records cracks ++ [record next] := by
 induction cracks with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head)) ih

end SFT.Materials.FractureAdvance
