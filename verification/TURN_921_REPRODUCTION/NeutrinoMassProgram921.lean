import SFT.Physics.NeutrinoMassEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NeutrinoMassEntryGrammar.candidates do
    match NeutrinoMassEntryEvidence.decideCandidate (NeutrinoMassEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NeutrinoMassEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NeutrinoMassEntryEvidence.registration sourceHash),
    ("census",NeutrinoMassEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NeutrinoMassEntryEvidence.closure decisions),
    ("controls",NeutrinoMassEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
