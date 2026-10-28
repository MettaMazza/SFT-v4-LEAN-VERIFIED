import SFT.InformationScience.QuantityEvidence
open SFT.Host.Canonical SFT.InformationScience

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in QuantityGrammar.candidates do
    match QuantityEvidence.decideCandidate (QuantityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match QuantityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",QuantityEvidence.registration sourceHash),
    ("census",QuantityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",QuantityEvidence.closure decisions),
    ("controls",QuantityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
