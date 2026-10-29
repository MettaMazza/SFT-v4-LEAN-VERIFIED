import SFT.Physics.TerminalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalGrammar.candidates do
    match TerminalEvidence.decideCandidate (TerminalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalEvidence.registration sourceHash),
    ("census",TerminalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalEvidence.closure decisions),
    ("controls",TerminalControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
