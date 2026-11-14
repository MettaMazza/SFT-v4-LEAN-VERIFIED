import SFT.Physics.BaryonPhotonEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in BaryonPhotonEntryGrammar.candidates do
    match BaryonPhotonEntryEvidence.decideCandidate (BaryonPhotonEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match BaryonPhotonEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",BaryonPhotonEntryEvidence.registration sourceHash),
    ("census",BaryonPhotonEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",BaryonPhotonEntryEvidence.closure decisions),
    ("controls",BaryonPhotonEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
