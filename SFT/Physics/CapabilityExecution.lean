import SFT.Physics.CapabilityLiterals
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.CapabilityExecution
open CapabilityPrediction CapabilityValues CapabilityAdmission CapabilityOperations

structure TraceRow where
  position : PositiveCount
  opcode : Opcode
  argumentHashes : List String
  outputHash : String

structure State where
  registers : List (String × Value)
  emitted : Value
  trace : List TraceRow

def initial : State := ⟨[],emptyOne,[]⟩

def traceRow (position : PositiveCount) (op : Opcode) (args : List Value) (output : Value) : TraceRow :=
  ⟨position,op,args.map identity,identity output⟩

def occupied (held : List (String × Value)) (name : String) : Bool :=
  held.any (fun p => p.1 == name)

def commit (s : State) (i : Instruction) (position : PositiveCount)
    (output : Value) (args : List Value) : Except String State :=
  let row := traceRow position i.opcode args output
  match i.opcode with
  | .emit => .ok ⟨s.registers,output,s.trace ++ [row]⟩
  | .assertSame => .ok ⟨s.registers,s.emitted,s.trace ++ [row]⟩
  | .input | .emptyOne | .label | .count | .ratio | .word | .pair | .table | .lookup | .junction | .product | .quotient | .same =>
    if occupied s.registers i.destination then .error "a Fold register may be held exactly once"
    else .ok ⟨s.registers ++ [(i.destination,output)],s.emitted,s.trace ++ [row]⟩

theorem emissionPreservesRegisters (s : State) (dest : String) (names : List String)
    (position : PositiveCount) (output : Value) (args : List Value) :
    commit s ⟨.emit,dest,names⟩ position output args =
      .ok ⟨s.registers,output,s.trace ++ [traceRow position .emit args output]⟩ := rfl

theorem assertionPreservesState (s : State) (dest : String) (names : List String)
    (position : PositiveCount) (output : Value) (args : List Value) :
    commit s ⟨.assertSame,dest,names⟩ position output args =
      .ok ⟨s.registers,s.emitted,s.trace ++ [traceRow position .assertSame args output]⟩ := rfl

theorem duplicateRejected (s : State) (i : Instruction) (position : PositiveCount)
    (output : Value) (args : List Value) (producing : producesValue i.opcode = true)
    (held : occupied s.registers i.destination = true) :
    commit s i position output args = .error "a Fold register may be held exactly once" := by
  cases i with
  | mk op dest names =>
    cases op <;> first
    | (unfold commit; rw [held]; rfl)
    | cases producing

theorem newRegisterHeld (s : State) (i : Instruction) (position : PositiveCount)
    (output : Value) (args : List Value) (producing : producesValue i.opcode = true)
    (fresh : occupied s.registers i.destination = false) :
    commit s i position output args =
      .ok ⟨s.registers ++ [(i.destination,output)],s.emitted,
        s.trace ++ [traceRow position i.opcode args output]⟩ := by
  cases i with
  | mk op dest names =>
    cases op <;> first
    | (unfold commit; rw [fresh]; rfl)
    | cases producing
def canonicalInstruction (i : Instruction) : SFT.Host.Canonical.Value :=
  .object [("opcode",.text (opcodeName i.opcode)),("destination",.text i.destination),
    ("arguments",.array (i.arguments.map SFT.Host.Canonical.Value.text))]

def canonicalProgram (p : Program) : SFT.Host.Canonical.Value :=
  .object [("program_id",.text p.programId),("instructions",.array (p.instructions.map canonicalInstruction))]

def canonicalTraceRow (r : TraceRow) : SFT.Host.Canonical.Value :=
  .object [("position",.object [("value",.integer (.ofNat r.position.value))]),
    ("opcode",.text (opcodeName r.opcode)),
    ("argument_hashes",.array (r.argumentHashes.map SFT.Host.Canonical.Value.text)),
    ("output_hash",.text r.outputHash)]

def canonicalTrace (rows : List TraceRow) : SFT.Host.Canonical.Value :=
  .array (rows.map canonicalTraceRow)

def insertInput (entry : String × Value) : List (String × Value) → List (String × Value)
 | [] => [entry]
 | p::rest => if SFT.Host.Text.le entry.1 p.1 then entry::p::rest else p::insertInput entry rest

def sortedInputs : List (String × Value) → List (String × Value)
 | [] => []
 | p::rest => insertInput p (sortedInputs rest)

def canonicalInputs (inputs : List (String × Value)) : SFT.Host.Canonical.Value :=
  .array ((sortedInputs inputs).map (fun p => .array [.text p.1,canonical p.2]))

def dispatch (i : Instruction) (inputs held : List (String × Value)) : Except String (Value × List Value) :=
  match i.opcode with
  | .input => CapabilityLiterals.input inputs i.arguments
  | .emptyOne => CapabilityLiterals.emptyLiteral i.arguments
  | .label => CapabilityLiterals.labelLiteral i.arguments
  | .count => CapabilityLiterals.countLiteral i.arguments
  | .ratio => CapabilityLiterals.ratioLiteral i.arguments
  | .word | .pair | .table | .lookup | .junction | .product | .quotient | .same | .assertSame | .emit => do
    let values ← resolve held i.arguments
    let output ← resolved i.opcode values
    pure (output,values)

def run (inputs : List (String × Value)) (s : State) (position : Nat) : List Instruction → Except String State
 | [] => .ok s
 | i::rest => do
   let (output,args) ← dispatch i inputs s.registers
   let next ← commit s i ⟨position+1,Nat.zero_lt_succ position⟩ output args
   run inputs next (position+1) rest

structure Execution where
  programId : String
  programHash : String
  inputManifestHash : String
  output : Value
  outputHash : String
  trace : List TraceRow
  traceHash : String
  completed : Bool

def execute (p : Program) (inputs : List (String × Value)) : Except String Execution := do
  if inputs.isEmpty then .error "official prediction requires a registered positive input manifest"
  else if !(inputs.all (fun x => nonblank x.1)) then .error "registered input identity is missing"
  else
    let s ← run inputs initial 0 p.instructions
    pure ⟨p.programId,SFT.Host.Canonical.identity (canonicalProgram p),
      SFT.Host.Canonical.identity (canonicalInputs inputs),s.emitted,identity s.emitted,
      s.trace,SFT.Host.Canonical.identity (canonicalTrace s.trace),true⟩

theorem runEmpty (inputs : List (String × Value)) (s : State) (position : Nat) :
    run inputs s position [] = .ok s := rfl

theorem commitTrace (s result : State) (i : Instruction) (position : PositiveCount)
    (output : Value) (args : List Value)
    (accepted : commit s i position output args = .ok result) :
    result.trace = s.trace ++ [traceRow position i.opcode args output] := by
  cases held : occupied s.registers i.destination <;>
    cases i with
    | mk op dest names =>
      cases op <;> unfold commit at accepted <;>
        (try rw [held] at accepted) <;> cases accepted <;> rfl

theorem runTraceLength (inputs : List (String × Value)) (steps : List Instruction)
    (s result : State) (position : Nat) (accepted : run inputs s position steps = .ok result) :
    result.trace.length = s.trace.length + steps.length := by
  induction steps generalizing s position with
  | nil => cases accepted; exact (Nat.add_zero _).symm
  | cons i rest ih =>
    cases hd : dispatch i inputs s.registers with
    | error e =>
      rw [run,hd] at accepted
      cases accepted
    | ok pair =>
      rcases pair with ⟨output,args⟩
      cases hc : commit s i ⟨position+1,Nat.zero_lt_succ position⟩ output args with
      | error e =>
        rw [run,hd] at accepted
        dsimp only [Bind.bind,Except.bind] at accepted
        rw [hc] at accepted
        cases accepted
      | ok next =>
        rw [run,hd] at accepted
        dsimp only [Bind.bind,Except.bind] at accepted
        rw [hc] at accepted
        have tail := ih next (position+1) accepted
        have trace := commitTrace s next i ⟨position+1,Nat.zero_lt_succ position⟩ output args hc
        rw [tail,trace,SFT.Foundation.CommonRefinement.appendLength]
        simp only [List.length_cons,List.length_nil]
        rw [Nat.add_assoc, Nat.add_comm 1 rest.length]

end SFT.Physics.CapabilityExecution
