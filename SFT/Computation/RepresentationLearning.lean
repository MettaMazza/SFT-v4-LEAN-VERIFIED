import SFT.InformationScience.EncodingLoss
namespace SFT.Computation.RepresentationLearning
open SFT.InformationScience.EncodingClasses SFT.InformationScience.EncodingMaps SFT.InformationScience.EncodingLoss
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations

structure Model where
  source : List String
  grammar : List Codeword
  encoding : Encoding
  taskRelation : List (Codeword × String)

def valid (m : Model) : Bool := validateEncoding m.source m.grammar m.encoding
structure Transformation (m : Model) where
  source : String
  word : Codeword
  sourceHeld : source ∈ m.source
  wordHeld : word ∈ m.grammar
  rowHeld : (source,word) ∈ m.encoding

structure TaskTrace (m : Model) extends Transformation m where
  result : String
  taskHeld : (word,result) ∈ m.taskRelation

def tasks (m : Model) (word : Codeword) : List String :=
  (m.taskRelation.filter (fun row => decide (row.1 = word))).map Prod.snd

theorem taskMeaning (m : Model) (word : Codeword) (result : String) : result ∈ tasks m word ↔ (word,result) ∈ m.taskRelation := by
  constructor
  · intro h
    obtain ⟨row,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ h
    have p := (filterMemberIff _ _ _).mp held
    have first := of_decide_eq_true p.2
    cases row with
    | mk a b =>
      dsimp at first same
      cases first
      cases same
      exact p.1
  · intro h; exact SFT.Foundation.Count.TraceDerivation.memMap Prod.snd (word,result) _ ((filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩)

def complexityLedger (m : Model) : List (String × Nat) := m.encoding.map (fun row => (row.1,row.2.length))

theorem complexityMeaning (m : Model) (source : String) (size : Nat) : (source,size) ∈ complexityLedger m ↔
    ∃ word, (source,word) ∈ m.encoding ∧ word.length = size := by
  constructor
  · intro h
    obtain ⟨row,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ h
    have a := congrArg Prod.fst same; have b := congrArg Prod.snd same
    cases row with
    | mk name word => dsimp at a b; cases a; exact ⟨word,held,b⟩
  · intro ⟨word,held,same⟩
    have h := SFT.Foundation.Count.TraceDerivation.memMap (fun row : String × Codeword => (row.1,row.2.length)) (source,word) _ held
    exact same ▸ h

theorem commonWordCloses (m : Model) (checked : valid m = true) (left right : Transformation m)
    (same : left.word = right.word) : closedPair m.encoding left.source right.source = .ok true := by
  apply classClosesPair m.source m.grammar m.encoding checked left.word left.source right.source
  · exact (memberMeaning _ _ _ _).mpr ⟨left.sourceHeld,left.rowHeld⟩
  · exact (memberMeaning _ _ _ _).mpr ⟨right.sourceHeld,same.symm ▸ right.rowHeld⟩

theorem noRecoveryFromClosed (m : Model) (left right : Transformation m) (different : left.source ≠ right.source)
    (same : left.word = right.word) : ¬ ∃ decoder : Codeword → String, decoder left.word = left.source ∧ decoder right.word = right.source := by
  intro ⟨decoder,a,b⟩
  exact different (a.symm.trans ((congrArg decoder same).trans b))

structure Extension (first second : Model) : Prop where
  source : ∀ x, x ∈ first.source → x ∈ second.source
  grammar : ∀ x, x ∈ first.grammar → x ∈ second.grammar
  encoding : ∀ x, x ∈ first.encoding → x ∈ second.encoding
  tasks : ∀ x, x ∈ first.taskRelation → x ∈ second.taskRelation

def extendTransformation (first second : Model) (inc : Extension first second) (t : Transformation first) : Transformation second :=
  ⟨t.source,t.word,inc.source _ t.sourceHeld,inc.grammar _ t.wordHeld,inc.encoding _ t.rowHeld⟩

def extendTask (first second : Model) (inc : Extension first second) (t : TaskTrace first) : TaskTrace second :=
  ⟨extendTransformation _ _ inc t.toTransformation,t.result,inc.tasks _ t.taskHeld⟩

theorem retainedWord (first second : Model) (inc : Extension first second) (t : Transformation first) :
    (extendTransformation _ _ inc t).word = t.word := rfl

theorem differentWordsRetained (m : Model) (checked : valid m = true) (left right : Transformation m)
    (different : left.word ≠ right.word) : closedPair m.encoding left.source right.source = .ok false := by
  have l := admittedRowLookup m.source m.grammar m.encoding checked left.source left.word left.rowHeld
  have r := admittedRowLookup m.source m.grammar m.encoding checked right.source right.word right.rowHeld
  rw [closedPairImages _ _ _ _ _ l r]
  have no : decide (left.word = right.word) = false := by
    cases h : decide (left.word = right.word) with
    | false => rfl
    | true => exact False.elim (different (of_decide_eq_true h))
  rw [no]

theorem distinctionExhaustion (m : Model) (checked : valid m = true) (left right : Transformation m) :
    closedPair m.encoding left.source right.source = .ok true ∨ closedPair m.encoding left.source right.source = .ok false := by
  cases decEq left.word right.word with
  | isTrue same => exact .inl (commonWordCloses m checked left right same)
  | isFalse different => exact .inr (differentWordsRetained m checked left right different)

theorem commonWordTasks (m : Model) (left right : Transformation m) (same : left.word = right.word) :
    tasks m left.word = tasks m right.word := congrArg (tasks m) same

def closedLedger (m : Model) : Except String (List Pair) := closedDistinctions m.source m.encoding

theorem closedLedgerExists (m : Model) (checked : valid m = true) : ∃ result, closedLedger m = .ok result :=
  admittedLossExists _ _ _ checked

theorem closedLedgerMeaning (m : Model) (checked : valid m = true) (result : List Pair)
    (run : closedLedger m = .ok result) (a b : String) : (a,b) ∈ result ↔
    (a,b) ∈ sourcePairs m.source ∧ ∃ word, a ∈ membersFor m.source m.encoding word ∧ b ∈ membersFor m.source m.encoding word :=
  closedLedgerClass _ _ _ checked result run a b

def retainedLedger (m : Model) : List Pair := (sourcePairs m.source).filter
  (fun p => decide (lookupFirst m.encoding p.1 ≠ lookupFirst m.encoding p.2))

theorem retainedLedgerMeaning (m : Model) (a b : String) : (a,b) ∈ retainedLedger m ↔
    (a,b) ∈ sourcePairs m.source ∧ lookupFirst m.encoding a ≠ lookupFirst m.encoding b := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

def compose (m : Model) (interface : List (Codeword × Codeword)) : Except String Encoding := composeEncodings m.encoding interface

theorem compositionRows (m : Model) (interface : List (Codeword × Codeword)) (result : Encoding)
    (run : compose m interface = .ok result) (source : String) (word : Codeword) :
    (source,word) ∈ result ↔ ∃ middle, (source,middle) ∈ m.encoding ∧ (middle,word) ∈ interface :=
  composedRow _ _ _ run source word

theorem compositionSources (m : Model) (interface : List (Codeword × Codeword)) (result : Encoding)
    (run : compose m interface = .ok result) : result.map Prod.fst = m.encoding.map Prod.fst :=
  compositionProvenance _ _ _ run

end SFT.Computation.RepresentationLearning
