import SFT.Computation.NativeClosing
namespace SFT.Computation.NativeClosingDomain
open SFT.InformationScience.QuantitySupport NativeClosing

theorem heldLabelAccepted (label : String) (held : label∈labels) : labels.contains label=true := by
 cases held with
 | head => rfl
 | tail _ held => cases held with
   | head => rfl
   | tail _ impossible => cases impossible

theorem wholeCarrierAccepted (word : Word) (held : ∀ label, label∈word → label∈labels) :
 word.all (fun label => labels.contains label)=true := by
 induction word with
 | nil => rfl
 | cons x xs ih =>
   rw [List.all_cons,heldLabelAccepted x (held x (.head _)),ih (fun label h => held label (.tail _ h))]
   rfl

theorem generatedWordAdmitted (depth : Nat) (positive : 0<depth) (word : Word)
 (generated : word∈words labels depth) : closingTrace word=.ok (suffixTrace word) := by
 have carrier := (wordCharacterization _ _ _).mp generated
 have all := wholeCarrierAccepted word carrier.2
 unfold closingTrace
 rw [all]
 cases word with
 | nil => rw [← carrier.1] at positive; cases positive
 | cons x xs => rfl

theorem firstGeneratedWord (depth : Nat) :
 ∃ tail, words labels depth=attainingWord depth::tail := by
 induction depth with
 | zero => exact ⟨[],rfl⟩
 | succ n ih =>
   obtain ⟨tail,eq⟩ := ih
   refine ⟨tail.map (List.cons "held-lower") ++ (words labels n).map (List.cons "held-upper"),?_⟩
   change ((words labels n).map (List.cons "held-lower") ++ ((words labels n).map (List.cons "held-upper") ++ [])) = _
   rw [SFT.InformationScience.SymbolExtension.appendNil,eq]
   rfl
end SFT.Computation.NativeClosingDomain
