import SFT.Mathematics.PrimePairEvidence
open SFT.Host.Canonical SFT.Mathematics

def main (args : List String) : IO Unit := do
  let sourceHash := args.headD ""
  if sourceHash.isEmpty then throw (IO.userError "Pass the pinned source manifest hash")
  let mut decisions : List SFT.Engine.CandidateDecision := []
  for c in PrimePairGrammar.candidates do
    match PrimePairEvidence.decideCandidate (PrimePairEvidence.generatedCandidateData c) with
    | .ok decision => decisions := decisions ++ [decision]
    | .error e => throw (IO.userError e)
  let unknown := match PrimePairEvidence.decideCandidate ⟨"unregistered","ignored","ignored"⟩ with
    | .error e => e
    | .ok _ => "incorrectly accepted"
  IO.println (render (.object [
    ("registration",PrimePairEvidence.registration sourceHash),
    ("census",PrimePairEvidence.census),
    ("decisions",.array (decisions.map SFT.Engine.decisionValue)),
    ("closure",PrimePairEvidence.closure decisions),
    ("controls",PrimePairEvidence.runControls sourceHash),
    ("unknown_id",.text unknown),
    ("prime_status",.array ((List.range 10001).map (fun n => .boolean (PrimePairCensus.isPrime n)))),
    ("goldbach_pairs",.array (PrimePairCensus.completeCensus.map (fun row => .array [.integer (.ofNat row.1), match row.2 with | none => .null | some p => .array [.integer (.ofNat p.1),.integer (.ofNat p.2)]]))),
    ("twins",.array ((PrimePairCensus.twinPairs 10000).map (fun p => .array [.integer (.ofNat p.1),.integer (.ofNat p.2)]))),
    ("spot_counts",.array [.integer (.ofNat (PrimePairCensus.unorderedCount 12)),.integer (.ofNat (PrimePairCensus.unorderedCount 100))])]))
