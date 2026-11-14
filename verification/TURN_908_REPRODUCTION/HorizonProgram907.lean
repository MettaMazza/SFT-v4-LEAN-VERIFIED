import SFT.Physics.StrongHorizonEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StrongHorizonEntryGrammar.candidates do
    match StrongHorizonEntryEvidence.decideCandidate (StrongHorizonEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StrongHorizonEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StrongHorizonEntryEvidence.registration sourceHash),
    ("census",StrongHorizonEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StrongHorizonEntryEvidence.closure decisions),
    ("controls",StrongHorizonEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
