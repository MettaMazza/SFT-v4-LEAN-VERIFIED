import SFT.Physics.GravityWaveEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravityWaveEntryGrammar.candidates do
    match GravityWaveEntryEvidence.decideCandidate (GravityWaveEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravityWaveEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravityWaveEntryEvidence.registration sourceHash),
    ("census",GravityWaveEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravityWaveEntryEvidence.closure decisions),
    ("controls",GravityWaveEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
