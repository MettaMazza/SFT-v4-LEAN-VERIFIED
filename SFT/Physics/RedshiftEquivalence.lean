import SFT.Physics.StaticFoldClock
import SFT.Physics.GravitySourceProofs
namespace SFT.Physics.RedshiftEquivalence
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations LeptonIntervals
structure Result where
 gravitationalRedshift : Rat
 acceleratedDoppler : Rat

def redshiftEquivalence : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String Result
 | .nonFraction,_ | _,.nonFraction => .error "equivalence carriers must be exact"
 | .fraction acceleration,.fraction height => do
  if !zero.blt acceleration || !zero.blt height then
   throw "equivalence carriers must be positive"
  let gravitational := multiply acceleration height
  let acquiredSpeed := multiply acceleration height
  let doppler := acquiredSpeed
  if !gravitational.blt doppler && !doppler.blt gravitational then
   pure ⟨gravitational,doppler⟩
  else throw "gravity and accelerated redshift traces differ"

theorem originalRecord : redshiftEquivalence (.fraction ⟨1,4,by decide,by decide⟩) (.fraction ⟨1,1,by decide,by decide⟩)=
 .ok ⟨⟨1,4,by decide,by decide⟩,⟨1,4,by decide,by decide⟩⟩ := rfl

theorem allPositiveCarriers (acceleration height : PositiveFraction) :
 redshiftEquivalence (.fraction (BoundaryGrowth.asFraction acceleration)) (.fraction (BoundaryGrowth.asFraction height))=
 .ok ⟨BoundaryGrowth.asFraction (BoundaryGrowth.multiply acceleration height),BoundaryGrowth.asFraction (BoundaryGrowth.multiply acceleration height)⟩ := by
 have ap : zero.blt (BoundaryGrowth.asFraction acceleration)=true := by
  rw [VacuumScaleProofs.positiveCarrierRepresentation]
  exact VacuumScaleProofs.positiveNormalized _ _ acceleration.positive _
 have hp : zero.blt (BoundaryGrowth.asFraction height)=true := by
  rw [VacuumScaleProofs.positiveCarrierRepresentation]
  exact VacuumScaleProofs.positiveNormalized _ _ height.positive _
 unfold redshiftEquivalence
 dsimp only
 rw [ap,hp]
 rw [GravitySourceProofs.sourceProduct,MagneticCovariance.positiveNotLessSelf]
 rfl

theorem everyReturnedEquality (a h : FoldFirstReturn.Input) (record : Result)
 (returned : redshiftEquivalence a h=.ok record) : record.gravitationalRedshift=record.acceleratedDoppler := by
 cases a with
 | nonFraction => cases returned
 | fraction acceleration =>
  cases h with
  | nonFraction => cases returned
  | fraction height =>
   unfold redshiftEquivalence at returned
   dsimp only at returned
   split at returned
   · cases returned
   · split at returned
     · cases returned;rfl
     · cases returned
end SFT.Physics.RedshiftEquivalence
