import SFT.Chemistry.ElectronCountSpinEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ElectronCountSpinGrammar.candidates do
    match ElectronCountSpinEvidence.decideCandidate (ElectronCountSpinEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ElectronCountSpinEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ElectronCountSpinEvidence.registration sourceHash),
    ("census",ElectronCountSpinEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ElectronCountSpinEvidence.closure decisions),
    ("controls",ElectronCountSpinEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
