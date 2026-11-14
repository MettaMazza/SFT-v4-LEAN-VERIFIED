import SFT.Physics.TerminalElectronEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalElectronEmpiricalGrammar.candidates do
    match TerminalElectronEmpiricalEvidence.decideCandidate (TerminalElectronEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalElectronEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalElectronEmpiricalEvidence.registration sourceHash),
    ("census",TerminalElectronEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalElectronEmpiricalEvidence.closure decisions),
    ("controls",TerminalElectronEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
