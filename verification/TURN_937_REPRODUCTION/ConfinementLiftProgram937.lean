import SFT.Physics.ConfinementLiftEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in ConfinementLiftEntryGrammar.candidates do
    match ConfinementLiftEntryEvidence.decideCandidate (ConfinementLiftEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match ConfinementLiftEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",ConfinementLiftEntryEvidence.registration sourceHash),
    ("census",ConfinementLiftEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",ConfinementLiftEntryEvidence.closure decisions),
    ("controls",ConfinementLiftEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
