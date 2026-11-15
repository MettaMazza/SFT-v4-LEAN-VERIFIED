import SFT.Physics.MediatorRangeChannelTrace
namespace SFT.Physics.MediatorRangeChannelRanges
open MediatorRangeChannel MediatorRangeChannelTrace LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalEveryRangeOrder (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (ordered : n*e<m*d) :
 largerMassShorterRange (.fraction (natRatio n d hd)) (.fraction (natRatio m e he))=.ok true := by
 unfold largerMassShorterRange ScatteringPartitionPath.orderedValue
 dsimp only
 rw [positiveNormalized n d hn hd,CommonScaleAxis.positiveNormalizedLess n d m e hn hd hm he ordered]
 change (do let short ← reciprocalRangeScale (.fraction (natRatio m e he));
            let long ← reciprocalRangeScale (.fraction (natRatio n d hd));
            pure (short.blt long))=Except.ok true
 rw [originalEveryPositiveRange m e hm he,originalEveryPositiveRange n d hn hd]
 change Except.ok ((natRatio e m hm).blt (natRatio d n hn))=Except.ok true
 apply congrArg Except.ok
 apply CommonScaleAxis.positiveNormalizedLess e m d n he hm hd hn
 rw [Nat.mul_comm e n,Nat.mul_comm d m]
 exact ordered
theorem originalEveryInverseSquare (n d a b : Nat) (hn : 0<n) (hd : 0<d) (ha : 0<a) (hb : 0<b) :
 masslessInverseSquare (.fraction (natRatio n d hd)) (.fraction (natRatio a b hb))=
 .ok (natRatio (n*(b*b)) (d*(a*a)) (Nat.mul_pos hd (Nat.mul_pos ha ha))) := by
 unfold masslessInverseSquare SymmetryActionPaths.positiveCoordinate
 dsimp only
 rw [positiveNormalized n d hn hd,positiveNormalized a b ha hb]
 change LeptonRatios.divide (natRatio n d hd) (multiply (natRatio a b hb) (natRatio a b hb))=_
 rw [multiplyNormalized,divideNormalized n d (a*a) (b*b) hd (Nat.mul_pos ha ha) (Nat.mul_pos hb hb)]
theorem originalFiniteRadiusPositive (n d a b : Nat) (hn : 0<n) (hd : 0<d) (ha : 0<a) (hb : 0<b) :
 (masslessInverseSquare (.fraction (natRatio n d hd)) (.fraction (natRatio a b hb))).map (fun q => zero.blt q)=.ok true := by
 rw [originalEveryInverseSquare n d a b hn hd ha hb]
 change Except.ok (zero.blt (natRatio (n*(b*b)) (d*(a*a)) _))=Except.ok true
 exact congrArg Except.ok (positiveNormalized _ _ (Nat.mul_pos hn (Nat.mul_pos hb hb)) (Nat.mul_pos hd (Nat.mul_pos ha ha)))
theorem originalMasslessFiniteTrace (n : Nat) :
 masslessForwardTrace (.integer (.ofNat (n+1)))=.ok (List.replicate (n+2) one) := rfl
theorem originalMasslessEveryCarrier (n : Nat) :
 ∀ q, q ∈ List.replicate n one → q=one := by
 induction n with
 | zero => intro q h; cases h
 | succ n ih =>
  intro q h
  change q ∈ one :: List.replicate n one at h
  cases h with
  | head => rfl
  | tail _ h => exact ih q h
end SFT.Physics.MediatorRangeChannelRanges
