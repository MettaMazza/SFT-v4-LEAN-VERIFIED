import SFT.Physics.FullDiracEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FullDiracGrammar.candidates do
    match FullDiracEvidence.decideCandidate (FullDiracEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FullDiracEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FullDiracEvidence.registration sourceHash),
    ("census",FullDiracEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FullDiracEvidence.closure decisions),
    ("controls",FullDiracControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
