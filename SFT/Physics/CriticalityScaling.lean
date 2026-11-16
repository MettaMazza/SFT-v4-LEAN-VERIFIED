import SFT.Physics.CriticalityUniversality
namespace SFT.Physics.CriticalityScaling
open CriticalityUniversality SFT.Foundation.FractionReduction SFT.Foundation.CommonRefinement
set_option maxHeartbeats 100000000
-- Reuse the existing exact power induction for the source's original perfect-power operations.
private theorem powerAdd (a b c : Nat) : a^(b+c)=a^b*a^c := by
 induction c with
 | zero => rw [Nat.add_zero,Nat.pow_zero,Nat.mul_one]
 | succ c ih => rw [Nat.add_succ,Nat.pow_succ,ih,Nat.pow_succ,mulAssoc]
private theorem powerPower (a b c : Nat) : (a^b)^c=a^(b*c) := by
 induction c with
 | zero => rw [Nat.pow_zero,Nat.mul_zero,Nat.pow_zero]
 | succ c ih => rw [Nat.pow_succ,ih,Nat.mul_succ,powerAdd]
theorem originalSquareExcess (q d : Nat) : (q^d)^2=q^(2*d) := by
 rw [powerPower,Nat.mul_comm d 2]
theorem originalCubicField (q d : Nat) : (q^d)^3=q^(3*d) := by
 rw [powerPower,Nat.mul_comm d 3]
theorem originalCascadeStructure (q d : Nat) : ((q^d)^2)^3=((q^d)^3)^2 := by
 rw [powerPower (q^d),powerPower (q^d)]
theorem originalCascadeSpectrum (q d : Nat) : ((q^d)^5)^3=((q^d)^3)^5 := by
 rw [powerPower (q^d),powerPower (q^d)]
theorem originalEveryMeanScale (q d : Nat) :
 meanFieldScaleWitness (.integer (.ofNat (q+1))) (.integer (.ofNat (d+1)))=
 .ok ⟨((q+1)^(d+1))^2,(q+1)^(d+1),(q+1)^(d+1),((q+1)^(d+1))^2,((q+1)^(d+1))^3,true,true,true,true⟩ := by
 unfold meanFieldScaleWitness
 change Except.ok (⟨_,_,_,_,_,_,_,_,_⟩ : MeanScale)=_
 rw [originalSquareExcess,originalCubicField,naturalEqualityReflexive,naturalEqualityReflexive]
theorem originalEveryCascadeScale (q d : Nat) :
 cascadeScaleWitness (.integer (.ofNat (q+1))) (.integer (.ofNat (d+1)))=
 .ok ⟨((q+1)^(d+1))^3,((q+1)^(d+1))^2,((q+1)^(d+1))^3,((q+1)^(d+1))^5,true,true,true⟩ := by
 unfold cascadeScaleWitness
 change Except.ok (⟨_,_,_,_,_,_,_⟩ : CascadeScale)=_
 rw [originalCascadeStructure,originalCascadeSpectrum,naturalEqualityReflexive,naturalEqualityReflexive]
theorem originalSuccessorStep (q d : Nat) : q^(d+1)=q^d*q := Nat.pow_succ _ _
theorem originalShellSuccession : LeptonIntervals.add cascadeExponents.structureFunction (VacuumLedgerProofs.wholeRatio 1)=cascadeExponents.spectrumMagnitude := rfl
end SFT.Physics.CriticalityScaling
