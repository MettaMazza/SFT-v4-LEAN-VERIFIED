import SFT.Physics.CapabilityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CapabilityGrammar.candidates do
    match CapabilityEvidence.decideCandidate (CapabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CapabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CapabilityEvidence.registration sourceHash),
    ("census",CapabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CapabilityEvidence.closure decisions),
    ("controls",CapabilityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
