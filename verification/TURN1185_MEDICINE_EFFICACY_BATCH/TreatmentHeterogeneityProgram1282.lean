import SFT.Medicine.TreatmentHeterogeneityEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TreatmentHeterogeneityGrammar.candidates do
    match TreatmentHeterogeneityEvidence.decideCandidate (TreatmentHeterogeneityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TreatmentHeterogeneityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TreatmentHeterogeneityEvidence.registration sourceHash),
    ("census",TreatmentHeterogeneityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TreatmentHeterogeneityEvidence.closure decisions),
    ("controls",TreatmentHeterogeneityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
