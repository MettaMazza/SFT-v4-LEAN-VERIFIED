import SFT.Physics.CustodyTypes
import SFT.Physics.LeptonComparison
namespace SFT.Physics.LeptonPrediction
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 20000

inductive Held where
 | label : String → String → Held
 | pair : Held → Held → Held

def heldValue : Held → Value
 | .label family label => .object [("family",.text family),("label",.text label)]
 | .pair left right => .object [("left",heldValue left),("right",heldValue right)]

inductive Instruction where
 | input : String → String → Instruction
 | label : String → String → String → Instruction
 | pair : String → String → String → Instruction
 | emit : String → Instruction

def opcode : Instruction → String
 | .input _ _ => "input"
 | .label _ _ _ => "label"
 | .pair _ _ _ => "pair"
 | .emit _ => "emit"

def destination : Instruction → String
 | .input d _ => d
 | .label d _ _ => d
 | .pair d _ _ => d
 | .emit _ => ""

def arguments : Instruction → List String
 | .input _ name => [name]
 | .label _ family label => [family,label]
 | .pair _ left right => [left,right]
 | .emit name => [name]

def instructionValue (i : Instruction) : Value := .object [
 ("opcode",.text (opcode i)),("destination",.text (destination i)),
 ("arguments",.array ((arguments i).map Value.text))]

def lookup (name : String) : List (String × Held) → Option Held
 | [] => none
 | (key,value)::rest => if Text.equal name key then some value else lookup name rest

def register (name : String) (registers : List (String × Held)) : Except String Held :=
 match lookup name registers with
 | none => .error "FoldLanguageHalt: instruction references an unheld register"
 | some value => .ok value



def evaluate (inputs registers : List (String × Held)) : Instruction → Except String (Held × List Held)
 | .input _ name => match lookup name inputs with
   | none => .error "FoldLanguageHalt: program requested an unregistered input"
   | some value => .ok (value,[value])
 | .label _ family label =>
   if nonblank family && nonblank label then .ok (.label family label,[.label family label])
   else .error "InadmissibleExactValue: held labels require a named family and label"
 | .pair _ left right => do
   let a ← register left registers
   let b ← register right registers
   .ok (.pair a b,[a,b])
 | .emit name => do
   let value ← register name registers
   .ok (value,[value])

structure TraceRow where
 position : Nat
 instruction : Instruction
 argumentValues : List Held
 output : Held

def traceValue (row : TraceRow) : Value := .object [
 ("position",.object [("value",.integer (.ofNat row.position))]),
 ("opcode",.text (opcode row.instruction)),
 ("argument_hashes",.array (row.argumentValues.map fun v => .text (identity (heldValue v)))),
 ("output_hash",.text (identity (heldValue row.output)))]

structure Result where
 output : Option Held
 registers : List (String × Held)
 trace : List TraceRow

def run (inputs : List (String × Held)) : List Instruction → Nat → Result → Except String Result
 | [],_,state => .ok state
 | i::rest,position,state => do
   let (output,args) ← evaluate inputs state.registers i
   let row : TraceRow := ⟨position,i,args,output⟩
   match i with
   | .emit _ => run inputs rest (position+1) ⟨some output,state.registers,state.trace++[row]⟩
   | .input _ _ =>
     if (lookup (destination i) state.registers).isSome then .error "FoldLanguageHalt: a Fold register may be held exactly once"
     else run inputs rest (position+1) ⟨state.output,(destination i,output)::state.registers,state.trace++[row]⟩
   | .label _ _ _ =>
     if (lookup (destination i) state.registers).isSome then .error "FoldLanguageHalt: a Fold register may be held exactly once"
     else run inputs rest (position+1) ⟨state.output,(destination i,output)::state.registers,state.trace++[row]⟩
   | .pair _ _ _ =>
     if (lookup (destination i) state.registers).isSome then .error "FoldLanguageHalt: a Fold register may be held exactly once"
     else run inputs rest (position+1) ⟨state.output,(destination i,output)::state.registers,state.trace++[row]⟩

def experimentId : String := "SFT-EXP-PHYS-VALIDATION-CHARGED-LEPTON-TERMINAL-001"
def expectedLabel : String := "terminal-cubic-mass-ratios-inside-both-complete-codata-intervals"
def programId : String := Text.append experimentId "-prediction"
def program : List Instruction := [
 .input "premise" "registered-premise",
 .label "prediction" "physical-observation" expectedLabel,
 .pair "bound-result" "premise" "prediction",
 .emit "prediction"]

def inputs (derivationSeal : String) : List (String × Held) := [("registered-premise",.label "sealed-derivation" derivationSeal)]

def execute (derivationSeal : String) : Except String Result :=
 if nonblank derivationSeal then run (inputs derivationSeal) program 1 ⟨none,[],[]⟩
 else .error "InadmissibleExactValue: held labels require a named family and label"

def programValue : Value := .object [("program_id",.text programId),("instructions",.array (program.map instructionValue))]
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text programId),("instructions",.array (program.map instructionValue))]

def inputManifest (derivationSeal : String) : Value := .array ((inputs derivationSeal).map fun (name,value) => .array [.text name,heldValue value])

def executionValue (derivationSeal : String) : Except String Value := do
 let result ← execute derivationSeal
 match result.output with
 | none => .error "FoldLanguageHalt: registered program did not emit"
 | some output => .ok (.object [
   ("program_id",.text programId),("program_hash",.text (identity programValue)),
   ("input_manifest_hash",.text (identity (inputManifest derivationSeal))),
   ("output",heldValue output),("output_hash",.text (identity (heldValue output))),
   ("trace",.array (result.trace.map traceValue)),
   ("trace_hash",.text (identity (.array (result.trace.map traceValue)))),("completed",.boolean true)])

def emitted (derivationSeal : String) : Except String (Option Held) := (execute derivationSeal).map Result.output

theorem registeredOutput (derivationSeal : String) (valid : nonblank derivationSeal = true) :
 emitted derivationSeal = .ok (some (.label "physical-observation" expectedLabel)) := by
 unfold emitted execute
 rw [valid]
 rfl

theorem completeTrace (derivationSeal : String) (valid : nonblank derivationSeal = true) :
 (execute derivationSeal).map (fun result => result.trace.map TraceRow.position) = .ok [1,2,3,4] := by
 unfold execute
 rw [valid]
 rfl

theorem premiseRetained (derivationSeal : String) (valid : nonblank derivationSeal = true) :
 (execute derivationSeal).map (fun result => lookup "bound-result" result.registers) =
 .ok (some (.pair (.label "sealed-derivation" derivationSeal) (.label "physical-observation" expectedLabel))) := by
 unfold execute
 rw [valid]
 rfl

end SFT.Physics.LeptonPrediction
