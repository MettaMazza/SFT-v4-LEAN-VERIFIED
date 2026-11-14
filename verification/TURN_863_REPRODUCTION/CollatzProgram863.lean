import SFT.Mathematics.CollatzEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in CollatzGrammar.candidates do
    match CollatzEvidence.decideCandidate (CollatzEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match CollatzEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",CollatzEvidence.registration sourceHash),
    ("census",CollatzEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",CollatzEvidence.closure decisions),
    ("controls",CollatzEvidence.runControls sourceHash),
    ("counts",.array (CollatzCensus.completeCensus.map fun row => match row.2 with | some n => .integer (Int.ofNat n) | none => .integer (-1))),
    ("unknown_id",.text unknown)]))
