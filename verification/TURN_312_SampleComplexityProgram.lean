import SFT.Computation.SampleComplexityEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SampleComplexityGrammar.candidates do
    match SampleComplexityEvidence.decideCandidate (SampleComplexityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SampleComplexityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SampleComplexityEvidence.registration sourceHash),
    ("census",SampleComplexityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SampleComplexityEvidence.closure decisions),
    ("controls",SampleComplexityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
