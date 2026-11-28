import SFT.Applications.Discovery.Sweep
import SFT.Applications.Discovery.Explorer
import SFT.Host.Text
open SFT.Applications.Discovery
open SFT.Host.Text

def digits : Nat → Nat → List Char
 | 0, _ => []
 | fuel+1, n =>
  let last := Char.ofNat (48+n%10)
  if n < 10 then [last] else digits fuel (n/10)++[last]
def number (n : Int) : String :=
 let text := String.ofList (digits (n.natAbs+1) n.natAbs)
 if n < 0 then append "-" text else text
def fractionText (q : Fraction) : String :=
 if q.denominator = 1 then number q.numerator else join [number q.numerator,"/",number q.denominator]
def line (s : String) : IO Unit := do
 let out ← IO.getStdout
 out.putStr (append s "\n")
def require (label : String) (ok : Bool) : IO Unit :=
 bif ok then line (append "PASS " label) else throw (IO.userError (append "FAIL " label))
def main : IO Unit := do
 require "sweep bound 128" (decide (sweepBound = 128))
 require "census enumeration 5022" (decide (censusByEnumeration = 5022))
 require "census independently agrees with phi sum" censusRoutesAgree
 require "all four sector folds close every member" closureIsClosed
 require "odd denominator orbit partition to31" (sweepPartitionHoldsTo 31)
 require "family lands lepton sector" familyLandsLeptonSector
 require "third invariant at3 is1/485" (equal (emergenceThirdInvariant 3) (fraction 1 485))
 require "family predicts penta and hepta invariants" familyPredictsNewSectors
 require "four sector couplings" sweepLandsCouplings
 require "mixing partition" sweepLandsMixing
 require "dark and baryon shares" sweepLandsDarkSector
 require "cosmic budget" sweepLandsCosmicBudget
 require "composed reactor angle" sweepComposesReactorAngle
 require "floor1/128" sweepReachesTheFloor
 require "Koide deviation17/3000000" (equal (subtract (fraction 2 3) (fraction 666661 1000000)) (fraction 17 3000000))
 require "complete autonomous sweep" discoverySweepCompletes
 line (append "CENSUS " (number censusByEnumeration))
 line (append "EMERGENCE3 " (fractionText (emergenceThirdInvariant 3)))

 require "V2 integer construction starts atOne" (decide (Explorer.integerFromOne 0 = 1))
 require "V2 cast preserves zero input behavior" (equal (Explorer.castOut (fraction 0 1)) (fraction 0 1))
 require "V2 cast5/2 gives1/2" (equal (Explorer.castOut (fraction 5 2)) (fraction 1 2))
 require "V2 fold half reachesOne" (equal (Explorer.mFold (fraction 1 2) 2) (fraction 1 1))
 require "V2 proper standing modes excludeOne" (decide ((Explorer.standing 4).length = 2) && !(Explorer.contains (Explorer.standing 4) (fraction 1 1)))
 require "USDE standing modes includeOne" (decide ((Explorer.usdeStanding 4).length = 3) && Explorer.contains (Explorer.usdeStanding 4) (fraction 1 1))
 require "V2 orbit1/7 has length3" (decide ((Explorer.orbitOf (fraction 1 7) 2).length = 3))
 require "V2 family transient behavior retained" (decide (Explorer.famOrbit 4 = 3))
 require "V2 source stopping cap retained" (decide ((Explorer.orbitOf (fraction 1 7) 2 1).length = 2))
 require "V2 closed seed4 contains four fractions" (decide ((Explorer.closedSet 4).length = 4))
 require "V2 fold count1/7 is8" (decide (Explorer.foldCount (fraction 1 7) = some 8))
 let tally := Explorer.axis1 4
 require "V2 axis1 enumerates18 expressions" (decide (tally.returnsOne+tally.fixed+tally.cycle+tally.unresolved = 18))
 require "V2 axis1 resolves its finite sweep" (decide (tally.unresolved = 0))
 line (append "V2_CLOSED30 " (number (Int.ofNat (Explorer.closedSet).length)))

 let thirds := Explorer.runGroupProof [fraction 1 3,fraction 2 3]
 require "V2 thirds group proof" (thirds.proves && thirds.t5PairLaw.getD false)
 let quarters := Explorer.runGroupProof [fraction 1 4,fraction 3 4]
 require "V2 quarters closure counterexample retained" (!quarters.t2Closed && !quarters.proves && !(quarters.t5PairLaw.getD true))

 let all := Explorer.axis1 40
 line (join ["V2_AXIS1_40 returnsOne=",number (Int.ofNat all.returnsOne)," fixed=",number (Int.ofNat all.fixed)," cycle=",number (Int.ofNat all.cycle)," unresolved=",number (Int.ofNat all.unresolved)])
 require "V2 original axis1 sweep covers30420 expressions" (decide (all.returnsOne+all.fixed+all.cycle+all.unresolved = 30420))
 require "V2 original axis1 sweep resolves" (decide (all.unresolved = 0))
