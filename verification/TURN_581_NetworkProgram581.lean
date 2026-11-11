import SFT.Chemistry.MolecularSealInputs
import SFT.Chemistry.NetworkEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  match SFT.Chemistry.MolecularSealInputs.validate with
  | .error e => throw (IO.userError e)
  | .ok _ => pure ()
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NetworkGrammar.candidates do
    match NetworkEvidence.decideCandidate (NetworkEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NetworkEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NetworkEvidence.registration sourceHash),
    ("census",NetworkEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NetworkEvidence.closure decisions),
    ("controls",NetworkEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
