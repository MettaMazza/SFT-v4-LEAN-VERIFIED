import SFT.Physics.HydrogenRydbergEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in HydrogenRydbergEntryGrammar.candidates do
    match HydrogenRydbergEntryEvidence.decideCandidate (HydrogenRydbergEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match HydrogenRydbergEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",HydrogenRydbergEntryEvidence.registration sourceHash),
    ("census",HydrogenRydbergEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",HydrogenRydbergEntryEvidence.closure decisions),
    ("controls",HydrogenRydbergEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
