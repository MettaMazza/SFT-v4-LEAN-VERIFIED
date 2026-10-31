import SFT.Physics.DecoherenceEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DecoherenceGrammar.candidates do
    match DecoherenceEvidence.decideCandidate (DecoherenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DecoherenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DecoherenceEvidence.registration sourceHash),
    ("census",DecoherenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DecoherenceEvidence.closure decisions),
    ("controls",DecoherenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
