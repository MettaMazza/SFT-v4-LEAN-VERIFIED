import SFT.EarthEnvironment.EarthSourcePathReceptorEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthSourcePathReceptorGrammar.candidates do
    match EarthSourcePathReceptorEvidence.decideCandidate (EarthSourcePathReceptorEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthSourcePathReceptorEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthSourcePathReceptorEvidence.registration sourceHash),
    ("census",EarthSourcePathReceptorEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthSourcePathReceptorEvidence.closure decisions),
    ("controls",EarthSourcePathReceptorEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
