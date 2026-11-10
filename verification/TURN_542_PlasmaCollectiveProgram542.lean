import SFT.Physics.PlasmaCollectiveEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PlasmaCollectiveGrammar.candidates do
    match PlasmaCollectiveEvidence.decideCandidate (PlasmaCollectiveEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PlasmaCollectiveEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PlasmaCollectiveEvidence.registration sourceHash),
    ("census",PlasmaCollectiveEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PlasmaCollectiveEvidence.closure decisions),
    ("controls",PlasmaCollectiveEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
