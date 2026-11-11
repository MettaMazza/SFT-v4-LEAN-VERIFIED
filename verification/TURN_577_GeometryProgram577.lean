import SFT.Chemistry.MolecularSealInputs
import SFT.Chemistry.GeometryEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  match SFT.Chemistry.MolecularSealInputs.validate with
  | .error e => throw (IO.userError e)
  | .ok _ => pure ()
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in GeometryGrammar.candidates do
    match GeometryEvidence.decideCandidate (GeometryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match GeometryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",GeometryEvidence.registration sourceHash),
    ("census",GeometryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",GeometryEvidence.closure decisions),
    ("controls",GeometryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
