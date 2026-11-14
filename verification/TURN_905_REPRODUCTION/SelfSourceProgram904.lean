import SFT.Physics.GravitySelfSourceEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravitySelfSourceEntryGrammar.candidates do
    match GravitySelfSourceEntryEvidence.decideCandidate (GravitySelfSourceEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravitySelfSourceEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravitySelfSourceEntryEvidence.registration sourceHash),
    ("census",GravitySelfSourceEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravitySelfSourceEntryEvidence.closure decisions),
    ("controls",GravitySelfSourceEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
