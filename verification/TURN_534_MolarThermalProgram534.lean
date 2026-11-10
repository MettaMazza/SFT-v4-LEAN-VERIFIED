import SFT.Physics.MolarThermalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MolarThermalGrammar.candidates do
    match MolarThermalEvidence.decideCandidate (MolarThermalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MolarThermalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MolarThermalEvidence.registration sourceHash),
    ("census",MolarThermalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MolarThermalEvidence.closure decisions),
    ("controls",MolarThermalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
