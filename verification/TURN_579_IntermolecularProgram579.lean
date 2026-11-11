import SFT.Chemistry.MolecularSealInputs
import SFT.Chemistry.IntermolecularEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  match SFT.Chemistry.MolecularSealInputs.validate with
  | .error e => throw (IO.userError e)
  | .ok _ => pure ()
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IntermolecularGrammar.candidates do
    match IntermolecularEvidence.decideCandidate (IntermolecularEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IntermolecularEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IntermolecularEvidence.registration sourceHash),
    ("census",IntermolecularEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IntermolecularEvidence.closure decisions),
    ("controls",IntermolecularEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
