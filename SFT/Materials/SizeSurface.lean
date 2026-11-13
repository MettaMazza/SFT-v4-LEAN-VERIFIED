import SFT.Physics.CollectiveCoarseGrain
import SFT.Mathematics.ExactRatioRelations
namespace SFT.Materials.SizeSurface
open SFT.Physics SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations

-- MATERIALS_OBLIGATIONS[67]: the ratio is calculated from retained support;
-- absent support is recorded without introducing a scalar correction.
structure Record (Transfer Mechanical : Type) where
 network : CollectiveCoarseGrain.NetworkObservation
 boundary : List String
 interior : List String
 completePartition : ∀ x, x ∈ network.graph.nodes ↔ x ∈ boundary ∨ x ∈ interior
 disjoint : ∀ x, x ∈ boundary → x ∈ interior → False
 accessibleStates : List String
 statesHeld : ∀ x ∈ accessibleStates, x ∈ network.graph.nodes
 transfers : MechanicalConservation.Network String Transfer
 transferHeld : ∀ t ∈ transfers, t.source ∈ network.graph.nodes ∧ t.destination ∈ network.graph.nodes
 mechanics : List Mechanical
 surfaceStates : SFT.Host.Canonical.Value
 curvature : SFT.Host.Canonical.Value
 sizeShapeBoundary : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {Transfer Mechanical : Type}

def supportRelation (r : Record Transfer Mechanical) := (r.boundary,r.interior)
def observedCensus (r : Record Transfer Mechanical) := (r.accessibleStates,r.transfers,r.mechanics)

def supportRatio (r : Record Transfer Mechanical) : Option PositiveFraction :=
 if hb : 0 < r.boundary.length then
  if hi : 0 < r.interior.length then some (ratio r.boundary.length r.interior.length hb hi)
  else none
 else none

def sizeEffect (a b : Record Transfer Mechanical) : Prop :=
 supportRelation a ≠ supportRelation b ∧ observedCensus a ≠ observedCensus b

theorem exactPositiveRatio (r : Record Transfer Mechanical)
 (hb : 0 < r.boundary.length) (hi : 0 < r.interior.length) :
 supportRatio r = some (ratio r.boundary.length r.interior.length hb hi) := by
 unfold supportRatio
 rw [dif_pos hb,dif_pos hi]

theorem ratioFromCounts (r : Record Transfer Mechanical)
 (hb : 0 < r.boundary.length) (hi : 0 < r.interior.length) :
 r.boundary.length * (ratio r.boundary.length r.interior.length hb hi).denominator =
 (ratio r.boundary.length r.interior.length hb hi).numerator * r.interior.length :=
 ratioValue _ _ hb hi

theorem absentBoundary (r : Record Transfer Mechanical) (empty : r.boundary = []) : supportRatio r = none := by
 unfold supportRatio
 have no : ¬ 0 < r.boundary.length := by rw [empty]; exact Nat.not_lt_zero 0
 rw [dif_neg no]

theorem absentInterior (r : Record Transfer Mechanical) (empty : r.interior = []) : supportRatio r = none := by
 unfold supportRatio
 split
 · have no : ¬ 0 < r.interior.length := by rw [empty]; exact Nat.not_lt_zero 0
   rw [dif_neg no]
 · rfl

theorem boundaryInMaterial (r : Record Transfer Mechanical) (x : String) (held : x ∈ r.boundary) :
 x ∈ r.network.graph.nodes := (r.completePartition x).mpr (.inl held)

theorem interiorInMaterial (r : Record Transfer Mechanical) (x : String) (held : x ∈ r.interior) :
 x ∈ r.network.graph.nodes := (r.completePartition x).mpr (.inr held)

theorem boundaryNotInterior (r : Record Transfer Mechanical) (x : String) (held : x ∈ r.boundary) :
 x ∉ r.interior := r.disjoint x held

theorem completeTransferBalance (r : Record Transfer Mechanical) :
 MechanicalConservation.outgoingSupport r.transfers = MechanicalConservation.incomingSupport r.transfers :=
 MechanicalConservation.completeConservation _

theorem unchangedSupportNoSizeEffect (a b : Record Transfer Mechanical)
 (same : supportRelation a = supportRelation b) : ¬ sizeEffect a b := fun effect => effect.1 same

theorem unchangedCensusNoSizeEffect (a b : Record Transfer Mechanical)
 (same : observedCensus a = observedCensus b) : ¬ sizeEffect a b := fun effect => effect.2 same

def record (r : Record Transfer Mechanical) := (r,supportRatio r,observedCensus r)

theorem wholeInputRetained (r : Record Transfer Mechanical) : (record r).1 = r := rfl

theorem surfaceAndShapeRetained (r : Record Transfer Mechanical) :
 (record r).1.surfaceStates = r.surfaceStates ∧ (record r).1.curvature = r.curvature ∧
 (record r).1.sizeShapeBoundary = r.sizeShapeBoundary := ⟨rfl,rfl,rfl⟩

def records (rs : List (Record Transfer Mechanical)) := rs.map record

theorem base (r : Record Transfer Mechanical) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Transfer Mechanical)) (r : Record Transfer Mechanical) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.SizeSurface
