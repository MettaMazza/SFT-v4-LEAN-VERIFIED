import SFT.Host.Canonical
import SFT.Mathematics.GeometryTopology
namespace SFT.Physics.CapabilityValues
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology

-- Python's str.strip whitespace set, used only for host string admission.
def whitespace (c : Char) : Bool := has
  [9,10,11,12,13,28,29,30,31,32,133,160,5760,8192,8193,8194,8195,8196,8197,8198,8199,8200,8201,8202,8232,8233,8239,8287,12288] c.toNat
def nonblank (s : String) : Bool := !(SFT.Host.Text.chars s).all whitespace

structure PositiveCount where
  value : Nat
  positive : 0 < value
  deriving DecidableEq

def count (n : Nat) : Except String PositiveCount :=
  if h : 0 < n then .ok ⟨n,h⟩ else .error "an SFT count must be a positive counted value"

structure HeldLabel where
  family : String
  label : String
  familyHeld : nonblank family = true
  labelHeld : nonblank label = true
  deriving DecidableEq

def heldLabel (family label : String) : Except String HeldLabel :=
  if f : nonblank family = true then
    if l : nonblank label = true then .ok ⟨family,label,f,l⟩
    else .error "held labels require a named family and label"
  else .error "held labels require a named family and label"

inductive Value where
 | emptyOne : String → Value
 | count : PositiveCount → Value
 | ratio : PositiveCount → PositiveCount → Value
 | label : HeldLabel → Value
 | word : List Value → Value
 | pair : Value → Value → Value
 | table : List (Value × Value) → Value

mutual
 def equal : Value → Value → Bool
  | .emptyOne a1, .emptyOne a2 => decide (a1 = a2)
  | .emptyOne _, .count _ => false
  | .emptyOne _, .ratio _ _ => false
  | .emptyOne _, .label _ => false
  | .emptyOne _, .word _ => false
  | .emptyOne _, .pair _ _ => false
  | .emptyOne _, .table _ => false
  | .count _, .emptyOne _ => false
  | .count a1, .count a2 => decide (a1.value = a2.value)
  | .count _, .ratio _ _ => false
  | .count _, .label _ => false
  | .count _, .word _ => false
  | .count _, .pair _ _ => false
  | .count _, .table _ => false
  | .ratio _ _, .emptyOne _ => false
  | .ratio _ _, .count _ => false
  | .ratio a1 b1, .ratio a2 b2 => decide (a1.value = a2.value) && decide (b1.value = b2.value)
  | .ratio _ _, .label _ => false
  | .ratio _ _, .word _ => false
  | .ratio _ _, .pair _ _ => false
  | .ratio _ _, .table _ => false
  | .label _, .emptyOne _ => false
  | .label _, .count _ => false
  | .label _, .ratio _ _ => false
  | .label a1, .label a2 => decide (a1.family = a2.family) && decide (a1.label = a2.label)
  | .label _, .word _ => false
  | .label _, .pair _ _ => false
  | .label _, .table _ => false
  | .word _, .emptyOne _ => false
  | .word _, .count _ => false
  | .word _, .ratio _ _ => false
  | .word _, .label _ => false
  | .word a1, .word a2 => equalList a1 a2
  | .word _, .pair _ _ => false
  | .word _, .table _ => false
  | .pair _ _, .emptyOne _ => false
  | .pair _ _, .count _ => false
  | .pair _ _, .ratio _ _ => false
  | .pair _ _, .label _ => false
  | .pair _ _, .word _ => false
  | .pair a1 b1, .pair a2 b2 => equal a1 a2 && equal b1 b2
  | .pair _ _, .table _ => false
  | .table _, .emptyOne _ => false
  | .table _, .count _ => false
  | .table _, .ratio _ _ => false
  | .table _, .label _ => false
  | .table _, .word _ => false
  | .table _, .pair _ _ => false
  | .table a1, .table a2 => equalEntries a1 a2
 def equalList : List Value → List Value → Bool
  | [], [] => true
  | [], _::_ => false
  | _::_, [] => false
  | a::as, b::bs => equal a b && equalList as bs
 def equalEntries : List (Value × Value) → List (Value × Value) → Bool
  | [], [] => true
  | [], _::_ => false
  | _::_, [] => false
  | (a,b)::as, (c,d)::bs => (equal a c && equal b d) && equalEntries as bs
end

abbrev JSON := SFT.Host.Canonical.Value

def countJSON (n : PositiveCount) : JSON := .object [("value",.integer (Int.ofNat n.value))]
mutual
 def canonical : Value → JSON
  | .emptyOne identity => .object [("identity",.text identity)]
  | .count n => countJSON n
  | .ratio n d => .object [("numerator",countJSON n),("denominator",countJSON d)]
  | .label label => .object [("family",.text label.family),("label",.text label.label)]
  | .word cells => .object [("cells",.array (canonicalList cells))]
  | .pair left right => .object [("left",canonical left),("right",canonical right)]
  | .table entries => .object [("entries",.array (canonicalEntries entries))]
 def canonicalList : List Value → List JSON
  | [] => []
  | x::xs => canonical x :: canonicalList xs
 def canonicalEntries : List (Value × Value) → List JSON
  | [] => []
  | (left,right)::rest => .object [("left",canonical left),("right",canonical right)] :: canonicalEntries rest
end

def identity (v : Value) : String := SFT.Host.Canonical.identity (canonical v)
def table (entries : List (Value × Value)) : Except String Value :=
  if entries.isEmpty then .error "a Fold table requires generated positive support"
  else if distinct (entries.map (fun e => identity e.1)) then .ok (.table entries)
  else .error "a Fold table cannot contain duplicate keys"

theorem countPositive (n : Nat) (c : PositiveCount) (accepted : count n = .ok c) : 0 < c.value := c.positive

theorem countIdentity (n : Nat) (c : PositiveCount) (accepted : count n = .ok c) : c.value = n := by
  unfold count at accepted
  split at accepted
  · cases accepted; rfl
  · cases accepted

theorem zeroRejected : count 0 = .error "an SFT count must be a positive counted value" := rfl

theorem labelIdentity (family label : String) (value : HeldLabel) (accepted : heldLabel family label = .ok value) :
    value.family = family ∧ value.label = label := by
  unfold heldLabel at accepted
  split at accepted
  · split at accepted
    · cases accepted; exact ⟨rfl,rfl⟩
    · cases accepted
  · cases accepted

theorem labelNonblank (value : HeldLabel) : nonblank value.family = true ∧ nonblank value.label = true :=
  ⟨value.familyHeld,value.labelHeld⟩

theorem tableEmptyRejected : table [] = .error "a Fold table requires generated positive support" := rfl
theorem countExt (a b : PositiveCount) (same : a.value = b.value) : a = b := by
  cases a; cases b; cases same; rfl
theorem labelExt (a b : HeldLabel) (family : a.family = b.family) (label : a.label = b.label) : a = b := by
  cases a; cases b; cases family; cases label; rfl
mutual
 theorem equalMeaning : (a b : Value) → (equal a b = true ↔ a = b)
  | .emptyOne a1, .emptyOne a2 => by
    constructor
    · intro h
      exact congrArg Value.emptyOne (of_decide_eq_true h)
    · intro h
      cases h
      exact decide_eq_true rfl
  | .emptyOne a1, .count a2 => by
    constructor <;> intro h <;> cases h
  | .emptyOne a1, .ratio a2 b2 => by
    constructor <;> intro h <;> cases h
  | .emptyOne a1, .label a2 => by
    constructor <;> intro h <;> cases h
  | .emptyOne a1, .word a2 => by
    constructor <;> intro h <;> cases h
  | .emptyOne a1, .pair a2 b2 => by
    constructor <;> intro h <;> cases h
  | .emptyOne a1, .table a2 => by
    constructor <;> intro h <;> cases h
  | .count a1, .emptyOne a2 => by
    constructor <;> intro h <;> cases h
  | .count a1, .count a2 => by
    constructor
    · intro h
      exact congrArg Value.count (countExt _ _ (of_decide_eq_true h))
    · intro h
      cases h
      exact decide_eq_true rfl
  | .count a1, .ratio a2 b2 => by
    constructor <;> intro h <;> cases h
  | .count a1, .label a2 => by
    constructor <;> intro h <;> cases h
  | .count a1, .word a2 => by
    constructor <;> intro h <;> cases h
  | .count a1, .pair a2 b2 => by
    constructor <;> intro h <;> cases h
  | .count a1, .table a2 => by
    constructor <;> intro h <;> cases h
  | .ratio a1 b1, .emptyOne a2 => by
    constructor <;> intro h <;> cases h
  | .ratio a1 b1, .count a2 => by
    constructor <;> intro h <;> cases h
  | .ratio a1 b1, .ratio a2 b2 => by
    constructor
    · intro h
      have p := (andTrue _ _).mp h
      cases countExt a1 a2 (of_decide_eq_true p.1)
      cases countExt b1 b2 (of_decide_eq_true p.2)
      rfl
    · intro h
      cases h
      exact (andTrue _ _).mpr ⟨decide_eq_true rfl,decide_eq_true rfl⟩
  | .ratio a1 b1, .label a2 => by
    constructor <;> intro h <;> cases h
  | .ratio a1 b1, .word a2 => by
    constructor <;> intro h <;> cases h
  | .ratio a1 b1, .pair a2 b2 => by
    constructor <;> intro h <;> cases h
  | .ratio a1 b1, .table a2 => by
    constructor <;> intro h <;> cases h
  | .label a1, .emptyOne a2 => by
    constructor <;> intro h <;> cases h
  | .label a1, .count a2 => by
    constructor <;> intro h <;> cases h
  | .label a1, .ratio a2 b2 => by
    constructor <;> intro h <;> cases h
  | .label a1, .label a2 => by
    constructor
    · intro h
      have p := (andTrue _ _).mp h
      exact congrArg Value.label (labelExt _ _ (of_decide_eq_true p.1) (of_decide_eq_true p.2))
    · intro h
      cases h
      exact (andTrue _ _).mpr ⟨decide_eq_true rfl,decide_eq_true rfl⟩
  | .label a1, .word a2 => by
    constructor <;> intro h <;> cases h
  | .label a1, .pair a2 b2 => by
    constructor <;> intro h <;> cases h
  | .label a1, .table a2 => by
    constructor <;> intro h <;> cases h
  | .word a1, .emptyOne a2 => by
    constructor <;> intro h <;> cases h
  | .word a1, .count a2 => by
    constructor <;> intro h <;> cases h
  | .word a1, .ratio a2 b2 => by
    constructor <;> intro h <;> cases h
  | .word a1, .label a2 => by
    constructor <;> intro h <;> cases h
  | .word a1, .word a2 => by
    constructor
    · intro h
      exact congrArg Value.word ((equalListMeaning _ _).mp h)
    · intro h
      cases h
      exact (equalListMeaning _ _).mpr rfl
  | .word a1, .pair a2 b2 => by
    constructor <;> intro h <;> cases h
  | .word a1, .table a2 => by
    constructor <;> intro h <;> cases h
  | .pair a1 b1, .emptyOne a2 => by
    constructor <;> intro h <;> cases h
  | .pair a1 b1, .count a2 => by
    constructor <;> intro h <;> cases h
  | .pair a1 b1, .ratio a2 b2 => by
    constructor <;> intro h <;> cases h
  | .pair a1 b1, .label a2 => by
    constructor <;> intro h <;> cases h
  | .pair a1 b1, .word a2 => by
    constructor <;> intro h <;> cases h
  | .pair a1 b1, .pair a2 b2 => by
    constructor
    · intro h
      have p := (andTrue _ _).mp h
      cases (equalMeaning _ _).mp p.1
      cases (equalMeaning _ _).mp p.2
      rfl
    · intro h
      cases h
      exact (andTrue _ _).mpr ⟨(equalMeaning _ _).mpr rfl,(equalMeaning _ _).mpr rfl⟩
  | .pair a1 b1, .table a2 => by
    constructor <;> intro h <;> cases h
  | .table a1, .emptyOne a2 => by
    constructor <;> intro h <;> cases h
  | .table a1, .count a2 => by
    constructor <;> intro h <;> cases h
  | .table a1, .ratio a2 b2 => by
    constructor <;> intro h <;> cases h
  | .table a1, .label a2 => by
    constructor <;> intro h <;> cases h
  | .table a1, .word a2 => by
    constructor <;> intro h <;> cases h
  | .table a1, .pair a2 b2 => by
    constructor <;> intro h <;> cases h
  | .table a1, .table a2 => by
    constructor
    · intro h
      exact congrArg Value.table ((equalEntriesMeaning _ _).mp h)
    · intro h
      cases h
      exact (equalEntriesMeaning _ _).mpr rfl
 theorem equalListMeaning : (a b : List Value) → (equalList a b = true ↔ a = b)
  | [], [] => ⟨fun _ => rfl,fun _ => rfl⟩
  | [], _::_ => by constructor <;> intro h <;> cases h
  | _::_, [] => by constructor <;> intro h <;> cases h
  | a::as, b::bs => by
    constructor
    · intro h
      have p := (andTrue _ _).mp h
      cases (equalMeaning _ _).mp p.1
      cases (equalListMeaning _ _).mp p.2
      rfl
    · intro h
      cases h
      exact (andTrue _ _).mpr ⟨(equalMeaning _ _).mpr rfl,(equalListMeaning _ _).mpr rfl⟩
 theorem equalEntriesMeaning : (a b : List (Value × Value)) → (equalEntries a b = true ↔ a = b)
  | [], [] => ⟨fun _ => rfl,fun _ => rfl⟩
  | [], _::_ => by constructor <;> intro h <;> cases h
  | _::_, [] => by constructor <;> intro h <;> cases h
  | (a,b)::as, (c,d)::bs => by
    constructor
    · intro h
      have p := (andTrue _ _).mp h
      have q := (andTrue _ _).mp p.1
      cases (equalMeaning _ _).mp q.1
      cases (equalMeaning _ _).mp q.2
      cases (equalEntriesMeaning _ _).mp p.2
      rfl
    · intro h
      cases h
      exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(equalMeaning _ _).mpr rfl,(equalMeaning _ _).mpr rfl⟩,(equalEntriesMeaning _ _).mpr rfl⟩
end
theorem tableAdmission (entries : List (Value × Value)) : table entries = .ok (.table entries) ↔
    entries.isEmpty = false ∧ distinct (entries.map (fun e => identity e.1)) = true := by
  unfold table
  cases empty : entries.isEmpty with
  | true =>
    constructor
    · intro bad; cases bad
    · intro bad; cases bad.1
  | false =>
    cases keys : distinct (entries.map (fun e => identity e.1)) with
    | false =>
      constructor
      · intro bad; cases bad
      · intro bad; cases bad.2
    | true => exact ⟨fun _ => ⟨rfl,rfl⟩,fun _ => rfl⟩

theorem duplicateKeysRejected (entries : List (Value × Value)) (nonempty : entries.isEmpty = false)
    (duplicates : distinct (entries.map (fun e => identity e.1)) = false) :
    table entries = .error "a Fold table cannot contain duplicate keys" := by
  unfold table; rw [nonempty,duplicates]; rfl
end SFT.Physics.CapabilityValues
