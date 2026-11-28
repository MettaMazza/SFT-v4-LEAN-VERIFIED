import SFT.Applications.Discovery.Inputs
namespace SFT.Applications.Discovery
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def sweepBound : Int := wholePower 2 7
def sweepContains (p q : Int) : Bool := decide (commonDivisor p q = 1 ∧ q < sweepBound+1 ∧ p < q+1 ∧ p > 0)
def censusByEnumeration : Int :=
 (List.range sweepBound.toNat).foldl (fun count i =>
  let q := Int.ofNat (i+1)
  (List.range q.toNat).foldl (fun n j => if commonDivisor (Int.ofNat (j+1)) q = 1 then n+1 else n) count) 0
def censusByPhiSum : Int :=
 (List.range (sweepBound-1).toNat).foldl (fun count i => count+eulerPhi (Int.ofNat (i+2))) 1
def censusRoutesAgree : Bool := decide (censusByEnumeration = censusByPhiSum)
def foldMemberLandsInside (p q factor : Int) : Bool :=
 let lifted := p*factor
 let wraps := (lifted-1).tdiv q
 let landed := lifted-wraps*q
 let shared := commonDivisor landed q
 decide (q.tdiv shared < sweepBound+1)
def closureIsClosed : Bool :=
 (List.range sweepBound.toNat).all fun i =>
  let q := Int.ofNat (i+1)
  (List.range q.toNat).all fun j =>
   let p := Int.ofNat (j+1)
   if commonDivisor p q = 1 then
    foldMemberLandsInside p q 2 && foldMemberLandsInside p q 3 && foldMemberLandsInside p q 5 && foldMemberLandsInside p q 7
   else true
def sweepPartitionHoldsTo (bound : Int) : Bool := orbitCountLawTo bound
def emergenceSecondInvariant (m : Int) : Fraction := fraction 1 (2*m)
def emergenceThirdInvariant (m : Int) : Fraction := fraction 1 (2*wholePower m 5-1)
def familyLandsLeptonSector : Bool :=
 equal (emergenceThirdInvariant 3) leadingThirdInvariant &&
 equal (subtract (fraction 1 1) (add (emergenceSecondInvariant 3) (emergenceSecondInvariant 3))) koideRatio
def familyPredictsNewSectors : Bool := equal (emergenceThirdInvariant 5) (fraction 1 6249) && equal (emergenceThirdInvariant 7) (fraction 1 33613)
def memberEquals (p q : Int) (forced : Fraction) : Bool := sweepContains p q && equal (fraction p q) forced
def sweepLandsCouplings : Bool := memberEquals 2 3 (sectorCoupling 3) && memberEquals 1 2 (sectorCoupling 2) && memberEquals 4 5 (sectorCoupling 5) && memberEquals 6 7 (sectorCoupling 7)
def sweepLandsMixing : Bool := memberEquals 1 4 sinSquaredMixing && memberEquals 3 4 cosSquaredMixing
def sweepLandsDarkSector : Bool := memberEquals 27 32 relicFractionOfMatter && sweepContains 5 32
def sweepLandsCosmicBudget : Bool := memberEquals 2 3 darkEnergyDensity && memberEquals 1 3 matterDensity && memberEquals 5 96 baryonDensity && memberEquals 9 32 coldDarkMatterDensity
def sweepComposesReactorAngle : Bool := equal (divide (multiply (fraction 1 2) (fraction 1 3)) (fraction 8 1)) (fraction 1 48) && sweepContains 1 48
def sweepReachesTheFloor : Bool := sweepContains 1 128
def discoverySweepCompletes : Bool := censusRoutesAgree && closureIsClosed && sweepPartitionHoldsTo 31 && familyLandsLeptonSector && familyPredictsNewSectors && sweepLandsCouplings && sweepLandsMixing && sweepLandsDarkSector && sweepLandsCosmicBudget && sweepComposesReactorAngle && sweepReachesTheFloor
end SFT.Applications.Discovery
