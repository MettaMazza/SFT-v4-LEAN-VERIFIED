import SFT.EarthEnvironment.EarthModelDataAssimilationEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthModelDataAssimilationGrammar.candidates do
    match EarthModelDataAssimilationEvidence.decideCandidate (EarthModelDataAssimilationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthModelDataAssimilationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthModelDataAssimilationEvidence.registration sourceHash),
    ("census",EarthModelDataAssimilationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthModelDataAssimilationEvidence.closure decisions),
    ("controls",EarthModelDataAssimilationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
