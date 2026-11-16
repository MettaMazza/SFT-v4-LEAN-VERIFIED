import SFT.Physics.CollectiveRadiationEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CollectiveRadiationGrammar.candidates do
    match CollectiveRadiationEntryEvidence.decideCandidate (CollectiveRadiationEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CollectiveRadiationEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CollectiveRadiationEntryEvidence.registration sourceHash),
    ("census",CollectiveRadiationEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CollectiveRadiationEntryEvidence.closure decisions),
    ("controls",CollectiveRadiationEntryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
