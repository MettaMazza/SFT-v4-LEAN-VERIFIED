import SFT.Physics.MassRatioFamilyEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MassRatioFamilyEntryGrammar.candidates do
    match MassRatioFamilyEntryEvidence.decideCandidate (MassRatioFamilyEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MassRatioFamilyEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MassRatioFamilyEntryEvidence.registration sourceHash),
    ("census",MassRatioFamilyEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MassRatioFamilyEntryEvidence.closure decisions),
    ("controls",MassRatioFamilyEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
