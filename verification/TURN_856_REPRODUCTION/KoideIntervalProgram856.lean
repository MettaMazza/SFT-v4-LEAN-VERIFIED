import SFT.Physics.KoideIntervalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in KoideIntervalGrammar.candidates do
    match KoideIntervalEvidence.decideCandidate (KoideIntervalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match KoideIntervalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",KoideIntervalEvidence.registration sourceHash),
    ("census",KoideIntervalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",KoideIntervalEvidence.closure decisions),
    ("controls",KoideIntervalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
