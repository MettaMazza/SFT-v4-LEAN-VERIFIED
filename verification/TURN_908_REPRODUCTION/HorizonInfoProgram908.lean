import SFT.Physics.HorizonInformationEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HorizonInformationEntryGrammar.candidates do
    match HorizonInformationEntryEvidence.decideCandidate (HorizonInformationEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HorizonInformationEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HorizonInformationEntryEvidence.registration sourceHash),
    ("census",HorizonInformationEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HorizonInformationEntryEvidence.closure decisions),
    ("controls",HorizonInformationEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
