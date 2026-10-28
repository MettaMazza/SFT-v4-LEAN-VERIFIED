import SFT.Computation.BindingTrace
import SFT.Computation.StateWords
namespace SFT.Computation.MachineExecution
open StateTransition StateComposition

-- Typed execution/halt trace required by the ABSTRACT-MACHINE source topic.
-- A terminal boundary is recorded separately from exhaustion of requested input.
def Halted (system : System) (initial terminal : String)
    (actions before : List String) : Prop :=
  initial ∈ system.states ∧ Path system initial actions before terminal ∧
    BindingTrace.Normal system terminal

theorem executionUnique (system : System) (initial : String)
    (actions left right : List String)
    (first : Execution system initial actions left)
    (second : Execution system initial actions right) : left = right := by
  have one := (runFromMeaning _ _ _ _).mpr first
  have two := (runFromMeaning _ _ _ _).mpr second
  rw [one] at two
  cases two
  rfl

theorem haltReconstructs (system : System) (initial terminal : String)
    (actions before : List String) (h : Halted system initial terminal actions before) :
    run system initial actions = .ok (before ++ [terminal]) ∧ before.length = actions.length :=
  ⟨BindingTrace.traceReplay _ _ _ _ _ h.1 h.2.1,pathTraceLength _ _ _ _ _ h.2.1⟩

theorem haltHasNoContinuation (system : System) (initial terminal : String)
    (actions before : List String) (h : Halted system initial terminal actions before)
    (action target : String) : step system terminal action ≠ .ok target := h.2.2.2 action target

theorem haltedContinuationEmpty (system : System) (initial terminal next : String)
    (actions before rest after : List String) (h : Halted system initial terminal actions before)
    (continuation : Path system terminal rest after next) : rest = [] :=
  BindingTrace.normalTraceEmpty _ _ _ _ _ h.2.2 continuation

theorem initialHalt (system : System) (state : String) (normal : BindingTrace.Normal system state) :
    Halted system state state [] [] := ⟨normal.1,.identity state,normal⟩

theorem haltComposition (system : System) (initial middle terminal : String)
    (left right before after : List String) (held : initial ∈ system.states)
    (prior : Path system initial left before middle)
    (final : Halted system middle terminal right after) :
    Halted system initial terminal (left ++ right) (before ++ after) :=
  ⟨held,pathSerial _ _ _ _ _ _ _ _ prior final.2.1,final.2.2⟩

theorem noUnregisteredConfiguration (states actions : List String) (rows : List Row) (system : System)
    (admitted : create states actions rows = .ok system) (initial : String)
    (held : initial ∈ states) (requested trace : List String)
    (runPassed : run system initial requested = .ok trace) :
    ∀ state, state ∈ trace → state ∈ states :=
  executionStates _ _ _ _ admitted _ held _ _
    ((runFromMeaning _ _ _ _).mp ((runAdmission _ _ _ _).mp runPassed).2)

-- Description/store words have exactly the source generated_words boundary.
theorem descriptionBoundary (alphabet positions : List String) (words : List SFT.InformationScience.QuantitySupport.Word)
    (generated : StateWords.generatedWords alphabet positions = .ok words)
    (word : SFT.InformationScience.QuantitySupport.Word) :
    word ∈ words ↔ word = ["empty-One"] ∨
      ∃ width, 0 < width ∧ width ≤ positions.length ∧ word.length = width ∧
        ∀ label, label ∈ word → label ∈ alphabet :=
  StateWords.generatedMembership _ _ _ generated _

end SFT.Computation.MachineExecution
