import SFT.Physics.PrimeSectorLadder
namespace SFT.Physics.SectorInventory
open GeneratorOperations LeptonIntervals PrimeSectorLadder

def chargeKindCount : CountInput → Except String Nat
 | .boolean _ => .error "charge count requires an admitted prime sector"
 | .integer (.negSucc _) => .error "charge count requires an admitted prime sector"
 | .integer (.ofNat sector) => do
   let sectors ← primeSectorLadder
   if sectors.contains sector then .ok sector
   else .error "charge count requires an admitted prime sector"

def runningCoupling (sector support : CountInput) : Except String Rat := do
 let p ← (chargeKindCount sector).mapError (fun _ => "running coupling requires a sector and positive support")
 match support with
 | .boolean _ => .error "running coupling requires a sector and positive support"
 | .integer (.negSucc _) => .error "running coupling requires a sector and positive support"
 | .integer (.ofNat 0) => .error "running coupling requires a sector and positive support"
 | .integer (.ofNat (k+1)) =>
   .ok (normalize (.ofNat (p+k)) (p+k+1) (Nat.zero_lt_succ _))

def singletConstituentCount := chargeKindCount

def antipodalPairCount (sector : CountInput) : Except String Nat := do
 let _ ← chargeKindCount sector
 pure 2

def generationMixingDiagonal (sector : CountInput) : Except String Rat := do
 let p ← chargeKindCount sector
 if h : 0 < 3*p then .ok (normalize (.ofNat (3*p-1)) (3*p) h)
 else .error "charge count requires an admitted prime sector"

def generationMixingBand (sector : CountInput) : Except String Rat := do
 let p ← chargeKindCount sector
 if h : 0 < 3*p then .ok (normalize (.ofNat (2*p-1)) (3*p) h)
 else .error "charge count requires an admitted prime sector"

def fermionMassPart (sector : CountInput) : Except String Rat := do
 let p ← chargeKindCount sector
 if h : 0 < p then .ok (normalize 1 p h)
 else .error "charge count requires an admitted prime sector"

def gaugeCarrierTotal : Except String Nat := do
 let sectors ← primeSectorLadder
 let counts ← sectors.mapM (fun p => mediatorCount (.integer (.ofNat p)))
 pure counts.sum

def undiscoveredGaugeCarrierCount : Except String Nat := do
 let penta ← mediatorCount (.integer 5)
 let hepta ← mediatorCount (.integer 7)
 pure (penta+hepta)

def smithionKindCount : Nat := ([5,7] : List Nat).length * 2 * 3

def completeNamedParticleCount : Except String Nat := do
 let gauge ← gaugeCarrierTotal
 pure (gauge+3+smithionKindCount)

theorem runningAtEveryPositiveSupport (sector : CountInput) (p k : Nat)
 (admitted : chargeKindCount sector = .ok p) :
 runningCoupling sector (.integer (.ofNat (k+1))) =
 .ok (normalize (.ofNat (p+k)) (p+k+1) (Nat.zero_lt_succ _)) := by
 unfold runningCoupling
 rw [admitted]
 rfl

theorem runningSourceNumerator (p k : Nat) : p+(k+1)-1 = p+k := by
 rfl

theorem everySingletRetainsCompleteSector (sector : CountInput) (p : Nat)
 (admitted : chargeKindCount sector = .ok p) : singletConstituentCount sector = .ok p := admitted

theorem everyAntipodalPair (sector : CountInput) (p : Nat)
 (admitted : chargeKindCount sector = .ok p) : antipodalPairCount sector = .ok 2 := by
 unfold antipodalPairCount
 rw [admitted]
 rfl

theorem completeChargeKinds :
 ([2,3,5,7] : List Nat).mapM (fun p => chargeKindCount (.integer (.ofNat p))) = .ok [2,3,5,7] := by
 unfold chargeKindCount
 rw [completeLadder]
 rfl

theorem exactGaugeTotal : gaugeCarrierTotal = .ok 83 := by
 unfold gaugeCarrierTotal
 rw [completeLadder]
 change (mediatorRecord.map List.sum) = .ok 83
 rw [exactMediators]
 rfl

theorem exactNewCarriers : undiscoveredGaugeCarrierCount = .ok 72 := by
 unfold undiscoveredGaugeCarrierCount mediatorCount
 rw [completeLadder]
 rfl

theorem exactSmithions : smithionKindCount = 12 := rfl

theorem exactNamedCount : completeNamedParticleCount = .ok 98 := by
 unfold completeNamedParticleCount
 rw [exactGaugeTotal]
 rfl
end SFT.Physics.SectorInventory
