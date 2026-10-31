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

def countValue : CountInput → Int
 | .integer n => n
 | .boolean false => 0
 | .boolean true => 1

def runningGap (lower upper support : CountInput) : Except String Rat :=
 if countValue lower < countValue upper then do
   let high ← runningCoupling upper support
   let low ← runningCoupling lower support
   pure (subtract high low)
 else .error "gap requires strictly ordered sectors"

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

def electronMassPartRatio (sector : CountInput) : Except String Rat := do
 let part ← fermionMassPart sector
 let electron ← fermionMassPart (.integer 2)
 if h : 0 < electron.num.natAbs then
   pure (normalize (part.num * Int.ofNat electron.den) (part.den * electron.num.natAbs)
     (Nat.mul_pos (Nat.pos_of_ne_zero part.den_nz) h))
 else .error "electron mass-part denominator cannot vanish"

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
theorem gapRetainsExactDifference (lower upper support : CountInput) (low high : Rat)
 (ordered : countValue lower < countValue upper)
 (upperResult : runningCoupling upper support = .ok high)
 (lowerResult : runningCoupling lower support = .ok low) :
 runningGap lower upper support = .ok (subtract high low) := by
 unfold runningGap
 rw [if_pos ordered, upperResult, lowerResult]
 rfl

theorem gapCommonNumerator (a b : Nat) : b*(a+1)-a*(b+1)=b-a := by
 rw [Nat.mul_succ, Nat.mul_succ, Nat.mul_comm b a]
 rw [Nat.add_comm (a*b) b, Nat.add_comm (a*b) a]
 exact SFT.Foundation.FractionReduction.addSubtractSame b a (a*b)

theorem runningGapNumerator (i j k : Nat) :
 (j+k)*(i+k+1)-(i+k)*(j+k+1)=j-i := by
 rw [gapCommonNumerator]
 exact SFT.Foundation.FractionReduction.addSubtractSame j i k

def pairFields (q : Except String Rat) : Except String (Int × Nat) :=
 q.map (fun x => (x.num,x.den))

def diagonalRecord : Except String (List (Int × Nat)) :=
 ([2,3,5,7] : List Nat).mapM (fun p => pairFields (generationMixingDiagonal (.integer (.ofNat p))))
def bandRecord : Except String (List (Int × Nat)) :=
 ([2,3,5,7] : List Nat).mapM (fun p => pairFields (generationMixingBand (.integer (.ofNat p))))
def massPartRecord : Except String (List (Int × Nat)) :=
 ([2,3,5,7] : List Nat).mapM (fun p => pairFields (fermionMassPart (.integer (.ofNat p))))
def electronRatioRecord : Except String (List (Int × Nat)) :=
 ([2,3,5,7] : List Nat).mapM (fun p => pairFields (electronMassPartRatio (.integer (.ofNat p))))

theorem exactDiagonalRecord : diagonalRecord = .ok [(5,6),(8,9),(14,15),(20,21)] := by
 unfold diagonalRecord pairFields generationMixingDiagonal chargeKindCount
 rw [completeLadder]
 rfl

theorem exactBandRecord : bandRecord = .ok [(1,2),(5,9),(3,5),(13,21)] := by
 unfold bandRecord pairFields generationMixingBand chargeKindCount
 rw [completeLadder]
 rfl

theorem exactMassPartRecord : massPartRecord = .ok [(1,2),(1,3),(1,5),(1,7)] := by
 unfold massPartRecord pairFields fermionMassPart chargeKindCount
 rw [completeLadder]
 rfl

theorem exactElectronRatioRecord : electronRatioRecord = .ok [(1,1),(2,3),(2,5),(2,7)] := by
 unfold electronRatioRecord pairFields electronMassPartRatio fermionMassPart chargeKindCount
 rw [completeLadder]
 rfl

def orderedPairs : List (Nat × Nat) :=
 ([2,3,5,7] : List Nat).flatMap (fun i => ([2,3,5,7] : List Nat).filterMap
   (fun j => if i<j then some (i,j) else none))

def gapRecord (support : Nat) : Except String (List (Int × Nat)) :=
 orderedPairs.mapM (fun p => pairFields (runningGap (.integer (.ofNat p.1)) (.integer (.ofNat p.2)) (.integer (.ofNat support))))

theorem completeOrderedPairs : orderedPairs = [(2,3),(2,5),(2,7),(3,5),(3,7),(5,7)] := rfl

theorem exactGapRecord : gapRecord 8 = .ok [(1,110),(3,130),(1,30),(2,143),(4,165),(2,195)] := by
 unfold gapRecord runningGap runningCoupling chargeKindCount pairFields
 rw [completeLadder]
 rfl

theorem allGapWitnesses :
 gapRecord 8 = .ok (orderedPairs.map (fun p =>
   let q := normalize (.ofNat (p.2-p.1)) ((p.1+8)*(p.2+8))
     (Nat.mul_pos (Nat.zero_lt_succ _) (Nat.zero_lt_succ _))
   (q.num,q.den))) := by
 rw [exactGapRecord]
 rfl

theorem firstExcludedSector : chargeKindCount (.integer 11) = .error "charge count requires an admitted prime sector" := by
 unfold chargeKindCount
 rw [completeLadder]
 rfl

end SFT.Physics.SectorInventory
