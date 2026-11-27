import SFT.Chemistry.NucleophilicEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NucleophilicGrammar.candidates do
    match NucleophilicEvidence.decideCandidate (NucleophilicEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NucleophilicEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NucleophilicEvidence.registration sourceHash),
    ("census",NucleophilicEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NucleophilicEvidence.closure decisions),
    ("controls",NucleophilicEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
