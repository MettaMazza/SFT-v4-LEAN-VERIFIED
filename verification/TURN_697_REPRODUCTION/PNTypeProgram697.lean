import SFT.Materials.PNTypeEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PNTypeGrammar.candidates do
    match PNTypeEvidence.decideCandidate (PNTypeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PNTypeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PNTypeEvidence.registration sourceHash),
    ("census",PNTypeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PNTypeEvidence.closure decisions),
    ("controls",PNTypeEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
