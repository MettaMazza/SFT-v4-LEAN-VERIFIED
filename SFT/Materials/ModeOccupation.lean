import SFT.Physics.QuantumPhysicalExclusion
namespace SFT.Materials.ModeOccupation
open SFT.Physics SFT.Physics.QuantumPhysicalIdentity SFT.Physics.QuantumPhysicalExclusion

-- The domain is every finite occupation list. Binary occupation is a result
-- of exclusion for the canonical word/cell, not a restriction of this domain.
def canonical {Word Cell : Type} (word : Word) (cell : Cell)
 (occupants : List (Occupant Word Cell)) : Prop :=
 ∀ a, a ∈ occupants → a.word = word ∧ a.cell = cell

def admitted {Word Cell : Type}
 (orientation : Pair (Occupant Word Cell) → MechanicalLocation.Held) :
 List (Occupant Word Cell) → Prop
 | [] => True
 | a :: rest => (∀ b, b ∈ rest → alternating orientation ⟨a,b⟩) ∧ admitted orientation rest

theorem absenceAdmitted {Word Cell : Type}
 (orientation : Pair (Occupant Word Cell) → MechanicalLocation.Held) :
 admitted orientation [] := True.intro

theorem singleAdmitted {Word Cell : Type}
 (orientation : Pair (Occupant Word Cell) → MechanicalLocation.Held) (a : Occupant Word Cell) :
 admitted orientation [a] := by
 constructor
 · intro b h; cases h
 · exact True.intro

theorem duplicateRejected {Word Cell : Type} (word : Word) (cell : Cell)
 (orientation : Pair (Occupant Word Cell) → MechanicalLocation.Held)
 (a b : Occupant Word Cell) (rest : List (Occupant Word Cell))
 (held : canonical word cell (a :: b :: rest)) : ¬ admitted orientation (a :: b :: rest) := by
 intro accepted
 have ha := held a (List.Mem.head _)
 have hb := held b (List.Mem.tail _ (List.Mem.head _))
 exact identicalSameCellExcluded orientation a b (ha.1.trans hb.1.symm)
  (ha.2.trans hb.2.symm) (accepted.1 b (List.Mem.head _))

theorem completeOccupationClassification {Word Cell : Type} (word : Word) (cell : Cell)
 (orientation : Pair (Occupant Word Cell) → MechanicalLocation.Held)
 (occupants : List (Occupant Word Cell)) (held : canonical word cell occupants) :
 admitted orientation occupants ↔ occupants = [] ∨ ∃ a, occupants = [a] := by
 constructor
 · intro accepted
   cases occupants with
   | nil => exact .inl rfl
   | cons a rest =>
     cases rest with
     | nil => exact .inr ⟨a,rfl⟩
     | cons b tail => exact False.elim (duplicateRejected word cell orientation a b tail held accepted)
 · intro h
   cases h with
   | inl absent => rw [absent]; exact absenceAdmitted orientation
   | inr occupied => obtain ⟨a,same⟩ := occupied; rw [same]; exact singleAdmitted orientation a

theorem singleCanonicalIdentity {Word Cell : Type} (word : Word) (cell : Cell)
 (a : Occupant Word Cell) (held : canonical word cell [a]) : a = ⟨word,cell⟩ := by
 have h := held a (List.Mem.head _)
 cases a with
 | mk aw ac =>
   change aw = word ∧ ac = cell at h
   cases h.1
   cases h.2
   rfl

theorem exactCanonicalOutcomes {Word Cell : Type} (word : Word) (cell : Cell)
 (orientation : Pair (Occupant Word Cell) → MechanicalLocation.Held)
 (occupants : List (Occupant Word Cell)) (held : canonical word cell occupants)
 (accepted : admitted orientation occupants) : occupants = [] ∨ occupants = [⟨word,cell⟩] := by
 cases (completeOccupationClassification word cell orientation occupants held).mp accepted with
 | inl h => exact .inl h
 | inr h =>
   obtain ⟨a,h⟩ := h
   cases h
   exact .inr (congrArg (fun a => [a]) (singleCanonicalIdentity word cell a held))

theorem twoOutcomesDistinct {Word Cell : Type} (word : Word) (cell : Cell) :
 ([] : List (Occupant Word Cell)) ≠ [⟨word,cell⟩] := by intro h; cases h
end SFT.Materials.ModeOccupation
