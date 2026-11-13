import SFT.Materials.LifecycleMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LifecycleMaterialGrammar.candidates do
    match LifecycleMaterialEvidence.decideCandidate (LifecycleMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LifecycleMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LifecycleMaterialEvidence.registration sourceHash),
    ("census",LifecycleMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LifecycleMaterialEvidence.closure decisions),
    ("controls",LifecycleMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
