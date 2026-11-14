import SFT.Physics.NeutrinoSplittingEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in NeutrinoSplittingEntryGrammar.candidates do
    match NeutrinoSplittingEntryEvidence.decideCandidate (NeutrinoSplittingEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match NeutrinoSplittingEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",NeutrinoSplittingEntryEvidence.registration sourceHash),
    ("census",NeutrinoSplittingEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",NeutrinoSplittingEntryEvidence.closure decisions),
    ("controls",NeutrinoSplittingEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
