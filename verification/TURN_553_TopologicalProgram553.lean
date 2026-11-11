import SFT.Physics.TopologicalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TopologicalGrammar.candidates do
    match TopologicalEvidence.decideCandidate (TopologicalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TopologicalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TopologicalEvidence.registration sourceHash),
    ("census",TopologicalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TopologicalEvidence.closure decisions),
    ("controls",TopologicalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
