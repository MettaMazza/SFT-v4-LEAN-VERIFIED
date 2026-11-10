import SFT.Physics.ThirdLawEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ThirdLawGrammar.candidates do
    match ThirdLawEvidence.decideCandidate (ThirdLawEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ThirdLawEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ThirdLawEvidence.registration sourceHash),
    ("census",ThirdLawEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ThirdLawEvidence.closure decisions),
    ("controls",ThirdLawEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
