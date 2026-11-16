import SFT.Materials.QuasicrystalInflationEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in QuasicrystalInflationGrammar.candidates do
    match QuasicrystalInflationEvidence.decideCandidate (QuasicrystalInflationEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match QuasicrystalInflationEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",QuasicrystalInflationEvidence.registration sourceHash),
    ("census",QuasicrystalInflationEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",QuasicrystalInflationEvidence.closure decisions),
    ("controls",QuasicrystalInflationEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
