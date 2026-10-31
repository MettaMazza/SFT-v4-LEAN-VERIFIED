import SFT.Physics.RunningConvergenceEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
 let sourceHash := args.headD ""
 let decisions := RunningConvergenceGrammar.candidates.map RunningConvergenceEvidence.decisionData
 let controls ← match RunningConvergenceEvidence.runControls sourceHash with
   | .ok cs => pure cs
   | .error e => throw (IO.userError e)
 let unknown := match RunningConvergenceEvidence.decideCandidate ⟨"unknown-candidate","",""⟩ with
   | .error e => e
   | .ok _ => "unexpected success"
 IO.println (render (.object [
  ("registration",RunningConvergenceEvidence.registration sourceHash),
  ("census",RunningConvergenceEvidence.census),
  ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
  ("closure",RunningConvergenceEvidence.closure decisions),
  ("controls",.array (controls.map SFT.Engine.controlResultValue)),
  ("unknown_id",.text unknown)]))
