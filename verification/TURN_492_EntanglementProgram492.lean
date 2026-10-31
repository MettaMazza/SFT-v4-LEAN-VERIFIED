import SFT.Physics.EntanglementEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EntanglementGrammar.candidates do
    match EntanglementEvidence.decideCandidate (EntanglementEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EntanglementEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EntanglementEvidence.registration sourceHash),
    ("census",EntanglementEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EntanglementEvidence.closure decisions),
    ("controls",EntanglementEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
