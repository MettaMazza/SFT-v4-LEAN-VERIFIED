import SFT.Physics.KineticTransportEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in KineticTransportGrammar.candidates do
    match KineticTransportEvidence.decideCandidate (KineticTransportEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match KineticTransportEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",KineticTransportEvidence.registration sourceHash),
    ("census",KineticTransportEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",KineticTransportEvidence.closure decisions),
    ("controls",KineticTransportEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
