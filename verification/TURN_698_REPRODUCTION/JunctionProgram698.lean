import SFT.Materials.JunctionEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in JunctionGrammar.candidates do
    match JunctionEvidence.decideCandidate (JunctionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match JunctionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",JunctionEvidence.registration sourceHash),
    ("census",JunctionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",JunctionEvidence.closure decisions),
    ("controls",JunctionEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
