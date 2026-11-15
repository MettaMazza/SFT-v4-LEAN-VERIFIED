import SFT.Physics.CompositeConfining
namespace SFT.Physics.CompositeConfining
open GeneratorOperations LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- V3 orbit_from_label: retain the initial Python Boolean/int representation.
def orbitLoop (sector initial : CountInput) : Nat → CountInput → List CountInput → Except String (List CountInput)
 | fuel, current, orbit => do
  if orbit.any (fun x => labelInteger x = labelInteger current) then
   if labelInteger current = labelInteger initial then pure orbit
   else throw "Fold mode entered a distinct recurrence before returning"
  else match fuel with
   | 0 => throw "Fold mode entered a distinct recurrence before returning"
   | n+1 =>
    let next ← foldModeLabel current sector
    orbitLoop sector initial n (.integer (.ofNat next)) (orbit ++ [current])
def orbitFromLabel (label sector : CountInput) : Except String (List CountInput) := do
 let labels ← standingModeLabels sector
 if !(labels.any (fun n => Int.ofNat n = labelInteger label)) then
  throw "orbit source lies outside the complete standing support"
 orbitLoop sector label labels.length label []
def partitionLoop (sector : CountInput) : Nat → List Nat → List (List Nat) → Except String (List (List Nat))
 | _, [], orbits => .ok orbits
 | 0, _::_, _ => .error "generated Fold orbits overlap"
 | fuel+1, first::rest, orbits => do
  let remaining := first::rest
  let raw ← orbitFromLabel (.integer (.ofNat first)) sector
  let orbit := raw.map (fun x => (labelInteger x).toNat)
  if orbit.any (fun x => !(remaining.any (fun y => y = x))) then
   throw "generated Fold orbits overlap"
  partitionLoop sector fuel (remaining.filter (fun x => !(orbit.any (fun y => y = x)))) (orbits ++ [orbit])
def orbitPartition (sector : CountInput) : Except String (List (List Nat)) := do
 let labels ← standingModeLabels sector
 partitionLoop sector labels.length labels []
structure SectorCertificate where
 sector : CountInput
 denominator : Nat
 modes : List Nat
 modeCount : Nat
 orbits : List (List Nat)
 orbitSizes : List Nat
 antipodalPairs : List (Nat × Nat)
 antipodalPairCount : Nat
 coupling : Rat
 denominatorPreserved : Bool
 foldIsBijective : Bool
 orbitsAreComplete : Bool
 pairsAreComplete : Bool
 pairsReassembleOne : Bool
def sameLabelSet (xs ys : List Nat) : Bool :=
 xs.all (fun x => ys.any (fun y => x = y)) && ys.all (fun y => xs.any (fun x => x = y))
def sectorCertificate (sector : CountInput) : Except String SectorCertificate := do
 let modes ← standingModeLabels sector
 let orbits ← orbitPartition sector
 let pairs ← antipodalPairs sector
 let denominator ← heldDenominator sector
 let images ← modes.mapM (fun x => foldModeLabel (.integer (.ofNat x)) sector)
 let predecessors ← modes.mapM (fun x => inverseFoldModeLabel (.integer (.ofNat x)) sector)
 let coupling ← holdingCoupling sector
 pure { sector := sector, denominator := denominator, modes := modes, modeCount := modes.length, orbits := orbits,
        orbitSizes := orbits.map List.length, antipodalPairs := pairs, antipodalPairCount := pairs.length,
        coupling := coupling, denominatorPreserved := images.all (fun x => 1 ≤ x && x < denominator),
        foldIsBijective := sameLabelSet images modes && sameLabelSet predecessors modes,
        orbitsAreComplete := sameLabelSet orbits.flatten modes,
        pairsAreComplete := sameLabelSet (pairs.flatMap (fun (a,b) => [a,b])) modes,
        pairsReassembleOne := pairs.all (fun (a,b) => a+b = denominator)}
def registeredSectorCensus : Except String (List SectorCertificate) :=
 ([8,12,18,24,30] : List Nat).mapM (fun x => sectorCertificate (.integer (.ofNat x)))
end SFT.Physics.CompositeConfining
