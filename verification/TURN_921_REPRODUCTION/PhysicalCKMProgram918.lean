import SFT.Physics.PhysicalCKMEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PhysicalCKMEntryGrammar.candidates do
    match PhysicalCKMEntryEvidence.decideCandidate (PhysicalCKMEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PhysicalCKMEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PhysicalCKMEntryEvidence.registration sourceHash),
    ("census",PhysicalCKMEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PhysicalCKMEntryEvidence.closure decisions),
    ("controls",PhysicalCKMEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
