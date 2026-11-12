import SFT.Materials.Lattice
import SFT.Physics.MechanicalConservation
import SFT.Mathematics.GraphPathSoundness
namespace SFT.Materials.MaterialInterface
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Physics.MechanicalConservation
open SFT.Foundation.Count.TraceDerivation

-- Obligation22: retain every relation across distinct material/phase labels.
structure Carrier where
 lattice : Lattice.Record
 material : String → String
 scale : String
 provenance : SFT.Host.Canonical.Value

def boundary (carrier : Carrier) : List Edge :=
 carrier.lattice.cells.graph.edges.filter (fun edge => decide (carrier.material edge.1 ≠ carrier.material edge.2))

theorem boundaryExactly (carrier : Carrier) (edge : Edge) : edge ∈ boundary carrier ↔
 edge ∈ carrier.lattice.cells.graph.edges ∧ carrier.material edge.1 ≠ carrier.material edge.2 := by
 have h := filterMemberIff (fun edge : Edge => decide (carrier.material edge.1 ≠ carrier.material edge.2))
   carrier.lattice.cells.graph.edges edge
 constructor
 · intro member
   have parts := h.mp member
   exact ⟨parts.1,of_decide_eq_true parts.2⟩
 · intro parts; exact h.mpr ⟨parts.1,decide_eq_true parts.2⟩

theorem boundaryEndpointsHeld (carrier : Carrier) (edge : Edge) (held : edge ∈ boundary carrier) :
 edge.1 ∈ carrier.lattice.cells.graph.nodes ∧ edge.2 ∈ carrier.lattice.cells.graph.nodes :=
 acceptedGraphEndpoints carrier.lattice.cells.nodes carrier.lattice.cells.edges carrier.lattice.cells.graph
   carrier.lattice.cells.generated edge ((boundaryExactly carrier edge).mp held).1

variable {Content Traction : Type}

structure Payload (Content Traction : Type) where
 content : Network String Content
 traction : Network String Traction
 compatibilityRecord : SFT.Host.Canonical.Value

structure Row (Content Traction : Type) where
 edge : Edge
 firstMaterial : String
 secondMaterial : String
 firstStructure : List String
 secondStructure : List String
 payload : Payload Content Traction

def row (carrier : Carrier) (data : Edge → Payload Content Traction) (edge : Edge) : Row Content Traction :=
 ⟨edge,carrier.material edge.1,carrier.material edge.2,
   carrier.lattice.word edge.1,carrier.lattice.word edge.2,data edge⟩

def assemble (carrier : Carrier) (data : Edge → Payload Content Traction) : List (Row Content Traction) :=
 (boundary carrier).map (row carrier data)

theorem completeBoundaryProjection (carrier : Carrier) (data : Edge → Payload Content Traction) :
 (assemble carrier data).map Row.edge = boundary carrier := by
 unfold assemble
 generalize boundary carrier = edges
 induction edges with
 | nil => rfl
 | cons edge rest ih => exact congrArg (List.cons edge) ih

theorem rowExactly (carrier : Carrier) (data : Edge → Payload Content Traction) (record : Row Content Traction) :
 record ∈ assemble carrier data ↔ ∃ edge, edge ∈ boundary carrier ∧ row carrier data edge = record := by
 constructor
 · intro held; exact memMapPreimage (row carrier data) record (boundary carrier) held
 · intro ⟨edge,held,same⟩
   cases same
   exact memMap (row carrier data) edge (boundary carrier) held

def onBoundary {Token : Type} (edge : Edge) (transfer : Transfer String Token) : Prop :=
 (transfer.source=edge.1 ∧ transfer.destination=edge.2) ∨
 (transfer.source=edge.2 ∧ transfer.destination=edge.1)

def compatible (carrier : Carrier) (record : Row Content Traction) : Prop :=
 record.firstMaterial=carrier.material record.edge.1 ∧
 record.secondMaterial=carrier.material record.edge.2 ∧
 record.firstStructure=carrier.lattice.word record.edge.1 ∧
 record.secondStructure=carrier.lattice.word record.edge.2 ∧
 (∀ transfer, transfer ∈ record.payload.content → onBoundary record.edge transfer) ∧
 (∀ transfer, transfer ∈ record.payload.traction → onBoundary record.edge transfer)

theorem assembledCompatibility (carrier : Carrier) (data : Edge → Payload Content Traction)
 (contentBound : ∀ edge, edge ∈ boundary carrier → ∀ transfer, transfer ∈ (data edge).content → onBoundary edge transfer)
 (tractionBound : ∀ edge, edge ∈ boundary carrier → ∀ transfer, transfer ∈ (data edge).traction → onBoundary edge transfer)
 (record : Row Content Traction) (held : record ∈ assemble carrier data) : compatible carrier record := by
 obtain ⟨edge,member,same⟩ := (rowExactly carrier data record).mp held
 cases same
 exact ⟨rfl,rfl,rfl,rfl,contentBound edge member,tractionBound edge member⟩

theorem distinctCarriersRetained (carrier : Carrier) (data : Edge → Payload Content Traction)
 (record : Row Content Traction) (held : record ∈ assemble carrier data) : record.firstMaterial ≠ record.secondMaterial := by
 obtain ⟨edge,member,same⟩ := (rowExactly carrier data record).mp held
 cases same
 exact ((boundaryExactly carrier edge).mp member).2

theorem everyBoundaryRecorded (carrier : Carrier) (data : Edge → Payload Content Traction) (edge : Edge)
 (held : edge ∈ boundary carrier) : row carrier data edge ∈ assemble carrier data := memMap _ _ _ held

theorem noInternalRow (carrier : Carrier) (data : Edge → Payload Content Traction) (edge : Edge)
 (same : carrier.material edge.1 = carrier.material edge.2) : row carrier data edge ∉ assemble carrier data := by
 intro held
 exact distinctCarriersRetained carrier data _ held same

theorem contentPaired (record : Row Content Traction) :
 outgoingSupport record.payload.content = incomingSupport record.payload.content := completeConservation _

theorem tractionPaired (record : Row Content Traction) :
 outgoingSupport record.payload.traction = incomingSupport record.payload.traction := completeConservation _

def allContent (records : List (Row Content Traction)) : Network String Content :=
 records.flatMap (fun record => record.payload.content)

def allTraction (records : List (Row Content Traction)) : Network String Traction :=
 records.flatMap (fun record => record.payload.traction)

theorem completeContentBalance (carrier : Carrier) (data : Edge → Payload Content Traction) :
 outgoingSupport (allContent (assemble carrier data)) = incomingSupport (allContent (assemble carrier data)) :=
 completeConservation _

theorem completeTractionBalance (carrier : Carrier) (data : Edge → Payload Content Traction) :
 outgoingSupport (allTraction (assemble carrier data)) = incomingSupport (allTraction (assemble carrier data)) :=
 completeConservation _

theorem transferEndpointsHeld (carrier : Carrier) (edge : Edge) (held : edge ∈ boundary carrier)
 {Token : Type} (transfer : Transfer String Token) (bound : onBoundary edge transfer) :
 transfer.source ∈ carrier.lattice.cells.graph.nodes ∧ transfer.destination ∈ carrier.lattice.cells.graph.nodes := by
 have endpoints := boundaryEndpointsHeld carrier edge held
 cases bound with
 | inl h => exact ⟨h.1.symm ▸ endpoints.1,h.2.symm ▸ endpoints.2⟩
 | inr h => exact ⟨h.1.symm ▸ endpoints.2,h.2.symm ▸ endpoints.1⟩

def observation (carrier : Carrier) (data : Edge → Payload Content Traction) :=
 (assemble carrier data,carrier.scale,carrier.provenance)

theorem observationBoundaryRetained (carrier : Carrier) (data : Edge → Payload Content Traction) :
 (observation carrier data).2.1=carrier.scale ∧ (observation carrier data).2.2=carrier.provenance := ⟨rfl,rfl⟩
end SFT.Materials.MaterialInterface
