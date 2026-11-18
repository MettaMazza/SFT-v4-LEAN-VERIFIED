import SFT.Biology.CellIdentityEvidence
open SFT.Host.Canonical SFT.Biology

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CellIdentityGrammar.candidates do
    match CellIdentityEvidence.decideCandidate (CellIdentityEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CellIdentityEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CellIdentityEvidence.registration sourceHash),
    ("census",CellIdentityEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CellIdentityEvidence.closure decisions),
    ("controls",CellIdentityEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
