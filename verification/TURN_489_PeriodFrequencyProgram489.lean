import SFT.Physics.PeriodFrequencyEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PeriodFrequencyGrammar.candidates do
    match PeriodFrequencyEvidence.decideCandidate (PeriodFrequencyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PeriodFrequencyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PeriodFrequencyEvidence.registration sourceHash),
    ("census",PeriodFrequencyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PeriodFrequencyEvidence.closure decisions),
    ("controls",PeriodFrequencyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
