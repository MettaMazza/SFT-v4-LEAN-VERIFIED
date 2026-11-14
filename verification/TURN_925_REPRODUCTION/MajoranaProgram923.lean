import SFT.Physics.MajoranaEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in MajoranaEntryGrammar.candidates do
    match MajoranaEntryEvidence.decideCandidate (MajoranaEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match MajoranaEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",MajoranaEntryEvidence.registration sourceHash),
    ("census",MajoranaEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",MajoranaEntryEvidence.closure decisions),
    ("controls",MajoranaEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
