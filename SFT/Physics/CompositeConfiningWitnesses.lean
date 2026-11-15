import SFT.Physics.CompositeConfiningOrbits
namespace SFT.Physics.CompositeConfiningWitnesses
open SFT.Physics.CompositeConfining
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def sectorEight : Bool := match sectorCertificate (.integer 8) with
 | .error _ => false
 | .ok c => c.orbits == [[1,2,4],[3,6,5]] && c.antipodalPairCount == 3
def sectorTwelve : Bool := match sectorCertificate (.integer 12) with
 | .error _ => false
 | .ok c => c.orbitSizes == [10] && c.antipodalPairCount == 5
def sectorEighteen : Bool := match sectorCertificate (.integer 18) with
 | .error _ => false
 | .ok c => c.orbitSizes == [8,8] && c.antipodalPairCount == 8
def sectorTwentyFour : Bool := match sectorCertificate (.integer 24) with
 | .error _ => false
 | .ok c => c.orbitSizes == [11,11] && c.antipodalPairCount == 11
def sectorThirty : Bool := match sectorCertificate (.integer 30) with
 | .error _ => false
 | .ok c => c.orbitSizes == [28] && c.antipodalPairCount == 14
def completeGeneralControls : Bool := match registeredSectorCensus with
 | .error _ => false
 | .ok cs => cs.all (fun c => c.foldIsBijective && c.denominatorPreserved &&
   c.orbitsAreComplete && c.pairsAreComplete && c.pairsReassembleOne)
def couplingTable : Bool := match registeredSectorCensus with
 | .error _ => false
 | .ok cs => cs.length == 5 &&
   (cs.zip ([(7,8),(11,12),(17,18),(23,24),(29,30)] : List (Nat × Nat))).all
    (fun row => row.1.coupling.num=Int.ofNat row.2.1 && row.1.coupling.den=row.2.2)
def witnesses : List Witness := [⟨"sector-eight","The denominator-seven support splits into the two exact three-member orbits and three complement pairs.",sectorEight⟩,⟨"sector-twelve","The denominator-eleven support is one ten-member orbit with five complement pairs.",sectorTwelve⟩,⟨"sector-eighteen","The denominator-seventeen support is two eight-member orbits with eight complement pairs.",sectorEighteen⟩,⟨"sector-twenty-four","The denominator-twenty-three support is two eleven-member orbits with eleven complement pairs.",sectorTwentyFour⟩,⟨"sector-thirty","The denominator-twenty-nine support is one twenty-eight-member orbit with fourteen complement pairs.",sectorThirty⟩,⟨"complete-general-controls","Every registered case is bijective, denominator-preserving, orbit-complete and complement-complete.",completeGeneralControls⟩,⟨"coupling-table","All five holding couplings are the exact all-but-one shares.",couplingTable⟩]
theorem sectorEightPassed : sectorEight = true := by decide +kernel
theorem sectorTwelvePassed : sectorTwelve = true := by decide +kernel
theorem sectorEighteenPassed : sectorEighteen = true := by decide +kernel
theorem sectorTwentyFourPassed : sectorTwentyFour = true := by decide +kernel
theorem sectorThirtyPassed : sectorThirty = true := by decide +kernel
theorem completeGeneralControlsPassed : completeGeneralControls = true := by decide +kernel
theorem couplingTablePassed : couplingTable = true := by decide +kernel
theorem allWitnessesPass : witnesses.all Witness.passed = true := by decide +kernel
end SFT.Physics.CompositeConfiningWitnesses
