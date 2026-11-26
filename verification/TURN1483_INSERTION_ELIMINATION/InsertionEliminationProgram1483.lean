import SFT.Chemistry.InsertionEliminationEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InsertionEliminationGrammar.candidates do
    match InsertionEliminationEvidence.decideCandidate (InsertionEliminationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InsertionEliminationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InsertionEliminationEvidence.registration sourceHash),
    ("census",InsertionEliminationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InsertionEliminationEvidence.closure decisions),
    ("controls",InsertionEliminationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
