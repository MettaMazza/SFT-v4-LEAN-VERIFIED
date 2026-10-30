import SFT.QuantumComputation.ReversibleCorrection
namespace SFT.QuantumComputation.Coding
open SFT.QuantumComputation.ReversibleFaults

theorem declaredErrorSupportsDisjoint (depth : Nat) (left right : List Nat)
    (leftBound : left.length ≤ depth) (rightBound : right.length ≤ depth) :
    changeFrom left "returned" 0 (List.replicate (2*depth+1) "held") ≠
      changeFrom right "held" 0 (List.replicate (2*depth+1) "returned") := by
  intro same
  have held := heldCorrection left depth leftBound
  have returned := returnedCorrection right depth rightBound
  rw [same,returned] at held
  have bad := Except.ok.inj held
  exact (by decide : ("returned" : String) ≠ "held") bad

theorem everyDeclaredErrorReconstructed (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) (mask : List Nat)
    (declared : mask ∈ faultMasks encoded.length trace.length) :
    decode (changeFrom mask (if label = "held" then "returned" else "held") 0 encoded) = .ok label := by
  have bound := ((faultMasksExactly encoded.length trace.length mask).mp declared).2
  have source := encodeAdmission label trace encoded accepted
  rw [source.2]
  cases source.1 with
  | inl same => cases same; exact heldCorrection mask trace.length bound
  | inr same => cases same; exact returnedCorrection mask trace.length bound

theorem noDeclaredError (word : List String) (opposite : String) (index : Nat) :
    changeFrom [] opposite index word = word := by
  induction word generalizing index with
  | nil => rfl
  | cons first rest ih => exact congrArg (List.cons first) (ih (index+1))

theorem encoderReconstruction (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) : decode encoded = .ok label := by
  have source := encodeAdmission label trace encoded accepted
  rw [source.2]
  cases source.1 with
  | inl same =>
    cases same
    have restored := heldCorrection [] trace.length (Nat.zero_le _)
    rw [noDeclaredError] at restored
    exact restored
  | inr same =>
    cases same
    have restored := returnedCorrection [] trace.length (Nat.zero_le _)
    rw [noDeclaredError] at restored
    exact restored

end SFT.QuantumComputation.Coding
