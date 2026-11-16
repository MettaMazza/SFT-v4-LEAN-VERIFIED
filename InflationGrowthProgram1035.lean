import SFT.Physics.InflationGrowthEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InflationGrowthGrammar.candidates do
    match InflationGrowthEntryEvidence.decideCandidate (InflationGrowthEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InflationGrowthEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InflationGrowthEntryEvidence.registration sourceHash),
    ("census",InflationGrowthEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InflationGrowthEntryEvidence.closure decisions),
    ("controls",InflationGrowthEntryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
