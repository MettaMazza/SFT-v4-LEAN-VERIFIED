import SFT
open SFT.Host.Canonical SFT.Foundation DerivationTrace DerivationTraceWitnesses

def partValue (p : ExactPartCarrier.Part) : Value :=
  .object [("value",.object [("numerator",.integer p.numerator),("denominator",.integer p.denominator)])]
def rowValue (r : DerivationRow) : Value := .object [
  ("operation",.text r.operation),("input_hashes",.array (r.inputHashes.map Value.text)),
  ("output",partValue r.output),("output_hash",.text r.outputHash)]
def replayValue : Except String ExactPartCarrier.Part → Value
 | .ok p => .object [("ok",partValue p)]
 | .error e => .object [("error",.text e)]
def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass pinned source hash")
  let rows ← match threeMoveTrace with
    | .ok rs => pure rs
    | .error e => throw (IO.userError e)
  IO.println (render (.object [
    ("trace",.array (rows.map rowValue)),
    ("replay",replayValue (replay rows)),
    ("direct",partValue (ExactOperations.foldPart FoldDynamics.third)),
    ("false_premise_trace",.array (falsePremiseTrace.map rowValue)),
    ("false_premise_replay",replayValue (replay falsePremiseTrace)),
    ("tampered_trace",.array (tamperedTrace.map rowValue)),
    ("tampered_replay",replayValue (replay tamperedTrace)),
    ("controls",DerivationTraceControls.runControls sourceHash)]))
