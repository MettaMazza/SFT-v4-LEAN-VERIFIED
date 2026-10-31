import SFT.Physics.ElectroweakTerminalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ElectroweakTerminalGrammar.candidates do
    match ElectroweakTerminalEvidence.decideCandidate (ElectroweakTerminalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ElectroweakTerminalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ElectroweakTerminalEvidence.registration sourceHash),
    ("census",ElectroweakTerminalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ElectroweakTerminalEvidence.closure decisions),
    ("controls",ElectroweakTerminalControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
