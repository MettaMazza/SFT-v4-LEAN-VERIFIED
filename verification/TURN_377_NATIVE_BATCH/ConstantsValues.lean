import SFT.Physics.CosmicIntervals
import SFT.Physics.VacuumDensity
import SFT.Physics.PlanckHierarchy
import Lean
open Lean SFT.Physics

def ratJSON (x : Rat) : Json := toJson (x.num,x.den)
def intervalJSON (x : Rat × Rat) : Json := toJson (ratJSON x.1,ratJSON x.2)
def get {α : Type} (x : Except String α) : IO α := match x with
 | .ok a => pure a
 | .error e => throw (IO.userError e)
def testFraction (n : Int) (d : Nat) : IO Rat :=
 if h : 0 < d then pure (LeptonIntervals.normalize n d h) else throw (IO.userError "invalid test denominator")
def main : IO Unit := do
 IO.println (Json.mkObj [("hubble",intervalJSON (← get (CosmicIntervals.hubbleRatioInterval CosmicIntervals.hubbleSource))),
 ("density",intervalJSON (← get (CosmicIntervals.densityRatioInterval CosmicIntervals.densitySource)))]).compress
 for k in [1,2,3,4,5,6,7,8] do
  let l ← get (VacuumDensity.finiteZeroPointLedger (.integer (.ofNat k)))
  IO.println (Json.mkObj [("depth",toJson l.depth),("support",toJson l.support),
    ("modes",toJson (l.modes.map ratJSON)),("total",ratJSON l.total),("mean",ratJSON l.mean),("closed",toJson l.closed)]).compress
 let cs ← get VacuumDensity.localFloorCandidates
 IO.println (toJson (cs.map fun c => Json.mkObj [("candidate_id",toJson c.candidateId),("amplitude_depth",toJson c.amplitudeDepth),("observable_depth",toJson c.observableDepth),("survives",toJson c.survives)])).compress
 let mut scales : List Json := []
 for rate in [(1,3),(2,3),(1,1)] do
  for speed in [(1,2),(3,4),(1,1)] do
   for scale in [(1,4),(2,1),(3,1)] do
    let a ← testFraction rate.1 rate.2
    let b ← testFraction speed.1 speed.2
    let t ← testFraction scale.1 scale.2
    let initial ← get (VacuumDensity.scaleTransport a b)
    let scaled ← get (VacuumDensity.scaleTransport (LeptonIntervals.multiply a t) (LeptonIntervals.multiply b t))
    scales := scales ++ [toJson (ratJSON initial,ratJSON scaled)]
 IO.println (toJson scales).compress
