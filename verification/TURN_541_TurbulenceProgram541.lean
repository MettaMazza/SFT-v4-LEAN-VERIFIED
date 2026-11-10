import SFT.Physics.TurbulenceEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TurbulenceGrammar.candidates do
    match TurbulenceEvidence.decideCandidate (TurbulenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TurbulenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TurbulenceEvidence.registration sourceHash),
    ("census",TurbulenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TurbulenceEvidence.closure decisions),
    ("controls",TurbulenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
