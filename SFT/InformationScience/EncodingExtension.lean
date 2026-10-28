import SFT.InformationScience.EncodingLoss
namespace SFT.InformationScience.EncodingExtension
open EncodingClasses EncodingDecoder
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

theorem boolEquality (a b : Bool) (h : a = true ↔ b = true) : a = b := by
  cases a <;> cases b
  · rfl
  · have no := h.mpr rfl; cases no
  · have no := h.mp rfl; cases no
  · rfl

theorem oldRow (encoding : Encoding) (fresh item : String) (new word : Codeword)
    (hne : item ≠ fresh) :
    has (encoding ++ [(fresh,new)]) (item,word) = has encoding (item,word) := by
  apply boolEquality
  constructor
  · intro h
    cases memAppendCases (item,word) encoding [(fresh,new)] ((hasIff _ _).mp h) with
    | inl old => exact (hasIff _ _).mpr old
    | inr added => cases added with
      | head => exact False.elim (hne rfl)
      | tail _ h => cases h
  · intro h; exact (hasIff _ _).mpr (memAppendLeft _ _ _ ((hasIff _ _).mp h))

theorem freshRow (encoding : Encoding) (fresh : String) (new word : Codeword)
    (hf : ¬ fresh ∈ encoding.map Prod.fst) :
    has (encoding ++ [(fresh,new)]) (fresh,word) = decide (word = new) := by
  apply boolEquality
  constructor
  · intro h
    cases memAppendCases (fresh,word) encoding [(fresh,new)] ((hasIff _ _).mp h) with
    | inl old => exact False.elim (hf (memMap Prod.fst (fresh,word) encoding old))
    | inr added => cases added with
      | head => exact decide_eq_true rfl
      | tail _ h => cases h
  · intro h; have eq := of_decide_eq_true h; cases eq
    exact (hasIff _ _).mpr (memAppendRight _ _ _ (List.Mem.head []))

theorem membersSuccessor (source : List String) (encoding : Encoding) (fresh : String)
    (new word : Codeword) (hs : ¬ fresh ∈ source) (he : ¬ fresh ∈ encoding.map Prod.fst) :
    membersFor (source ++ [fresh]) (encoding ++ [(fresh,new)]) word =
      membersFor source encoding word ++ (if word = new then [fresh] else []) := by
  induction source with
  | nil =>
    change (match has (encoding ++ [(fresh,new)]) (fresh,word) with | true => [fresh] | false => []) = _
    rw [freshRow _ _ _ _ he]
    by_cases h : word = new
    · rw [if_pos h,decide_eq_true h]; rfl
    · rw [if_neg h,decide_eq_false h]; rfl
  | cons item rest ih =>
    have different : item ≠ fresh := by intro eq; cases eq; exact hs (List.Mem.head _)
    have hr : ¬ fresh ∈ rest := fun h => hs (List.Mem.tail item h)
    change (match has (encoding ++ [(fresh,new)]) (item,word) with
      | true => item :: membersFor (rest ++ [fresh]) (encoding ++ [(fresh,new)]) word
      | false => membersFor (rest ++ [fresh]) (encoding ++ [(fresh,new)]) word) = _
    rw [oldRow _ _ _ _ _ different,ih hr]
    change (match has encoding (item,word) with
      | true => item :: (membersFor rest encoding word ++ (if word = new then [fresh] else []))
      | false => membersFor rest encoding word ++ (if word = new then [fresh] else [])) =
      (match has encoding (item,word) with | true => item :: membersFor rest encoding word | false => membersFor rest encoding word) ++ (if word = new then [fresh] else [])
    cases h : has encoding (item,word) <;> rfl

theorem freshKeys (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (fresh : String)
    (hs : ¬ fresh ∈ source) : ¬ fresh ∈ encoding.map Prod.fst := by
  intro h
  exact hs (((keysMeaning _ _).mp ((validationMeaning _ _ _).mp valid).2.2.2.2.2.1).1 fresh h)

theorem unusedMembers (source : List String) (encoding : Encoding) (word : Codeword)
    (unused : ¬ word ∈ encoding.map Prod.snd) : membersFor source encoding word = [] := by
  induction source with
  | nil => rfl
  | cons item rest ih =>
    have no : has encoding (item,word) = false := (absentIff _ _).mpr
      (fun h => unused (memMap Prod.snd (item,word) encoding h))
    change (match has encoding (item,word) with | true => item :: membersFor rest encoding word | false => membersFor rest encoding word) = []
    rw [no]; exact ih

theorem usedSuccessor (encoding : Encoding) (fresh : String) (new word : Codeword) :
    word ∈ (encoding ++ [(fresh,new)]).map Prod.snd ↔ word ∈ encoding.map Prod.snd ∨ word = new := by
  constructor
  · intro h
    obtain ⟨row,hr,eq⟩ := memMapPreimage Prod.snd word _ h
    cases memAppendCases row encoding [(fresh,new)] hr with
    | inl old => exact Or.inl (by rw [← eq]; exact memMap Prod.snd row encoding old)
    | inr added => cases added with
      | head => exact Or.inr eq.symm
      | tail _ h => cases h
  · intro h
    cases h with
    | inl old =>
      obtain ⟨row,hr,eq⟩ := memMapPreimage Prod.snd word encoding old
      rw [← eq]; exact memMap Prod.snd row _ (memAppendLeft _ _ _ hr)
    | inr eq => cases eq; exact memMap Prod.snd (fresh,new) _ (memAppendRight _ _ _ (List.Mem.head []))

theorem freshPreservesDecoder (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (fresh : String) (new : Codeword)
    (hs : ¬ fresh ∈ source) (unused : ¬ new ∈ encoding.map Prod.snd)
    (decoder : Decoder) (hd : exactDecoder source encoding = some decoder) :
    ∃ extended, exactDecoder (source ++ [fresh]) (encoding ++ [(fresh,new)]) = some extended := by
  apply (decoderExistsIff _ _).mpr
  intro word members hm
  have p := (classMeaning _ _ _ _).mp hm
  rw [p.2,membersSuccessor _ _ _ _ _ hs (freshKeys _ _ _ valid _ hs)]
  cases (usedSuccessor _ _ _ _).mp p.1 with
  | inl old =>
    have ne : word ≠ new := by intro eq; cases eq; exact unused old
    rw [if_neg ne]
    have hc := (classMeaning source encoding word (membersFor source encoding word)).mpr ⟨old,rfl⟩
    obtain ⟨item,eq⟩ := inverseSingletons _ _ hd _ _ hc
    rw [eq]; exact ⟨item,rfl⟩
  | inr eq =>
    cases eq
    rw [if_pos rfl,unusedMembers _ _ _ unused]
    exact ⟨fresh,rfl⟩

theorem appendNotSingleton (members : List String) (fresh : String)
    (nonempty : ∃ item, item ∈ members) : ¬ ∃ item, members ++ [fresh] = [item] := by
  cases members with
  | nil => obtain ⟨_,h⟩ := nonempty; cases h
  | cons first rest =>
    intro ⟨item,eq⟩
    have tail := List.cons.inj eq
    have impossible : fresh ∈ rest ++ [fresh] := memAppendRight _ _ _ (List.Mem.head [])
    have empty : rest ++ [fresh] = [] := tail.2
    rw [empty] at impossible; cases impossible

theorem reusedClosesDecoder (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (fresh : String) (new : Codeword)
    (hs : ¬ fresh ∈ source) (used : new ∈ encoding.map Prod.snd) :
    exactDecoder (source ++ [fresh]) (encoding ++ [(fresh,new)]) = none := by
  have hc := (classMeaning source encoding new (membersFor source encoding new)).mpr ⟨used,rfl⟩
  have ne := admittedClassNonempty _ _ _ valid _ _ hc
  cases hd : exactDecoder (source ++ [fresh]) (encoding ++ [(fresh,new)]) with
  | none => rfl
  | some decoder =>
    have hm := (classMeaning (source ++ [fresh]) (encoding ++ [(fresh,new)]) new
      (membersFor (source ++ [fresh]) (encoding ++ [(fresh,new)]) new)).mpr
      ⟨(usedSuccessor _ _ _ _).mpr (Or.inr rfl),rfl⟩
    obtain ⟨item,eq⟩ := inverseSingletons _ _ hd _ _ hm
    rw [membersSuccessor _ _ _ _ _ hs (freshKeys _ _ _ valid _ hs),if_pos rfl] at eq
    exact False.elim (appendNotSingleton _ _ ne ⟨item,eq⟩)

theorem singletonBase (item : String) (word : Codeword) :
    exactDecoder [item] [(item,word)] = some [(word,item)] := by
  have self : has [(item,word)] (item,word) = true := (hasIff _ _).mpr (List.Mem.head [])
  change inverseClasses [(word,membersFor [item] [(item,word)] word)] = _
  have single : membersFor [item] [(item,word)] word = [item] := by
    change (match has [(item,word)] (item,word) with | true => [item] | false => []) = _
    rw [self]
  rw [single]; rfl

end SFT.InformationScience.EncodingExtension
