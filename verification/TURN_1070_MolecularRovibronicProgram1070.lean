import SFT.Chemistry.MolecularRovibronicEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MolecularRovibronicGrammar.candidates do
    match MolecularRovibronicEvidence.decideCandidate (MolecularRovibronicEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MolecularRovibronicEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MolecularRovibronicEvidence.registration sourceHash),
    ("census",MolecularRovibronicEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MolecularRovibronicEvidence.closure decisions),
    ("controls",MolecularRovibronicEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
