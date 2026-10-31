import SFT.Physics.GravityFieldSourceEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravityFieldSourceGrammar.candidates do
    match GravityFieldSourceEvidence.decideCandidate (GravityFieldSourceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravityFieldSourceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravityFieldSourceEvidence.registration sourceHash),
    ("census",GravityFieldSourceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravityFieldSourceEvidence.closure decisions),
    ("controls",GravityFieldSourceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
