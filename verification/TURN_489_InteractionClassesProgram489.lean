import SFT.Physics.InteractionClassesEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InteractionClassesGrammar.candidates do
    match InteractionClassesEvidence.decideCandidate (InteractionClassesEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InteractionClassesEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InteractionClassesEvidence.registration sourceHash),
    ("census",InteractionClassesEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InteractionClassesEvidence.closure decisions),
    ("controls",InteractionClassesEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
