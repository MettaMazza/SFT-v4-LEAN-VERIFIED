import SFT.Chemistry.MixtureEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MixtureGrammar.candidates do
    match MixtureEvidence.decideCandidate (MixtureEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MixtureEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MixtureEvidence.registration sourceHash),
    ("census",MixtureEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MixtureEvidence.closure decisions),
    ("controls",MixtureEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
