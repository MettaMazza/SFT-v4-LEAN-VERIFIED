import SFT.Physics.CausalInterval
import SFT.Physics.MagneticCovariance
namespace SFT.Physics.StaticFoldClock
open SFT.Foundation ExactOperations ExactPartCarrier
open LeptonIntervals
inductive Result where
 | horizon
 | accessible (metricSquare foldedMetric : Rat)

def staticClock : FoldFirstReturn.Input → Except String Result
 | .nonFraction => .error "well depth must be an exact positive part"
 | .fraction well => do
  if !(zero.blt well && !(asFraction one).blt well) then
   throw "well depth must be an exact positive part"
  let metric ← GravityFlux.positiveTake (.fraction (asFraction one)) (.fraction well)
  match metric with
  | none => pure .horizon
  | some metric =>
   let metricPart ← fromPair metric.num (.ofNat metric.den)
   let wellPart ← fromPair well.num (.ofNat well.den)
   let folded := asFraction (foldPart metricPart)
   let complement ← GravityFlux.positiveTake (.fraction (asFraction one)) (.fraction (asFraction (foldPart wellPart)))
   match complement with
   | none => .error "static clock failed Fold covariance"
   | some complement =>
    if !folded.blt complement && !complement.blt folded then pure (.accessible metric folded)
    else throw "static clock failed Fold covariance"

def exactClockRate : Except String Rat := do
 let record ← staticClock (.fraction ⟨7,16,by decide,by decide⟩)
 let rate : Rat := ⟨3,4,by decide,by decide⟩
 match record with
 | .horizon => .error "clock rate did not square to the exact metric carrier"
 | .accessible metric _ =>
  let square := multiply rate rate
  if !metric.blt square && !square.blt metric then pure rate
  else throw "clock rate did not square to the exact metric carrier"

theorem originalCovariance : staticClock (.fraction ⟨1,8,by decide,by decide⟩)=
 .ok (.accessible ⟨7,8,by decide,by decide⟩ ⟨3,4,by decide,by decide⟩) := rfl

theorem originalMetric : staticClock (.fraction ⟨7,16,by decide,by decide⟩)=
 .ok (.accessible ⟨9,16,by decide,by decide⟩ ⟨1,8,by decide,by decide⟩) := rfl

theorem originalRate : exactClockRate=.ok ⟨3,4,by decide,by decide⟩ := rfl

theorem originalHorizon : staticClock (.fraction ⟨1,1,by decide,by decide⟩)=.ok .horizon := rfl

theorem originalHalfBoundary : staticClock (.fraction ⟨1,2,by decide,by decide⟩)=
 .error "static clock failed Fold covariance" := rfl

theorem exactRateSquare : multiply (⟨3,4,by decide,by decide⟩ : Rat) ⟨3,4,by decide,by decide⟩=⟨9,16,by decide,by decide⟩ := rfl

theorem generatedFoldCovariance (n d : Nat) (positive : 0<n) (proper : n<d) (notHalf : n+n≠d) :
 asFraction (foldPart (normalizePart (d-n) d (ExactCast.subtractPositive d n proper) (Nat.sub_le d n)))=
 subtract (asFraction one) (asFraction (foldPart (normalizePart n d positive (Nat.le_of_lt proper)))) :=
 MagneticCovariance.foldComplement n d positive proper notHalf

theorem everyReturnedMetric (well metric folded : Rat)
 (returned : staticClock (.fraction well)=.ok (.accessible metric folded)) :
 GravityFlux.positiveTake (.fraction (asFraction one)) (.fraction well)=.ok (some metric) := by
 unfold staticClock at returned
 dsimp only at returned
 split at returned
 · cases returned
 · generalize h : GravityFlux.positiveTake (.fraction (asFraction one)) (.fraction well)=taken at returned ⊢
   cases taken with
   | error message => cases returned
   | ok value =>
    cases value with
    | none => cases returned
    | some value =>
     dsimp only [Except.bind,Bind.bind] at returned
     generalize fromPair value.num (.ofNat value.den)=mp at returned
     cases mp with
     | error message => cases returned
     | ok mp =>
      dsimp only [Except.bind,Bind.bind] at returned
      generalize fromPair well.num (.ofNat well.den)=wp at returned
      cases wp with
      | error message => cases returned
      | ok wp =>
       dsimp only [Except.bind,Bind.bind] at returned
       generalize GravityFlux.positiveTake (.fraction (asFraction one)) (.fraction (asFraction (foldPart wp)))=cp at returned
       cases cp with
       | error message => cases returned
       | ok cp =>
        cases cp with
        | none => cases returned
        | some cp =>
         dsimp only [Except.bind,Bind.bind] at returned
         split at returned
         · cases returned;rfl
         · cases returned
end SFT.Physics.StaticFoldClock
