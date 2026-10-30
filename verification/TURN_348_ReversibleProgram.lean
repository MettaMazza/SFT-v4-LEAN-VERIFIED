import verification.TURN_348_ReversibleEvidenceDraft
open SFT.Host.Canonical SFT.QuantumComputation

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ReversibleGrammar.candidates do
    match ReversibleEvidence.decideCandidate (ReversibleEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ReversibleEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ReversibleEvidence.registration sourceHash),
    ("census",ReversibleEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ReversibleEvidence.closure decisions),
    ("controls",ReversibleControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
