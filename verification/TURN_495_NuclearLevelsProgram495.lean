import SFT.Physics.NuclearLevelsEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NuclearLevelsGrammar.candidates do
    match NuclearLevelsEvidence.decideCandidate (NuclearLevelsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NuclearLevelsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NuclearLevelsEvidence.registration sourceHash),
    ("census",NuclearLevelsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NuclearLevelsEvidence.closure decisions),
    ("controls",NuclearLevelsEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
