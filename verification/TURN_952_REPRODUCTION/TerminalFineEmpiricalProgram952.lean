import SFT.Physics.TerminalFineEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalFineEmpiricalGrammar.candidates do
    match TerminalFineEmpiricalEvidence.decideCandidate (TerminalFineEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalFineEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalFineEmpiricalEvidence.registration sourceHash),
    ("census",TerminalFineEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalFineEmpiricalEvidence.closure decisions),
    ("controls",TerminalFineEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
