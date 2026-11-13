import SFT.Materials.ZeroResistanceEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ZeroResistanceGrammar.candidates do
    match ZeroResistanceEvidence.decideCandidate (ZeroResistanceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ZeroResistanceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ZeroResistanceEvidence.registration sourceHash),
    ("census",ZeroResistanceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ZeroResistanceEvidence.closure decisions),
    ("controls",ZeroResistanceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
