import SFT.Physics.MeasuredFrequencyEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MeasuredFrequencyGrammar.candidates do
    match MeasuredFrequencyEvidence.decideCandidate (MeasuredFrequencyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MeasuredFrequencyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MeasuredFrequencyEvidence.registration sourceHash),
    ("census",MeasuredFrequencyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MeasuredFrequencyEvidence.closure decisions),
    ("controls",MeasuredFrequencyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
