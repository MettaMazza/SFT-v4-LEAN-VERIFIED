import SFT.Mathematics.CalculatorCompleteEntryEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CalculatorCompleteGrammar.candidates do
    match CalculatorCompleteEntryEvidence.decideCandidate (CalculatorCompleteEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CalculatorCompleteEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CalculatorCompleteEntryEvidence.registration sourceHash),
    ("census",CalculatorCompleteEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CalculatorCompleteEntryEvidence.closure decisions),
    ("controls",CalculatorCompleteEntryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
