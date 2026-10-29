import SFT.Computation.DistributedMessages
namespace SFT.Computation.StreamingTrace
open StateTransition StateComposition RandomnessResources
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects

-- Every generated prefix, including the identity prefix, in source order.
def prefixes : List String → List (List String)
 | [] => [[]]
 | symbol :: rest => [] :: (prefixes rest).map (List.cons symbol)

def outputs (system : System) (initial : String) (input : List String) :=
  (prefixes input).map (fun part => (part,run system initial part))

def summary (system : System) (initial : String) (input : List String) : Outcome :=
  match run system initial input with
  | .error reason => .failed reason
  | .ok trace => .returned (endLabel trace)

def closedBySummary (system : System) (initial : String) (left right : List String) : Bool :=
  decide (left ≠ right ∧ summary system initial left = summary system initial right)

def pairs (left right : List (List String)) : List (List String × List String) :=
  left.flatMap (fun first => right.map (fun second => (first,second)))

def lostDistinctions (system : System) (initial : String) (support : List (List String)) :=
  (pairs support support).filter (fun pair => closedBySummary system initial pair.1 pair.2)

theorem prefixBoundary (input part : List String) (held : part ∈ prefixes input) :
    ∃ suffix, input = part ++ suffix := by
  induction input generalizing part with
  | nil =>
    cases held with
    | head => exact ⟨[],rfl⟩
    | tail _ impossible => cases impossible
  | cons symbol rest ih =>
    cases held with
    | head => exact ⟨symbol :: rest,rfl⟩
    | tail _ member =>
      obtain ⟨prior,present,same⟩ := memMapPreimage (List.cons symbol) _ _ member
      obtain ⟨suffix,split⟩ := ih prior present
      cases same; exact ⟨suffix,congrArg (List.cons symbol) split⟩

theorem completePrefixes (part suffix : List String) : part ∈ prefixes (part ++ suffix) := by
  induction part with
  | nil => cases suffix <;> exact .head _
  | cons symbol rest ih => exact .tail [] (memMap (List.cons symbol) _ _ ih)

theorem prefixMeaning (input part : List String) :
    part ∈ prefixes input ↔ ∃ suffix, input = part ++ suffix := by
  constructor
  · exact prefixBoundary _ _
  · intro ⟨suffix,same⟩; cases same; exact completePrefixes _ _

theorem prefixCount (input : List String) : (prefixes input).length = input.length + 1 := by
  induction input with
  | nil => rfl
  | cons symbol rest ih =>
    change ((prefixes rest).map (List.cons symbol)).length + 1 = _
    rw [CommunicationResources.mapLength,ih]; rfl

theorem exactOutput (system : System) (initial : String) (input part : List String) :
    (part,run system initial part) ∈ outputs system initial input ↔ part ∈ prefixes input := by
  constructor
  · intro held
    obtain ⟨p,present,same⟩ := memMapPreimage _ _ _ held
    have identity := congrArg Prod.fst same
    dsimp only at identity; cases identity; exact present
  · intro held; exact memMap _ _ _ held

theorem outputCount (system : System) (initial : String) (input : List String) :
    (outputs system initial input).length = input.length + 1 :=
  (CommunicationResources.mapLength _ _).trans (prefixCount _)

theorem prefixRetained (input added part : List String) (held : part ∈ prefixes input) :
    part ∈ prefixes (input ++ added) := by
  obtain ⟨suffix,split⟩ := prefixBoundary _ _ held
  apply (prefixMeaning _ _).mpr
  refine ⟨suffix ++ added,?_⟩
  rw [split]; exact SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _

theorem outputRetained (system : System) (initial : String) (input added part : List String)
    (held : part ∈ prefixes input) :
    (part,run system initial part) ∈ outputs system initial (input ++ added) :=
  (exactOutput _ _ _ _).mpr (prefixRetained _ _ _ held)

theorem retainedSummary (system : System) (initial terminal : String) (part trace : List String)
    (observed : run system initial part = .ok (trace ++ [terminal])) :
    summary system initial part = .returned (some terminal) := by
  unfold summary; rw [observed]; exact congrArg Outcome.returned (terminalLabel _ _)

theorem prefixReconstruction (system : System) (initial : String) (input part trace : List String)
    (prefixHeld : part ∈ prefixes input) (observed : run system initial part = .ok trace) :
    ∃ suffix before terminal, input = part ++ suffix ∧ trace = before ++ [terminal] ∧
      Path system initial part before terminal ∧ summary system initial part = .returned (some terminal) := by
  obtain ⟨suffix,boundary⟩ := prefixBoundary _ _ prefixHeld
  obtain ⟨_,before,terminal,split,path⟩ := nativePath _ _ _ _ observed
  exact ⟨suffix,before,terminal,boundary,split,path,retainedSummary _ _ _ _ _ (observed.trans (congrArg Except.ok split))⟩

theorem pairMembership (left right : List (List String)) (a b : List String) :
    (a,b) ∈ pairs left right ↔ a ∈ left ∧ b ∈ right := by
  induction left with
  | nil => constructor; intro h; cases h; intro h; cases h.1
  | cons first rest ih =>
    change (a,b) ∈ (right.map (fun second => (first,second))) ++ pairs rest right ↔ _
    constructor
    · intro held
      cases memAppendCases _ _ _ held with
      | inl head =>
        obtain ⟨second,member,same⟩ := memMapPreimage (fun second => (first,second)) _ _ head
        cases same; exact ⟨.head _,member⟩
      | inr tail => have p := ih.mp tail; exact ⟨.tail _ p.1,p.2⟩
    · intro h
      cases h.1 with
      | head => exact memAppendLeft _ _ _ (memMap (fun second => (a,second)) _ _ h.2)
      | tail _ member => exact memAppendRight _ _ _ (ih.mpr ⟨member,h.2⟩)

theorem lossMeaning (system : System) (initial : String) (support : List (List String)) (left right : List String) :
    (left,right) ∈ lostDistinctions system initial support ↔
      left ∈ support ∧ right ∈ support ∧ left ≠ right ∧ summary system initial left = summary system initial right := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    have members := (pairMembership _ _ _ _).mp p.1
    have closed := of_decide_eq_true p.2
    exact ⟨members.1,members.2,closed.1,closed.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨(pairMembership _ _ _ _).mpr ⟨h.1,h.2.1⟩,decide_eq_true ⟨h.2.2.1,h.2.2.2⟩⟩

theorem distinctionRetained (system : System) (initial : String) (support : List (List String)) (left right : List String)
    (different : summary system initial left ≠ summary system initial right) :
    ¬ (left,right) ∈ lostDistinctions system initial support := fun h => different ((lossMeaning _ _ _ _ _).mp h).2.2.2

theorem prefixMemory (system : System) (initial : String) (part trace occupied : List String)
    (ledger : ResourceRecord.Ledger) (observed : run system initial part = .ok trace)
    (recorded : ResourceRecord.resourceLedger trace occupied = .ok ledger) :
    ledger.timeTrace.map Prod.snd = trace ∧ ledger.spaceSupport = occupied ∧
      ledger.timeCount = part.length + 1 ∧ ledger.spaceCount = occupied.length := by
  have p := ResourceRecord.recordReconstructs _ _ _ recorded
  exact ⟨p.1,p.2.1,ResourceRecord.executionObservationCount _ _ _ _ _ _ observed recorded,p.2.2.2⟩

theorem onePrefix : prefixes [] = [[]] := rfl
theorem updateSummary (system : System) (initial current next action : String) (part trace : List String)
    (held : initial ∈ system.states) (path : Path system initial part trace current)
    (update : step system current action = .ok next) :
    summary system initial (part ++ [action]) = .returned (some next) := by
  have executed := nativeComposition system initial current next part [action] trace [current] held path
    (.next _ _ _ _ _ _ update (.identity _))
  exact retainedSummary _ _ _ _ _ executed

theorem continuation (system : System) (initial middle terminal : String) (first second before after : List String)
    (held : initial ∈ system.states) (left : Path system initial first before middle)
    (right : Path system middle second after terminal) :
    summary system initial (first ++ second) = .returned (some terminal) :=
  retainedSummary _ _ _ _ _ (nativeComposition _ _ _ _ _ _ _ _ held left right)

theorem retainedLoss (system : System) (initial : String) (input added left right : List String)
    (lost : (left,right) ∈ lostDistinctions system initial (prefixes input)) :
    (left,right) ∈ lostDistinctions system initial (prefixes (input ++ added)) := by
  have p := (lossMeaning _ _ _ _ _).mp lost
  exact (lossMeaning _ _ _ _ _).mpr ⟨prefixRetained _ _ _ p.1,prefixRetained _ _ _ p.2.1,p.2.2⟩
end SFT.Computation.StreamingTrace
