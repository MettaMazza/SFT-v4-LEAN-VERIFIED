import SFT.Chemistry.CoordinationIsomerismEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CoordinationIsomerismGrammar.candidates do
    match CoordinationIsomerismEvidence.decideCandidate (CoordinationIsomerismEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CoordinationIsomerismEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CoordinationIsomerismEvidence.registration sourceHash),
    ("census",CoordinationIsomerismEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CoordinationIsomerismEvidence.closure decisions),
    ("controls",CoordinationIsomerismEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
