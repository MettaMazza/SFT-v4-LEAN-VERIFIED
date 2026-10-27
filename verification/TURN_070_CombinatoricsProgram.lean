import SFT
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CombinatoricsGrammar.candidates do
    match CombinatoricsEvidence.decideCandidate (CombinatoricsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CombinatoricsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CombinatoricsEvidence.registration sourceHash),
    ("census",CombinatoricsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CombinatoricsEvidence.closure decisions),
    ("controls",CombinatoricsControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
