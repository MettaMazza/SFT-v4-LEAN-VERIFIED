import SFT.Computation.UniversalInterpretation
namespace SFT.Computation.ResourceRecord
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

structure Ledger where
  timeTrace : List (String × String)
  spaceSupport : List String
  timeCount : Nat
  spaceCount : Nat

def timeRows (next : Nat) : List String → List (String × String)
 | [] => []
 | state :: rest => (SFT.Host.Text.append "transition-" (toString next),state) :: timeRows (next+1) rest

-- Literal resource_ledger: trace includes its initial observation; no silent
-- conversion to action count and no assumption that occupied equals the trace.
def resourceLedger (trace occupied : List String) : Except String Ledger :=
  if !distinct occupied then .error "ValueError: occupied states must contain unique generated identities"
  else if trace.isEmpty || occupied.isEmpty then .error "ValueError: resource ledgers require nonempty generated traces"
  else .ok ⟨timeRows 1 trace,occupied,trace.length,occupied.length⟩

theorem timeRowsRetain (trace : List String) (next : Nat) :
    (timeRows next trace).map Prod.snd = trace := by
  induction trace generalizing next with
  | nil => rfl
  | cons state rest ih => exact congrArg (List.cons state) (ih (next+1))

theorem timeRowsLength (trace : List String) (next : Nat) :
    (timeRows next trace).length = trace.length := by
  induction trace generalizing next with
  | nil => rfl
  | cons state rest ih => exact congrArg Nat.succ (ih (next+1))

theorem ledgerMeaning (trace occupied : List String) (ledger : Ledger) :
    resourceLedger trace occupied = .ok ledger ↔
      distinct occupied = true ∧ trace.isEmpty = false ∧ occupied.isEmpty = false ∧
      ledger = Ledger.mk (timeRows 1 trace) occupied trace.length occupied.length := by
  unfold resourceLedger
  cases hd : distinct occupied <;> cases ht : trace.isEmpty <;> cases ho : occupied.isEmpty
  all_goals try { constructor; intro h; cases h; intro h; cases h.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.2.1 }
  constructor
  · intro h; exact ⟨rfl,rfl,rfl,(Except.ok.inj h).symm⟩
  · intro h; rw [h.2.2.2]; rfl

theorem recordReconstructs (trace occupied : List String) (ledger : Ledger)
    (passed : resourceLedger trace occupied = .ok ledger) :
    ledger.timeTrace.map Prod.snd = trace ∧ ledger.spaceSupport = occupied ∧
      ledger.timeCount = trace.length ∧ ledger.spaceCount = occupied.length := by
  have eq := (ledgerMeaning _ _ _).mp passed |>.2.2.2
  rw [eq]
  exact ⟨timeRowsRetain _ _,rfl,rfl,rfl⟩

open StateTransition StateComposition

theorem executionObservationCount (system : System) (initial : String) (actions trace occupied : List String)
    (ledger : Ledger) (observed : run system initial actions = .ok trace)
    (recorded : resourceLedger trace occupied = .ok ledger) : ledger.timeCount = actions.length + 1 := by
  obtain ⟨held,before,terminal,eq,path⟩ := nativePath _ _ _ _ observed
  have count := (recordReconstructs _ _ _ recorded).2.2.1
  rw [eq] at count
  have appendLength : ∀ items : List String, (items ++ [terminal]).length = items.length + 1 := by
    intro items
    induction items with
    | nil => rfl
    | cons state rest ih => exact congrArg Nat.succ ih
  rw [appendLength before,pathTraceLength _ _ _ _ _ path] at count
  exact count

end SFT.Computation.ResourceRecord
