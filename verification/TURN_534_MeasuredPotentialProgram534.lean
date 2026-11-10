import SFT.Physics.MeasuredPotentialEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MeasuredPotentialGrammar.candidates do
    match MeasuredPotentialEvidence.decideCandidate (MeasuredPotentialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MeasuredPotentialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MeasuredPotentialEvidence.registration sourceHash),
    ("census",MeasuredPotentialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MeasuredPotentialEvidence.closure decisions),
    ("controls",MeasuredPotentialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
