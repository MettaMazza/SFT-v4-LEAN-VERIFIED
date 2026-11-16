import SFT.Mathematics.CalculatorBrowserEntryEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CalculatorBrowserGrammar.candidates do
    match CalculatorBrowserEntryEvidence.decideCandidate (CalculatorBrowserEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CalculatorBrowserEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CalculatorBrowserEntryEvidence.registration sourceHash),
    ("census",CalculatorBrowserEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CalculatorBrowserEntryEvidence.closure decisions),
    ("controls",CalculatorBrowserEntryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
