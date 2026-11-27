import SFT.EarthEnvironment.EarthGeologicalProvenanceEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthGeologicalProvenanceGrammar.candidates do
    match EarthGeologicalProvenanceEvidence.decideCandidate (EarthGeologicalProvenanceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthGeologicalProvenanceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthGeologicalProvenanceEvidence.registration sourceHash),
    ("census",EarthGeologicalProvenanceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthGeologicalProvenanceEvidence.closure decisions),
    ("controls",EarthGeologicalProvenanceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
