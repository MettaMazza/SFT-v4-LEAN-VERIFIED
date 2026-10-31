import SFT.Physics.NoSignallingEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NoSignallingGrammar.candidates do
    match NoSignallingEvidence.decideCandidate (NoSignallingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NoSignallingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NoSignallingEvidence.registration sourceHash),
    ("census",NoSignallingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NoSignallingEvidence.closure decisions),
    ("controls",NoSignallingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
