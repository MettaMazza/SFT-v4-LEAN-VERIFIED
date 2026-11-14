import SFT.Physics.NeutrinoMassMixingValidationEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NeutrinoMassMixingValidationGrammar.candidates do
    match NeutrinoMassMixingValidationEvidence.decideCandidate (NeutrinoMassMixingValidationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NeutrinoMassMixingValidationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NeutrinoMassMixingValidationEvidence.registration sourceHash),
    ("census",NeutrinoMassMixingValidationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NeutrinoMassMixingValidationEvidence.closure decisions),
    ("controls",NeutrinoMassMixingValidationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
