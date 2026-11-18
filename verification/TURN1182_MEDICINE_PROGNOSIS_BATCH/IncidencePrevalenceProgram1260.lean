import SFT.Medicine.IncidencePrevalenceEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in IncidencePrevalenceGrammar.candidates do
    match IncidencePrevalenceEvidence.decideCandidate (IncidencePrevalenceEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match IncidencePrevalenceEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",IncidencePrevalenceEvidence.registration sourceHash),
    ("census",IncidencePrevalenceEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",IncidencePrevalenceEvidence.closure decisions),
    ("controls",IncidencePrevalenceEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
