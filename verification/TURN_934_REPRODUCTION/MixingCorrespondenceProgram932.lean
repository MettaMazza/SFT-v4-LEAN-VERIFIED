import SFT.Physics.MixingCorrespondenceEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MixingCorrespondenceEntryGrammar.candidates do
    match MixingCorrespondenceEntryEvidence.decideCandidate (MixingCorrespondenceEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MixingCorrespondenceEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MixingCorrespondenceEntryEvidence.registration sourceHash),
    ("census",MixingCorrespondenceEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MixingCorrespondenceEntryEvidence.closure decisions),
    ("controls",MixingCorrespondenceEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
