import SFT.EarthEnvironment.EarthAbsenceMissingnessEvidence
open SFT.Host.Canonical SFT.EarthEnvironment

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in EarthAbsenceMissingnessGrammar.candidates do
    match EarthAbsenceMissingnessEvidence.decideCandidate (EarthAbsenceMissingnessEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match EarthAbsenceMissingnessEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",EarthAbsenceMissingnessEvidence.registration sourceHash),
    ("census",EarthAbsenceMissingnessEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",EarthAbsenceMissingnessEvidence.closure decisions),
    ("controls",EarthAbsenceMissingnessEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
