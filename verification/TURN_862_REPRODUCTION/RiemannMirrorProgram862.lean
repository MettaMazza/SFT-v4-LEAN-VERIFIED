import SFT.Mathematics.RiemannMirrorEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RiemannMirrorGrammar.candidates do
    match RiemannMirrorEvidence.decideCandidate (RiemannMirrorEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RiemannMirrorEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RiemannMirrorEvidence.registration sourceHash),
    ("census",RiemannMirrorEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RiemannMirrorEvidence.closure decisions),
    ("controls",RiemannMirrorEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
