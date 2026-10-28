import SFT.Computation.RewritingDerivation
namespace SFT.Computation.RewritingClasses
open RewritingDerivation StateWords
open SFT.InformationScience.QuantitySupport

-- The topic's finite registered rule applications and generated word carrier are
-- declarative boundaries on retained records, not new exact_rewrite guards.
def Admitted (positions : List String) (rules : List Record) (carrier : List Word) (record : Record) : Prop :=
  record ∈ rules ∧ record.source ∈ carrier ∧ record.successor ∈ carrier ∧ Replays positions record

def Retained (positions : List String) (rules : List Record) (carrier : List Word)
    (initial : Word) (records : List Record) (terminal : Word) : Prop :=
  initial ∈ carrier ∧ Trace positions initial records terminal ∧
    ∀ record, record ∈ records → Admitted positions rules carrier record

def Terminal (positions : List String) (rules : List Record) (carrier : List Word) (word : Word) : Prop :=
  word ∈ carrier ∧ ∀ record, Admitted positions rules carrier record → record.source = word → False

def Cyclic (positions : List String) (rules : List Record) (carrier : List Word) (word : Word) : Prop :=
  ∃ records, records ≠ [] ∧ Retained positions rules carrier word records word

def Branching (positions : List String) (rules : List Record) (carrier : List Word) (word : Word) : Prop :=
  ∃ left right, Admitted positions rules carrier left ∧ Admitted positions rules carrier right ∧
    left.source = word ∧ right.source = word ∧ left.successor ≠ right.successor

theorem coordinateExists (word : Word) (positions : List String) (held : String)
    (length : word.length = positions.length) (member : held ∈ positions) :
    ∃ symbol, (held,symbol) ∈ positions.zip word := by
  induction positions generalizing word with
  | nil => cases member
  | cons position positions ih => cases word with
    | nil => cases length
    | cons symbol word =>
      cases member with
      | head => exact ⟨symbol,.head _⟩
      | tail _ hm =>
        obtain ⟨found,hf⟩ := ih word (Nat.succ.inj length) hm
        exact ⟨found,.tail _ hf⟩

theorem occurrenceDecomposition (word : Word) (positions : List String) (held symbol : String)
    (occurrence : (held,symbol) ∈ positions.zip word) :
    ∃ before after, word = before ++ symbol :: after := by
  induction positions generalizing word with
  | nil => cases occurrence
  | cons position positions ih => cases word with
    | nil => cases occurrence
    | cons first word =>
      cases occurrence with
      | head => exact ⟨[],word,rfl⟩
      | tail _ hm =>
        obtain ⟨before,after,eq⟩ := ih word hm
        exact ⟨first::before,after,congrArg (List.cons first) eq⟩

theorem admittedPattern (positions : List String) (rules : List Record) (carrier : List Word) (record : Record)
    (h : Admitted positions rules carrier record) :
    ∃ symbol, (record.heldPosition,symbol) ∈ positions.zip record.source ∧
      (∃ before after, record.source = before ++ symbol :: after) ∧
      (record.heldPosition,record.replacement) ∈ positions.zip record.successor := by
  have p := (rewriteMeaning _ _ _ _ _).mp h.2.2.2
  obtain ⟨symbol,hm⟩ := coordinateExists _ _ _ p.2.1 p.2.2.1
  refine ⟨symbol,hm,occurrenceDecomposition _ _ _ _ hm,?_⟩
  have hc := recordCoordinate _ _ h.2.2.2 _ _ hm
  rw [if_pos rfl] at hc
  exact hc

theorem unregisteredExcluded (positions : List String) (rules : List Record) (carrier : List Word) (record : Record)
    (missing : record ∉ rules) : ¬ Admitted positions rules carrier record :=
  fun h => missing h.1

theorem sourceOutsideExcluded (positions : List String) (rules : List Record) (carrier : List Word) (record : Record)
    (missing : record.source ∉ carrier) : ¬ Admitted positions rules carrier record :=
  fun h => missing h.2.1

theorem successorOutsideExcluded (positions : List String) (rules : List Record) (carrier : List Word) (record : Record)
    (missing : record.successor ∉ carrier) : ¬ Admitted positions rules carrier record :=
  fun h => missing h.2.2.1

theorem traceHead (positions : List String) (initial terminal : Word) (records : List Record)
    (h : Trace positions initial records terminal) :
    records = [] ∨ ∃ record rest, records = record::rest ∧ record.source = initial := by
  induction h with
  | identity => exact .inl rfl
  | next record records terminal valid rest ih => exact .inr ⟨record,records,rfl,rfl⟩

theorem retainedIdentity (positions : List String) (rules : List Record) (carrier : List Word) (word : Word)
    (member : word ∈ carrier) : Retained positions rules carrier word [] word :=
  ⟨member,.identity word,fun _ h => by cases h⟩

theorem retainedComposition (positions : List String) (rules : List Record) (carrier : List Word)
    (initial middle terminal : Word) (left right : List Record)
    (first : Retained positions rules carrier initial left middle)
    (second : Retained positions rules carrier middle right terminal) :
    Retained positions rules carrier initial (left++right) terminal := by
  refine ⟨first.1,traceComposition _ _ _ _ _ _ first.2.1 second.2.1,?_⟩
  intro record hm
  cases SFT.Foundation.Count.TraceDerivation.memAppendCases _ _ _ hm with
  | inl hl => exact first.2.2 record hl
  | inr hr => exact second.2.2 record hr

theorem terminalTraceEmpty (positions : List String) (rules : List Record) (carrier : List Word)
    (initial terminal : Word) (records : List Record)
    (boundary : Terminal positions rules carrier initial)
    (trace : Retained positions rules carrier initial records terminal) : records = [] := by
  cases traceHead _ _ _ _ trace.2.1 with
  | inl empty => exact empty
  | inr h =>
    obtain ⟨record,rest,eq,source⟩ := h
    have member : record ∈ records := eq.symm ▸ List.Mem.head rest
    exact False.elim (boundary.2 record (trace.2.2 record member) source)

theorem terminalNotCyclic (positions : List String) (rules : List Record) (carrier : List Word) (word : Word)
    (boundary : Terminal positions rules carrier word) : ¬ Cyclic positions rules carrier word := by
  intro cycle
  obtain ⟨records,nonempty,trace⟩ := cycle
  exact nonempty (terminalTraceEmpty _ _ _ _ _ _ boundary trace)

theorem terminalNotBranching (positions : List String) (rules : List Record) (carrier : List Word) (word : Word)
    (boundary : Terminal positions rules carrier word) : ¬ Branching positions rules carrier word := by
  intro branch
  obtain ⟨left,right,hl,hr,source,other,different⟩ := branch
  exact boundary.2 left hl source

theorem cyclicRepeat (positions : List String) (rules : List Record) (carrier : List Word) (word : Word)
    (records : List Record) (trace : Retained positions rules carrier word records word) :
    Retained positions rules carrier word (records++records) word :=
  retainedComposition _ _ _ _ _ _ _ _ trace trace

theorem branchTraces (positions : List String) (rules : List Record) (carrier : List Word) (word : Word)
    (branch : Branching positions rules carrier word) :
    ∃ left right, Retained positions rules carrier word [left] left.successor ∧
      Retained positions rules carrier word [right] right.successor ∧ left.successor ≠ right.successor := by
  obtain ⟨left,right,hl,hr,sl,sr,different⟩ := branch
  have one : ∀ record : Record, Admitted positions rules carrier record →
      Retained positions rules carrier record.source [record] record.successor := by
    intro record h
    refine ⟨h.2.1,.next record [] record.successor h.2.2.2 (.identity _),?_⟩
    intro selected hm
    cases hm with
    | head => exact h
    | tail _ hm => cases hm
  exact ⟨left,right,sl ▸ one left hl,sr ▸ one right hr,different⟩


theorem retainedStep (positions : List String) (rules : List Record) (carrier : List Word)
    (record : Record) (h : Admitted positions rules carrier record) :
    Retained positions rules carrier record.source [record] record.successor := by
  refine ⟨h.2.1,.next record [] record.successor h.2.2.2 (.identity _),?_⟩
  intro selected hm
  cases hm with
  | head => exact h
  | tail _ hm => cases hm

theorem retainedSuccessor (positions : List String) (rules : List Record) (carrier : List Word)
    (initial : Word) (records : List Record) (record : Record)
    (trace : Retained positions rules carrier initial records record.source)
    (step : Admitted positions rules carrier record) :
    Retained positions rules carrier initial (records++[record]) record.successor :=
  retainedComposition _ _ _ _ _ _ _ _ trace (retainedStep _ _ _ _ step)

theorem retainedExtension (positions : List String) (rules larger : List Record)
    (carrier extended : List Word) (initial terminal : Word) (records : List Record)
    (rulesHeld : ∀ record, record ∈ rules → record ∈ larger)
    (wordsHeld : ∀ word, word ∈ carrier → word ∈ extended)
    (trace : Retained positions rules carrier initial records terminal) :
    Retained positions larger extended initial records terminal := by
  refine ⟨wordsHeld _ trace.1,trace.2.1,?_⟩
  intro record hm
  have h := trace.2.2 record hm
  exact ⟨rulesHeld _ h.1,wordsHeld _ h.2.1,wordsHeld _ h.2.2.1,h.2.2.2⟩

end SFT.Computation.RewritingClasses
