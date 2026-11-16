import SFT.Physics.ThermalHistoryEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ThermalHistoryGrammar.candidates do
    match ThermalHistoryEntryEvidence.decideCandidate (ThermalHistoryEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ThermalHistoryEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ThermalHistoryEntryEvidence.registration sourceHash),
    ("census",ThermalHistoryEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ThermalHistoryEntryEvidence.closure decisions),
    ("controls",ThermalHistoryEntryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
