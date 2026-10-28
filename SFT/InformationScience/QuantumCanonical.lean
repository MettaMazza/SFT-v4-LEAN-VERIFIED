import SFT.Mathematics.SelectionEncoding
import SFT.InformationScience.QuantumBasis
import SFT.Mathematics.CategoryIdentity
namespace SFT.InformationScience.QuantumCanonical
open SFT.Host.Text QuantumBasis QuantitySupport
open SFT.Foundation.Count.TraceDerivation

-- The fixed labels are those of pinned fold_assembly.py, not a new raw-input guard.
def Held (word : Word) : Prop := ∀ s, s ∈ word → s = "held-a" ∨ s = "held-b"

def alphabet : List Char := ['h','e','l','d','-','a','b',':','s','i']
def Textual (cs : List Char) : Prop := ∀ c, c ∈ cs → c ∈ alphabet

theorem textualTail (c : Char) (cs : List Char) (h : Textual (c::cs)) : Textual cs :=
  fun x hx => h x (List.Mem.tail c hx)

theorem decodeEncoded (cs : List Char) (h : Textual cs) :
    decode (cs.flatMap String.utf8EncodeChar).length (cs.flatMap String.utf8EncodeChar) = cs := by
  induction cs with
  | nil => rfl
  | cons c cs ih =>
    have hc := h c (List.Mem.head cs)
    have rest := ih (textualTail c cs h)
    unfold alphabet at hc
    cases hc with
    | head => exact congrArg (List.cons _) rest
    | tail _ hc =>
      cases hc with
      | head => exact congrArg (List.cons _) rest
      | tail _ hc =>
        cases hc with
        | head => exact congrArg (List.cons _) rest
        | tail _ hc =>
          cases hc with
          | head => exact congrArg (List.cons _) rest
          | tail _ hc =>
            cases hc with
            | head => exact congrArg (List.cons _) rest
            | tail _ hc =>
              cases hc with
              | head => exact congrArg (List.cons _) rest
              | tail _ hc =>
                cases hc with
                | head => exact congrArg (List.cons _) rest
                | tail _ hc =>
                  cases hc with
                  | head => exact congrArg (List.cons _) rest
                  | tail _ hc =>
                    cases hc with
                    | head => exact congrArg (List.cons _) rest
                    | tail _ hc =>
                      cases hc with
                      | head => exact congrArg (List.cons _) rest
                      | tail _ hc =>
                        cases hc

theorem charsOfList (cs : List Char) (h : Textual cs) : chars (String.ofList cs) = cs := by
  unfold chars
  change decode (String.ofList cs).toUTF8.data.size (String.ofList cs).toUTF8.data.toList = cs
  rw [← Array.length_toList, SFT.Mathematics.CategoryIdentity.encodedBytes]
  exact decodeEncoded cs h

theorem textualAppend (a b : List Char) (ha : Textual a) (hb : Textual b) : Textual (a++b) := by
  intro c hc
  cases memAppendCases c a b hc with
  | inl h => exact ha c h
  | inr h => exact hb c h

-- Exact character expression of the original colon join.
def joined : Word → List Char
 | [] => []
 | s::ss => chars s ++ ss.flatMap (fun t => ':' :: chars t)

theorem flatText (ss : Word) :
    (ss.flatMap (fun s => [":",s])).flatMap chars = ss.flatMap (fun s => ':' :: chars s) := by
  induction ss with
  | nil => rfl
  | cons s ss ih =>
    change (([":",s] ++ ss.flatMap (fun s => [":",s])).flatMap chars) = _
    rw [SFT.Mathematics.CategoryIdentity.flatMapAppend]
    change (':' :: (chars s ++ [])) ++ (ss.flatMap (fun s => [":",s])).flatMap chars = _
    rw [SFT.Mathematics.CategoryIdentity.appendNil,ih]
    rfl

theorem joinExpression (word : Word) : intercalate ":" word = String.ofList (joined word) := by
  cases word with
  | nil => rfl
  | cons s ss =>
    change String.ofList (chars s ++ (ss.flatMap (fun s => [":",s])).flatMap chars) = _
    rw [flatText]; rfl



theorem textualOfAll (cs : List Char) (h : cs.all (fun c => SFT.Mathematics.DiscreteObjects.has alphabet c) = true) : Textual cs := by
  induction cs with
  | nil => intro c hc; cases hc
  | cons c cs ih =>
    have parts := (SFT.Foundation.Count.Representation.andTrue _ _).mp h
    intro x hx
    cases hx with
    | head => exact (SFT.Mathematics.DiscreteObjects.hasIff _ _).mp parts.1
    | tail _ hx => exact ih parts.2 x hx

theorem heldChars (s : String) (h : s = "held-a" ∨ s = "held-b") : Textual (chars s) := by
  cases h with
  | inl h => cases h; exact textualOfAll _ (by decide)
  | inr h => cases h; exact textualOfAll _ (by decide)

def tails (word : Word) : List Char := word.flatMap (fun s => ':' :: chars s)

theorem heldTail (s : String) (ss : Word) (h : Held (s::ss)) : Held ss :=
  fun x hx => h x (List.Mem.tail s hx)

theorem tailsText (word : Word) (h : Held word) : Textual (tails word) := by
  induction word with
  | nil => intro c hc; cases hc
  | cons s ss ih =>
    have hs := heldChars s (h s (List.Mem.head ss))
    apply textualAppend _ _ _ (ih (heldTail s ss h))
    intro c hc
    cases hc with
    | head => exact (SFT.Mathematics.DiscreteObjects.hasIff _ _).mp (by decide)
    | tail _ hc => exact hs c hc

theorem joinedText (word : Word) (h : Held word) : Textual (joined word) := by
  cases word with
  | nil => intro c hc; cases hc
  | cons s ss => exact textualAppend _ _ (heldChars s (h s (List.Mem.head ss))) (tailsText ss (heldTail s ss h))

theorem nameChars (word : Word) (h : Held word) :
    chars (basisName word) = chars "basis:" ++ joined word := by
  unfold basisName append
  rw [joinExpression, charsOfList _ (joinedText word h)]
  exact charsOfList _ (textualAppend _ _ (textualOfAll _ (by decide)) (joinedText word h))

theorem cancelPrefix {α : Type} (pre a b : List α) (h : pre ++ a = pre ++ b) : a = b := by
  induction pre with
  | nil => exact h
  | cons x xs ih => exact ih (List.cons.inj h).2

theorem tailsInjection (a b : Word) (ha : Held a) (hb : Held b) (eq : tails a = tails b) : a = b := by
  induction a generalizing b with
  | nil =>
    cases b with
    | nil => rfl
    | cons s ss => cases eq
  | cons s ss ih =>
    cases b with
    | nil => cases eq
    | cons t ts =>
      have hs := ha s (List.Mem.head ss)
      have ht := hb t (List.Mem.head ts)
      have ha' := heldTail s ss ha
      have hb' := heldTail t ts hb
      cases hs with
      | inl hs =>
        cases hs
        cases ht with
        | inl ht =>
          cases ht
          exact congrArg (List.cons "held-a") (ih ts ha' hb' (congrArg (List.drop 7) eq))
        | inr ht =>
          cases ht
          have bad : ('a' : Char) = 'b' := congrArg (fun cs => (cs.drop 6).headD 'x') eq
          have impossible : true = false := congrArg (fun c => c == 'a') bad
          cases impossible
      | inr hs =>
        cases hs
        cases ht with
        | inl ht =>
          cases ht
          have bad : ('b' : Char) = 'a' := congrArg (fun cs => (cs.drop 6).headD 'x') eq
          have impossible : false = true := congrArg (fun c => c == 'a') bad
          cases impossible
        | inr ht =>
          cases ht
          exact congrArg (List.cons "held-b") (ih ts ha' hb' (congrArg (List.drop 7) eq))

theorem joinedInjection (a b : Word) (ha : Held a) (hb : Held b) (eq : joined a = joined b) : a = b := by
  cases a with
  | nil =>
    cases b with
    | nil => rfl
    | cons s ss =>
      cases hb s (List.Mem.head ss) with
      | inl h => cases h; cases eq
      | inr h => cases h; cases eq
  | cons s ss =>
    cases b with
    | nil =>
      cases ha s (List.Mem.head ss) with
      | inl h => cases h; cases eq
      | inr h => cases h; cases eq
    | cons t ts => exact tailsInjection _ _ ha hb (congrArg (List.cons ':') eq)

theorem basisNameInjection (a b : Word) (ha : Held a) (hb : Held b) (eq : basisName a = basisName b) : a = b := by
  have charsEq := congrArg chars eq
  rw [nameChars a ha, nameChars b hb] at charsEq
  exact joinedInjection a b ha hb (cancelPrefix _ _ _ charsEq)



theorem inheritedHeld (n : Nat) (word : Word)
    (h : word ∈ SFT.Foundation.FoldAssembly.supportAfterExtensions n) : Held word := by
  intro s hs
  have member := ((SFT.Foundation.FoldAssembly.supportIffLengthAndHeldLabels n word).mp h).2 s hs
  cases member with
  | head => exact Or.inl rfl
  | tail _ member => cases member with
    | head => exact Or.inr rfl
    | tail _ member => cases member

theorem supportCorrespondence (positions : List String) (support : List Word)
    (h : QuantumSupport.completeFoldSupport SFT.Foundation.FoldAssembly.labels positions = .ok support)
    (word : Word) : word ∈ support ↔ word ∈ SFT.Foundation.FoldAssembly.supportAfterExtensions positions.length := by
  constructor
  · intro member
    exact (SFT.Foundation.FoldAssembly.supportIffLengthAndHeldLabels _ _).mpr
      ((QuantumSupport.supportMembership _ _ _ h word).mp member)
  · intro member
    exact (QuantumSupport.supportMembership _ _ _ h word).mpr
      ((SFT.Foundation.FoldAssembly.supportIffLengthAndHeldLabels _ _).mp member)

theorem admittedNamesInjective (positions : List String) (support : List Word)
    (h : QuantumSupport.completeFoldSupport SFT.Foundation.FoldAssembly.labels positions = .ok support)
    (a : Word) (ha : a ∈ support) (b : Word) (hb : b ∈ support)
    (eq : basisName a = basisName b) : a = b :=
  basisNameInjection a b
    (inheritedHeld _ a ((supportCorrespondence _ _ h a).mp ha))
    (inheritedHeld _ b ((supportCorrespondence _ _ h b).mp hb)) eq

theorem admittedNamesDistinct (positions : List String) (support : List Word)
    (h : QuantumSupport.completeFoldSupport SFT.Foundation.FoldAssembly.labels positions = .ok support) :
    SFT.Mathematics.DiscreteObjects.distinct (support.map basisName) = true :=
  SFT.Mathematics.CombinatorialSelections.mapDistinctWithin basisName support
    (QuantumSupport.supportDistinct _ _ _ h) (admittedNamesInjective positions support h)

theorem basisInverse (positions : List String) (support : List Word)
    (h : QuantumSupport.completeFoldSupport SFT.Foundation.FoldAssembly.labels positions = .ok support)
    (name : String) (member : name ∈ support.map basisName) :
    ∃ word, word ∈ support ∧ basisName word = name ∧
      ∀ other, other ∈ support → basisName other = name → other = word := by
  obtain ⟨word,hw,eq⟩ := memMapPreimage _ _ _ member
  refine ⟨word,hw,eq,?_⟩
  intro other ho he
  exact admittedNamesInjective _ _ h other ho word hw (he.trans eq.symm)

end SFT.InformationScience.QuantumCanonical
