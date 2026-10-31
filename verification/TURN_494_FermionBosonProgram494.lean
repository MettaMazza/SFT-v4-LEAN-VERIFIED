import SFT.Physics.FermionBosonEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in FermionBosonGrammar.candidates do
    match FermionBosonEvidence.decideCandidate (FermionBosonEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match FermionBosonEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",FermionBosonEvidence.registration sourceHash),
    ("census",FermionBosonEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",FermionBosonEvidence.closure decisions),
    ("controls",FermionBosonEvidence.runControls sourceHash),
    ("unknown_id",.text unknown)]))
