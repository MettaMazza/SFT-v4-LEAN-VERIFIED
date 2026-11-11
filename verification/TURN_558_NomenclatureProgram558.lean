import SFT.Chemistry.NomenclatureEvidence
open SFT.Host.Canonical SFT.Chemistry

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NomenclatureGrammar.candidates do
    match NomenclatureEvidence.decideCandidate (NomenclatureEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NomenclatureEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NomenclatureEvidence.registration sourceHash),
    ("census",NomenclatureEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NomenclatureEvidence.closure decisions),
    ("controls",NomenclatureEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
