import verification.TURN_346_ReversibleFaultDraft
namespace SFT.QuantumComputation.ReversibleFaults
open SFT.Mathematics.DiscreteObjects

def removePosition (position : Nat) : List Nat → List Nat
  | [] => []
  | first::rest => if first = position then rest else first :: removePosition position rest

theorem removedOther (mask : List Nat) (position value : Nat) (different : position ≠ value) :
    has (removePosition position mask) value = has mask value := by
  induction mask with
  | nil => rfl
  | cons first rest ih =>
    by_cases eq : first = position
    · cases eq; rw [removePosition,ite_eq_left rfl,has,ite_eq_right different]
    · rw [removePosition,ite_eq_right eq,has,has,ih]

theorem removedLength (mask : List Nat) (position : Nat) (held : has mask position = true) :
    (removePosition position mask).length + 1 = mask.length := by
  induction mask with
  | nil => cases held
  | cons first rest ih =>
    by_cases eq : first = position
    · rw [removePosition,ite_eq_left eq]; rfl
    · rw [has,ite_eq_right eq] at held
      rw [removePosition,ite_eq_right eq]
      exact congrArg Nat.succ (ih held)

theorem changeAgreesAbove (left right : List Nat) (opposite : String) (index : Nat) (word : List String)
    (agree : ∀ value, index ≤ value → has left value = has right value) :
    changeFrom left opposite index word = changeFrom right opposite index word := by
  induction word generalizing index with
  | nil => rfl
  | cons first rest ih =>
    rw [changeFrom,changeFrom,agree index (Nat.le_refl _)]
    rw [ih (index+1) (fun value bound => agree value (Nat.le_trans (Nat.le_succ _) bound))]

theorem removeEarlierUnchanged (mask : List Nat) (opposite : String) (position : Nat) (word : List String) :
    changeFrom (removePosition position mask) opposite (position+1) word =
      changeFrom mask opposite (position+1) word := by
  apply changeAgreesAbove
  intro value bound
  exact removedOther mask position value (fun equal => Nat.not_succ_le_self position (equal ▸ bound))

theorem changedCountBound (mask : List Nat) (original opposite : String) (different : original ≠ opposite)
    (index width : Nat) :
    labelCount opposite (changeFrom mask opposite index (List.replicate width original)) ≤ mask.length := by
  induction width generalizing index mask with
  | zero => exact Nat.zero_le _
  | succ width ih =>
    rw [List.replicate_succ,changeFrom]
    cases selected : has mask index with
    | false =>
      change labelCount opposite (original :: changeFrom mask opposite (index+1) (List.replicate width original)) ≤ mask.length
      rw [labelCount,ite_eq_right different]
      exact ih mask (index+1)
    | true =>
      change labelCount opposite (opposite :: changeFrom mask opposite (index+1) (List.replicate width original)) ≤ mask.length
      rw [labelCount,ite_eq_left rfl]
      rw [← removeEarlierUnchanged mask opposite index]
      have bound := Nat.succ_le_succ (ih (removePosition index mask) (index+1))
      exact (removedLength mask index selected) ▸ bound

theorem changedCounts (mask : List Nat) (original opposite : String) (different : original ≠ opposite)
    (index width : Nat) :
    labelCount original (changeFrom mask opposite index (List.replicate width original)) +
    labelCount opposite (changeFrom mask opposite index (List.replicate width original)) = width := by
  induction width generalizing index with
  | zero => rfl
  | succ width ih =>
    rw [List.replicate_succ,changeFrom]
    cases selected : has mask index with
    | false =>
      change labelCount original (original :: _) + labelCount opposite (original :: _) = width+1
      rw [labelCount,ite_eq_left rfl,labelCount,ite_eq_right different]
      rw [Nat.add_right_comm,ih]
    | true =>
      change labelCount original (opposite :: _) + labelCount opposite (opposite :: _) = width+1
      rw [labelCount,ite_eq_right (Ne.symm different),labelCount,ite_eq_left rfl]
      rw [← Nat.add_assoc,ih]

theorem changedExternalGuard (mask : List Nat) (original opposite : String)
    (originalAllowed : has ["held","returned"] original = true)
    (oppositeAllowed : has ["held","returned"] opposite = true) (index width : Nat) :
    (changeFrom mask opposite index (List.replicate width original)).any
      (fun label => !has ["held","returned"] label) = false := by
  induction width generalizing index with
  | zero => rfl
  | succ width ih =>
    rw [List.replicate_succ,changeFrom,List.any_cons]
    cases selected : has mask index with
    | false =>
      change (!has ["held","returned"] original || _) = false
      rw [originalAllowed,ih]; rfl
    | true =>
      change (!has ["held","returned"] opposite || _) = false
      rw [oppositeAllowed,ih]; rfl

theorem majorityFromBudget (correct wrong depth : Nat)
    (total : correct + wrong = 2*depth+1) (bounded : wrong ≤ depth) : wrong < correct := by
  cases Nat.lt_or_ge wrong correct with
  | inl h => exact h
  | inr h =>
    have sum := Nat.add_le_add (Nat.le_trans h bounded) bounded
    rw [total,← Nat.two_mul] at sum
    exact False.elim (Nat.not_succ_le_self _ sum)

theorem heldCorrection (mask : List Nat) (depth : Nat) (bounded : mask.length ≤ depth) :
    decode (changeFrom mask "returned" 0 (List.replicate (2*depth+1) "held")) = .ok "held" := by
  have count := changedCountBound mask "held" "returned" (by decide) 0 (2*depth+1)
  have total := changedCounts mask "held" "returned" (by decide) 0 (2*depth+1)
  have majority := majorityFromBudget _ _ depth total (Nat.le_trans count bounded)
  have guard := changedExternalGuard mask "held" "returned" rfl rfl 0 (2*depth+1)
  have nonempty : (changeFrom mask "returned" 0 (List.replicate (2*depth+1) "held")).isEmpty = false := rfl
  unfold decode
  rw [guard,nonempty]
  change (if _ = _ then _ else if _ < _ then _ else _) = _
  rw [ite_eq_right (Nat.ne_of_gt majority),ite_eq_left majority]

theorem returnedCorrection (mask : List Nat) (depth : Nat) (bounded : mask.length ≤ depth) :
    decode (changeFrom mask "held" 0 (List.replicate (2*depth+1) "returned")) = .ok "returned" := by
  have count := changedCountBound mask "returned" "held" (by decide) 0 (2*depth+1)
  have total := changedCounts mask "returned" "held" (by decide) 0 (2*depth+1)
  have majority := majorityFromBudget _ _ depth total (Nat.le_trans count bounded)
  have guard := changedExternalGuard mask "returned" "held" rfl rfl 0 (2*depth+1)
  have nonempty : (changeFrom mask "held" 0 (List.replicate (2*depth+1) "returned")).isEmpty = false := rfl
  unfold decode
  rw [guard,nonempty]
  change (if _ = _ then _ else if _ < _ then _ else _) = _
  rw [ite_eq_right (Nat.ne_of_lt majority),ite_eq_right (Nat.not_lt_of_ge (Nat.le_of_lt majority))]

theorem decodeMasksComplete (encoded : List String) (opposite label : String) (masks : List (List Nat))
    (correct : ∀ mask, mask ∈ masks → decode (changeFrom mask opposite 0 encoded) = .ok label) :
    decodeMasks encoded opposite masks = .ok (masks.map (fun mask => (changeFrom mask opposite 0 encoded,label))) := by
  induction masks with
  | nil => rfl
  | cons mask rest ih =>
    rw [decodeMasks,correct mask (.head _)]
    change (match decodeMasks encoded opposite rest with
      | .error error => .error error
      | .ok tail => .ok ((changeFrom mask opposite 0 encoded,label)::tail) : Except String (List (List String × String))) = _
    rw [ih (fun next held => correct next (.tail _ held))]
    rfl

theorem encodeAdmission (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) :
    (label = "held" ∨ label = "returned") ∧ encoded = List.replicate (2*trace.length+1) label := by
  unfold encode at accepted
  split at accepted
  · cases accepted
  · rename_i guard
    have allowed : has ["held","returned"] label = true := by
      cases h : has ["held","returned"] label with
      | true => rfl
      | false => rw [h] at guard; exact False.elim (guard rfl)
    have member := (hasIff ["held","returned"] label).mp allowed
    constructor
    · cases member with
      | head => exact .inl rfl
      | tail _ member => cases member with
        | head => exact .inr rfl
        | tail _ member => cases member
    · exact (Except.ok.inj accepted).symm

theorem exhaustiveCorrection (label : String) (trace encoded : List String)
    (accepted : encode label trace = .ok encoded) :
    exhaustiveFaultCensus label trace = .ok
      ((faultMasks encoded.length trace.length).map (fun mask =>
        (changeFrom mask (if label = "held" then "returned" else "held") 0 encoded,label))) := by
  have admission := encodeAdmission label trace encoded accepted
  unfold exhaustiveFaultCensus
  rw [accepted]
  apply decodeMasksComplete
  intro mask held
  have bound := ((faultMasksExactly encoded.length trace.length mask).mp held).2
  rw [admission.2]
  cases admission.1 with
  | inl eq => cases eq; exact heldCorrection mask trace.length bound
  | inr eq => cases eq; exact returnedCorrection mask trace.length bound

end SFT.QuantumComputation.ReversibleFaults
