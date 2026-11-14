import SFT.Physics.GravityWaveTrace
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showDifferences (x : Except String (List Int)) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok xs => .array (xs.map Value.integer)
def main : IO Unit := do
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [])))
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [(1)])))
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [(1),(2),(3),(4)])))
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [(1),(8),(27),(64)])))
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [(7),(19),(37)])))
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [(1),(1)])))
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [(2),(1)])))
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [(-2),(-1)])))
 IO.println (render (showDifferences (GravityWaveTrace.positiveDifferences [(0),(1)])))
 match GravityWaveTrace.gravitationalWaveTrace with
 | .error message => IO.println (render (.object [("error",.text message)]))
 | .ok r => IO.println (render (.object [("speed",fraction r.speed),("phase_trace",.array (r.phaseTrace.map fraction)),("monopole_record",.text r.monopoleRecord),("dipole_record",.text r.dipoleRecord),("first_unfrozen_second_differences",.array (r.firstUnfrozenSecondDifferences.map Value.integer))]))
