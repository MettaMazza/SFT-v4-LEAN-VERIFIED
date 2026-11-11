import SFT.Chemistry.AcidbaseSealInputs
import SFT.Chemistry.LewisEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  match SFT.Chemistry.AcidbaseSealInputs.validate with
  | .error e => throw (IO.userError e)
  | .ok _ => pure ()
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in LewisGrammar.candidates do
    match LewisEvidence.decideCandidate (LewisEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match LewisEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",LewisEvidence.registration sourceHash),
    ("census",LewisEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",LewisEvidence.closure decisions),
    ("controls",LewisEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
