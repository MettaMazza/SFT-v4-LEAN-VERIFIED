import SFT.Physics.CoupledEnsembleSynchronizationEvidence
open SFT.Host.Canonical SFT.Physics CoupledEnsembleSynchronizationEvidence CoupledEnsembleSynchronizationGrammar
def main (args : List String) : IO Unit := do
 let sourceHash := args.headD ""
 let mut decisions : List SFT.Engine.CandidateDecision := []
 for c in candidates do
  match decideCandidate (generatedCandidateData c) with
  | .ok d => decisions := decisions ++ [d]
  | .error e => throw (IO.userError e)
 let controls ← match controlData sourceHash with
  | .ok x => pure x
  | .error e => throw (IO.userError e)
 let closure ← match closureData decisions with
  | .ok x => pure x
  | .error e => throw (IO.userError e)
 IO.println (render (.object [("registration",SFT.Engine.registrationValue (registrationData sourceHash)),("census",census),("decisions",.array (decisions.map SFT.Engine.decisionValue)),("closure",SFT.Engine.closureEvidenceValue closure),("controls",.array (controls.map SFT.Engine.controlResultValue))]))
