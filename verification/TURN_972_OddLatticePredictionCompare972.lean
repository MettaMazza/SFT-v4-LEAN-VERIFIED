import SFT.Physics.OddLatticePrediction
open SFT.Physics SFT.Host.Canonical OddLatticePrediction
set_option maxRecDepth 20000
#eval do
 let result : Except String Value := do
  let inputs ← formalPredictionInputs
  let doc ← predictionProgramDocument
  let program ← predictionProgram
  let execution ← CapabilityExecution.execute program inputs
  let out ← outputMapping execution.output (inputs.map Prod.fst)
  pure (.object [("inputs",.object (inputs.map (fun (k,v) => (k,CapabilityValues.canonical v)))),("program",doc),("output",.object (out.map (fun (k,v) => (k,CapabilityValues.canonical v))))])
 match result with
 | .ok x => IO.println (render x)
 | .error e => IO.println e
