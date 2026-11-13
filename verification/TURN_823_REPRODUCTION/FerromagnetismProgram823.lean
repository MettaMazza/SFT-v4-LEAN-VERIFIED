import SFT.Materials.FerromagnetismEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FerromagnetismGrammar.candidates do
    match FerromagnetismEvidence.decideCandidate (FerromagnetismEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FerromagnetismEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FerromagnetismEvidence.registration sourceHash),
    ("census",FerromagnetismEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FerromagnetismEvidence.closure decisions),
    ("controls",FerromagnetismEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
