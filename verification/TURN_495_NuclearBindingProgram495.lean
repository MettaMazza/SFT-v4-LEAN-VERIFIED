import SFT.Physics.NuclearBindingEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NuclearBindingGrammar.candidates do
    match NuclearBindingEvidence.decideCandidate (NuclearBindingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NuclearBindingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NuclearBindingEvidence.registration sourceHash),
    ("census",NuclearBindingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NuclearBindingEvidence.closure decisions),
    ("controls",NuclearBindingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
