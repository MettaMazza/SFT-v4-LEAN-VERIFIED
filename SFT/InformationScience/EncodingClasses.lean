import SFT.InformationScience.SymbolExtension
namespace SFT.InformationScience.EncodingClasses
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation
abbrev Codeword := List String
abbrev Encoding := List (String × Codeword)

def retainFirst (seen : List Codeword) : List Codeword → List Codeword
  | [] => []
  | label :: rest => if has seen label then retainFirst seen rest
    else label :: retainFirst (seen ++ [label]) rest

def firstCodewords (items : List Codeword) : List Codeword := retainFirst [] items

def keysMatch (source : List String) (encoding : Encoding) : Bool :=
  (encoding.map Prod.fst).all (has source) && source.all (has (encoding.map Prod.fst))

def validateEncoding (source : List String) (support : List Codeword) (encoding : Encoding) : Bool :=
  !source.isEmpty && !support.isEmpty && distinct source && distinct support &&
    decide (encoding.length = source.length) && keysMatch source encoding &&
    distinct (encoding.map Prod.fst) && encoding.all (fun row => has support row.2)

def membersFor (source : List String) (encoding : Encoding) (codeword : Codeword) : List String :=
  source.filter (fun item => has encoding (item,codeword))

def sourceClasses (source : List String) (encoding : Encoding) : List (Codeword × List String) :=
  (firstCodewords (encoding.map Prod.snd)).map (fun codeword => (codeword,membersFor source encoding codeword))

theorem retainFirstMembership (seen items : List Codeword) (label : Codeword) :
    label ∈ retainFirst seen items ↔ label ∈ items ∧ ¬ label ∈ seen := by
  induction items generalizing seen with
  | nil => constructor <;> intro h; cases h; cases h.1
  | cons first rest ih =>
    unfold retainFirst
    cases known : has seen first with
    | true =>
      constructor
      · intro h; have p := (ih seen).mp h; exact ⟨List.Mem.tail first p.1,p.2⟩
      · intro h
        cases h.1 with
        | head => exact False.elim (h.2 ((hasIff _ _).mp known))
        | tail _ hr => exact (ih seen).mpr ⟨hr,h.2⟩
    | false =>
      constructor
      · intro h
        cases h with
        | head =>
          refine ⟨List.Mem.head rest,?_⟩
          intro hv; have yes := (hasIff _ _).mpr hv; rw [known] at yes; cases yes
        | tail _ hr =>
          have p := (ih (seen ++ [first])).mp hr
          exact ⟨List.Mem.tail first p.1,fun hv => p.2 (memAppendLeft _ _ _ hv)⟩
      · intro h
        cases h.1 with
        | head => exact List.Mem.head _
        | tail _ hr =>
          by_cases same : label = first
          · cases same; exact List.Mem.head _
          · apply List.Mem.tail
            apply (ih (seen ++ [first])).mpr
            refine ⟨hr,?_⟩
            intro hv
            cases memAppendCases label seen [first] hv with
            | inl old => exact h.2 old
            | inr new => cases new with
              | head => exact same rfl
              | tail _ h => cases h

theorem firstCodewordsMembership (items : List Codeword) (label : Codeword) :
    label ∈ firstCodewords items ↔ label ∈ items :=
  ⟨fun h => ((retainFirstMembership [] items label).mp h).1,
   fun h => (retainFirstMembership [] items label).mpr ⟨h,fun h => by cases h⟩⟩

theorem retainFirstDistinct (seen items : List Codeword) : distinct (retainFirst seen items) = true := by
  induction items generalizing seen with
  | nil => rfl
  | cons first rest ih =>
    change distinct (if has seen first then retainFirst seen rest else first :: retainFirst (seen ++ [first]) rest) = true
    cases known : has seen first with
    | true => exact ih seen
    | false =>
      apply (distinctCons _ _).mpr
      refine ⟨(absentIff _ _).mpr ?_,ih (seen ++ [first])⟩
      intro member
      have p := (retainFirstMembership (seen ++ [first]) rest first).mp member
      exact p.2 (memAppendRight _ _ _ (List.Mem.head []))

theorem firstCodewordsDistinct (items : List Codeword) : distinct (firstCodewords items) = true := retainFirstDistinct [] items


theorem keysMeaning (source : List String) (encoding : Encoding) : keysMatch source encoding = true ↔
    (∀ item, item ∈ encoding.map Prod.fst → item ∈ source) ∧
    (∀ item, item ∈ source → item ∈ encoding.map Prod.fst) := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    exact ⟨fun item hm => (hasIff _ _).mp (allTrueAtMember _ _ p.1 item hm),
      fun item hm => (hasIff _ _).mp (allTrueAtMember _ _ p.2 item hm)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr (fun item hm => (hasIff _ _).mpr (h.1 item hm)),
      (allTrueIffMembers _ _).mpr (fun item hm => (hasIff _ _).mpr (h.2 item hm))⟩

theorem validationMeaning (source : List String) (support : List Codeword) (encoding : Encoding) :
    validateEncoding source support encoding = true ↔ source.isEmpty = false ∧ support.isEmpty = false ∧
    distinct source = true ∧ distinct support = true ∧ encoding.length = source.length ∧
    keysMatch source encoding = true ∧ distinct (encoding.map Prod.fst) = true ∧
    encoding.all (fun row => has support row.2) = true := by
  constructor
  · intro h
    have p7 := (andTrue _ _).mp h
    have p6 := (andTrue _ _).mp p7.1
    have p5 := (andTrue _ _).mp p6.1
    have p4 := (andTrue _ _).mp p5.1
    have p3 := (andTrue _ _).mp p4.1
    have p2 := (andTrue _ _).mp p3.1
    have p1 := (andTrue _ _).mp p2.1
    exact ⟨(notTrue _).mp p1.1,(notTrue _).mp p1.2,p2.2,p3.2,of_decide_eq_true p4.2,p5.2,p6.2,p7.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,
      (notTrue _).mpr h.2.1⟩,h.2.2.1⟩,h.2.2.2.1⟩,decide_eq_true h.2.2.2.2.1⟩,
      h.2.2.2.2.2.1⟩,h.2.2.2.2.2.2.1⟩,h.2.2.2.2.2.2.2⟩

theorem memberMeaning (source : List String) (encoding : Encoding) (word : Codeword) (item : String) :
    item ∈ membersFor source encoding word ↔ item ∈ source ∧ (item,word) ∈ encoding := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

theorem classMeaning (source : List String) (encoding : Encoding) (word : Codeword) (members : List String) :
    (word,members) ∈ sourceClasses source encoding ↔
      word ∈ encoding.map Prod.snd ∧ members = membersFor source encoding word := by
  constructor
  · intro h
    obtain ⟨w,hm,eq⟩ := memMapPreimage (fun word => (word,membersFor source encoding word)) (word,members) _ h
    have same := congrArg Prod.fst eq
    cases same
    exact ⟨(firstCodewordsMembership _ _).mp hm,(congrArg Prod.snd eq).symm⟩
  · intro h
    cases h.2
    exact memMap (fun word => (word,membersFor source encoding word)) word _ ((firstCodewordsMembership _ _).mpr h.1)

theorem classKeysMap (words : List Codeword) (source : List String) (encoding : Encoding) :
    (words.map (fun word => (word,membersFor source encoding word))).map Prod.fst = words := by
  induction words with
  | nil => rfl
  | cons w rest ih => exact congrArg (List.cons w) ih

theorem classKeysDistinct (source : List String) (encoding : Encoding) :
    distinct ((sourceClasses source encoding).map Prod.fst) = true := by
  rw [sourceClasses,classKeysMap]
  exact firstCodewordsDistinct _

theorem sourceProvenance (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (item : String) (word : Codeword)
    (member : (item,word) ∈ encoding) : item ∈ source ∧ word ∈ support := by
  have v := (validationMeaning _ _ _).mp valid
  have keys := (keysMeaning _ _).mp v.2.2.2.2.2.1
  exact ⟨keys.1 item (memMap Prod.fst (item,word) encoding member),
    (hasIff _ _).mp (allTrueAtMember _ _ v.2.2.2.2.2.2.2 (item,word) member)⟩

theorem admittedClassNonempty (source : List String) (support : List Codeword) (encoding : Encoding)
    (valid : validateEncoding source support encoding = true) (word : Codeword) (members : List String)
    (hc : (word,members) ∈ sourceClasses source encoding) : ∃ item, item ∈ members := by
  have p := (classMeaning _ _ _ _).mp hc
  obtain ⟨row,hr,eq⟩ := memMapPreimage Prod.snd word encoding p.1
  cases row with
  | mk item code =>
    cases eq
    refine ⟨item,?_⟩
    rw [p.2]
    exact (memberMeaning _ _ _ _).mpr ⟨(sourceProvenance _ _ _ valid _ _ hr).1,hr⟩

end SFT.InformationScience.EncodingClasses
