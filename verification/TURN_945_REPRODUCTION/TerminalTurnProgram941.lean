import SFT.Physics.TerminalTurnEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalTurnEntryGrammar.candidates do
    match TerminalTurnEntryEvidence.decideCandidate (TerminalTurnEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalTurnEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalTurnEntryEvidence.registration sourceHash),
    ("census",TerminalTurnEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalTurnEntryEvidence.closure decisions),
    ("controls",TerminalTurnEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
