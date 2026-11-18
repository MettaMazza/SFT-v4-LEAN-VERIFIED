import SFT.Medicine.InjuryStateEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InjuryStateGrammar.candidates do
    match InjuryStateEvidence.decideCandidate (InjuryStateEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InjuryStateEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InjuryStateEvidence.registration sourceHash),
    ("census",InjuryStateEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InjuryStateEvidence.closure decisions),
    ("controls",InjuryStateEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
