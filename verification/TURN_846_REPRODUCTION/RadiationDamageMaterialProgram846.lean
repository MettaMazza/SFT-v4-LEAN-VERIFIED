import SFT.Materials.RadiationDamageMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RadiationDamageMaterialGrammar.candidates do
    match RadiationDamageMaterialEvidence.decideCandidate (RadiationDamageMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RadiationDamageMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RadiationDamageMaterialEvidence.registration sourceHash),
    ("census",RadiationDamageMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RadiationDamageMaterialEvidence.closure decisions),
    ("controls",RadiationDamageMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
