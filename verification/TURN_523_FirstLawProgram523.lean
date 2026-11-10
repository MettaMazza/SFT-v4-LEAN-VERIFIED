import SFT.Physics.FirstLawEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FirstLawGrammar.candidates do
    match FirstLawEvidence.decideCandidate (FirstLawEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FirstLawEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FirstLawEvidence.registration sourceHash),
    ("census",FirstLawEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FirstLawEvidence.closure decisions),
    ("controls",FirstLawEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
