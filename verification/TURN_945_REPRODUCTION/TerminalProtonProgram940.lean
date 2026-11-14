import SFT.Physics.TerminalProtonEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalProtonEntryGrammar.candidates do
    match TerminalProtonEntryEvidence.decideCandidate (TerminalProtonEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalProtonEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalProtonEntryEvidence.registration sourceHash),
    ("census",TerminalProtonEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalProtonEntryEvidence.closure decisions),
    ("controls",TerminalProtonEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
