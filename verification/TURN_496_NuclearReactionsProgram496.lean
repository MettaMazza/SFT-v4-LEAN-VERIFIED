import SFT.Physics.NuclearReactionsEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NuclearReactionsGrammar.candidates do
    match NuclearReactionsEvidence.decideCandidate (NuclearReactionsEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NuclearReactionsEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NuclearReactionsEvidence.registration sourceHash),
    ("census",NuclearReactionsEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NuclearReactionsEvidence.closure decisions),
    ("controls",NuclearReactionsEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
