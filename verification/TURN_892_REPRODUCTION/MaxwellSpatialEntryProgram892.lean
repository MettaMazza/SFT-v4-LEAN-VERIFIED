import SFT.Physics.MaxwellSpatialEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MaxwellSpatialEntryGrammar.candidates do
    match MaxwellSpatialEntryEvidence.decideCandidate (MaxwellSpatialEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MaxwellSpatialEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MaxwellSpatialEntryEvidence.registration sourceHash),
    ("census",MaxwellSpatialEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MaxwellSpatialEntryEvidence.closure decisions),
    ("controls",MaxwellSpatialEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
