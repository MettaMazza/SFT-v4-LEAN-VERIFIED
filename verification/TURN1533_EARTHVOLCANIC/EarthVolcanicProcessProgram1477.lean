import SFT.EarthEnvironment.EarthVolcanicProcessEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthVolcanicProcessGrammar.candidates do
    match EarthVolcanicProcessEvidence.decideCandidate (EarthVolcanicProcessEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthVolcanicProcessEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthVolcanicProcessEvidence.registration sourceHash),
    ("census",EarthVolcanicProcessEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthVolcanicProcessEvidence.closure decisions),
    ("controls",EarthVolcanicProcessEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
