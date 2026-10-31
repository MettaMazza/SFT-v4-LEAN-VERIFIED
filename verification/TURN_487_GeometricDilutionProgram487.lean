import SFT.Physics.GeometricDilutionEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GeometricDilutionGrammar.candidates do
    match GeometricDilutionEvidence.decideCandidate (GeometricDilutionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GeometricDilutionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GeometricDilutionEvidence.registration sourceHash),
    ("census",GeometricDilutionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GeometricDilutionEvidence.closure decisions),
    ("controls",GeometricDilutionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
