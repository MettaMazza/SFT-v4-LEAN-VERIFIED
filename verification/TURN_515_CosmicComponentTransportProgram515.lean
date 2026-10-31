import SFT.Physics.CosmicComponentTransportEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisionBuffer : Array SFT.Engine.CandidateDecision := #[]
  for c in CosmicComponentTransportGrammar.candidates do
    match CosmicComponentTransportEvidence.decideCandidate (CosmicComponentTransportEvidence.generatedCandidateData c) with
    | .ok decision => decisionBuffer := decisionBuffer.push decision
    | .error e => throw (IO.userError e)
  let decisions := decisionBuffer.toList
  let unknown := match CosmicComponentTransportEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CosmicComponentTransportEvidence.registration sourceHash),
    ("census",CosmicComponentTransportEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CosmicComponentTransportEvidence.closure decisions),
    ("controls",CosmicComponentTransportControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
