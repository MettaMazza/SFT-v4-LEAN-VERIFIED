import SFT
open SFT.Host.Canonical SFT.Foundation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in DerivationTraceGrammar.candidates do
    match DerivationTraceEvidence.decideCandidate (DerivationTraceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match DerivationTraceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",DerivationTraceEvidence.registration sourceHash),
    ("census",DerivationTraceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",DerivationTraceEvidence.closure decisions),
    ("controls",DerivationTraceControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
