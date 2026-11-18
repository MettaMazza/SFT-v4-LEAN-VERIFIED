import SFT.Medicine.CensoringCompetingEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CensoringCompetingGrammar.candidates do
    match CensoringCompetingEvidence.decideCandidate (CensoringCompetingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CensoringCompetingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CensoringCompetingEvidence.registration sourceHash),
    ("census",CensoringCompetingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CensoringCompetingEvidence.closure decisions),
    ("controls",CensoringCompetingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
