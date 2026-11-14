import SFT.Physics.PMNSPhysicalEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PMNSPhysicalEntryGrammar.candidates do
    match PMNSPhysicalEntryEvidence.decideCandidate (PMNSPhysicalEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PMNSPhysicalEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PMNSPhysicalEntryEvidence.registration sourceHash),
    ("census",PMNSPhysicalEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PMNSPhysicalEntryEvidence.closure decisions),
    ("controls",PMNSPhysicalEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
