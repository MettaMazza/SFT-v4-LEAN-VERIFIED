import SFT.Physics.QuantumPhysicalIdentity
namespace SFT.Physics.QuantumPhysicalExclusion
open QuantumPhysicalIdentity

structure Occupant (Word Cell : Type) where
  word : Word
  cell : Cell

-- Alternating exchange retains an opposite held orientation, not a signed magnitude.
def alternating {Constituent : Type} (orientation : Pair Constituent → MechanicalLocation.Held)
    (p : Pair Constituent) : Prop := orientation (exchange p) = MechanicalLocation.opposite (orientation p)

theorem oppositeNeverSame (held : MechanicalLocation.Held) : MechanicalLocation.opposite held ≠ held := by
  cases held <;> intro h <;> cases h

theorem fixedExchangeExcluded {Constituent : Type} (orientation : Pair Constituent → MechanicalLocation.Held)
    (p : Pair Constituent) (fixed : exchange p = p) : ¬ alternating orientation p := by
  intro h
  change orientation (exchange p) = MechanicalLocation.opposite (orientation p) at h
  rw [fixed] at h
  exact oppositeNeverSame (orientation p) h.symm

theorem identicalSameCellFixed {Word Cell : Type} (a b : Occupant Word Cell)
    (sameWord : a.word = b.word) (sameCell : a.cell = b.cell) : exchange (⟨a,b⟩ : Pair (Occupant Word Cell)) = ⟨a,b⟩ := by
  cases a with
  | mk aw ac => cases b with
    | mk bw bc => cases sameWord; cases sameCell; rfl

theorem identicalSameCellExcluded {Word Cell : Type}
    (orientation : Pair (Occupant Word Cell) → MechanicalLocation.Held)
    (a b : Occupant Word Cell) (sameWord : a.word = b.word) (sameCell : a.cell = b.cell) :
    ¬ alternating orientation ⟨a,b⟩ :=
  fixedExchangeExcluded orientation _ (identicalSameCellFixed a b sameWord sameCell)

theorem admittedSameWordRequiresDistinctCell {Word Cell : Type}
    (orientation : Pair (Occupant Word Cell) → MechanicalLocation.Held)
    (a b : Occupant Word Cell) (sameWord : a.word = b.word) (accepted : alternating orientation ⟨a,b⟩) :
    a.cell ≠ b.cell := fun sameCell => identicalSameCellExcluded orientation a b sameWord sameCell accepted
end SFT.Physics.QuantumPhysicalExclusion
