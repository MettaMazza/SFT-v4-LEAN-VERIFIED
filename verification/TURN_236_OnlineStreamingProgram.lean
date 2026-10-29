import SFT.Computation.OnlineStreamingEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in OnlineStreamingGrammar.candidates do
    match OnlineStreamingEvidence.decideCandidate (OnlineStreamingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match OnlineStreamingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",OnlineStreamingEvidence.registration sourceHash),
    ("census",OnlineStreamingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",OnlineStreamingEvidence.closure decisions),
    ("controls",OnlineStreamingControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
