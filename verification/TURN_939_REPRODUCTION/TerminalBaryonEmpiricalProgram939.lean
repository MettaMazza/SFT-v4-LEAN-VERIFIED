import SFT.Physics.TerminalBaryonEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalBaryonEmpiricalGrammar.candidates do
    match TerminalBaryonEmpiricalEvidence.decideCandidate (TerminalBaryonEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalBaryonEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalBaryonEmpiricalEvidence.registration sourceHash),
    ("census",TerminalBaryonEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalBaryonEmpiricalEvidence.closure decisions),
    ("controls",TerminalBaryonEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
