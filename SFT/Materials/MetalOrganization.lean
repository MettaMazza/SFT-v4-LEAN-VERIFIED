import SFT.Chemistry.MetallicNetwork
import SFT.Materials.ConductorAccess
import SFT.Materials.Lattice
namespace SFT.Materials.MetalOrganization
open SFT.Mathematics.GraphOperations SFT.Chemistry

structure Record where
 first : String
 rest : List String
 bonding : List Edge
 valid : MetallicNetwork.admissible (first::rest) bonding = true
 connected : MetallicNetwork.connectedCollectiveSupport (first::rest) bonding = true
 access : ConductorAccess.Boundary
 cell : String → String
 cellsHeld : ∀ label, label ∈ access.direct.graph.nodes → cell label ∈ first::rest
 source : String
 target : String
 direct : (source,target) ∈ ConductorAccess.directPaths access
 differentCells : cell source ≠ cell target
 translations : List Lattice.Record
 translationCells : ∀ t, t ∈ translations → ∀ x, x ∈ t.cells.graph.nodes → x ∈ first::rest
 provenance : SFT.Host.Canonical.Value

variable (r : Record)

theorem atomicConnection (target : String) (held : target ∈ r.first::r.rest) :
 PathWitness (MetallicNetwork.graph (r.first::r.rest) r.bonding) r.first target :=
 (MetallicNetwork.connectedExactlyPaths _ _ _ r.valid).mp r.connected target held

theorem originalBondsRetained (edge : Edge) (held : edge ∈ r.bonding) :
 edge ∈ (MetallicNetwork.graph (r.first::r.rest) r.bonding).edges :=
 MetallicNetwork.sourceEdgesRetained _ _ _ held

theorem gaplessCarrierPath : PathWitness r.access.direct.graph r.source r.target :=
 ((ConductorAccess.directPathExactly r.access r.source r.target).mp r.direct).2.2

theorem conductorClass : ConductorAccess.classify r.access = .conductor := by
 apply (ConductorAccess.conductorExactly r.access).mpr
 intro absent
 have held := r.direct
 rw [absent] at held
 cases held

theorem bothAtomicCells : r.cell r.source ∈ r.first::r.rest ∧ r.cell r.target ∈ r.first::r.rest := by
 have h := (ConductorAccess.directPathExactly r.access r.source r.target).mp r.direct
 exact ⟨r.cellsHeld r.source (r.access.occupiedHeld _ h.1),r.cellsHeld r.target (r.access.accessibleHeld _ h.2.1)⟩

theorem multipleConstituentCells : r.cell r.source ≠ r.cell r.target := r.differentCells

theorem declaredTranslationsStayAtomic (t : Lattice.Record) (held : t ∈ r.translations)
 (n : Nat) (x : String) (member : x ∈ t.cells.graph.nodes) :
 Lattice.translate t n x ∈ r.first::r.rest :=
 r.translationCells t held _ (Lattice.everyTranslationHeld t n x member)

theorem declaredTranslationPreservesBonds (t : Lattice.Record) (n : Nat) (a b : String)
 (ha : a ∈ t.cells.graph.nodes) (hb : b ∈ t.cells.graph.nodes) :
 (Lattice.translate t n a,Lattice.translate t n b) ∈ t.cells.graph.edges ↔ (a,b) ∈ t.cells.graph.edges :=
 Lattice.everyAdjacencyRecurs t n a b ha hb

def record := (r,ConductorAccess.directPaths r.access,ConductorAccess.classify r.access)

theorem completeInputRetained : (record r).1 = r := rfl

def records (rs : List Record) := rs.map record

theorem base : records [r] = [record r] := rfl

theorem successor (rs : List Record) : records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.MetalOrganization
