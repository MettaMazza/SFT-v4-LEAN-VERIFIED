import SFT.Physics.CriticalityUniversalityEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CriticalityUniversalityGrammar.candidates do
    match CriticalityUniversalityEntryEvidence.decideCandidate (CriticalityUniversalityEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CriticalityUniversalityEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CriticalityUniversalityEntryEvidence.registration sourceHash),
    ("census",CriticalityUniversalityEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CriticalityUniversalityEntryEvidence.closure decisions),
    ("controls",CriticalityUniversalityEntryEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
