import SFT.Physics.MolecularSpectroscopyEmpiricalEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MolecularSpectroscopyEmpiricalGrammar.candidates do
    match MolecularSpectroscopyEmpiricalEvidence.decideCandidate (MolecularSpectroscopyEmpiricalEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MolecularSpectroscopyEmpiricalEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MolecularSpectroscopyEmpiricalEvidence.registration sourceHash),
    ("census",MolecularSpectroscopyEmpiricalEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MolecularSpectroscopyEmpiricalEvidence.closure decisions),
    ("controls",MolecularSpectroscopyEmpiricalEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
