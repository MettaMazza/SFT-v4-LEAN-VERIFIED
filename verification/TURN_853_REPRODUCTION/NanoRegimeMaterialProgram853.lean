import SFT.Materials.NanoRegimeMaterialEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NanoRegimeMaterialGrammar.candidates do
    match NanoRegimeMaterialEvidence.decideCandidate (NanoRegimeMaterialEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NanoRegimeMaterialEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NanoRegimeMaterialEvidence.registration sourceHash),
    ("census",NanoRegimeMaterialEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NanoRegimeMaterialEvidence.closure decisions),
    ("controls",NanoRegimeMaterialEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
