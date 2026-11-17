import SFT.Materials.FerrimagneticGapEvidence
open SFT.Host.Canonical SFT.Materials

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FerrimagneticGapGrammar.candidates do
    match FerrimagneticGapEvidence.decideCandidate (FerrimagneticGapEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FerrimagneticGapEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FerrimagneticGapEvidence.registration sourceHash),
    ("census",FerrimagneticGapEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FerrimagneticGapEvidence.closure decisions),
    ("controls",FerrimagneticGapEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
