import SFT.Physics.CausalIntervalEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CausalIntervalEntryGrammar.candidates do
    match CausalIntervalEntryEvidence.decideCandidate (CausalIntervalEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CausalIntervalEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CausalIntervalEntryEvidence.registration sourceHash),
    ("census",CausalIntervalEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CausalIntervalEntryEvidence.closure decisions),
    ("controls",CausalIntervalEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
