import SFT.Physics.InteractionUnification
import SFT.Physics.MagneticCovariance
import SFT.Mathematics.OrbitCyclotomic
namespace SFT.Physics.InteractionUnificationStanding
open InteractionUnification LeptonIntervals VacuumLedgerProofs
open SFT.Foundation.FractionReduction
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- Equality of actual normalized modes over one denominator preserves their generated index. -/
theorem originalModeIndexUnique (a b d : Nat) (hd : 0<d)
 (same : natRatio a d hd=natRatio b d hd) : a=b := by
 have av := natRatioValue a d hd
 have bv := natRatioValue b d hd
 rw [same] at av
 exact Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero (natRatio b d hd).den_nz) (av.trans bv.symm)
/-- The complete source standing-mode list contains exactly its interior indices. -/
theorem originalModeCoverage (n : Nat) (q : Rat) :
 q ∈ ((List.range n).map (fun i => natRatio (i+1) (n+1) (Nat.zero_lt_succ n))) ↔
 ∃ j, 0<j ∧ j<n+1 ∧ q=natRatio j (n+1) (Nat.zero_lt_succ n) := by
 constructor
 · intro h
   obtain ⟨i,member,eq⟩ := SFT.Mathematics.OrbitCyclotomic.mapPreimage _ _ q h
   exact ⟨i+1,Nat.zero_lt_succ _,Nat.succ_lt_succ ((SFT.Mathematics.OrbitCyclotomic.rangeMember n i).mp member),eq.symm⟩
 · intro h
   obtain ⟨j,positive,bound,eq⟩ := h
   cases j with
   | zero => exact False.elim (Nat.not_lt_zero _ positive)
   | succ i =>
    rw [eq]
    exact SFT.Mathematics.OrbitCyclotomic.mapMember _ (List.range n) i
     ((SFT.Mathematics.OrbitCyclotomic.rangeMember n i).mpr (Nat.lt_of_succ_lt_succ bound))
/-- Self-antipodality forces precisely the central index and therefore half-One. -/
theorem originalSelfAntipodal (j d : Nat) (positive : 0<j) (proper : j<d) :
 subtract InteractionUnification.one (natRatio j d (Nat.lt_trans positive proper))=
 natRatio j d (Nat.lt_trans positive proper) ↔
 natRatio j d (Nat.lt_trans positive proper)=InteractionUnification.half := by
 constructor
 · intro same
   change subtract (SFT.Foundation.ExactPartCarrier.asFraction SFT.Foundation.ExactOperations.one) (natRatio j d _) = _ at same
   rw [MagneticCovariance.subtractOneNormalized j d positive proper] at same
   have index := originalModeIndexUnique (d-j) j d (Nat.lt_trans positive proper) same
   have full := subtractAdd d j (Nat.le_of_lt proper)
   rw [index] at full
   apply natRatioCongruence j d 1 2
   rw [Nat.mul_two,Nat.one_mul]
   exact full
 · intro same
   rw [same]
   rfl
/-- All four original table records reassemble One from holding and positive mass shortfall. -/
theorem originalTableMassClosure : (primeSectors.mapM fun m => do
 let row ← baseSectorTable (.integer (.ofNat m))
 pure (SFT.Mathematics.LimitComputations.equalRat (add row.coupling row.massShortfall) InteractionUnification.one && zero.blt row.massShortfall))
 = Except.ok [true,true,true,true] := rfl
end SFT.Physics.InteractionUnificationStanding
