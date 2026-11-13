import SFT.Mathematics.BoundedNBodyEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in BoundedNBodyGrammar.candidates do
    match BoundedNBodyEvidence.decideCandidate (BoundedNBodyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match BoundedNBodyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",BoundedNBodyEvidence.registration sourceHash),
    ("census",BoundedNBodyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",BoundedNBodyEvidence.closure decisions),
    ("controls",BoundedNBodyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
