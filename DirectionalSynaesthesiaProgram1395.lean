import SFT.Consciousness.DirectionalSynaesthesiaEvidence
open SFT.Host.Canonical SFT.Consciousness

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DirectionalSynaesthesiaGrammar.candidates do
    match DirectionalSynaesthesiaEvidence.decideCandidate (DirectionalSynaesthesiaEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DirectionalSynaesthesiaEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DirectionalSynaesthesiaEvidence.registration sourceHash),
    ("census",DirectionalSynaesthesiaEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DirectionalSynaesthesiaEvidence.closure decisions),
    ("controls",DirectionalSynaesthesiaEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
