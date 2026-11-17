import SFT.Chemistry.MulticentreSupportEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MulticentreSupportGrammar.candidates do
    match MulticentreSupportEvidence.decideCandidate (MulticentreSupportEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MulticentreSupportEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MulticentreSupportEvidence.registration sourceHash),
    ("census",MulticentreSupportEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MulticentreSupportEvidence.closure decisions),
    ("controls",MulticentreSupportEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
