import SFT.Medicine.MissingReportingEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MissingReportingGrammar.candidates do
    match MissingReportingEvidence.decideCandidate (MissingReportingEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MissingReportingEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MissingReportingEvidence.registration sourceHash),
    ("census",MissingReportingEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MissingReportingEvidence.closure decisions),
    ("controls",MissingReportingEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
