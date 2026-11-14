import SFT.Physics.TerminalLambEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalLambEmpiricalGrammar.candidates do
    match TerminalLambEmpiricalEvidence.decideCandidate (TerminalLambEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalLambEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalLambEmpiricalEvidence.registration sourceHash),
    ("census",TerminalLambEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalLambEmpiricalEvidence.closure decisions),
    ("controls",TerminalLambEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
