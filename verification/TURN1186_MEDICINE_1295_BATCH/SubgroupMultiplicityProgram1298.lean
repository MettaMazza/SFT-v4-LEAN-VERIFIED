import SFT.Medicine.SubgroupMultiplicityEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SubgroupMultiplicityGrammar.candidates do
    match SubgroupMultiplicityEvidence.decideCandidate (SubgroupMultiplicityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SubgroupMultiplicityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SubgroupMultiplicityEvidence.registration sourceHash),
    ("census",SubgroupMultiplicityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SubgroupMultiplicityEvidence.closure decisions),
    ("controls",SubgroupMultiplicityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
