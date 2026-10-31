import SFT.Physics.EvolutionEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EvolutionGrammar.candidates do
    match EvolutionEvidence.decideCandidate (EvolutionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EvolutionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EvolutionEvidence.registration sourceHash),
    ("census",EvolutionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EvolutionEvidence.closure decisions),
    ("controls",EvolutionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
