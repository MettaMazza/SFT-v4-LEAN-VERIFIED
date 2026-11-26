import SFT.Chemistry.ComplexSpinState
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.ComplexSpinState
abbrev J := Canonical.Value
def numberJSON (n : Nat) : J := .integer (.ofNat n)
def countJSON : ExactCount → J
 | .empty identity => .object [("empty",.text identity)]
 | .positive n => numberJSON n.value
def signatureJSON (s : Signature) : J := .object [
 ("electron_count",numberJSON s.electrons.value),("lower_pairs",countJSON s.lowerPairs),("lower_singles",countJSON s.lowerSingles),
 ("upper_pairs",countJSON s.upperPairs),("upper_singles",countJSON s.upperSingles),
 ("pair_closure_count",countJSON (pairClosures s)),("unmatched_fibre_count",countJSON (unmatched s)),
 ("split_crossing_count",countJSON (crossings s)),("spin_width",numberJSON (spinWidth s).value)]
def orderJSON (s : Order) : J := .object [("interaction_recurrence",countJSON s.recurrence),
 ("high_state",signatureJSON s.highState),("low_state",signatureJSON s.lowState),
 ("high_cost",countJSON s.highCost),("low_cost",countJSON s.lowCost),
 ("order",.object [("family",.text s.relation.family),("label",.text s.relation.label)])]
def output (r : Except String J) : J := match r with
 | .error e => .object [("error",.text e)]
 | .ok x => .object [("ok",x)]
def censusCase (n : Nat) : Except String J := do
 let rows ← enumerate (← count n)
 pure (.array (rows.map signatureJSON))
def lowCase (n : Nat) : Except String J := do
 pure (signatureJSON (← low (← enumerate (← count n))))
def highCase (n : Nat) : Except String J := do
 pure (signatureJSON (← high (← enumerate (← count n))))
def costs (n : Nat) : Except String J := do
 let rows ← sixCensus
 pure (.array (rows.map fun row => countJSON (pathCost row (exactCount n))))
def main : IO Unit := do
 let cases := (List.range 11).flatMap fun n => [censusCase (n+1),lowCase (n+1),highCase (n+1)]
 let vector : Except String J := do pure (.array ((← sixVector).map orderJSON))
 IO.println (Canonical.render (.array ((cases++[vector]++(List.range 5).map costs).map output)))
