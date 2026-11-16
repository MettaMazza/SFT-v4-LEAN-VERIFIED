import SFT.Physics.CompactHorizon
namespace SFT.Physics.CompactHorizonDerivation
open CompactHorizon LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalExclusionExponentOrder (q : Nat) (afterBase : 1<q) : q^4<q^6 := by
 have positive : 0<q := Nat.lt_trans (by decide) afterBase
 have p4 := Nat.pow_pos positive (n:=4)
 have step : q^4<q^4*q := by
  have h := Nat.mul_lt_mul_of_pos_left afterBase p4
  rw [Nat.mul_one] at h
  exact h
 have step2 : q^4*q<q^4*q*q := by
  have h := Nat.mul_lt_mul_of_pos_left afterBase (Nat.mul_pos p4 positive)
  rw [Nat.mul_one] at h
  exact h
 change q^4<q^4*q*q
 exact Nat.lt_trans step step2
theorem originalCubePacking (q : Nat) : q*q*q=q^3 := by
 rw [Nat.pow_succ,Nat.pow_succ,Nat.pow_succ,Nat.pow_zero,Nat.one_mul]
theorem originalPairedSupport (q : Nat) : (q*q*q)*(q*q*q)=q^6 := by
 change (q*q*q)*(q*q*q)=(((((1*q)*q)*q)*q)*q)*q
 rw [Nat.one_mul,← mulAssoc (q*q*q) (q*q) q,← mulAssoc (q*q*q) q q]
theorem originalExclusionSupport (q : Nat) : q*q*q*q=q^4 := by
 rw [originalCubePacking]
 exact (Nat.pow_succ q 3).symm
theorem originalQuarterWitness : CompactHorizon.quarter=StrongFieldHorizon.originalRecord.mass := rfl
theorem originalThermalWitness : CompactHorizon.quarter=StrongFieldHorizon.originalRecord.normalizedThermalCarrier := rfl
theorem originalQuarterBoundary : CompactHorizon.quarter=StrongFieldHorizon.originalRecord.entropyCoefficient := rfl
theorem originalThermalProduct : thermalMassProduct=natRatio 1 16 (by decide) := rfl
theorem originalThermalScale (n d : Nat) (hn : 0<n) (hd : 0<d) :
 LeptonRatios.divide thermalMassProduct (natRatio n d hd)=.ok (natRatio d (16*n) (Nat.mul_pos (by decide) hn)) := by
 rw [originalThermalProduct,divideNormalized _ _ _ _ (by decide) hn hd,Nat.one_mul]
theorem originalThermalMassInvariant (n d : Nat) (hn : 0<n) (hd : 0<d) :
 multiply (natRatio d (16*n) (Nat.mul_pos (by decide) hn)) (natRatio n d hd)=thermalMassProduct := by
 rw [multiplyNormalized,originalThermalProduct]
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.mul_comm d n,mulAssoc 16 n d,Nat.mul_comm (n*d) 16]
theorem originalEveryReachedFloor (depth : Nat) :
 zero.blt (natRatio 1 (2^depth) (Nat.pow_pos (by decide)))=true :=
 FiniteQuantumGravityGeneral.originalFloorPositive depth
theorem originalEmissionMassFalls (depth : Nat) :
 (natRatio 1 (2^(depth+1)) (Nat.pow_pos (by decide))).blt (natRatio 1 (2^depth) (Nat.pow_pos (by decide)))=true :=
 FiniteQuantumGravityGeneral.originalFloorDecreases depth
theorem originalQuarterArea (a b : Nat) (hb : 0<b) :
 multiply (multiply CompactHorizon.quarter (natRatio a b hb)) (wholeRatio 4)=natRatio a b hb := by
 change multiply (multiply (natRatio 1 4 (by decide)) (natRatio a b hb)) (wholeRatio 4)=_
 rw [multiplyNormalized,← natRatioWhole 4,multiplyNormalized]
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.mul_one,mulAssoc a 4 b]
theorem originalPositiveHorizon (n d : Nat) (hn : 0<n) (hd : 0<d) :
 horizonThermodynamics (natRatio n d hd)=.ok
  ⟨natRatio n d hd,natRatio (n+n) d hd,
   natRatio ((n+n)*(n+n)) (d*d) (Nat.mul_pos hd hd),
   multiply CompactHorizon.quarter (natRatio ((n+n)*(n+n)) (d*d) (Nat.mul_pos hd hd)),
   natRatio d (16*n) (Nat.mul_pos (by decide) hn),thermalMassProduct⟩ := by
 unfold horizonThermodynamics positiveFraction
 rw [positiveNormalized n d hn hd]
 rw [if_pos rfl]
 dsimp only [Except.bind,Bind.bind]
 rw [originalThermalScale n d hn hd]
 dsimp only [Except.bind,Bind.bind]
 rw [originalThermalMassInvariant n d hn hd]
 rw [addNormalized,multiplyNormalized,originalQuarterArea]
 unfold bne
 rw [ratEqualSelf,ratEqualSelf,ratEqualSelf]
 rfl
theorem originalHalving (n d : Nat) (hd : 0<d) :
 multiply (natRatio n d hd) CompactHorizon.half=natRatio n (d*2) (Nat.mul_pos hd (by decide)) := by
 change multiply (natRatio n d hd) (natRatio 1 2 (by decide))=_
 rw [multiplyNormalized,Nat.mul_one]
theorem originalEvaporationTotal (count n d : Nat) (hn : 0<n) (hd : 0<d) :
 ∃ rows, evaporationRows count (natRatio n d hd)=.ok rows ∧ rows.length=count ∧
 rows.all (fun h=>[h.mass,h.radius,h.areaSupport,h.entropySupport,h.temperature].all (fun q=>zero.blt q))=true := by
 induction count generalizing n d with
 | zero => exact ⟨[],rfl,rfl,rfl⟩
 | succ count ih =>
  obtain ⟨rows,hr,hl,hp⟩ := ih n (d*2) hn (Nat.mul_pos hd (by decide))
  let h : Horizon := ⟨natRatio n d hd,natRatio (n+n) d hd,
   natRatio ((n+n)*(n+n)) (d*d) (Nat.mul_pos hd hd),
   multiply CompactHorizon.quarter (natRatio ((n+n)*(n+n)) (d*d) (Nat.mul_pos hd hd)),
   natRatio d (16*n) (Nat.mul_pos (by decide) hn),thermalMassProduct⟩
  refine ⟨h::rows,?_,?_,?_⟩
  · change (do pure ((← horizonThermodynamics (natRatio n d hd))::(← evaporationRows count (multiply (natRatio n d hd) CompactHorizon.half))))=_
    rw [originalPositiveHorizon n d hn hd,originalHalving,hr]
    rfl
  · change rows.length+1=count+1
    rw [hl]
  · have pn : 0<n+n := Nat.lt_of_lt_of_le hn (Nat.le_add_right n n)
    have pp : 0<(n+n)*(n+n) := Nat.mul_pos pn pn
    have entropy : zero.blt h.entropySupport=true := by
     change zero.blt (multiply (natRatio 1 4 (by decide)) (natRatio ((n+n)*(n+n)) (d*d) (Nat.mul_pos hd hd)))=true
     rw [multiplyNormalized]
     exact positiveNormalized _ _ (Nat.mul_pos (by decide) pp) _
    change ((zero.blt h.mass && (zero.blt h.radius && (zero.blt h.areaSupport && (zero.blt h.entropySupport && (zero.blt h.temperature && true))))) && rows.all (fun h=>[h.mass,h.radius,h.areaSupport,h.entropySupport,h.temperature].all (fun q=>zero.blt q)))=true
    rw [hp,entropy]
    change ((zero.blt (natRatio n d hd) && (zero.blt (natRatio (n+n) d hd) && (zero.blt (natRatio ((n+n)*(n+n)) (d*d) (Nat.mul_pos hd hd)) && (true && (zero.blt (natRatio d (16*n) (Nat.mul_pos (by decide) hn)) && true))))) && true)=true
    rw [positiveNormalized n d hn hd,positiveNormalized (n+n) d pn hd,positiveNormalized ((n+n)*(n+n)) (d*d) pp (Nat.mul_pos hd hd),positiveNormalized d (16*n) hd (Nat.mul_pos (by decide) hn)]
    rfl
#print axioms originalHalving
#print axioms originalEvaporationTotal
#print axioms originalQuarterArea
#print axioms originalPositiveHorizon
#print axioms originalExclusionExponentOrder
#print axioms originalCubePacking
#print axioms originalPairedSupport
#print axioms originalExclusionSupport
#print axioms originalQuarterWitness
#print axioms originalThermalWitness
#print axioms originalQuarterBoundary
#print axioms originalThermalProduct
#print axioms originalThermalScale
#print axioms originalThermalMassInvariant
#print axioms originalEveryReachedFloor
#print axioms originalEmissionMassFalls
end SFT.Physics.CompactHorizonDerivation
