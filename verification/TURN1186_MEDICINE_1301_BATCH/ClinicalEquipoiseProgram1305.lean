import SFT.Medicine.ClinicalEquipoiseEvidence
open SFT.Host.Canonical SFT.Medicine

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ClinicalEquipoiseGrammar.candidates do
    match ClinicalEquipoiseEvidence.decideCandidate (ClinicalEquipoiseEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ClinicalEquipoiseEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ClinicalEquipoiseEvidence.registration sourceHash),
    ("census",ClinicalEquipoiseEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ClinicalEquipoiseEvidence.closure decisions),
    ("controls",ClinicalEquipoiseEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
