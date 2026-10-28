import SFT.Computation.StateExtension
import SFT.InformationScience.CompressionSupport
namespace SFT.Computation.StateWords
open SFT.InformationScience.QuantitySupport SFT.InformationScience.CompressionSupport
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

def grow (alphabet : List String) : Nat → List Word × List Word
 | 0 => ([[]],[["empty-One"]])
 | n+1 => let previous := grow alphabet n
          let frontier := extendWords alphabet previous.1
          (frontier,previous.2 ++ frontier)

def generatedWords (alphabet positions : List String) : Except String (List Word) :=
  if !distinct alphabet then .error "ValueError: alphabet must contain unique generated identities"
  else if !distinct positions then .error "ValueError: depth trace must contain unique generated identities"
  else if alphabet.isEmpty then .error "ValueError: alphabet requires a generated symbol"
  else .ok (grow alphabet positions.length).2

def rewriteRows (word : Word) (held : String) (positions : List String) (replacement : String) : Word :=
  (positions.zip word).map (fun pair => if pair.1 = held then replacement else pair.2)

def exactRewrite (word : Word) (held : String) (positions : List String) (replacement : String) : Except String Word :=
  if !distinct positions then .error "ValueError: positions must contain unique generated identities"
  else if !decide (word.length = positions.length) || !has positions held then
    .error "ValueError: rewrite position is not an exact generated coordinate"
  else .ok (rewriteRows word held positions replacement)

theorem growMeaning (alphabet : List String) (n : Nat) :
    grow alphabet n = (words alphabet n,["empty-One"] :: shortThrough alphabet n) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    unfold grow
    rw [ih]
    change (extendWords alphabet (words alphabet n),(["empty-One"] :: shortThrough alphabet n) ++ extendWords alphabet (words alphabet n)) = _
    rw [← positionSuccessorOrder]
    rfl

theorem generatedMeaning (alphabet positions : List String) (result : List Word) :
    generatedWords alphabet positions = .ok result ↔
      distinct alphabet = true ∧ distinct positions = true ∧ alphabet.isEmpty = false ∧
      result = ["empty-One"] :: shortThrough alphabet positions.length := by
  unfold generatedWords
  cases ha : distinct alphabet <;> cases hp : distinct positions <;> cases he : alphabet.isEmpty
  all_goals try { constructor; intro h; cases h; intro h; cases h.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.2.1 }
  rw [growMeaning]
  constructor
  · intro h; exact ⟨rfl,rfl,rfl,(Except.ok.inj h).symm⟩
  · intro h; rw [h.2.2.2]; rfl

theorem generatedMembership (alphabet positions : List String) (result : List Word)
    (h : generatedWords alphabet positions = .ok result) (word : Word) :
    word ∈ result ↔ word = ["empty-One"] ∨
      ∃ width, 0 < width ∧ width ≤ positions.length ∧ word.length = width ∧ ∀ label, label ∈ word → label ∈ alphabet := by
  rw [(generatedMeaning _ _ _).mp h |>.2.2.2]
  constructor
  · intro member
    cases member with
    | head => exact Or.inl rfl
    | tail _ hm =>
      obtain ⟨width,positive,bound,hw⟩ := (shortMembership _ _ _).mp hm
      exact Or.inr ⟨width,positive,bound,(wordCharacterization _ _ _).mp hw⟩
  · intro member
    cases member with
    | inl eq => cases eq; exact List.Mem.head _
    | inr hp =>
      obtain ⟨width,positive,bound,length,letters⟩ := hp
      exact List.Mem.tail _ ((shortMembership _ _ _).mpr ⟨width,positive,bound,(wordCharacterization _ _ _).mpr ⟨length,letters⟩⟩)

theorem growSuccessor (alphabet : List String) (n : Nat) :
    (grow alphabet (n+1)).2 = (grow alphabet n).2 ++ words alphabet (n+1) := by
  rw [growMeaning alphabet (n+1),growMeaning alphabet n]
  rfl

theorem rewriteMeaning (word : Word) (held : String) (positions : List String) (replacement : String) (result : Word) :
    exactRewrite word held positions replacement = .ok result ↔
      distinct positions = true ∧ word.length = positions.length ∧ held ∈ positions ∧
      result = rewriteRows word held positions replacement := by
  unfold exactRewrite
  cases hp : distinct positions <;> cases hl : decide (word.length = positions.length) <;> cases hh : has positions held
  all_goals try { constructor; intro h; cases h; intro h; cases h.1 }
  all_goals try { constructor; intro h; cases h; intro h; have bad := decide_eq_true h.2.1; rw [hl] at bad; cases bad }
  all_goals try { constructor; intro h; cases h; intro h; have bad := (hasIff _ _).mpr h.2.2.1; rw [hh] at bad; cases bad }
  · constructor
    · intro h; exact ⟨rfl,of_decide_eq_true hl,(hasIff _ _).mp hh,(Except.ok.inj h).symm⟩
    · intro h; rw [h.2.2.2]; rfl



theorem rewriteTrace (word : Word) (held : String) (positions : List String) (replacement : String)
    (length : word.length = positions.length) :
    positions.zip (rewriteRows word held positions replacement) =
      (positions.zip word).map (fun pair => (pair.1,if pair.1 = held then replacement else pair.2)) := by
  induction positions generalizing word with
  | nil => cases word with
    | nil => rfl
    | cons _ _ => cases length
  | cons position positions ih => cases word with
    | nil => cases length
    | cons symbol word =>
      exact congrArg (List.cons (position,if position = held then replacement else symbol))
        (ih word (Nat.succ.inj length))

theorem rewriteLength (word : Word) (held : String) (positions : List String) (replacement : String)
    (length : word.length = positions.length) :
    (rewriteRows word held positions replacement).length = word.length := by
  induction positions generalizing word with
  | nil => cases word with
    | nil => rfl
    | cons _ _ => cases length
  | cons position positions ih => cases word with
    | nil => cases length
    | cons symbol word => exact congrArg Nat.succ (ih word (Nat.succ.inj length))

theorem rewriteCoordinate (word : Word) (held : String) (positions : List String) (replacement : String)
    (length : word.length = positions.length) (position symbol : String)
    (member : (position,symbol) ∈ positions.zip word) :
    (position,if position = held then replacement else symbol) ∈ positions.zip (rewriteRows word held positions replacement) := by
  rw [rewriteTrace word held positions replacement length]
  exact memMap _ (position,symbol) _ member

end SFT.Computation.StateWords
