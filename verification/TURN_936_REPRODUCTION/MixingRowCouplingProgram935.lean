import SFT.Physics.MixingRowCouplingEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MixingRowCouplingEntryGrammar.candidates do
    match MixingRowCouplingEntryEvidence.decideCandidate (MixingRowCouplingEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MixingRowCouplingEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MixingRowCouplingEntryEvidence.registration sourceHash),
    ("census",MixingRowCouplingEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MixingRowCouplingEntryEvidence.closure decisions),
    ("controls",MixingRowCouplingEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
