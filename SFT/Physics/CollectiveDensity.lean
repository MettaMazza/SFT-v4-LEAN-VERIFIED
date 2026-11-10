import SFT.Physics.CollectiveCoarseGrain
namespace SFT.Physics.CollectiveDensity
open CollectiveCoarseGrain
open SFT.Foundation.ExactOperations
open SFT.InformationScience.EntropyLedger

-- The declared region is the complete generated observation fibre, not a
-- separately chosen denominator. Content is its retained positive carrier.
structure RegionContent (network : NetworkObservation) where
 label : String
 members : List String
 present : (label,members) ∈ network.classes
 content : PositiveFraction
 contentSource : String

variable {network : NetworkObservation}

def supportCount (r : RegionContent network) := r.members.length

theorem supportPositive (r : RegionContent network) : 0 < supportCount r :=
 membersPositive network.graph.nodes network.observation network.classes network.computed
 (r.label,r.members) r.present

def density (r : RegionContent network) : PositiveFraction :=
 normalizePositive r.content.numerator (r.content.denominator * supportCount r)
 r.content.positive (Nat.mul_pos (Nat.pos_of_ne_zero r.content.denominatorNonzero) (supportPositive r))

theorem exactContentOverSupport (r : RegionContent network) :
 r.content.numerator * (density r).denominator =
 (density r).numerator * (r.content.denominator * supportCount r) :=
 normalizedValuePreserved _ _ _ _

theorem densityPositive (r : RegionContent network) : 0 < (density r).numerator :=
 (density r).positive

theorem supportIsCompleteRegion (r : RegionContent network) :
 r.members = region network r.label := everyClassIsCompleteFibre network r.label r.members r.present

theorem denominatorCountsEveryRegionCell (r : RegionContent network) :
 supportCount r = (region network r.label).length := congrArg List.length (supportIsCompleteRegion r)

theorem contentAndRegionRetained (r : RegionContent network) :
 (RegionContent.mk r.label r.members r.present r.content r.contentSource : RegionContent network) = r := rfl

theorem countContentRatio (r : RegionContent network) (count : Nat)
 (numerator : r.content.numerator = count) (unitDenominator : r.content.denominator = 1) :
 count * (density r).denominator = (density r).numerator * supportCount r := by
 have h := exactContentOverSupport r
 rw [numerator,unitDenominator,Nat.one_mul] at h
 exact h

abbrev singletonSupport := CollectiveCoarseGrain.oneCellBase
abbrev successorPreservesPriorCells := CollectiveCoarseGrain.successorRetainsPaths
abbrev successorRetainsObservationFibre := CollectiveCoarseGrain.successorRetainsObservationFibre
end SFT.Physics.CollectiveDensity
