import SFT.Computation.NativePnpEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NativePnpGrammar.candidates do
    match NativePnpEvidence.decideCandidate (NativePnpEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NativePnpEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NativePnpEvidence.registration sourceHash),
    ("census",NativePnpEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NativePnpEvidence.closure decisions),
    ("controls",NativePnpEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
