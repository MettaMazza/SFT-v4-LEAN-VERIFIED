import SFT.Computation.IntegrityEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IntegrityGrammar.candidates do
    match IntegrityEvidence.decideCandidate (IntegrityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IntegrityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IntegrityEvidence.registration sourceHash),
    ("census",IntegrityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IntegrityEvidence.closure decisions),
    ("controls",IntegrityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
