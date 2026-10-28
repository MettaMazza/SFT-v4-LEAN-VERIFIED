import SFT.InformationScience.EncodingMaps
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.InformationScience.CompressionDescription
open SFT.Mathematics.GeometryTopology
open EncodingMaps SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
abbrev Word := List String
abbrev Dictionary := List (String × Word)

def valid (dictionary : Dictionary) (tokens : List String) : Bool :=
  !dictionary.isEmpty && distinct (dictionary.map Prod.fst) && !tokens.isEmpty &&
    tokens.all (has (dictionary.map Prod.fst))

def block (dictionary : Dictionary) (token : String) : Word :=
  match lookupFirst dictionary token with
  | none => []
  | some word => word

def decoded (dictionary : Dictionary) (tokens : List String) : Word :=
  tokens.flatMap (block dictionary)

def reconstruct (dictionary : Dictionary) (tokens : List String) : Except String Word :=
  if valid dictionary tokens then .ok (decoded dictionary tokens)
  else .error "ValueError: compressed description requires a complete dictionary and nonempty valid token trace"

structure Resources where
  dictionary : List Word
  tokens : List Word
  reconstructed : Word
  completeResource : List Word

def dictionaryTrace (dictionary : Dictionary) : List Word :=
  dictionary.map (fun row => "dictionary" :: row.1 :: row.2)
def tokenCells (tokens : List String) : List Word := tokens.map (fun token => ["token",token])

def descriptionResourceTrace (dictionary : Dictionary) (tokens : List String) : Except String Resources :=
  match reconstruct dictionary tokens with
  | .error e => .error e
  | .ok word => .ok ⟨dictionaryTrace dictionary,tokenCells tokens,word,dictionaryTrace dictionary ++ tokenCells tokens⟩

def isLosslessDescription (message : Word) (dictionary : Dictionary) (tokens : List String) : Except String Bool :=
  if message.isEmpty then .ok false else
    match reconstruct dictionary tokens with
    | .error e => .error e
    | .ok word => .ok (decide (word = message))

def provenance (dictionary : Dictionary) (tokens : List String) : List (String × String) :=
  tokens.flatMap (fun token => (block dictionary token).map (fun cell => (token,cell)))

def redundantPositions (message : Word) (dictionary : Dictionary) (tokens : List String) : Except String (List (String × String)) :=
  match isLosslessDescription message dictionary tokens with
  | .error e => .error e
  | .ok false => .error "ValueError: redundancy requires exact reconstruction"
  | .ok true => .ok (provenance dictionary tokens)

theorem validMeaning (dictionary : Dictionary) (tokens : List String) :
    valid dictionary tokens = true ↔ dictionary.isEmpty = false ∧ distinct (dictionary.map Prod.fst) = true ∧
      tokens.isEmpty = false ∧ ∀ token, token ∈ tokens → token ∈ dictionary.map Prod.fst := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    have t := (andTrue _ _).mp q.1
    exact ⟨(notTrue _).mp t.1,t.2,(notTrue _).mp q.2,fun token hm => (hasIff _ _).mp (allTrueAtMember _ _ p.2 token hm)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,h.2.1⟩,(notTrue _).mpr h.2.2.1⟩,
      (allTrueIffMembers _ _).mpr (fun token hm => (hasIff _ _).mpr (h.2.2.2 token hm))⟩

theorem admittedBlock (dictionary : Dictionary) (tokens : List String) (h : valid dictionary tokens = true)
    (token : String) (member : token ∈ tokens) :
    ∃ word, (token,word) ∈ dictionary ∧ lookupFirst dictionary token = some word ∧ block dictionary token = word := by
  obtain ⟨word,hw⟩ := (lookupDefined dictionary token).mpr (((validMeaning _ _).mp h).2.2.2 token member)
  exact ⟨word,lookupRow _ _ _ hw,hw,by unfold block; rw [hw]⟩

theorem blockOfRow (dictionary : Dictionary) (token : String) (word : Word)
    (unique : distinct (dictionary.map Prod.fst) = true) (member : (token,word) ∈ dictionary) :
    block dictionary token = word := by
  unfold block; rw [lookupUnique _ _ _ unique member]

theorem reconstructMeaning (dictionary : Dictionary) (tokens : List String) (word : Word) :
    reconstruct dictionary tokens = .ok word ↔ valid dictionary tokens = true ∧ word = decoded dictionary tokens := by
  unfold reconstruct
  cases hv : valid dictionary tokens with
  | false => constructor; intro h; cases h; intro h; cases h.1
  | true => constructor; intro h; cases h; exact ⟨rfl,rfl⟩; intro h; rw [h.2]; rfl

theorem reconstructionExists (dictionary : Dictionary) (tokens : List String) :
    (∃ word, reconstruct dictionary tokens = .ok word) ↔ valid dictionary tokens = true := by
  constructor
  · intro ⟨word,h⟩; exact ((reconstructMeaning _ _ _).mp h).1
  · intro h; exact ⟨decoded dictionary tokens,(reconstructMeaning _ _ _).mpr ⟨h,rfl⟩⟩

theorem decodedMembership (dictionary : Dictionary) (tokens : List String) (cell : String) :
    cell ∈ decoded dictionary tokens ↔ ∃ token, token ∈ tokens ∧ cell ∈ block dictionary token := by
  constructor
  · intro h; exact memFlatMapOrigin _ _ _ h
  · intro ⟨token,ht,hc⟩; exact memFlatMap _ _ _ _ ht hc

theorem reconstructedProvenance (dictionary : Dictionary) (tokens : List String) (word : Word)
    (h : reconstruct dictionary tokens = .ok word) (cell : String) :
    cell ∈ word ↔ ∃ token, ∃ source, token ∈ tokens ∧ (token,source) ∈ dictionary ∧ cell ∈ source := by
  have p := (reconstructMeaning _ _ _).mp h
  rw [p.2]
  constructor
  · intro hcell
    obtain ⟨token,ht,hc⟩ := (decodedMembership _ _ _).mp hcell
    obtain ⟨source,hs,_,hb⟩ := admittedBlock _ _ p.1 token ht
    rw [hb] at hc
    exact ⟨token,source,ht,hs,hc⟩
  · intro ⟨token,source,ht,hs,hc⟩
    apply (decodedMembership _ _ _).mpr
    exact ⟨token,ht,by rw [blockOfRow _ _ _ ((validMeaning _ _).mp p.1).2.1 hs]; exact hc⟩

theorem flatMapAppend {α β : Type} (f : α → List β) (left right : List α) :
    (left ++ right).flatMap f = left.flatMap f ++ right.flatMap f := by
  induction left with
  | nil => rfl
  | cons first rest ih =>
    change f first ++ (rest ++ right).flatMap f = (f first ++ rest.flatMap f) ++ right.flatMap f
    rw [ih,SFT.Mathematics.ExactTraceArithmetic.appendAssociative]

theorem decodedSuccessor (dictionary : Dictionary) (tokens : List String) (token : String) :
    decoded dictionary (tokens ++ [token]) = decoded dictionary tokens ++ block dictionary token := by
  unfold decoded
  rw [flatMapAppend]
  change _ ++ (block dictionary token ++ []) = _
  rw [SymbolExtension.appendNil]

theorem validSuccessor (dictionary : Dictionary) (tokens : List String) (token : String)
    (h : valid dictionary tokens = true) (member : token ∈ dictionary.map Prod.fst) :
    valid dictionary (tokens ++ [token]) = true := by
  have p := (validMeaning _ _).mp h
  apply (validMeaning _ _).mpr
  refine ⟨p.1,p.2.1,?_,?_⟩
  · cases tokens <;> rfl
  · intro held hm
    cases memAppendCases _ _ _ hm with
    | inl old => exact p.2.2.2 held old
    | inr added => cases added with
      | head => exact member
      | tail _ impossible => cases impossible

theorem reconstructSuccessor (dictionary : Dictionary) (tokens : List String) (token : String) (word added : Word)
    (h : reconstruct dictionary tokens = .ok word) (row : (token,added) ∈ dictionary) :
    reconstruct dictionary (tokens ++ [token]) = .ok (word ++ added) := by
  have p := (reconstructMeaning _ _ _).mp h
  apply (reconstructMeaning _ _ _).mpr
  refine ⟨validSuccessor _ _ _ p.1 (memMap Prod.fst _ _ row),?_⟩
  rw [decodedSuccessor,p.2,blockOfRow _ _ _ ((validMeaning _ _).mp p.1).2.1 row]

theorem tokenSuccessor (tokens : List String) (token : String) :
    tokenCells (tokens ++ [token]) = tokenCells tokens ++ [["token",token]] :=
  SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem resourceFields (dictionary : Dictionary) (tokens : List String) (word : Word)
    (h : reconstruct dictionary tokens = .ok word) :
    descriptionResourceTrace dictionary tokens = .ok ⟨dictionaryTrace dictionary,tokenCells tokens,word,
      dictionaryTrace dictionary ++ tokenCells tokens⟩ := by
  unfold descriptionResourceTrace; rw [h]

theorem resourceCounts (dictionary : Dictionary) (tokens : List String) :
    (dictionaryTrace dictionary).length = dictionary.length ∧ (tokenCells tokens).length = tokens.length ∧
      (dictionaryTrace dictionary ++ tokenCells tokens).length = dictionary.length + tokens.length := by
  have a := mapLength (fun row : String × Word => "dictionary" :: row.1 :: row.2) dictionary
  have b := mapLength (fun token : String => ["token",token]) tokens
  exact ⟨a,b,by rw [appendLength]; unfold dictionaryTrace tokenCells; rw [a,b]⟩

theorem losslessMeaning (message : Word) (dictionary : Dictionary) (tokens : List String) :
    isLosslessDescription message dictionary tokens = .ok true ↔
      message.isEmpty = false ∧ reconstruct dictionary tokens = .ok message := by
  unfold isLosslessDescription
  cases empty : message.isEmpty with
  | true => constructor; intro h; cases h; intro h; cases h.1
  | false =>
    change (match reconstruct dictionary tokens with | .error e => Except.error e | .ok word => Except.ok (decide (word = message))) = .ok true ↔ _
    cases decodedEq : reconstruct dictionary tokens with
    | error e => constructor; intro h; cases h; intro h; cases h.2
    | ok word =>
      constructor
      · intro h
        have eq : decide (word = message) = true := Except.ok.inj h
        have same := of_decide_eq_true eq
        cases same
        exact ⟨rfl,rfl⟩
      · intro h
        have same := Except.ok.inj h.2
        cases same
        change Except.ok (decide (message = message)) = (Except.ok true : Except String Bool)
        rw [decide_eq_true rfl]

theorem singleTokenBase (dictionary : Dictionary) (token : String) (word : Word)
    (nonempty : dictionary.isEmpty = false) (unique : distinct (dictionary.map Prod.fst) = true)
    (row : (token,word) ∈ dictionary) : reconstruct dictionary [token] = .ok word := by
  apply (reconstructMeaning _ _ _).mpr
  constructor
  · apply (validMeaning _ _).mpr
    refine ⟨nonempty,unique,rfl,?_⟩
    intro held hm
    cases hm with
    | head => exact memMap Prod.fst _ _ row
    | tail _ impossible => cases impossible
  · change word = block dictionary token ++ []
    rw [blockOfRow _ _ _ unique row,SymbolExtension.appendNil]

theorem provenanceCells (dictionary : Dictionary) (tokens : List String) :
    (provenance dictionary tokens).map Prod.snd = decoded dictionary tokens := by
  have cells : ∀ token : String, ∀ word : Word,
      (word.map (fun cell => (token,cell))).map Prod.snd = word := by
    intro token word
    induction word with
    | nil => rfl
    | cons first rest ih => exact congrArg (List.cons first) ih
  induction tokens with
  | nil => rfl
  | cons token rest ih =>
    change (((block dictionary token).map (fun cell => (token,cell))) ++ provenance dictionary rest).map Prod.snd = block dictionary token ++ decoded dictionary rest
    rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,cells,ih]

theorem redundancyExact (message : Word) (dictionary : Dictionary) (tokens : List String)
    (h : isLosslessDescription message dictionary tokens = .ok true) :
    redundantPositions message dictionary tokens = .ok (provenance dictionary tokens) ∧
      (provenance dictionary tokens).map Prod.snd = message ∧
      (provenance dictionary tokens).length = message.length := by
  have decodedEq := ((reconstructMeaning _ _ _).mp ((losslessMeaning _ _ _).mp h).2).2
  have cells : (provenance dictionary tokens).map Prod.snd = message := (provenanceCells _ _).trans decodedEq.symm
  refine ⟨?_,cells,?_⟩
  · unfold redundantPositions; rw [h]
  · have lengths := congrArg List.length cells
    rw [mapLength] at lengths
    exact lengths

theorem resourceSuccessor (dictionary : Dictionary) (tokens : List String) (token : String) :
    dictionaryTrace dictionary ++ tokenCells (tokens ++ [token]) =
      (dictionaryTrace dictionary ++ tokenCells tokens) ++ [["token",token]] := by
  rw [tokenSuccessor,SFT.Mathematics.ExactTraceArithmetic.appendAssociative]

end SFT.InformationScience.CompressionDescription
