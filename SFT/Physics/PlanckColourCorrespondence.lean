import SFT.Physics.PlanckHierarchy
import SFT.Physics.ColourCouplingDerivation
namespace SFT.Physics.PlanckColourCorrespondence

theorem existingShareIsForcedCoupling :
    PlanckHierarchy.colourShare = ColourCouplingDerivation.colourCoupling := by
  rw [ColourCouplingDerivation.forcedFromFoldAndGenerator]
  rfl

theorem existingShareRetainsBothLabelsOverGenerator :
    PlanckHierarchy.colourShare.map (fun p => (p.numerator,p.denominator)) = .ok (2,3) := by
  rw [existingShareIsForcedCoupling,ColourCouplingDerivation.forcedFromFoldAndGenerator]
  rfl
end SFT.Physics.PlanckColourCorrespondence
