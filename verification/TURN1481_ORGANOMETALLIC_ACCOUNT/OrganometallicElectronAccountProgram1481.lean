import SFT.Chemistry.OrganometallicElectronAccountEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in OrganometallicElectronAccountGrammar.candidates do
    match OrganometallicElectronAccountEvidence.decideCandidate (OrganometallicElectronAccountEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match OrganometallicElectronAccountEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",OrganometallicElectronAccountEvidence.registration sourceHash),
    ("census",OrganometallicElectronAccountEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",OrganometallicElectronAccountEvidence.closure decisions),
    ("controls",OrganometallicElectronAccountEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
