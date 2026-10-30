import SFT.Physics.CapabilityExecution
open SFT.Physics.CapabilityValues SFT.Physics.CapabilityExecution SFT.Physics.CapabilityAdmission
def canonicalExecution (e : Execution) : SFT.Host.Canonical.Value := .object [("program_id",.text e.programId),("program_hash",.text e.programHash),("input_manifest_hash",.text e.inputManifestHash),("output",canonical e.output),("output_hash",.text e.outputHash),("trace",canonicalTrace e.trace),("trace_hash",.text e.traceHash),("completed",.boolean e.completed)]
def renderExecution : Except String Execution → String | .error e => SFT.Host.Text.append "error:" e | .ok e => SFT.Host.Canonical.render (canonicalExecution e)
def program0 : Program := ⟨"formal-prerequisite-witness",[⟨.input,"held",["registered"]⟩,⟨.emit,"",["held"]⟩]⟩
def inputs0 : List (String × Value) := [("registered",(.count ⟨1,by decide⟩))]
def program1 : Program := ⟨"all-operations",[⟨.input,"held",["registered"]⟩,⟨.emptyOne,"empty",["structural-empty-One"]⟩,⟨.label,"key",["family","name"]⟩,⟨.count,"count",["12"]⟩,⟨.ratio,"left",["2","4"]⟩,⟨.ratio,"right",["3","7"]⟩,⟨.junction,"sum",["left","right"]⟩,⟨.product,"product",["left","right"]⟩,⟨.quotient,"quotient",["left","right"]⟩,⟨.same,"same",["left","right"]⟩,⟨.assertSame,"",["held","held"]⟩,⟨.pair,"pair",["key","sum"]⟩,⟨.table,"table",["key","pair"]⟩,⟨.lookup,"lookup",["table","key"]⟩,⟨.word,"word",["held","empty","count","sum","product","quotient","same","lookup"]⟩,⟨.emit,"",["word"]⟩]⟩
def inputs1 : List (String × Value) := [("registered",(.count ⟨3,by decide⟩))]
def program2 : Program := ⟨"unicode-count",[⟨.count,"n",["٠1"]⟩,⟨.emit,"",["n"]⟩]⟩
def inputs2 : List (String × Value) := [("x",(.emptyOne "empty-One"))]
def program3 : Program := ⟨"overwrite",[⟨.count,"n",["1"]⟩,⟨.count,"n",["2"]⟩,⟨.emit,"",["n"]⟩]⟩
def inputs3 : List (String × Value) := [("x",(.emptyOne "empty-One"))]
def program4 : Program := ⟨"unheld",[⟨.pair,"p",["missing","also-missing"]⟩,⟨.emit,"",["p"]⟩]⟩
def inputs4 : List (String × Value) := [("x",(.emptyOne "empty-One"))]
def program5 : Program := ⟨"missing-input",[⟨.input,"x",["absent"]⟩,⟨.emit,"",["x"]⟩]⟩
def inputs5 : List (String × Value) := [("present",(.emptyOne "empty-One"))]
def program6 : Program := ⟨"empty-manifest",[⟨.count,"n",["1"]⟩,⟨.emit,"",["n"]⟩]⟩
def inputs6 : List (String × Value) := []
def program7 : Program := ⟨"blank-input",[⟨.count,"n",["1"]⟩,⟨.emit,"",["n"]⟩]⟩
def inputs7 : List (String × Value) := [(" ",(.emptyOne "empty-One"))]
def main : IO Unit := do
  IO.println (renderExecution (execute program0 inputs0))
  IO.println (renderExecution (execute program1 inputs1))
  IO.println (renderExecution (execute program2 inputs2))
  IO.println (renderExecution (execute program3 inputs3))
  IO.println (renderExecution (execute program4 inputs4))
  IO.println (renderExecution (execute program5 inputs5))
  IO.println (renderExecution (execute program6 inputs6))
  IO.println (renderExecution (execute program7 inputs7))
