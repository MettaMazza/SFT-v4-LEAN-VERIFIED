import SFT.Computation.StateExtension
import SFT.Computation.LanguageDerivation
namespace SFT.Computation.AutomatonRecognition
open StateTransition StateComposition StateExtension
open SFT.Foundation.Count.TraceDerivation

-- Typed representation of the source topic's accepting class and complete run.
-- No additional executable method is attributed to operations.py.
def lastState (current : String) : List String → String
 | [] => current
 | next::rest => lastState next rest

def terminalState : List String → Option String
 | [] => none
 | first::rest => some (lastState first rest)

def HeldClass (system : System) (accepting : List String) : Prop :=
  ∀ state, state ∈ accepting → state ∈ system.states

def Accepted (system : System) (initial : String) (input accepting trace : List String) : Prop :=
  initial ∈ system.states ∧ ∃ before terminal,
    trace = before ++ [terminal] ∧ Path system initial input before terminal ∧ terminal ∈ accepting

theorem terminalAppend (before : List String) (terminal : String) :
    terminalState (before ++ [terminal]) = some terminal := by
  induction before with
  | nil => rfl
  | cons first rest ih => cases rest with
    | nil => rfl
    | cons next tail => exact ih

theorem acceptedMeaning (system : System) (initial : String) (input accepting trace : List String) :
    Accepted system initial input accepting trace ↔
      run system initial input = .ok trace ∧ ∃ terminal, terminalState trace = some terminal ∧ terminal ∈ accepting := by
  constructor
  · intro ⟨held,before,terminal,eq,path,member⟩
    cases eq
    exact ⟨(runAdmission _ _ _ _).mpr ⟨held,(runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ path)⟩,
      terminal,terminalAppend before terminal,member⟩
  · intro ⟨success,terminal,last,member⟩
    obtain ⟨held,before,ending,eq,path⟩ := nativePath _ _ _ _ success
    rw [eq,terminalAppend] at last
    cases Option.some.inj last
    exact ⟨held,before,terminal,eq,path,member⟩

theorem acceptedInitial (system : System) (initial : String) (input accepting trace : List String)
    (h : Accepted system initial input accepting trace) : trace.head? = some initial :=
  executionInitial _ _ _ _ ((runFromMeaning _ _ _ _).mp ((runAdmission _ _ _ _).mp ((acceptedMeaning _ _ _ _ _).mp h).1).2)

theorem acceptedTraceLength (system : System) (initial : String) (input accepting trace : List String)
    (h : Accepted system initial input accepting trace) : trace.length = input.length + 1 :=
  executionLength _ _ _ _ ((runFromMeaning _ _ _ _).mp ((runAdmission _ _ _ _).mp ((acceptedMeaning _ _ _ _ _).mp h).1).2)

theorem emptyClassRejects (system : System) (initial : String) (input trace : List String) :
    ¬ Accepted system initial input [] trace := by
  intro ⟨_,_,_,_,_,member⟩
  cases member

theorem identityAcceptance (system : System) (initial : String) (accepting : List String)
    (held : initial ∈ system.states) : Accepted system initial [] accepting [initial] ↔ initial ∈ accepting := by
  constructor
  · intro h
    obtain ⟨_,terminal,last,member⟩ := (acceptedMeaning _ _ _ _ _).mp h
    have eq : initial = terminal := Option.some.inj last
    cases eq; exact member
  · intro member; exact ⟨held,[],initial,rfl,.identity initial,member⟩

theorem acceptedTerminalInCarrier (system : System) (initial : String) (input accepting trace : List String)
    (classHeld : HeldClass system accepting) (h : Accepted system initial input accepting trace) :
    ∃ terminal, terminalState trace = some terminal ∧ terminal ∈ system.states := by
  obtain ⟨_,terminal,last,member⟩ := (acceptedMeaning _ _ _ _ _).mp h
  exact ⟨terminal,last,classHeld terminal member⟩

theorem acceptedComposition (system : System) (initial middle terminal : String)
    (left right before after accepting : List String) (held : initial ∈ system.states)
    (first : Path system initial left before middle) (second : Path system middle right after terminal)
    (member : terminal ∈ accepting) :
    Accepted system initial (left ++ right) accepting ((before ++ after) ++ [terminal]) :=
  ⟨held,before ++ after,terminal,rfl,pathSerial _ _ _ _ _ _ _ _ first second,member⟩

theorem acceptancePreserved (old extended : System)
    (admitted : create extended.states extended.actions extended.transitions = .ok extended)
    (statesRetained : ∀ state, state ∈ old.states → state ∈ extended.states)
    (rowsRetained : ∀ row, row ∈ old.transitions → row ∈ extended.transitions)
    (initial : String) (input accepting trace : List String) (h : Accepted old initial input accepting trace) :
    Accepted extended initial input accepting trace := by
  have p := (acceptedMeaning _ _ _ _ _).mp h
  exact (acceptedMeaning _ _ _ _ _).mpr ⟨extendRun _ _ admitted statesRetained rowsRetained _ _ _ p.1,p.2⟩



theorem executionInputAlphabet (system : System)
    (admitted : create system.states system.actions system.transitions = .ok system)
    (initial : String) (input trace : List String) (h : Execution system initial input trace) :
    ∀ symbol, symbol ∈ input → symbol ∈ system.actions := by
  induction h with
  | base => intro symbol member; cases member
  | next state action target actions trace edge rest ih =>
    intro symbol member
    cases member with
    | head => exact (admittedStepBound _ _ _ _ admitted _ _ _ edge).2.2
    | tail _ hm => exact ih symbol hm

theorem acceptedInputAlphabet (system : System)
    (admitted : create system.states system.actions system.transitions = .ok system)
    (initial : String) (input accepting trace : List String) (h : Accepted system initial input accepting trace) :
    ∀ symbol, symbol ∈ input → symbol ∈ system.actions :=
  executionInputAlphabet system admitted initial input trace
    ((runFromMeaning _ _ _ _).mp ((runAdmission _ _ _ _).mp ((acceptedMeaning _ _ _ _ _).mp h).1).2)

theorem acceptedSuccessor (system : System) (initial terminal next : String)
    (input before accepting : List String) (held : initial ∈ system.states)
    (path : Path system initial input before terminal) (symbol : String)
    (edge : step system terminal symbol = .ok next) (member : next ∈ accepting) :
    Accepted system initial (input ++ [symbol]) accepting ((before ++ [terminal]) ++ [next]) :=
  ⟨held,before ++ [terminal],next,rfl,pathSuccessor _ _ _ _ _ _ path symbol edge,member⟩

end SFT.Computation.AutomatonRecognition
