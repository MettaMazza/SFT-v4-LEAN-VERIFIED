import SFT.Physics.MicroMacroEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MicroMacroGrammar.candidates do
    match MicroMacroEvidence.decideCandidate (MicroMacroEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MicroMacroEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MicroMacroEvidence.registration sourceHash),
    ("census",MicroMacroEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MicroMacroEvidence.closure decisions),
    ("controls",MicroMacroEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
