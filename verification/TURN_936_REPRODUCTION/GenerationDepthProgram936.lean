import SFT.Physics.GenerationDepthEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GenerationDepthEntryGrammar.candidates do
    match GenerationDepthEntryEvidence.decideCandidate (GenerationDepthEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GenerationDepthEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GenerationDepthEntryEvidence.registration sourceHash),
    ("census",GenerationDepthEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GenerationDepthEntryEvidence.closure decisions),
    ("controls",GenerationDepthEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
