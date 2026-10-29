import SFT.Computation.StringsSequencesEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StringsSequencesGrammar.candidates do
    match StringsSequencesEvidence.decideCandidate (StringsSequencesEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StringsSequencesEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StringsSequencesEvidence.registration sourceHash),
    ("census",StringsSequencesEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StringsSequencesEvidence.closure decisions),
    ("controls",StringsSequencesControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
