import SFT.Materials.SemiTransportEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in SemiTransportGrammar.candidates do
    match SemiTransportEvidence.decideCandidate (SemiTransportEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match SemiTransportEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",SemiTransportEvidence.registration sourceHash),
    ("census",SemiTransportEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",SemiTransportEvidence.closure decisions),
    ("controls",SemiTransportEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
