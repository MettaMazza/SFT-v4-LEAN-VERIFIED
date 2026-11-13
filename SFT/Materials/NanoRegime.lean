import SFT.Materials.SizeSurface
import SFT.InformationScience.EntropyRefinement
namespace SFT.Materials.NanoRegime
open SFT.Mathematics.AlgebraOperations
open SFT.Physics SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityObservations SFT.Foundation.Count.TraceDerivation

-- FUNC-NANOMATERIAL: compare the bulk image with the retained finite census.
-- The boundary/interior and accessible-state memberships are actual source
-- records; no numerical size threshold is introduced.
structure Record (Transfer Mechanical : Type) where
 material : SizeSurface.Record Transfer Mechanical
 bulk : Observation
 bulkClasses : Partition
 bulkComputed : SFT.InformationScience.EntropyPartition.exactPartition material.network.graph.nodes bulk = .ok bulkClasses
 resolution : SFT.Host.Canonical.Value

variable {Transfer Mechanical : Type}

def census (r : Record Transfer Mechanical) (cell : String) :=
 (has r.material.boundary cell,has r.material.interior cell,
  has r.material.accessibleStates cell,image r.material.network.observation cell)

def bulkCloses (r : Record Transfer Mechanical) : Bool :=
 r.material.network.graph.nodes.all (fun a => r.material.network.graph.nodes.all
  (fun b => decide (image r.bulk a ≠ image r.bulk b ∨ census r a = census r b)))

def nanoscaleBoundary (r : Record Transfer Mechanical) : Bool := !(bulkCloses r)

theorem closureExactly (r : Record Transfer Mechanical) : bulkCloses r = true ↔
 ∀ a, a ∈ r.material.network.graph.nodes → ∀ b, b ∈ r.material.network.graph.nodes →
 image r.bulk a = image r.bulk b → census r a = census r b := by
 constructor
 · intro h a ha b hb same
   have inner := allTrueAtMember _ _ h a ha
   have pair := of_decide_eq_true (allTrueAtMember _ _ inner b hb)
   cases pair with
   | inl different => exact False.elim (different same)
   | inr equal => exact equal
 · intro h
   apply (allTrueIffMembers _ _).mpr
   intro a ha
   apply (allTrueIffMembers _ _).mpr
   intro b hb
   apply decide_eq_true
   by_cases same : image r.bulk a = image r.bulk b
   · exact Or.inr (h a ha b hb same)
   · exact Or.inl same

theorem nanoscaleExactly (r : Record Transfer Mechanical) : nanoscaleBoundary r = true ↔
 ¬ (∀ a, a ∈ r.material.network.graph.nodes → ∀ b, b ∈ r.material.network.graph.nodes →
 image r.bulk a = image r.bulk b → census r a = census r b) := by
 constructor
 · intro active closed
   have pass := (closureExactly r).mpr closed
   unfold nanoscaleBoundary at active
   rw [pass] at active
   cases active
 · intro notClosed
   unfold nanoscaleBoundary
   cases result : bulkCloses r with
   | false => rfl
   | true => exact False.elim (notClosed ((closureExactly r).mp result))

theorem retainedDistinctionRejectsBulk (r : Record Transfer Mechanical) (a b : String)
 (ha : a ∈ r.material.network.graph.nodes) (hb : b ∈ r.material.network.graph.nodes)
 (same : image r.bulk a = image r.bulk b) (different : census r a ≠ census r b) :
 bulkCloses r = false := by
 cases result : bulkCloses r with
 | false => rfl
 | true => exact False.elim (different ((closureExactly r).mp result a ha b hb same))

theorem retainedDistinctionAdmitsBoundary (r : Record Transfer Mechanical) (a b : String)
 (ha : a ∈ r.material.network.graph.nodes) (hb : b ∈ r.material.network.graph.nodes)
 (same : image r.bulk a = image r.bulk b) (different : census r a ≠ census r b) :
 nanoscaleBoundary r = true := by
 unfold nanoscaleBoundary
 rw [retainedDistinctionRejectsBulk r a b ha hb same different]
 rfl

theorem boundaryInteriorDistinguished (r : Record Transfer Mechanical) (a b : String)
 (ha : a ∈ r.material.boundary) (hb : b ∈ r.material.interior) : census r a ≠ census r b := by
 intro same
 have equal := congrArg Prod.fst same
 change has r.material.boundary a = has r.material.boundary b at equal
 have left := (hasIff _ _).mpr ha
 have right : has r.material.boundary b = true := equal ▸ left
 exact r.material.disjoint b ((hasIff _ _).mp right) hb

theorem collapsedBoundaryInteriorAdmitted (r : Record Transfer Mechanical) (a b : String)
 (ha : a ∈ r.material.boundary) (hb : b ∈ r.material.interior)
 (same : image r.bulk a = image r.bulk b) : nanoscaleBoundary r = true :=
 retainedDistinctionAdmitsBoundary r a b (SizeSurface.boundaryInMaterial _ _ ha)
  (SizeSurface.interiorInMaterial _ _ hb) same (boundaryInteriorDistinguished r a b ha hb)

theorem propertyDistinctionRetained (r : Record Transfer Mechanical) (a b : String)
 (different : image r.material.network.observation a ≠ image r.material.network.observation b) :
 census r a ≠ census r b := fun same => different (congrArg (fun x => x.2.2.2) same)

theorem bulkCannotReconstruct (r : Record Transfer Mechanical) (a b : String)
 (same : image r.bulk a = image r.bulk b) (different : census r a ≠ census r b)
 (recover : Option String → Bool × Bool × Bool × Option String)
 (left : recover (image r.bulk a) = census r a)
 (right : recover (image r.bulk b) = census r b) : False :=
 different (left.symm.trans ((congrArg recover same).trans right))

theorem exactSupportRatio (r : Record Transfer Mechanical)
 (hb : 0 < r.material.boundary.length) (hi : 0 < r.material.interior.length) :
 SizeSurface.supportRatio r.material = some (SFT.Mathematics.ExactRatioRelations.ratio r.material.boundary.length r.material.interior.length hb hi) :=
 SizeSurface.exactPositiveRatio _ hb hi

theorem completeTransferConservation (r : Record Transfer Mechanical) :
 MechanicalConservation.outgoingSupport r.material.transfers = MechanicalConservation.incomingSupport r.material.transfers :=
 SizeSurface.completeTransferBalance _

def censusRows (r : Record Transfer Mechanical) := r.material.network.graph.nodes.map (fun cell => (cell,census r cell))

theorem everyCellRecorded (r : Record Transfer Mechanical) :
 (censusRows r).map Prod.fst = r.material.network.graph.nodes := by
 unfold censusRows
 generalize r.material.network.graph.nodes = nodes
 induction nodes with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons h) ih

def record (r : Record Transfer Mechanical) := (r,SizeSurface.record r.material,censusRows r,bulkCloses r,nanoscaleBoundary r)

theorem completeInputRetained (r : Record Transfer Mechanical) : (record r).1 = r := rfl

def records (rs : List (Record Transfer Mechanical)) := rs.map record

theorem base (r : Record Transfer Mechanical) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Transfer Mechanical)) (r : Record Transfer Mechanical) :
 records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.NanoRegime
