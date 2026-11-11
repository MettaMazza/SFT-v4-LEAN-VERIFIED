import SFT.Chemistry.AcidbaseSealInputs
import SFT.Chemistry.ProtonEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  match SFT.Chemistry.AcidbaseSealInputs.validate with
  | .error e => throw (IO.userError e)
  | .ok _ => pure ()
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ProtonGrammar.candidates do
    match ProtonEvidence.decideCandidate (ProtonEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ProtonEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ProtonEvidence.registration sourceHash),
    ("census",ProtonEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ProtonEvidence.closure decisions),
    ("controls",ProtonEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
