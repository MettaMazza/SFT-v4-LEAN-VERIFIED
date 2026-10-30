import verification.TURN_348_ReversibleControlsDraft
open SFT.QuantumComputation.ReversibleGrammar SFT.Host.Canonical
set_option maxRecDepth 1000000
def main (args : List String) : IO _root_.Unit := do
  let out ← IO.getStdout
  for c in candidates do
    out.putStrLn (render (.array [.text (candidateId c),.text (exactForm c),.boolean (survives c),.text (decisionReason c)]))
  out.putStrLn (render (SFT.QuantumComputation.ReversibleControls.runControls (args.headD "")))
