import SFT.Physics.ParticleModeCertificate
namespace SFT.Physics.ParticleModeNativeBindings
open ParticleModeFibres ParticleModeFibreDerivation ParticleModeFixedDerivation
open ParticleModePlacement LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

theorem originalFibreEnumeration (m p q : Nat) (hm : 0<m) (hq : 0<q) :
 mapExact (fibreValue m (natRatio p q hq)) (List.range m)=.ok (completeOffsets m p q hm hq) := by
 have each : ∀ xs : List Nat, mapExact (fibreValue m (natRatio p q hq)) xs=
   .ok (xs.map (fun j=>offsetValue m p q j hm hq)) := by
  intro xs
  induction xs with
  | nil => rfl
  | cons x xs ih =>
   change (do let y ← fibreValue m (natRatio p q hq) x
              let ys ← mapExact (fibreValue m (natRatio p q hq)) xs
              pure (y::ys)) = _
   rw [originalOffsetFormula,ih]
   rfl
 exact each _

theorem originalFixedEnumeration (k : Nat) :
 mapExact (fun j=>LeptonRatios.divide (wholeRatio (j+1)) (wholeRatio (k+1))) (List.range k)=
 .ok (completeFixedModes k) := by
 have each : ∀ xs : List Nat, mapExact (fun j=>LeptonRatios.divide (wholeRatio (j+1)) (wholeRatio (k+1))) xs=
  .ok (xs.map (fixedValue k)) := by
  intro xs
  induction xs with
  | nil => rfl
  | cons x xs ih =>
   change (do let y ← LeptonRatios.divide (wholeRatio (x+1)) (wholeRatio (k+1))
              let ys ← mapExact (fun j=>LeptonRatios.divide (wholeRatio (j+1)) (wholeRatio (k+1))) xs
              pure (y::ys)) = _
   rw [originalFixedValue,ih]
   rfl
 exact each _

theorem originalPlacementEnumeration (depth count : Nat) :
 mapExact (placementValue depth) (List.range count)=.ok ((List.range count).map
  (fun j=>BoundaryGrowth.asFraction (VacuumSpectrum.level (2^depth) j (Nat.pow_pos (by decide))))) := by
 have each : ∀ xs : List Nat, mapExact (placementValue depth) xs=.ok (xs.map
  (fun j=>BoundaryGrowth.asFraction (VacuumSpectrum.level (2^depth) j (Nat.pow_pos (by decide))))) := by
  intro xs
  induction xs with
  | nil => rfl
  | cons x xs ih =>
   change (do let y ← placementValue depth x
              let ys ← mapExact (placementValue depth) xs
              pure (y::ys)) = _
   rw [originalPlacementValue,ih]
   rfl
 exact each _
#print axioms originalFibreEnumeration
#print axioms originalFixedEnumeration
#print axioms originalPlacementEnumeration
end SFT.Physics.ParticleModeNativeBindings
