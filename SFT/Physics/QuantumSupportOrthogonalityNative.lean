import SFT.Physics.QuantumSupportOrthogonalityInduction
namespace SFT.Physics.QuantumSupportOrthogonalityNative
open QuantumSupportPreparation QuantumSupportParity QuantumSupportOrthogonalityInduction
-- Literal inner operation of V3 orthogonality_certificate and the existing native operation.
def productRow (left right mode : Word) : Except String String := do
 let lp ← walshPhase left mode
 let rp ← walshPhase right mode
 pure (if lp==rp then held else returned)
private theorem generatedNonempty (d : Nat) (word : Word) (member : word∈words (d+1)) : word.isEmpty=false := by
 have size := originalGeneratedWordLength (d+1) word member
 cases word with
 | nil => cases size
 | cons x xs => rfl

theorem originalGeneratedProductRow (d : Nat) (left right mode : Word)
 (hl : left∈words (d+1)) (hr : right∈words (d+1)) (hm : mode∈words (d+1)) :
 productRow left right mode=.ok (if phaseBit left mode==phaseBit right mode then held else returned) := by
 unfold productRow
 rw [originalPhaseOperation left mode ((originalGeneratedWordLength _ _ hl).trans (originalGeneratedWordLength _ _ hm).symm) (generatedNonempty d left hl)]
 dsimp only [Bind.bind,Except.bind]
 rw [originalPhaseOperation right mode ((originalGeneratedWordLength _ _ hr).trans (originalGeneratedWordLength _ _ hm).symm) (generatedNonempty d right hr)]
 cases phaseBit left mode <;> cases phaseBit right mode <;> rfl
end SFT.Physics.QuantumSupportOrthogonalityNative
