import SFT.Materials.RefractiveResponseEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in RefractiveResponseGrammar.candidates do
    match RefractiveResponseEvidence.decideCandidate (RefractiveResponseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match RefractiveResponseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",RefractiveResponseEvidence.registration sourceHash),
    ("census",RefractiveResponseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",RefractiveResponseEvidence.closure decisions),
    ("controls",RefractiveResponseEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
