import SFT.Physics.NuclearResidualForce
import SFT.Physics.CommonScaleAxisAlgebra
namespace SFT.Physics.NuclearResidualForceProofs
open NuclearResidualForce LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxRecDepth 20000
theorem everyPositiveRange (n d : Nat) (hn : 0<n) (hd : 0<d) :
 mediatorRange (.fraction (natRatio n d hd))=.ok (natRatio d n hn) := by
 unfold mediatorRange
 change (if !zero.blt (natRatio n d hd) then _ else _)=_
 rw [positiveNormalized n d hn hd,←natRatioWhole 1]
 change LeptonRatios.divide (natRatio 1 1 (by decide)) (natRatio n d hd)=_
 rw [divideNormalized 1 1 n d (by decide) hn hd]
 apply congrArg Except.ok
 apply natRatioCongruence
 rw [Nat.one_mul,Nat.one_mul]
theorem everyInverseOrder (n d m e : Nat) (hn : 0<n) (hd : 0<d) (hm : 0<m) (he : 0<e)
 (ordered : n*e<m*d) : inverseMassOrder (.fraction (natRatio n d hd)) (.fraction (natRatio m e he))=.ok true := by
 have sourceLess := CommonScaleAxis.positiveNormalizedLess n d m e hn hd hm he ordered
 have reverseLess : (natRatio e m hm).blt (natRatio d n hn)=true := by
  apply CommonScaleAxis.positiveNormalizedLess e m d n he hm hd hn
  rw [Nat.mul_comm e n,Nat.mul_comm d m]
  exact ordered
 unfold inverseMassOrder
 change (do
  if !zero.blt (natRatio n d hd) || !(natRatio n d hd).blt (natRatio m e he) then throw "range ordering requires positive ordered masses"
  let longer ← mediatorRange (.fraction (natRatio n d hd))
  let shorter ← mediatorRange (.fraction (natRatio m e he))
  pure (shorter.blt longer))=_
 rw [positiveNormalized n d hn hd,sourceLess]
 change (do
  let longer ← mediatorRange (.fraction (natRatio n d hd))
  let shorter ← mediatorRange (.fraction (natRatio m e he))
  pure (shorter.blt longer))=_
 rw [everyPositiveRange n d hn hd,everyPositiveRange m e hm he]
 exact congrArg Except.ok reverseLess
theorem everyPresentMass (n d : Nat) (hn : 0<n) (hd : 0<d) :
 mediatorReachClass (.carrier (.fraction (natRatio n d hd)))=.ok "finite-positive-reciprocal-scale" := by
 unfold mediatorReachClass
 change (do
  let _ ← mediatorRange (.fraction (natRatio n d hd))
  pure "finite-positive-reciprocal-scale")=_
 rw [everyPositiveRange n d hn hd]
 rfl
end SFT.Physics.NuclearResidualForceProofs
