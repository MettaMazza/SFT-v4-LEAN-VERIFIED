import SFT.Chemistry.LigandStateSplitting
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.LigandStateSplitting
def summary {α : Type} : Except String α → Canonical.Value
 | .ok _ => .object [("ok",.boolean true)]
 | .error e => .object [("error",.text e)]
def casesOut : Except String (List Canonical.Value) := do
 let supports ← generated
 let first := supports.headD (← support (← heldLabel "rank-two-state-support" "held-contrast-1-2") (← heldLabel "rank-two-support-kind" "held-axis-contrast") (← count 1) (← count 2))
 let s ← sixResult
 let r ← removed s.centre
 let bad := Distance.part (← part 1 2)
 return [summary (level .absent []),summary (level .absent [first,first]),
  summary (splitting s.centre s.unperturbed [] [] .absent .absent true),
  summary (splitting s.centre (← count 4) s.levels s.separations s.lower s.upper true),
  summary (splitting s.centre s.unperturbed s.levels [] s.lower s.upper true),
  summary (splitting s.centre s.unperturbed s.levels s.separations .absent s.upper true),
  summary (splitting s.centre s.unperturbed s.levels s.separations bad bad true),
  summary (splitting r.centre r.unperturbed r.levels r.separations bad .absent true),
  summary (splitting s.centre s.unperturbed s.levels s.separations s.lower s.upper false)]
def main : IO Unit := do
 match casesOut with
 | .error e => throw (IO.userError e)
 | .ok rows => IO.println (Canonical.render (.array rows))
