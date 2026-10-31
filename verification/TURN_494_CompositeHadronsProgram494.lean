import SFT.Physics.CompositeHadronsEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CompositeHadronsGrammar.candidates do
    match CompositeHadronsEvidence.decideCandidate (CompositeHadronsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CompositeHadronsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CompositeHadronsEvidence.registration sourceHash),
    ("census",CompositeHadronsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CompositeHadronsEvidence.closure decisions),
    ("controls",CompositeHadronsEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
