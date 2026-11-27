import SFT.Chemistry.RearrangementEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RearrangementGrammar.candidates do
    match RearrangementEvidence.decideCandidate (RearrangementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RearrangementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RearrangementEvidence.registration sourceHash),
    ("census",RearrangementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RearrangementEvidence.closure decisions),
    ("controls",RearrangementEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
