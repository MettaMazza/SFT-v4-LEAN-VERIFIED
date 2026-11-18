import SFT.Medicine.BenefitHarmEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in BenefitHarmGrammar.candidates do
    match BenefitHarmEvidence.decideCandidate (BenefitHarmEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match BenefitHarmEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",BenefitHarmEvidence.registration sourceHash),
    ("census",BenefitHarmEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",BenefitHarmEvidence.closure decisions),
    ("controls",BenefitHarmEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
