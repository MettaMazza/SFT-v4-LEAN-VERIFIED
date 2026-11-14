import SFT.Physics.TerminalElectronAnomalyEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalElectronAnomalyEntryGrammar.candidates do
    match TerminalElectronAnomalyEntryEvidence.decideCandidate (TerminalElectronAnomalyEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalElectronAnomalyEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalElectronAnomalyEntryEvidence.registration sourceHash),
    ("census",TerminalElectronAnomalyEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalElectronAnomalyEntryEvidence.closure decisions),
    ("controls",TerminalElectronAnomalyEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
