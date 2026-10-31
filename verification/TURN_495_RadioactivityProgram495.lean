import SFT.Physics.RadioactivityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RadioactivityGrammar.candidates do
    match RadioactivityEvidence.decideCandidate (RadioactivityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RadioactivityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RadioactivityEvidence.registration sourceHash),
    ("census",RadioactivityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RadioactivityEvidence.closure decisions),
    ("controls",RadioactivityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
