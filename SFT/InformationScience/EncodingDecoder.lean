import SFT.InformationScience.EncodingClasses
namespace SFT.InformationScience.EncodingDecoder
open EncodingClasses SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation
abbrev Decoder := List (Codeword × String)

def inverseClasses : List (Codeword × List String) → Option Decoder
  | [] => some []
  | (word,members) :: rest => match members with
    | [] => none
    | item :: tail => match tail with
      | _ :: _ => none
      | [] => match inverseClasses rest with
        | none => none
        | some decoder => some ((word,item) :: decoder)

def exactDecoder (source : List String) (encoding : Encoding) : Option Decoder :=
  inverseClasses (sourceClasses source encoding)

def matchesFor (decoder : Decoder) (word : Codeword) : List String :=
  match decoder with
  | [] => []
  | (held,item) :: rest => if held = word then item :: matchesFor rest word else matchesFor rest word

def decode (word : Codeword) (decoder : Decoder) : Except String String :=
  match matchesFor decoder word with
  | [] => .error "decoding requires one retained source image"
  | item :: rest => match rest with
    | [] => .ok item
    | _ :: _ => .error "decoding requires one retained source image"

theorem inverseKeys (classes : List (Codeword × List String)) (decoder : Decoder)
    (h : inverseClasses classes = some decoder) : decoder.map Prod.fst = classes.map Prod.fst := by
  induction classes generalizing decoder with
  | nil => cases h; rfl
  | cons row rest ih =>
    cases row with
    | mk word members =>
      cases members with
      | nil => cases h
      | cons item tail =>
        cases tail with
        | cons next tail => cases h
        | nil =>
          change (match inverseClasses rest with | none => none | some ds => some ((word,item)::ds)) = some decoder at h
          cases hr : inverseClasses rest with
          | none => rw [hr] at h; cases h
          | some ds => rw [hr] at h; cases h; exact congrArg (List.cons word) (ih ds hr)

theorem inverseRelation (classes : List (Codeword × List String)) (decoder : Decoder)
    (h : inverseClasses classes = some decoder) (word : Codeword) (item : String) :
    (word,item) ∈ decoder ↔ (word,[item]) ∈ classes := by
  induction classes generalizing decoder with
  | nil => cases h; constructor <;> intro h <;> cases h
  | cons row rest ih =>
    cases row with
    | mk code members =>
      cases members with
      | nil => cases h
      | cons source tail =>
        cases tail with
        | cons next tail => cases h
        | nil =>
          change (match inverseClasses rest with | none => none | some ds => some ((code,source)::ds)) = some decoder at h
          cases hr : inverseClasses rest with
          | none => rw [hr] at h; cases h
          | some ds =>
            rw [hr] at h; cases h
            constructor
            · intro hm
              cases hm with
              | head => exact List.Mem.head _
              | tail _ hm => exact List.Mem.tail _ ((ih ds hr).mp hm)
            · intro hm
              cases hm with
              | head => exact List.Mem.head _
              | tail _ hm => exact List.Mem.tail _ ((ih ds hr).mpr hm)

theorem inverseSingletons (classes : List (Codeword × List String)) (decoder : Decoder)
    (h : inverseClasses classes = some decoder) (word : Codeword) (members : List String)
    (hm : (word,members) ∈ classes) : ∃ item, members = [item] := by
  induction classes generalizing decoder with
  | nil => cases hm
  | cons row rest ih =>
    cases row with
    | mk code sources =>
      cases sources with
      | nil => cases h
      | cons item tail =>
        cases tail with
        | cons next tail => cases h
        | nil =>
          change (match inverseClasses rest with | none => none | some ds => some ((code,item)::ds)) = some decoder at h
          cases hr : inverseClasses rest with
          | none => rw [hr] at h; cases h
          | some ds =>
            cases hm with
            | head => exact ⟨item,rfl⟩
            | tail _ hm => exact ih ds hr hm

theorem inverseExists (classes : List (Codeword × List String)) :
    (∃ decoder, inverseClasses classes = some decoder) ↔
      ∀ word members, (word,members) ∈ classes → ∃ item, members = [item] := by
  constructor
  · intro ⟨decoder,h⟩ word members hm; exact inverseSingletons _ _ h _ _ hm
  · intro allSingleton
    induction classes with
    | nil => exact ⟨[],rfl⟩
    | cons row rest ih =>
      cases row with
      | mk word members =>
        obtain ⟨item,he⟩ := allSingleton word members (List.Mem.head _)
        cases he
        obtain ⟨decoder,hd⟩ := ih (fun w ms hm => allSingleton w ms (List.Mem.tail _ hm))
        refine ⟨(word,item)::decoder,?_⟩
        change (match inverseClasses rest with | none => none | some ds => some ((word,item)::ds)) = _
        rw [hd]

theorem decoderExistsIff (source : List String) (encoding : Encoding) :
    (∃ decoder, exactDecoder source encoding = some decoder) ↔
      ∀ word members, (word,members) ∈ sourceClasses source encoding → ∃ item, members = [item] :=
  inverseExists _

theorem matchesAbsent (decoder : Decoder) (word : Codeword)
    (h : ¬ word ∈ decoder.map Prod.fst) : matchesFor decoder word = [] := by
  induction decoder with
  | nil => rfl
  | cons row rest ih =>
    cases row with
    | mk held item =>
      have different : held ≠ word := by intro he; cases he; exact h (List.Mem.head _)
      rw [matchesFor,ite_eq_right different]
      exact ih (fun hm => h (List.Mem.tail held hm))

theorem uniqueDecode (decoder : Decoder) (word : Codeword) (item : String)
    (hd : distinct (decoder.map Prod.fst) = true) (hm : (word,item) ∈ decoder) :
    matchesFor decoder word = [item] := by
  induction decoder with
  | nil => cases hm
  | cons row rest ih =>
    cases row with
    | mk held source =>
      have p := (andTrue _ _).mp hd
      have absent := (absentIff _ _).mp ((notTrue _).mp p.1)
      cases hm with
      | head => rw [matchesFor,ite_eq_left rfl,matchesAbsent _ _ absent]
      | tail _ member =>
        have different : held ≠ word := by
          intro same; cases same
          exact absent (memMap Prod.fst (word,item) rest member)
        rw [matchesFor,ite_eq_right different]
        exact ih p.2 member

theorem decodeExactlyOnce (decoder : Decoder) (word : Codeword) (item : String) :
    decode word decoder = .ok item ↔ matchesFor decoder word = [item] := by
  unfold decode
  cases hm : matchesFor decoder word with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil => constructor <;> intro h <;> cases h <;> rfl
    | cons next tail => constructor <;> intro h <;> cases h

theorem decoderLeftInverse (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (decoder : Decoder)
    (hd : exactDecoder source encoding = some decoder) (item : String) (word : Codeword)
    (hm : (item,word) ∈ encoding) : decode word decoder = .ok item := by
  have sourceMember := (sourceProvenance _ _ _ valid _ _ hm).1
  have used := memMap Prod.snd (item,word) encoding hm
  have hc := (classMeaning source encoding word (membersFor source encoding word)).mpr ⟨used,rfl⟩
  obtain ⟨held,hs⟩ := inverseSingletons _ _ hd _ _ hc
  have hi := (memberMeaning _ _ _ _).mpr ⟨sourceMember,hm⟩
  rw [hs] at hi
  have same : item = held := by
    cases hi with
    | head => rfl
    | tail _ impossible => cases impossible
  cases same
  have row : (word,item) ∈ decoder := (inverseRelation _ _ hd _ _).mpr (by rw [← hs]; exact hc)
  have distinctKeys : distinct (decoder.map Prod.fst) = true := by
    rw [inverseKeys _ _ hd]; exact classKeysDistinct _ _
  exact (decodeExactlyOnce _ _ _).mpr (uniqueDecode _ _ _ distinctKeys row)

end SFT.InformationScience.EncodingDecoder
