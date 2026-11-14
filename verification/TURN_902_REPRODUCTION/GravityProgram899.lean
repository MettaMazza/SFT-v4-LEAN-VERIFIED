import SFT.Physics.GravityFluxEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GravityFluxEntryGrammar.candidates do
    match GravityFluxEntryEvidence.decideCandidate (GravityFluxEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GravityFluxEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GravityFluxEntryEvidence.registration sourceHash),
    ("census",GravityFluxEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GravityFluxEntryEvidence.closure decisions),
    ("controls",GravityFluxEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
