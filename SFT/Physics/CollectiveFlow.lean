import SFT.Physics.CollectivePressure
import SFT.Physics.FieldSourceContinuity
namespace SFT.Physics.CollectiveFlow
open MechanicalConservation FieldSourceContinuity
open SFT.Mathematics.DiscreteObjects

inductive Content (Material Momentum Energy : Type) where
 | material (value : Material)
 | momentum (value : Momentum)
 | energy (value : Energy)

structure Flow (Carrier : Type) where
 cells : CollectiveCoarseGrain.NetworkObservation
 transfers : Network String Carrier
 adjacent : ∀ t, t ∈ transfers → (t.source,t.destination) ∈ cells.graph.edges

variable {Carrier : Type}

def inside (region : List String) (cell : String) := has region cell

theorem completeRegionBalance (f : Flow Carrier) (region : List String) :
 departuresInside (inside region) f.transfers + (inward (inside region) f.transfers).length =
 arrivalsInside (inside region) f.transfers + (outward (inside region) f.transfers).length :=
 exactInteriorBoundaryBalance (inside region) f.transfers

theorem exactOutgoingCarriers (f : Flow Carrier) (region : List String) :
 (interiorLosses (inside region) f.transfers).map Prod.snd =
 (boundaryOutflow (inside region) f.transfers).map Prod.snd := lossExactlyOutflow _ _

theorem exactIncomingCarriers (f : Flow Carrier) (region : List String) :
 (interiorGains (inside region) f.transfers).map Prod.snd =
 (boundaryInflow (inside region) f.transfers).map Prod.snd := gainExactlyInflow _ _

theorem everyOutflowIsNamedAdjacent (f : Flow Carrier) (region : List String)
 (t : Transfer String Carrier) (crosses : t ∈ outward (inside region) f.transfers) :
 t ∈ f.transfers ∧ (t.source,t.destination) ∈ f.cells.graph.edges ∧
 inside region t.source = true ∧ inside region t.destination = false := by
 have h := noUnrecordedOutflow _ _ _ crosses
 exact ⟨h.1,f.adjacent t h.1,h.2⟩

theorem everyInflowIsNamedAdjacent (f : Flow Carrier) (region : List String)
 (t : Transfer String Carrier) (crosses : t ∈ inward (inside region) f.transfers) :
 t ∈ f.transfers ∧ (t.source,t.destination) ∈ f.cells.graph.edges ∧
 inside region t.source = false ∧ inside region t.destination = true := by
 have h := (inwardMember _ _ _).mp crosses
 exact ⟨h.1,f.adjacent t h.1,h.2⟩

theorem everyOutgoingRecordIncluded (f : Flow Carrier) (region : List String)
 (t : Transfer String Carrier) (held : t ∈ f.transfers)
 (source : inside region t.source = true) (destination : inside region t.destination = false) :
 t ∈ outward (inside region) f.transfers := noOmittedOutflow _ _ _ held source destination

theorem everyIncomingRecordIncluded (f : Flow Carrier) (region : List String)
 (t : Transfer String Carrier) (held : t ∈ f.transfers)
 (source : inside region t.source = false) (destination : inside region t.destination = true) :
 t ∈ inward (inside region) f.transfers := (inwardMember _ _ _).mpr ⟨held,source,destination⟩

theorem joinedRegionsBalance (f : Flow Carrier) (left right : List String) :
 let joined := fun cell => inside left cell || inside right cell
 departuresInside joined f.transfers + (inward joined f.transfers).length =
 arrivalsInside joined f.transfers + (outward joined f.transfers).length :=
 exactInteriorBoundaryBalance _ _

theorem joinedRegionClosesInternalTransfer (f : Flow Carrier) (left right : List String)
 (t : Transfer String Carrier) (source : inside left t.source = true)
 (destination : inside right t.destination = true) :
 let joined := fun cell => inside left cell || inside right cell
 t ∉ outward joined f.transfers ∧ t ∉ inward joined f.transfers := by
 have hs : (inside left t.source || inside right t.source) = true := by rw [source]; rfl
 have hd : (inside left t.destination || inside right t.destination) = true := by
  rw [destination]
  cases inside left t.destination <;> rfl
 constructor
 · intro h
   have bad := ((outwardMember _ _ _).mp h).2.2
   rw [hd] at bad
   cases bad
 · intro h
   have bad := ((inwardMember _ _ _).mp h).2.1
   rw [hs] at bad
   cases bad

abbrev everyMaterialMomentumEnergyRecordPaired := @MechanicalConservation.completeConservation
abbrev successorRetainsPriorRecords := @MechanicalConservation.appendRetainsPrior
end SFT.Physics.CollectiveFlow
