import SFT.EarthEnvironment.EarthSourceSinkStorageEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthSourceSinkStorageGrammar.candidates do
    match EarthSourceSinkStorageEvidence.decideCandidate (EarthSourceSinkStorageEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthSourceSinkStorageEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthSourceSinkStorageEvidence.registration sourceHash),
    ("census",EarthSourceSinkStorageEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthSourceSinkStorageEvidence.closure decisions),
    ("controls",EarthSourceSinkStorageEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
