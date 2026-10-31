import SFT.Physics.SourceContinuityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SourceContinuityGrammar.candidates do
    match SourceContinuityEvidence.decideCandidate (SourceContinuityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SourceContinuityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SourceContinuityEvidence.registration sourceHash),
    ("census",SourceContinuityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SourceContinuityEvidence.closure decisions),
    ("controls",SourceContinuityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
