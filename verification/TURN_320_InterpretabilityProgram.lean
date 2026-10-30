import SFT.Computation.InterpretabilityEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in InterpretabilityGrammar.candidates do
    match InterpretabilityEvidence.decideCandidate (InterpretabilityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match InterpretabilityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",InterpretabilityEvidence.registration sourceHash),
    ("census",InterpretabilityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",InterpretabilityEvidence.closure decisions),
    ("controls",InterpretabilityControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
