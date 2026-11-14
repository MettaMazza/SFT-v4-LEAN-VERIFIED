import SFT.Physics.QuarkComparison
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.QuarkComparison
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def interval (r : Interval) : Value := .array [fraction r.1,fraction r.2]
#eval do
 let (d,u) ← IO.ofExcept refinedQuarkRoots
 let q ← IO.ofExcept quarkPredictionIntervals
 let c ← IO.ofExcept ckmPredictionIntervals
 IO.println (render (.object [("roots",.object [("down",.array (d.map interval)),("up",.array (u.map interval))]),("quark",.object [("s_over_d",interval q.sOverD),("b_over_s",interval q.bOverS),("t_over_c",interval q.tOverC)]),("ckm",.object [("s12_squared",interval c.s12Squared),("s23_squared",interval c.s23Squared),("s13_squared",interval c.s13Squared),("jarlskog_squared",interval c.jarlskogSquared)])]))
