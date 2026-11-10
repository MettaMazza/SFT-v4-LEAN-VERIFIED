import SFT.Physics.MeasuredWaveEnergyEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MeasuredWaveEnergyGrammar.candidates do
    match MeasuredWaveEnergyEvidence.decideCandidate (MeasuredWaveEnergyEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MeasuredWaveEnergyEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MeasuredWaveEnergyEvidence.registration sourceHash),
    ("census",MeasuredWaveEnergyEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MeasuredWaveEnergyEvidence.closure decisions),
    ("controls",MeasuredWaveEnergyEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
