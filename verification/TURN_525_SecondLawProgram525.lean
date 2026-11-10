import SFT.Physics.SecondLawEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SecondLawGrammar.candidates do
    match SecondLawEvidence.decideCandidate (SecondLawEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SecondLawEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SecondLawEvidence.registration sourceHash),
    ("census",SecondLawEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SecondLawEvidence.closure decisions),
    ("controls",SecondLawEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
