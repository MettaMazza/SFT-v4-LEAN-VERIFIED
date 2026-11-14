import SFT.Physics.CKMFibreEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CKMFibreEntryGrammar.candidates do
    match CKMFibreEntryEvidence.decideCandidate (CKMFibreEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CKMFibreEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CKMFibreEntryEvidence.registration sourceHash),
    ("census",CKMFibreEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CKMFibreEntryEvidence.closure decisions),
    ("controls",CKMFibreEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
