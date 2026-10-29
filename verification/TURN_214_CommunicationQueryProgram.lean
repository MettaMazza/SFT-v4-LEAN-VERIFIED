import SFT.Computation.CommunicationQueryEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CommunicationQueryGrammar.candidates do
    match CommunicationQueryEvidence.decideCandidate (CommunicationQueryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CommunicationQueryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CommunicationQueryEvidence.registration sourceHash),
    ("census",CommunicationQueryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CommunicationQueryEvidence.closure decisions),
    ("controls",CommunicationQueryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
