import SFT.Chemistry.LigandStateSplittingEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LigandStateSplittingGrammar.candidates do
    match LigandStateSplittingEvidence.decideCandidate (LigandStateSplittingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LigandStateSplittingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LigandStateSplittingEvidence.registration sourceHash),
    ("census",LigandStateSplittingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LigandStateSplittingEvidence.closure decisions),
    ("controls",LigandStateSplittingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
