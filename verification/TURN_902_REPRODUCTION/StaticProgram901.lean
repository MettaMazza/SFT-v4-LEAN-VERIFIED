import SFT.Physics.StaticFoldClockEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StaticFoldClockEntryGrammar.candidates do
    match StaticFoldClockEntryEvidence.decideCandidate (StaticFoldClockEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StaticFoldClockEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StaticFoldClockEntryEvidence.registration sourceHash),
    ("census",StaticFoldClockEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StaticFoldClockEntryEvidence.closure decisions),
    ("controls",StaticFoldClockEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
