import SFT.Physics.CapabilityPrediction
import SFT.Physics.CapabilityValues
namespace SFT.Physics.CapabilityAdmission
open CapabilityPrediction CapabilityValues
structure Instruction where
  opcode : Opcode
  destination : String
  arguments : List String

def instruction (op : Opcode) (dest : String) (args : List String) : Except String Instruction :=
  if producesValue op && !nonblank dest then
    .error "value-producing instruction requires a destination"
  else if args.isEmpty then
    .error "every instruction requires its exact argument trace"
  else .ok ⟨op, dest, args⟩

def isEmit : Opcode → Bool
 | .emit => true
 | .input | .emptyOne | .label | .count | .ratio | .word | .pair | .table | .lookup | .junction | .product | .quotient | .same | .assertSame => false

def terminal : List Instruction → Bool
 | [] => false
 | [i] => isEmit i.opcode
 | _ :: j :: rest => terminal (j :: rest)

structure Program where
  programId : String
  instructions : List Instruction

def program (id : String) (steps : List Instruction) : Except String Program :=
  if !nonblank id || steps.isEmpty then
    .error "a Fold program requires identity and positive instruction support"
  else if (steps.filter (fun i => isEmit i.opcode)).length != 1 || !terminal steps then
    .error "a Fold program must terminate with exactly one emit instruction"
  else .ok ⟨id, steps⟩

theorem instructionExact (op : Opcode) (dest : String) (args : List String)
    (d : (producesValue op && !nonblank dest) = false) (a : args.isEmpty = false) :
    instruction op dest args = .ok ⟨op,dest,args⟩ := by
  unfold instruction
  rw [d, a]
  rfl

theorem destinationRejected (op : Opcode) (dest : String) (args : List String)
    (d : (producesValue op && !nonblank dest) = true) :
    instruction op dest args = .error "value-producing instruction requires a destination" := by
  unfold instruction
  rw [d]
  rfl

theorem argumentsRejected (op : Opcode) (dest : String)
    (d : (producesValue op && !nonblank dest) = false) :
    instruction op dest [] = .error "every instruction requires its exact argument trace" := by
  unfold instruction
  rw [d]
  rfl

theorem programExact (id : String) (steps : List Instruction)
    (support : (!nonblank id || steps.isEmpty) = false)
    (emission : ((steps.filter (fun i => isEmit i.opcode)).length != 1 || !terminal steps) = false) :
    program id steps = .ok ⟨id,steps⟩ := by
  unfold program
  rw [support,emission]
  rfl
theorem supportRejected (id : String) (steps : List Instruction)
    (support : (!nonblank id || steps.isEmpty) = true) :
    program id steps = .error "a Fold program requires identity and positive instruction support" := by
  unfold program
  rw [support]
  rfl

theorem emissionRejected (id : String) (steps : List Instruction)
    (support : (!nonblank id || steps.isEmpty) = false)
    (emission : ((steps.filter (fun i => isEmit i.opcode)).length != 1 || !terminal steps) = true) :
    program id steps = .error "a Fold program must terminate with exactly one emit instruction" := by
  unfold program
  rw [support,emission]
  rfl

end SFT.Physics.CapabilityAdmission
