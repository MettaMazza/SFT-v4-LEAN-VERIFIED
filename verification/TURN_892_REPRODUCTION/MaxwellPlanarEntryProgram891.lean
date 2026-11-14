import SFT.Physics.MaxwellPlanarEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MaxwellPlanarEntryGrammar.candidates do
    match MaxwellPlanarEntryEvidence.decideCandidate (MaxwellPlanarEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MaxwellPlanarEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MaxwellPlanarEntryEvidence.registration sourceHash),
    ("census",MaxwellPlanarEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MaxwellPlanarEntryEvidence.closure decisions),
    ("controls",MaxwellPlanarEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
