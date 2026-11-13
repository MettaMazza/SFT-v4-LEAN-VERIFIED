import SFT.Foundation.AdmissionEvidence
open SFT.Host.Canonical SFT.Foundation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in AdmissionGrammar.candidates do
    match AdmissionEvidence.decideCandidate (AdmissionEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match AdmissionEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",AdmissionEvidence.registration sourceHash),
    ("census",AdmissionEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",AdmissionEvidence.closure decisions),
    ("controls",AdmissionControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
