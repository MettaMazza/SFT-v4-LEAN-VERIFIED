import SFT.Chemistry.MolecularBondAngleEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MolecularBondAngleGrammar.candidates do
    match MolecularBondAngleEvidence.decideCandidate (MolecularBondAngleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MolecularBondAngleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MolecularBondAngleEvidence.registration sourceHash),
    ("census",MolecularBondAngleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MolecularBondAngleEvidence.closure decisions),
    ("controls",MolecularBondAngleEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
