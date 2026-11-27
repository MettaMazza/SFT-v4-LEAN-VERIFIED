import SFT.EarthEnvironment.EarthStratigraphicOrderEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthStratigraphicOrderGrammar.candidates do
    match EarthStratigraphicOrderEvidence.decideCandidate (EarthStratigraphicOrderEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthStratigraphicOrderEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthStratigraphicOrderEvidence.registration sourceHash),
    ("census",EarthStratigraphicOrderEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthStratigraphicOrderEvidence.closure decisions),
    ("controls",EarthStratigraphicOrderEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
