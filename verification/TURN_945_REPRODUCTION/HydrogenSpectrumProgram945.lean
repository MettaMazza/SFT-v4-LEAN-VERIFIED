import SFT.Physics.HydrogenSpectrumEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HydrogenSpectrumEntryGrammar.candidates do
    match HydrogenSpectrumEntryEvidence.decideCandidate (HydrogenSpectrumEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HydrogenSpectrumEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HydrogenSpectrumEntryEvidence.registration sourceHash),
    ("census",HydrogenSpectrumEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HydrogenSpectrumEntryEvidence.closure decisions),
    ("controls",HydrogenSpectrumEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
