import SFT.Physics.ThermalResponseEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ThermalResponseGrammar.candidates do
    match ThermalResponseEvidence.decideCandidate (ThermalResponseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ThermalResponseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ThermalResponseEvidence.registration sourceHash),
    ("census",ThermalResponseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ThermalResponseEvidence.closure decisions),
    ("controls",ThermalResponseEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
