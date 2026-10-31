import SFT.Physics.DisplacementEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DisplacementGrammar.candidates do
    match DisplacementEvidence.decideCandidate (DisplacementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DisplacementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DisplacementEvidence.registration sourceHash),
    ("census",DisplacementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DisplacementEvidence.closure decisions),
    ("controls",DisplacementEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
