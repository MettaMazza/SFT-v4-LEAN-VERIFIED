import SFT.Physics.GaugeEquivalenceEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GaugeEquivalenceGrammar.candidates do
    match GaugeEquivalenceEvidence.decideCandidate (GaugeEquivalenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GaugeEquivalenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GaugeEquivalenceEvidence.registration sourceHash),
    ("census",GaugeEquivalenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GaugeEquivalenceEvidence.closure decisions),
    ("controls",GaugeEquivalenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
