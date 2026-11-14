import SFT.Physics.OpticalEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in OpticalEntryGrammar.candidates do
    match OpticalEntryEvidence.decideCandidate (OpticalEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match OpticalEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",OpticalEntryEvidence.registration sourceHash),
    ("census",OpticalEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",OpticalEntryEvidence.closure decisions),
    ("controls",OpticalEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
