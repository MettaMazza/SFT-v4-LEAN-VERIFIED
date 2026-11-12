import SFT.Mathematics.DiscreteComplement
import SFT.Physics.QuantumPhysicalExclusion
import SFT.Physics.FieldElectricDistinction
namespace SFT.Materials.CarrierDuality
open SFT.Mathematics.DiscreteObjects
open SFT.Physics

-- V3 materials obligation ELEC-CARRIER-DUALITY: retain the state carrier
-- while describing its occupied and locally absent support separately.
def holes (support occupied : Collection) : Collection :=
 support.filter (fun cell => !has occupied cell)

theorem holeExactly (support occupied : Collection) (cell : Form) :
 cell ∈ holes support occupied ↔ cell ∈ support ∧ cell ∉ occupied := by
 constructor
 · intro h
   have p := (filterMemberIff _ _ _).mp h
   cases hc : has occupied cell with
   | false => exact ⟨p.1,(absentIff _ _).mp hc⟩
   | true => rw [hc] at p; cases p.2
 · intro h
   exact (filterMemberIff _ _ _).mpr ⟨h.1,by rw [(absentIff _ _).mpr h.2]; rfl⟩

theorem descriptionsExhaust (support occupied : Collection) (cell : Form)
 (held : cell ∈ support) : cell ∈ occupied ∨ cell ∈ holes support occupied := by
 cases h : has occupied cell with
 | true => exact .inl ((hasIff _ _).mp h)
 | false => exact .inr ((holeExactly _ _ _).mpr ⟨held,(absentIff _ _).mp h⟩)

theorem descriptionsDisjoint (support occupied : Collection) (cell : Form)
 (absent : cell ∈ holes support occupied) : cell ∉ occupied :=
 ((holeExactly _ _ _).mp absent).2

theorem dualDescriptionRecoversOccupation (support occupied : Collection)
 (inside : ∀ cell, cell ∈ occupied → cell ∈ support) (cell : Form) :
 cell ∈ holes support (holes support occupied) ↔ cell ∈ occupied := by
 constructor
 · intro h
   have p := (holeExactly _ _ _).mp h
   cases hc : has occupied cell with
   | true => exact (hasIff _ _).mp hc
   | false => exact False.elim (p.2 ((holeExactly _ _ _).mpr ⟨p.1,(absentIff _ _).mp hc⟩))
 · intro h
   exact (holeExactly _ _ _).mpr ⟨inside cell h,fun absent => descriptionsDisjoint _ _ _ absent h⟩

-- The bound is inherited from the existing exchange proof, not postulated
-- by selecting a two-case outcome table.
theorem repeatedSameStateExcluded {Word Cell : Type}
 (orientation : QuantumPhysicalIdentity.Pair (QuantumPhysicalExclusion.Occupant Word Cell) → MechanicalLocation.Held)
 (a b : QuantumPhysicalExclusion.Occupant Word Cell)
 (sameWord : a.word = b.word) (sameCell : a.cell = b.cell) :
 ¬ QuantumPhysicalExclusion.alternating orientation ⟨a,b⟩ :=
 QuantumPhysicalExclusion.identicalSameCellExcluded orientation a b sameWord sameCell

def occupationRows (support occupied : Collection) :=
 support.map (fun cell => (cell,has occupied cell))

def absenceRows (support occupied : Collection) :=
 support.map (fun cell => (cell,!has occupied cell))

theorem everySiteRetained (support occupied : Collection) :
 (occupationRows support occupied).map Prod.fst = support ∧
 (absenceRows support occupied).map Prod.fst = support := by
 induction support with
 | nil => exact ⟨rfl,rfl⟩
 | cons first rest ih => exact ⟨congrArg (List.cons first) ih.1,congrArg (List.cons first) ih.2⟩

theorem occupiedTransportIsOppositeAbsence (before after : Collection) (source target : Form)
 (sourceBefore : source ∈ before) (targetBefore : target ∉ before)
 (sourceAfter : source ∉ after) (targetAfter : target ∈ after)
 (support : Collection) (hs : source ∈ support) (ht : target ∈ support) :
 source ∉ holes support before ∧ target ∈ holes support before ∧
 source ∈ holes support after ∧ target ∉ holes support after :=
 ⟨fun h => descriptionsDisjoint _ _ _ h sourceBefore,
  (holeExactly _ _ _).mpr ⟨ht,targetBefore⟩,
  (holeExactly _ _ _).mpr ⟨hs,sourceAfter⟩,
  fun h => descriptionsDisjoint _ _ _ h targetAfter⟩

theorem everyUnchangedCellUnchangedInDual (support before after : Collection) (cell : Form)
 (same : cell ∈ before ↔ cell ∈ after) :
 cell ∈ holes support before ↔ cell ∈ holes support after := by
 constructor
 · intro h
   have p := (holeExactly _ _ _).mp h
   exact (holeExactly _ _ _).mpr ⟨p.1,fun ha => p.2 (same.mpr ha)⟩
 · intro h
   have p := (holeExactly _ _ _).mp h
   exact (holeExactly _ _ _).mpr ⟨p.1,fun hb => p.2 (same.mp hb)⟩

def chargePair (charge : FieldElectricDistinction.Charge) :=
 (charge,FieldElectricDistinction.reverse charge)

theorem chargeOrientationAndMagnitudeRetained (charge : FieldElectricDistinction.Charge) :
 (chargePair charge).2.amount = (chargePair charge).1.amount ∧
 (chargePair charge).2.held = MechanicalLocation.opposite (chargePair charge).1.held := ⟨rfl,rfl⟩

theorem chargeDescriptionsDistinct (charge : FieldElectricDistinction.Charge) :
 (chargePair charge).2.held ≠ (chargePair charge).1.held :=
 QuantumPhysicalExclusion.oppositeNeverSame charge.held

theorem reversingDescriptionTwice (charge : FieldElectricDistinction.Charge) :
 FieldElectricDistinction.reverse (chargePair charge).2 = charge :=
 FieldElectricDistinction.reversedTwice charge
end SFT.Materials.CarrierDuality
