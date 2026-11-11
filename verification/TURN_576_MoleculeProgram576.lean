import SFT.Chemistry.MolecularSealInputs
import SFT.Chemistry.MoleculeEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  match SFT.Chemistry.MolecularSealInputs.validate with
  | .error e => throw (IO.userError e)
  | .ok _ => pure ()
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MoleculeGrammar.candidates do
    match MoleculeEvidence.decideCandidate (MoleculeEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MoleculeEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MoleculeEvidence.registration sourceHash),
    ("census",MoleculeEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MoleculeEvidence.closure decisions),
    ("controls",MoleculeEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
