import SFT.QuantumComputation.Coding
namespace SFT.QuantumComputation.ErrorCorrection
open SFT.QuantumComputation.ReversibleFaults SFT.Foundation.Count.TraceDerivation

theorem exactRepetitionWidth (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) : encoded.length = 2*trace.length+1 := by
  have count : ∀ n : Nat, (List.replicate n label).length = n := by
    intro n
    induction n with
    | zero => rfl
    | succ n ih => exact congrArg Nat.succ ih
  rw [(encodeAdmission label trace encoded accepted).2]
  exact count _

theorem completeCensusRows (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) (rows : List (List String × String))
    (generated : exhaustiveFaultCensus label trace = .ok rows) (row : List String × String) :
    row ∈ rows ↔ ∃ mask, mask.Sublist (List.range encoded.length) ∧ mask.length ≤ trace.length ∧
      row = (changeFrom mask (if label = "held" then "returned" else "held") 0 encoded,label) := by
  have full := exhaustiveCorrection label trace encoded accepted
  rw [generated] at full
  have same := Except.ok.inj full
  rw [same]
  constructor
  · intro held
    obtain ⟨mask,member,equal⟩ := memMapPreimage _ row _ held
    have allowed := (faultMasksExactly encoded.length trace.length mask).mp member
    exact ⟨mask,allowed.1,allowed.2,equal.symm⟩
  · intro ⟨mask,inside,bounded,equal⟩
    rw [equal]
    exact memMap _ mask _ ((faultMasksExactly encoded.length trace.length mask).mpr ⟨inside,bounded⟩)
theorem everyCensusRowRecovers (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) (rows : List (List String × String))
    (generated : exhaustiveFaultCensus label trace = .ok rows) (row : List String × String)
    (held : row ∈ rows) : decode row.1 = .ok row.2 := by
  obtain ⟨mask,inside,bounded,equal⟩ := (completeCensusRows label trace encoded accepted rows generated row).mp held
  rw [equal]
  exact SFT.QuantumComputation.Coding.everyDeclaredErrorReconstructed label trace encoded accepted mask
    ((faultMasksExactly encoded.length trace.length mask).mpr ⟨inside,bounded⟩)
theorem successorRetainsRecovery (label : String) (trace : List String) (fresh : String)
    (encoded : List String) (accepted : encode label (trace ++ [fresh]) = .ok encoded)
    (mask : List Nat) (oldMask : mask ∈ faultMasks (2*trace.length+1) trace.length) :
    decode (changeFrom mask (if label = "held" then "returned" else "held") 0 encoded) = .ok label := by
  have oldBound := ((faultMasksExactly (2*trace.length+1) trace.length mask).mp oldMask).2
  have bound : mask.length ≤ (trace ++ [fresh]).length := by
    rw [SFT.Foundation.CommonRefinement.appendLength]
    exact Nat.le_trans oldBound (Nat.le_succ trace.length)
  have source := encodeAdmission label (trace ++ [fresh]) encoded accepted
  rw [source.2]
  cases source.1 with
  | inl same => cases same; exact heldCorrection mask (trace ++ [fresh]).length bound
  | inr same => cases same; exact returnedCorrection mask (trace ++ [fresh]).length bound
end SFT.QuantumComputation.ErrorCorrection
