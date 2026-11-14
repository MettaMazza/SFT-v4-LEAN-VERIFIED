import SFT.Physics.TerminalBaryonEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalBaryonEntryGrammar.candidates do
    match TerminalBaryonEntryEvidence.decideCandidate (TerminalBaryonEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalBaryonEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalBaryonEntryEvidence.registration sourceHash),
    ("census",TerminalBaryonEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalBaryonEntryEvidence.closure decisions),
    ("controls",TerminalBaryonEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
