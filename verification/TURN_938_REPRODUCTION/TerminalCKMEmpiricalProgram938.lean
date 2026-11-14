import SFT.Physics.TerminalCKMEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalCKMEmpiricalGrammar.candidates do
    match TerminalCKMEmpiricalEvidence.decideCandidate (TerminalCKMEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalCKMEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalCKMEmpiricalEvidence.registration sourceHash),
    ("census",TerminalCKMEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalCKMEmpiricalEvidence.closure decisions),
    ("controls",TerminalCKMEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
