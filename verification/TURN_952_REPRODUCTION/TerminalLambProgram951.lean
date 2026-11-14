import SFT.Physics.TerminalLambEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalLambEntryGrammar.candidates do
    match TerminalLambEntryEvidence.decideCandidate (TerminalLambEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalLambEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalLambEntryEvidence.registration sourceHash),
    ("census",TerminalLambEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalLambEntryEvidence.closure decisions),
    ("controls",TerminalLambEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
