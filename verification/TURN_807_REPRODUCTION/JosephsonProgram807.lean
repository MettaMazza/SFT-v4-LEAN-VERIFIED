import SFT.Materials.JosephsonEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in JosephsonGrammar.candidates do
    match JosephsonEvidence.decideCandidate (JosephsonEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match JosephsonEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",JosephsonEvidence.registration sourceHash),
    ("census",JosephsonEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",JosephsonEvidence.closure decisions),
    ("controls",JosephsonEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
