import SFT.Physics.TerminalProtonEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalProtonEmpiricalGrammar.candidates do
    match TerminalProtonEmpiricalEvidence.decideCandidate (TerminalProtonEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalProtonEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalProtonEmpiricalEvidence.registration sourceHash),
    ("census",TerminalProtonEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalProtonEmpiricalEvidence.closure decisions),
    ("controls",TerminalProtonEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
