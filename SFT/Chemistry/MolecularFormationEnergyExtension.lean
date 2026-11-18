import SFT.Chemistry.MolecularFormationEnergy
import SFT.Chemistry.IntermolecularBindingExtension
namespace SFT.Chemistry.MolecularFormationEnergyExtension
open SFT.Foundation.ExactOperations
open SFT.Host SFT.Physics SFT.Physics.BoundaryGrowth SFT.Physics.VacuumLedgerProofs
open SFT.Chemistry.DihedralTorsion SFT.Chemistry.MolecularFormationEnergy
open SFT.Chemistry.IntermolecularBinding SFT.Chemistry.IntermolecularBindingExtension
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- A successful source binding Take supplies the same separation in the
-- formation relation. The original strict-order guard determines its label.
private theorem bindingAbove (p r magnitude : Ratio)
 (taken : exactBindingTake (.ratio p) (.ratio r)=.ok magnitude) :
 exactFormationStateRelation (.ratio p) (.ratio r)=.ok ⟨aboveOrientation,.ratio magnitude⟩ := by
 by_cases order : (fraction r).numerator*(fraction p).denominator <
   (fraction p).numerator*(fraction r).denominator
 · rw [bindingTakeExact p r order] at taken
   cases Except.ok.inj taken
   exact productAbove p r order
 · unfold exactBindingTake barrierTake at taken
   dsimp only at taken
   rw [dif_neg order] at taken
   cases taken
private theorem bindingBelow (p r magnitude : Ratio)
 (taken : exactBindingTake (.ratio r) (.ratio p)=.ok magnitude) :
 exactFormationStateRelation (.ratio p) (.ratio r)=.ok ⟨belowOrientation,.ratio magnitude⟩ := by
 by_cases order : (fraction p).numerator*(fraction r).denominator <
   (fraction r).numerator*(fraction p).denominator
 · rw [bindingTakeExact r p order] at taken
   cases Except.ok.inj taken
   exact productBelow p r order
 · unfold exactBindingTake barrierTake at taken
   dsimp only at taken
   rw [dif_neg order] at taken
   cases taken
-- Equality of reduced fractions follows from the existing exact ratio theorem.
private theorem sameFractions (p r : Ratio)
 (cross : (fraction p).numerator*(fraction r).denominator=
  (fraction r).numerator*(fraction p).denominator) : fraction p=fraction r := by
 have ext (a b : PositiveFraction) (hn : a.numerator=b.numerator) (hd : a.denominator=b.denominator) : a=b := by
  cases a
  cases b
  dsimp only at hn hd
  cases hn
  cases hd
  rfl
 let a := fraction p
 let b := fraction r
 have asRat (v : PositiveFraction) : asFraction v=natRatio v.numerator v.denominator
   (Nat.pos_of_ne_zero v.denominatorNonzero) := by
  have normalized : normalizePositive v.numerator v.denominator v.positive
    (Nat.pos_of_ne_zero v.denominatorNonzero)=v := by

   apply ext
   · change v.numerator/Nat.gcd v.numerator v.denominator=v.numerator
     rw [v.reduced,divisionOne]
   · change v.denominator/Nat.gcd v.numerator v.denominator=v.denominator
     rw [v.reduced,divisionOne]
  rw [← CommonScaleAxis.normalizedPositiveAsRat v.numerator v.denominator v.positive]
  exact congrArg asFraction normalized.symm
 have equalRat : asFraction a=asFraction b := by
  rw [asRat,asRat]
  exact natRatioCongruence _ _ _ _ _ _ cross
 have numerator := Int.ofNat.inj (congrArg Rat.num equalRat)
 have denominator := congrArg Rat.den equalRat
 exact ext a b numerator denominator

theorem sharedAbove (p r x : Ratio)
 (above : (fraction r).numerator*(fraction p).denominator <
   (fraction p).numerator*(fraction r).denominator) :
 sharedStateExtensionPreservesFormationRelation (.ratio p) (.ratio r) (.ratio x)=.ok true := by
 let ep := rawRatio (AlphaRatio.add (fraction p) (fraction x))
 let er := rawRatio (AlphaRatio.add (fraction r) (fraction x))
 have retained := everySharedConstituentPreservesBinding p r x above
 unfold appendSharedConstituentPreservesBinding at retained
 rw [bindingTakeExact p r above] at retained
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at retained
 cases extended : exactBindingTake (.ratio ep) (.ratio er) with
 | error e =>
  rw [extended] at retained
  cases retained
 | ok value =>
  rw [extended] at retained
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at retained
  unfold sharedStateExtensionPreservesFormationRelation
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
  rw [productAbove p r above]
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
  rw [bindingAbove ep er value extended]
  exact retained

theorem sharedBelow (p r x : Ratio)
 (below : (fraction p).numerator*(fraction r).denominator <
   (fraction r).numerator*(fraction p).denominator) :
 sharedStateExtensionPreservesFormationRelation (.ratio p) (.ratio r) (.ratio x)=.ok true := by
 let ep := rawRatio (AlphaRatio.add (fraction p) (fraction x))
 let er := rawRatio (AlphaRatio.add (fraction r) (fraction x))
 have retained := everySharedConstituentPreservesBinding r p x below
 unfold appendSharedConstituentPreservesBinding at retained
 rw [bindingTakeExact r p below] at retained
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at retained
 cases extended : exactBindingTake (.ratio er) (.ratio ep) with
 | error e =>
  rw [extended] at retained
  cases retained
 | ok value =>
  rw [extended] at retained
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at retained
  unfold sharedStateExtensionPreservesFormationRelation
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
  rw [productBelow p r below]
  dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
  rw [bindingBelow ep er value extended]
  exact retained

theorem sharedEqual (p r x : Ratio)
 (same : (fraction p).numerator*(fraction r).denominator=
  (fraction r).numerator*(fraction p).denominator) :
 sharedStateExtensionPreservesFormationRelation (.ratio p) (.ratio r) (.ratio x)=.ok true := by
 have equal := sameFractions p r same
 unfold sharedStateExtensionPreservesFormationRelation
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 rw [equalStates p r same]
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 rw [equal,equalStates _ _ rfl]
 rfl

theorem everySharedStatePreservesFormationRelation (p r x : Ratio) :
 sharedStateExtensionPreservesFormationRelation (.ratio p) (.ratio r) (.ratio x)=.ok true := by
 cases Nat.lt_trichotomy ((fraction p).numerator*(fraction r).denominator)
  ((fraction r).numerator*(fraction p).denominator) with
 | inl below => exact sharedBelow p r x below
 | inr rest => cases rest with
  | inl same => exact sharedEqual p r x same
  | inr above => exact sharedAbove p r x above

theorem repetitionAbove (p r : Ratio) (k : CapabilityValues.PositiveCount)
 (above : (fraction r).numerator*(fraction p).denominator <
   (fraction p).numerator*(fraction r).denominator) :
 repeatedFormationRelation (.ratio p) (.ratio r) (.count k)=
 .ok ⟨aboveOrientation,.ratio (rawRatio (BoundaryGrowth.multiply
  (LeptonTake.heldRemainder (fraction p) (fraction r) above) (AlphaRatio.whole k.value k.positive)))⟩ := by
 have retained := everyPositiveRepetitionScalesBinding p r k above
 unfold repeatedUnitBinding at retained
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at retained
 unfold repeatedFormationRelation
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 exact bindingAbove _ _ _ retained

theorem repetitionBelow (p r : Ratio) (k : CapabilityValues.PositiveCount)
 (below : (fraction p).numerator*(fraction r).denominator <
   (fraction r).numerator*(fraction p).denominator) :
 repeatedFormationRelation (.ratio p) (.ratio r) (.count k)=
 .ok ⟨belowOrientation,.ratio (rawRatio (BoundaryGrowth.multiply
  (LeptonTake.heldRemainder (fraction r) (fraction p) below) (AlphaRatio.whole k.value k.positive)))⟩ := by
 have retained := everyPositiveRepetitionScalesBinding r p k below
 unfold repeatedUnitBinding at retained
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure] at retained
 unfold repeatedFormationRelation
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 exact bindingBelow _ _ _ retained

theorem repetitionEqual (p r : Ratio) (k : CapabilityValues.PositiveCount)
 (same : (fraction p).numerator*(fraction r).denominator=
  (fraction r).numerator*(fraction p).denominator) :
 repeatedFormationRelation (.ratio p) (.ratio r) (.count k)=.ok ⟨equalOrientation,.emptyOne⟩ := by
 have equal := sameFractions p r same
 unfold repeatedFormationRelation
 dsimp only [Bind.bind,Pure.pure,Except.bind,Except.pure]
 rw [equal]
 exact equalStates _ _ rfl
end SFT.Chemistry.MolecularFormationEnergyExtension
