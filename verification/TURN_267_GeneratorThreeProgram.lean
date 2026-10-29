import SFT.Physics.GeneratorThreeEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GeneratorThreeGrammar.candidates do
    match GeneratorThreeEvidence.decideCandidate (GeneratorThreeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GeneratorThreeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GeneratorThreeEvidence.registration sourceHash),
    ("census",GeneratorThreeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GeneratorThreeEvidence.closure decisions),
    ("controls",GeneratorThreeControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
