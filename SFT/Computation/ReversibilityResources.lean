import SFT.Computation.RandomnessResources
import SFT.InformationScience.ConservationReverse
namespace SFT.Computation.ReversibilityResources
open StateTransition StateComposition
open SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.DiscreteObjects

-- Exact fibres of the original transition operation, without a new inverse law.
def reaches (system : System) (action target state : String) : Bool :=
  match step system state action with
  | .error _ => false
  | .ok result => decide (result = target)

def predecessorFibre (system : System) (action target : String) : List String :=
  system.states.filter (reaches system action target)

theorem reachesMeaning (system : System) (action target state : String) :
    reaches system action target state = true ↔ step system state action = .ok target := by
  unfold reaches
  cases h : step system state action with
  | error reason => constructor <;> intro h <;> cases h
  | ok result =>
    constructor
    · intro h; cases of_decide_eq_true h; rfl
    · intro h; cases Except.ok.inj h; exact decide_eq_true rfl

theorem completeFibre (system : System) (action target state : String) :
    state ∈ predecessorFibre system action target ↔
      state ∈ system.states ∧ step system state action = .ok target := by
  constructor
  · intro h
    have parts := (filterMemberIff _ _ _).mp h
    exact ⟨parts.1,(reachesMeaning _ _ _ _).mp parts.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(reachesMeaning _ _ _ _).mpr h.2⟩

theorem mergedPredecessors (system : System) (action target left right : String)
    (one : left ∈ predecessorFibre system action target)
    (two : right ∈ predecessorFibre system action target) (different : left ≠ right) :
    ∀ state, SFT.InformationScience.ConservationReverse.predecessorRecord
      (predecessorFibre system action target) ≠ .unique state :=
  SFT.InformationScience.ConservationReverse.distinctPredecessorsNotUnique _ _ _ one two different

theorem erasedLabelCannotRecover (target left right : String) (different : left ≠ right) :
    ¬ ∃ recover : String → String, recover target = left ∧ recover target = right := by
  intro ⟨recover,one,two⟩
  exact different (one.symm.trans two)

structure Row where
  source : String
  action : String
  target : String

-- Reverse traversal uses each actual forward edge and retained predecessor.
inductive Inverse (system : System) : String → List Row → String → Prop where
 | identity (state) : Inverse system state [] state
 | previous (row : Row) (rest : List Row) (initial : String)
     (edge : step system row.source row.action = .ok row.target)
     (prior : Inverse system row.source rest initial) :
     Inverse system row.target (row :: rest) initial

theorem inverseSerial (system : System) (terminal middle initial : String)
    (first second : List Row) (one : Inverse system terminal first middle)
    (two : Inverse system middle second initial) :
    Inverse system terminal (first ++ second) initial := by
  induction one with
  | identity => exact two
  | previous row rest middle edge prior ih => exact .previous _ _ _ edge (ih two)

theorem everyForwardPathHasRetainedInverse (system : System)
    (initial terminal : String) (actions before : List String)
    (path : Path system initial actions before terminal) :
    ∃ rows, Inverse system terminal rows initial ∧ rows.length = actions.length := by
  induction path with
  | identity state => exact ⟨[],.identity state,rfl⟩
  | next state action target actions before terminal edge prior ih =>
    obtain ⟨rows,inverse,count⟩ := ih
    refine ⟨rows ++ [⟨state,action,target⟩],
      inverseSerial _ _ _ _ _ _ inverse (.previous ⟨state,action,target⟩ [] state edge (.identity state)),?_⟩
    rw [CommunicationResources.countAppend,count]
    rfl

def undo (system : System) (current : String) : List Row → Except String String
 | [] => .ok current
 | row :: rest =>
   if current = row.target then
     if reaches system row.action row.target row.source then undo system row.source rest
     else .error "retained predecessor is not an original transition"
   else .error "inverse interface mismatch"

theorem inverseExecutes (system : System) (terminal initial : String) (rows : List Row)
    (inverse : Inverse system terminal rows initial) : undo system terminal rows = .ok initial := by
  induction inverse with
  | identity => rfl
  | previous row rest initial edge prior ih =>
    unfold undo
    rw [ite_eq_left rfl,(reachesMeaning _ _ _ _).mpr edge]
    exact ih

theorem nativeInverse (system : System) (initial : String) (actions trace : List String)
    (executed : run system initial actions = .ok trace) :
    ∃ before terminal rows, trace = before ++ [terminal] ∧
      Inverse system terminal rows initial ∧ undo system terminal rows = .ok initial ∧
      rows.length = actions.length := by
  obtain ⟨held,before,terminal,equal,path⟩ := nativePath _ _ _ _ executed
  obtain ⟨rows,inverse,count⟩ := everyForwardPathHasRetainedInverse _ _ _ _ _ path
  exact ⟨before,terminal,rows,equal,inverse,inverseExecutes _ _ _ _ inverse,count⟩

theorem inverseRowsRetained (system : System) (terminal initial : String) (rows : List Row)
    (inverse : Inverse system terminal rows initial) (row : Row) (held : row ∈ rows) :
    step system row.source row.action = .ok row.target := by
  induction inverse with
  | identity => cases held
  | previous entry rest initial edge prior ih =>
    cases held with
    | head => exact edge
    | tail _ member => exact ih member

theorem inverseBase (system : System) (state : String) : undo system state [] = .ok state := rfl

theorem inverseSuccessor (system : System) (row : Row) (rest : List Row) (initial : String)
    (edge : step system row.source row.action = .ok row.target)
    (prior : Inverse system row.source rest initial) :
    Inverse system row.target (row :: rest) initial ∧
      undo system row.target (row :: rest) = .ok initial :=
  ⟨.previous _ _ _ edge prior,inverseExecutes _ _ _ _ (.previous _ _ _ edge prior)⟩

theorem inverseResourceRecord (trace occupied : List String) (ledger : ResourceRecord.Ledger)
    (recorded : ResourceRecord.resourceLedger trace occupied = .ok ledger) :
    ledger.timeTrace.map Prod.snd = trace ∧ ledger.spaceSupport = occupied ∧
      ledger.timeCount = trace.length ∧ ledger.spaceCount = occupied.length :=
  ResourceRecord.recordReconstructs _ _ _ recorded
theorem retainedInverseCost (system : System) (terminal initial : String)
    (rows : List Row) (occupied : List String) (ledger : ResourceRecord.Ledger)
    (inverse : Inverse system terminal rows initial)
    (recorded : ResourceRecord.resourceLedger (terminal :: rows.map Row.source) occupied = .ok ledger) :
    undo system terminal rows = .ok initial ∧
      ledger.timeTrace.map Prod.snd = terminal :: rows.map Row.source ∧
      ledger.timeCount = rows.length + 1 ∧ ledger.spaceSupport = occupied := by
  have retained := ResourceRecord.recordReconstructs _ _ _ recorded
  refine ⟨inverseExecutes _ _ _ _ inverse,retained.1,?_,retained.2.1⟩
  rw [retained.2.2.1]
  change (rows.map Row.source).length + 1 = rows.length + 1
  rw [CommunicationResources.mapLength]
end SFT.Computation.ReversibilityResources
