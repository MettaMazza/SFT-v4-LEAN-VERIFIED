import SFT.Physics.MagneticAnomalyEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MagneticAnomalyEntryGrammar.candidates do
    match MagneticAnomalyEntryEvidence.decideCandidate (MagneticAnomalyEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MagneticAnomalyEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MagneticAnomalyEntryEvidence.registration sourceHash),
    ("census",MagneticAnomalyEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MagneticAnomalyEntryEvidence.closure decisions),
    ("controls",MagneticAnomalyEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
