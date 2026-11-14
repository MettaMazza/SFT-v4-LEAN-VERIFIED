import SFT.Physics.MirrorMassClosureEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MirrorMassClosureEntryGrammar.candidates do
    match MirrorMassClosureEntryEvidence.decideCandidate (MirrorMassClosureEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MirrorMassClosureEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MirrorMassClosureEntryEvidence.registration sourceHash),
    ("census",MirrorMassClosureEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MirrorMassClosureEntryEvidence.closure decisions),
    ("controls",MirrorMassClosureEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
