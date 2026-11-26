import SFT.Chemistry.CanonicalExecutionChunks
namespace SFT.Chemistry.CapabilityTraceChunks
open SFT.Physics
open CapabilityPrediction CapabilityValues CapabilityAdmission CapabilityOperations CapabilityExecution
def traceRow (position : PositiveCount) (op : Opcode) (args : List Value) (output : Value) : TraceRow :=
  ⟨position,op,args.map CanonicalExecutionChunks.valueIdentity,CanonicalExecutionChunks.valueIdentity output⟩

theorem valueIdentityPreserved (v : Value) : CanonicalExecutionChunks.valueIdentity v = CapabilityValues.identity v :=
 CanonicalExecutionChunks.identityPreserved (canonical v)
theorem traceRowPreserved (position : PositiveCount) (op : Opcode) (args : List Value) (output : Value) :
 traceRow position op args output = CapabilityExecution.traceRow position op args output := by
 have h : args.map CanonicalExecutionChunks.valueIdentity = args.map CapabilityValues.identity := by
  induction args with
  | nil => rfl
  | cons a rest ih => rw [List.map_cons,List.map_cons,valueIdentityPreserved,ih]
 unfold traceRow CapabilityExecution.traceRow
 rw [h,valueIdentityPreserved]
def commit (s : State) (i : Instruction) (position : PositiveCount)
    (output : Value) (args : List Value) : Except String State :=
  let row := traceRow position i.opcode args output
  match i.opcode with
  | .emit => .ok ⟨s.registers,output,s.trace ++ [row]⟩
  | .assertSame => .ok ⟨s.registers,s.emitted,s.trace ++ [row]⟩
  | .input | .emptyOne | .label | .count | .ratio | .word | .pair | .table | .lookup | .junction | .product | .quotient | .same =>
    if occupied s.registers i.destination then .error "a Fold register may be held exactly once"
    else .ok ⟨s.registers ++ [(i.destination,output)],s.emitted,s.trace ++ [row]⟩

theorem commitPreserved (s : State) (i : Instruction) (position : PositiveCount) (output : Value) (args : List Value) :
 commit s i position output args = CapabilityExecution.commit s i position output args := by
 unfold commit CapabilityExecution.commit
 rw [traceRowPreserved]
 cases i.opcode <;> rfl
def run (inputs : List (String × Value)) (s : State) (position : Nat) : List Instruction → Except String State
 | [] => .ok s
 | i::rest => do
   let (output,args) ← dispatch i inputs s.registers
   let next ← commit s i ⟨position+1,Nat.zero_lt_succ position⟩ output args
   run inputs next (position+1) rest

theorem runPreserved (inputs : List (String × Value)) (s : State) (position : Nat) (instructions : List Instruction) :
 run inputs s position instructions = CapabilityExecution.run inputs s position instructions := by
 induction instructions generalizing s position with
 | nil => rfl
 | cons i rest ih =>
   unfold run CapabilityExecution.run
   cases hd : dispatch i inputs s.registers with
   | error e => rfl
   | ok pair =>
     cases pair with
     | mk output args =>
       change (commit s i ⟨position+1,Nat.zero_lt_succ position⟩ output args >>= fun next => run inputs next (position+1) rest) =
        (CapabilityExecution.commit s i ⟨position+1,Nat.zero_lt_succ position⟩ output args >>= fun next => CapabilityExecution.run inputs next (position+1) rest)
       rw [commitPreserved]
       cases hc : CapabilityExecution.commit s i ⟨position+1,Nat.zero_lt_succ position⟩ output args with
       | error e => rfl
       | ok next => exact ih next (position+1)
def execute (p : Program) (inputs : List (String × Value)) : Except String Execution := do
  if inputs.isEmpty then .error "official prediction requires a registered positive input manifest"
  else if !(inputs.all (fun x => nonblank x.1)) then .error "registered input identity is missing"
  else
    let s ← run inputs initial 0 p.instructions
    pure ⟨p.programId,CanonicalExecutionChunks.identity (canonicalProgram p),
      CanonicalExecutionChunks.identity (canonicalInputs inputs),s.emitted,CanonicalExecutionChunks.valueIdentity s.emitted,
      s.trace,CanonicalExecutionChunks.identity (canonicalTrace s.trace),true⟩

theorem executePreserved (p : Program) (inputs : List (String × Value)) :
 execute p inputs = CapabilityExecution.execute p inputs := by
 unfold execute CapabilityExecution.execute
 split
 · rfl
 · split
   · rfl
   · rw [runPreserved]
     cases h : CapabilityExecution.run inputs initial 0 p.instructions with
     | error e => rfl
     | ok state =>
       change Except.ok _ = Except.ok _
       rw [CanonicalExecutionChunks.identityPreserved,CanonicalExecutionChunks.identityPreserved,
        valueIdentityPreserved,CanonicalExecutionChunks.identityPreserved]
end SFT.Chemistry.CapabilityTraceChunks
#print axioms SFT.Chemistry.CapabilityTraceChunks.traceRow
#print axioms SFT.Chemistry.CapabilityTraceChunks.valueIdentityPreserved
#print axioms SFT.Chemistry.CapabilityTraceChunks.traceRowPreserved
#print axioms SFT.Chemistry.CapabilityTraceChunks.commit
#print axioms SFT.Chemistry.CapabilityTraceChunks.commitPreserved
#print axioms SFT.Chemistry.CapabilityTraceChunks.run
#print axioms SFT.Chemistry.CapabilityTraceChunks.runPreserved
#print axioms SFT.Chemistry.CapabilityTraceChunks.execute
#print axioms SFT.Chemistry.CapabilityTraceChunks.executePreserved
