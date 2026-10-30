import verification.TURN_345_ReversibleObservationDraft
namespace SFT.QuantumComputation.ReversibleFaults
open SFT.Mathematics.DiscreteObjects

def encode (label : String) (depthTrace : List String) : Except String (List String) :=
  if !has ["held","returned"] label || depthTrace.isEmpty || !distinct depthTrace then
    .error "code requires a held label and nonempty generated fault-depth trace"
  else .ok (List.replicate (2*depthTrace.length+1) label)

def labelCount (label : String) : List String → Nat
  | [] => 0
  | first::rest => if first = label then labelCount label rest + 1 else labelCount label rest

def decode (word : List String) : Except String String :=
  if word.isEmpty || word.any (fun label => !has ["held","returned"] label) then
    .error "codeword contains an external label"
  else
    let held := labelCount "held" word
    let returned := labelCount "returned" word
    if held = returned then .error "decoder requires an odd generated width"
    else if returned < held then .ok "held" else .ok "returned"

def combinations : List Nat → Nat → List (List Nat)
  | [], k => match k with
    | 0 => [[]]
    | .succ _ => []
  | first::rest, k => match k with
    | 0 => [[]]
    | .succ smaller => (combinations rest smaller).map (List.cons first) ++ combinations rest (smaller+1)

def faultMasks (width depth : Nat) : List (List Nat) :=
  (List.range (depth+1)).flatMap (fun count => combinations (List.range width) count)

def changeFrom (mask : List Nat) (opposite : String) (index : Nat) : List String → List String
  | [] => []
  | first::rest => (if has mask index then opposite else first) :: changeFrom mask opposite (index+1) rest

def decodeMasks (encoded : List String) (opposite : String) : List (List Nat) → Except String (List (List String × String))
  | [] => .ok []
  | mask::rest =>
    let changed := changeFrom mask opposite 0 encoded
    match decode changed with
    | .error error => .error error
    | .ok label => match decodeMasks encoded opposite rest with
      | .error error => .error error
      | .ok tail => .ok ((changed,label)::tail)

def exhaustiveFaultCensus (label : String) (depthTrace : List String) : Except String (List (List String × String)) :=
  match encode label depthTrace with
  | .error error => .error error
  | .ok encoded => decodeMasks encoded (if label = "held" then "returned" else "held")
      (faultMasks encoded.length depthTrace.length)

theorem faultWordLength (mask : List Nat) (opposite : String) (index : Nat) (word : List String) :
    (changeFrom mask opposite index word).length = word.length := by
  induction word generalizing index with
  | nil => rfl
  | cons first rest ih => exact congrArg Nat.succ (ih (index+1))

open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

theorem emptySublist (items : List Nat) : ([] : List Nat).Sublist items := by
  induction items with
  | nil => exact .slnil
  | cons first rest ih => exact .cons first ih

theorem zeroCombinations (items : List Nat) : combinations items 0 = [[]] := by cases items <;> rfl

theorem combinationSound (items mask : List Nat) (count : Nat)
    (member : mask ∈ combinations items count) : mask.Sublist items ∧ mask.length = count := by
  induction items generalizing count mask with
  | nil =>
    cases count with
    | zero => cases member with
      | head => exact ⟨.slnil,rfl⟩
      | tail _ h => cases h
    | succ count => cases member
  | cons first rest ih =>
    cases count with
    | zero =>
      rw [zeroCombinations] at member
      cases member with
      | head => exact ⟨emptySublist _,rfl⟩
      | tail _ h => cases h
    | succ count =>
      change mask ∈ (combinations rest count).map (List.cons first) ++ combinations rest (count+1) at member
      cases memAppendCases _ _ _ member with
      | inl member =>
        obtain ⟨tail,held,equal⟩ := memMapPreimage (List.cons first) mask _ member
        cases equal
        have prior := ih tail count held
        exact ⟨.cons_cons first prior.1,congrArg Nat.succ prior.2⟩
      | inr member =>
        have prior := ih mask (count+1) member
        exact ⟨.cons first prior.1,prior.2⟩

theorem emptyOfLengthZero (items : List Nat) (length : items.length = 0) : items = [] := by
  cases items with
  | nil => rfl
  | cons first rest => cases length

theorem combinationComplete (items mask : List Nat) (contained : mask.Sublist items) (count : Nat)
    (length : mask.length = count) : mask ∈ combinations items count := by
  induction contained generalizing count with
  | slnil => cases length; exact .head _
  | @cons left right first contained ih =>
    cases count with
    | zero =>
      have empty := emptyOfLengthZero left length
      cases empty
      rw [zeroCombinations]
      exact .head _
    | succ count =>
      exact memAppendRight _ _ _ (ih (count+1) length)
  | cons_cons first contained ih =>
    cases count with
    | zero => cases length
    | succ count =>
      apply memAppendLeft
      exact memMap (List.cons first) _ _ (ih count (Nat.succ.inj length))

theorem combinationExactly (items mask : List Nat) (count : Nat) :
    mask ∈ combinations items count ↔ mask.Sublist items ∧ mask.length = count :=
  ⟨combinationSound items mask count,fun h => combinationComplete items mask h.1 count h.2⟩

theorem rangeLoopMembership (bound value : Nat) (acc : List Nat) :
    value ∈ List.range.loop bound acc ↔ value < bound ∨ value ∈ acc := by
  induction bound generalizing acc with
  | zero =>
    constructor
    · intro h; exact .inr h
    · intro h; cases h with
      | inl h => exact False.elim (Nat.not_lt_zero _ h)
      | inr h => exact h
  | succ bound ih =>
    change value ∈ List.range.loop bound (bound::acc) ↔ _
    constructor
    · intro h
      cases (ih (bound::acc)).mp h with
      | inl h => exact .inl (Nat.lt_trans h (Nat.lt_succ_self _))
      | inr h => cases h with
        | head => exact .inl (Nat.lt_succ_self _)
        | tail _ h => exact .inr h
    · intro h
      apply (ih (bound::acc)).mpr
      cases h with
      | inl h =>
        cases Nat.lt_or_eq_of_le (Nat.le_of_lt_succ h) with
        | inl h => exact .inl h
        | inr h => cases h; exact .inr (.head _)
      | inr h => exact .inr (.tail _ h)

theorem rangeMembership (bound value : Nat) : value ∈ List.range bound ↔ value < bound := by
  constructor
  · intro h
    cases (rangeLoopMembership bound value []).mp h with
    | inl h => exact h
    | inr h => cases h
  · intro h; exact (rangeLoopMembership bound value []).mpr (.inl h)

theorem faultMasksExactly (width depth : Nat) (mask : List Nat) :
    mask ∈ faultMasks width depth ↔ mask.Sublist (List.range width) ∧ mask.length ≤ depth := by
  constructor
  · intro h
    obtain ⟨count,generated,held⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin
      (fun count => combinations (List.range width) count) (List.range (depth+1)) mask h
    have parts := combinationSound _ _ _ held
    exact ⟨parts.1,parts.2 ▸ Nat.le_of_lt_succ ((rangeMembership _ _).mp generated)⟩
  · intro h
    exact SFT.Foundation.CommonRefinement.memFlatMap _ _ mask.length mask
      ((rangeMembership _ _).mpr (Nat.lt_succ_of_le h.2))
      (combinationComplete _ _ h.1 _ rfl)

end SFT.QuantumComputation.ReversibleFaults
