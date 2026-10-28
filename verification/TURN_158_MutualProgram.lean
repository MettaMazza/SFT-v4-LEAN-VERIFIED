import SFT.InformationScience.MutualEvidence
open SFT.Host.Canonical SFT.InformationScience

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MutualGrammar.candidates do
    match MutualEvidence.decideCandidate (MutualEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MutualEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MutualEvidence.registration sourceHash),
    ("census",MutualEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MutualEvidence.closure decisions),
    ("controls",MutualControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
