import SFT.Physics.ZeroNuEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ZeroNuEntryGrammar.candidates do
    match ZeroNuEntryEvidence.decideCandidate (ZeroNuEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ZeroNuEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ZeroNuEntryEvidence.registration sourceHash),
    ("census",ZeroNuEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ZeroNuEntryEvidence.closure decisions),
    ("controls",ZeroNuEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
