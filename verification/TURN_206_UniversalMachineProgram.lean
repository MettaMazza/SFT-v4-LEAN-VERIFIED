import SFT.Computation.UniversalMachineEvidence
open SFT.Host.Canonical SFT.Computation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in UniversalMachineGrammar.candidates do
    match UniversalMachineEvidence.decideCandidate (UniversalMachineEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match UniversalMachineEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",UniversalMachineEvidence.registration sourceHash),
    ("census",UniversalMachineEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",UniversalMachineEvidence.closure decisions),
    ("controls",UniversalMachineControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
