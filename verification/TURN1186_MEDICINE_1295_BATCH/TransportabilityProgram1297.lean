import SFT.Medicine.TransportabilityEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TransportabilityGrammar.candidates do
    match TransportabilityEvidence.decideCandidate (TransportabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TransportabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TransportabilityEvidence.registration sourceHash),
    ("census",TransportabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TransportabilityEvidence.closure decisions),
    ("controls",TransportabilityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
