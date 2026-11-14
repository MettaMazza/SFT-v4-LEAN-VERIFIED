import SFT.Physics.HydrogenRydbergEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HydrogenRydbergEmpiricalGrammar.candidates do
    match HydrogenRydbergEmpiricalEvidence.decideCandidate (HydrogenRydbergEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HydrogenRydbergEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HydrogenRydbergEmpiricalEvidence.registration sourceHash),
    ("census",HydrogenRydbergEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HydrogenRydbergEmpiricalEvidence.closure decisions),
    ("controls",HydrogenRydbergEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
