import SFT.Chemistry.SupramolecularRelease
namespace SFT.Chemistry.MolecularNetwork
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

structure Network where
 assembly : MolecularAssembly.Assembly
 first : String
 rest : List String
 names : assembly.raw.carriers=first::rest

def graph (network : Network) := MolecularCarrier.helperGraph network.assembly.raw.carriers (MolecularAssembly.edges network.assembly.raw)

theorem everyNamedNodeReached (network : Network) (target : String) (held : target∈network.assembly.raw.carriers) :
 PathWitness (graph network) network.first target := by
 have connected := (MolecularAssembly.acceptedConditions _ _ network.assembly.accepted).2.2.1
 rw [network.names] at connected held
 have result := MolecularCarrier.connectedPaths network.first network.rest _ connected target held
 change PathWitness (MolecularCarrier.helperGraph network.assembly.raw.carriers _) network.first target
 rw [network.names]
 exact result

theorem noReachableNodeOutsideBoundary (network : Network) (target : String)
 (path : PathWitness (graph network) network.first target) : target∈network.assembly.raw.carriers := by
 have connected := (MolecularAssembly.acceptedConditions _ _ network.assembly.accepted).2.2.1
 change PathWitness (MolecularCarrier.helperGraph network.assembly.raw.carriers _) network.first target at path
 rw [network.names] at connected path ⊢
 exact MolecularCarrier.connectedExcludesOutside network.first network.rest _ connected target path

theorem maximalDeclaredComponent (network : Network) (target : String) :
 Nonempty (PathWitness (graph network) network.first target) ↔ target∈network.assembly.raw.carriers :=
 ⟨fun ⟨path⟩ => noReachableNodeOutsideBoundary network target path,
  fun held => ⟨everyNamedNodeReached network target held⟩⟩

theorem everyEdgeHasRegisteredChannel (network : Network) (edge : Edge) (held : edge∈(graph network).edges) :
 ∃ row ∈ network.assembly.raw.interactions,
 edge=(row.left,row.right) ∨ edge=(row.right,row.left) := by
 cases memAppendCases edge (MolecularAssembly.edges network.assembly.raw)
  ((MolecularAssembly.edges network.assembly.raw).map (fun e : Edge => (e.2,e.1))) held with
 | inl direct =>
   obtain ⟨row,member,equal⟩ := memMapPreimage MolecularAssembly.edge edge network.assembly.raw.interactions direct
   exact ⟨row,member,.inl equal.symm⟩
 | inr reversed =>
   obtain ⟨prior,member,equal⟩ := memMapPreimage (fun e : Edge => (e.2,e.1)) edge (MolecularAssembly.edges network.assembly.raw) reversed
   obtain ⟨row,rowMember,original⟩ := memMapPreimage MolecularAssembly.edge prior network.assembly.raw.interactions member
   cases original
   exact ⟨row,rowMember,.inr equal.symm⟩

theorem unregisteredEdgeExcluded (network : Network) (edge : Edge)
 (absent : ∀ row ∈ network.assembly.raw.interactions,
  edge≠(row.left,row.right) ∧ edge≠(row.right,row.left)) : ¬edge∈(graph network).edges := by
 intro held
 obtain ⟨row,member,either⟩ := everyEdgeHasRegisteredChannel network edge held
 cases either with
 | inl forward => exact (absent row member).1 forward
 | inr backward => exact (absent row member).2 backward

structure Record where
 network : Network
 components : List SupramolecularRelease.NamedComponent
 completeComponents : components.map SupramolecularRelease.NamedComponent.name=network.assembly.raw.carriers
 provenance : SFT.Host.Canonical.Value

theorem allMolecularCompositionsRetained (record : Record) (part : SupramolecularRelease.NamedComponent)
 (held : part∈record.components) : part.molecule.raw∈record.components.map (fun p => p.molecule.raw) :=
 memMap _ _ _ held

theorem successorConnectivity (raw : MolecularAssembly.Raw) (first : String) (rest : List String)
 (names : raw.carriers=first::rest) (fresh anchor : String) (channel : MolecularAssembly.HeldLabel)
 (covered : ∀ e ∈ MolecularAssembly.edges raw, e.1∈raw.carriers ∧ e.2∈raw.carriers)
 (connected : MolecularCarrier.connected raw.carriers (MolecularAssembly.edges raw)=true)
 (held : anchor∈raw.carriers) :
 MolecularCarrier.connected (MolecularAssembly.append raw fresh anchor channel).carriers
 (MolecularAssembly.edges (MolecularAssembly.append raw fresh anchor channel))=true :=
 MolecularAssembly.appendConnectivity raw first rest names fresh anchor channel covered connected held

def edgeOne : MolecularAssembly.HeldLabel := ⟨"network","edge-one",rfl,rfl⟩
def edgeTwo : MolecularAssembly.HeldLabel := ⟨"network","edge-two",rfl,rfl⟩
def originalNetwork : MolecularAssembly.Raw :=
 ⟨["node-one","node-two","node-three"],[⟨"node-one","node-two",edgeOne⟩,⟨"node-two","node-three",edgeTwo⟩]⟩

theorem originalInteractionCount : MolecularAssembly.interactionCount originalNetwork=2 := rfl
theorem originalNodeRetention : originalNetwork.carriers=["node-one","node-two","node-three"] := rfl

theorem originalNetworkConnected : MolecularCarrier.connected originalNetwork.carriers (MolecularAssembly.edges originalNetwork)=true := by
 apply MolecularCarrier.connectedFromPaths
 · intro target held
   cases held with
   | head => exact ⟨[],by decide,rfl⟩
   | tail _ tail =>
     cases tail with
     | head => exact ⟨["node-one"],by decide,rfl⟩
     | tail _ tail =>
       cases tail with
       | head => exact ⟨["node-one","node-two"],by decide,rfl⟩
       | tail _ impossible => cases impossible
 · intro target path
   apply MolecularCarrier.helperNodesKnown _ _ _ target (pathWitnessTarget _ _ _ path)
   intro edge held
   cases held with
   | head => exact ⟨.head _,.tail _ (.head _)⟩
   | tail _ tail =>
     cases tail with
     | head => exact ⟨.tail _ (.head _),.tail _ (.tail _ (.head []))⟩
     | tail _ impossible => cases impossible

theorem originalNetworkAdmitted : MolecularAssembly.admit originalNetwork=.ok originalNetwork := by
 unfold MolecularAssembly.admit
 change (if !MolecularCarrier.connected originalNetwork.carriers (MolecularAssembly.edges originalNetwork) then _ else _)=_
 rw [originalNetworkConnected]
 rfl
def originalPair : MolecularAssembly.Raw := ⟨["node-one","node-two"],[⟨"node-one","node-two",edgeOne⟩]⟩
theorem originalPairConnected : MolecularCarrier.connected originalPair.carriers (MolecularAssembly.edges originalPair)=true := by
 apply MolecularCarrier.connectedFromPaths
 · intro target held
   cases held with
   | head => exact ⟨[],by decide,rfl⟩
   | tail _ tail =>
     cases tail with
     | head => exact ⟨["node-one"],by decide,rfl⟩
     | tail _ impossible => cases impossible
 · intro target path
   apply MolecularCarrier.helperNodesKnown _ _ _ target (pathWitnessTarget _ _ _ path)
   intro edge held
   cases held with
   | head => exact ⟨.head _,.tail _ (.head [])⟩
   | tail _ impossible => cases impossible

theorem originalPairAdmitted : MolecularAssembly.admit originalPair=.ok originalPair := by
 unfold MolecularAssembly.admit
 change (if !MolecularCarrier.connected originalPair.carriers (MolecularAssembly.edges originalPair) then _ else _)=_
 rw [originalPairConnected]
 rfl
end SFT.Chemistry.MolecularNetwork
