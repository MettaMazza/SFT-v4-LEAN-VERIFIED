import SFT.Physics.MatterAntiparticle
namespace SFT.Physics.MatterExchange
open MechanicalLocation QuantumPhysicalIdentity

inductive Class where
  | preserving | alternating

def classify : Held → Held → Class
  | .first,.first | .second,.second => .preserving
  | .first,.second | .second,.first => .alternating

theorem twoHeldActionsExhaust (original exchanged : Held) :
    exchanged = original ∨ exchanged = opposite original := by
  cases original <;> cases exchanged
  · exact Or.inl rfl
  · exact Or.inr rfl
  · exact Or.inr rfl
  · exact Or.inl rfl

theorem preservingExactly (original exchanged : Held) :
    classify original exchanged = .preserving ↔ exchanged = original := by
  cases original <;> cases exchanged <;> constructor <;> intro h
  all_goals first | rfl | cases h

theorem alternatingExactly (original exchanged : Held) :
    classify original exchanged = .alternating ↔ exchanged = opposite original := by
  cases original <;> cases exchanged <;> constructor <;> intro h
  all_goals first | rfl | cases h

theorem classesExclusive (original exchanged : Held) :
    ¬(exchanged = original ∧ exchanged = opposite original) := by
  intro h
  exact QuantumPhysicalExclusion.oppositeNeverSame original (h.2.symm.trans h.1)

theorem alternatingSameCellExcluded {Word Cell : Type}
    (orientation : Pair (QuantumPhysicalExclusion.Occupant Word Cell) → Held)
    (a b : QuantumPhysicalExclusion.Occupant Word Cell)
    (word : a.word = b.word) (cell : a.cell = b.cell) :
    classify (orientation ⟨a,b⟩) (orientation (exchange ⟨a,b⟩)) ≠ .alternating := by
  intro h
  exact QuantumPhysicalExclusion.identicalSameCellExcluded orientation a b word cell
    ((alternatingExactly _ _).mp h)

theorem preservingSameCellAdmitted {Word Cell : Type}
    (orientation : Pair (QuantumPhysicalExclusion.Occupant Word Cell) → Held)
    (a b : QuantumPhysicalExclusion.Occupant Word Cell)
    (word : a.word = b.word) (cell : a.cell = b.cell) :
    classify (orientation ⟨a,b⟩) (orientation (exchange ⟨a,b⟩)) = .preserving := by
  apply (preservingExactly _ _).mpr
  exact congrArg orientation (QuantumPhysicalExclusion.identicalSameCellFixed a b word cell)
end SFT.Physics.MatterExchange
