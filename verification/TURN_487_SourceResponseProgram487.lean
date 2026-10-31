import SFT.Physics.SourceResponseEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SourceResponseGrammar.candidates do
    match SourceResponseEvidence.decideCandidate (SourceResponseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SourceResponseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SourceResponseEvidence.registration sourceHash),
    ("census",SourceResponseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SourceResponseEvidence.closure decisions),
    ("controls",SourceResponseEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
