import SFT.Physics.CubicAtomicSupportEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CubicAtomicSupportEntryGrammar.candidates do
    match CubicAtomicSupportEntryEvidence.decideCandidate (CubicAtomicSupportEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CubicAtomicSupportEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CubicAtomicSupportEntryEvidence.registration sourceHash),
    ("census",CubicAtomicSupportEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CubicAtomicSupportEntryEvidence.closure decisions),
    ("controls",CubicAtomicSupportEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
