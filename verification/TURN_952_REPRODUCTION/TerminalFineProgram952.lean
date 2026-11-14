import SFT.Physics.TerminalFineEntryEvidence
open SFT.Host.Canonical SFT.Physics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in TerminalFineEntryGrammar.candidates do
    match TerminalFineEntryEvidence.decideCandidate (TerminalFineEntryEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match TerminalFineEntryEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",TerminalFineEntryEvidence.registration sourceHash),
    ("census",TerminalFineEntryEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",TerminalFineEntryEvidence.closure decisions),
    ("controls",TerminalFineEntryControls.runControls sourceHash),
    ("unknown_id",.text unknown)]))
