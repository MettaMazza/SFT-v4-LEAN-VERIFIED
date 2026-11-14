import SFT.Physics.ProtonIdentityEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ProtonIdentityEntryGrammar.candidates do
    match ProtonIdentityEntryEvidence.decideCandidate (ProtonIdentityEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ProtonIdentityEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ProtonIdentityEntryEvidence.registration sourceHash),
    ("census",ProtonIdentityEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ProtonIdentityEntryEvidence.closure decisions),
    ("controls",ProtonIdentityEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
