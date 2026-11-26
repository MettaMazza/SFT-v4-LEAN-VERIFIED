import SFT.Chemistry.OrganometallicBondEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in OrganometallicBondGrammar.candidates do
    match OrganometallicBondEvidence.decideCandidate (OrganometallicBondEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match OrganometallicBondEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",OrganometallicBondEvidence.registration sourceHash),
    ("census",OrganometallicBondEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",OrganometallicBondEvidence.closure decisions),
    ("controls",OrganometallicBondEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
