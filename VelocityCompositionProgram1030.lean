import SFT.Physics.VelocityCompositionEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in VelocityCompositionGrammar.candidates do
    match VelocityCompositionEntryEvidence.decideCandidate (VelocityCompositionEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match VelocityCompositionEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",VelocityCompositionEntryEvidence.registration sourceHash),
    ("census",VelocityCompositionEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",VelocityCompositionEntryEvidence.closure decisions),
    ("controls",VelocityCompositionEntryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
