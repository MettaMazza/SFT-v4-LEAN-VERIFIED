import SFT.Physics.TerminalHyperfineEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalHyperfineEmpiricalGrammar.candidates do
    match TerminalHyperfineEmpiricalEvidence.decideCandidate (TerminalHyperfineEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalHyperfineEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalHyperfineEmpiricalEvidence.registration sourceHash),
    ("census",TerminalHyperfineEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalHyperfineEmpiricalEvidence.closure decisions),
    ("controls",TerminalHyperfineEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
