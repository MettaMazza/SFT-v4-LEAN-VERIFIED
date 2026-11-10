import SFT.Physics.ViscosityEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ViscosityGrammar.candidates do
    match ViscosityEvidence.decideCandidate (ViscosityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ViscosityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ViscosityEvidence.registration sourceHash),
    ("census",ViscosityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ViscosityEvidence.closure decisions),
    ("controls",ViscosityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
