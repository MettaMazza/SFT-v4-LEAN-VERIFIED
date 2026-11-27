import SFT.EarthEnvironment.EarthquakeCatalogEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthquakeCatalogGrammar.candidates do
    match EarthquakeCatalogEvidence.decideCandidate (EarthquakeCatalogEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthquakeCatalogEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthquakeCatalogEvidence.registration sourceHash),
    ("census",EarthquakeCatalogEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthquakeCatalogEvidence.closure decisions),
    ("controls",EarthquakeCatalogEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
