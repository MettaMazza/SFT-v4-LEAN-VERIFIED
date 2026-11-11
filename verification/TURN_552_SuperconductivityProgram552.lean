import SFT.Physics.SuperconductivityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SuperconductivityGrammar.candidates do
    match SuperconductivityEvidence.decideCandidate (SuperconductivityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SuperconductivityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SuperconductivityEvidence.registration sourceHash),
    ("census",SuperconductivityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SuperconductivityEvidence.closure decisions),
    ("controls",SuperconductivityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
