import SFT.Medicine.StoppingWithdrawalEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in StoppingWithdrawalGrammar.candidates do
    match StoppingWithdrawalEvidence.decideCandidate (StoppingWithdrawalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match StoppingWithdrawalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",StoppingWithdrawalEvidence.registration sourceHash),
    ("census",StoppingWithdrawalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",StoppingWithdrawalEvidence.closure decisions),
    ("controls",StoppingWithdrawalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
