import SFT.Physics.TunnellingEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TunnellingGrammar.candidates do
    match TunnellingEvidence.decideCandidate (TunnellingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TunnellingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TunnellingEvidence.registration sourceHash),
    ("census",TunnellingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TunnellingEvidence.closure decisions),
    ("controls",TunnellingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
