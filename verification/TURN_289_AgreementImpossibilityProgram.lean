import SFT.Computation.AgreementImpossibilityEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AgreementImpossibilityGrammar.candidates do
    match AgreementImpossibilityEvidence.decideCandidate (AgreementImpossibilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AgreementImpossibilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AgreementImpossibilityEvidence.registration sourceHash),
    ("census",AgreementImpossibilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AgreementImpossibilityEvidence.closure decisions),
    ("controls",AgreementImpossibilityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
