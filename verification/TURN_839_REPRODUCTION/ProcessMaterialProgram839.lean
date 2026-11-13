import SFT.Materials.ProcessMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ProcessMaterialGrammar.candidates do
    match ProcessMaterialEvidence.decideCandidate (ProcessMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ProcessMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ProcessMaterialEvidence.registration sourceHash),
    ("census",ProcessMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ProcessMaterialEvidence.closure decisions),
    ("controls",ProcessMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
