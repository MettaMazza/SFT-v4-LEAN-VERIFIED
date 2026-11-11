import SFT.Chemistry.MolecularSealInputs
import SFT.Chemistry.IsomerEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  match SFT.Chemistry.MolecularSealInputs.validate with
  | .error e => throw (IO.userError e)
  | .ok _ => pure ()
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IsomerGrammar.candidates do
    match IsomerEvidence.decideCandidate (IsomerEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IsomerEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IsomerEvidence.registration sourceHash),
    ("census",IsomerEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IsomerEvidence.closure decisions),
    ("controls",IsomerEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
