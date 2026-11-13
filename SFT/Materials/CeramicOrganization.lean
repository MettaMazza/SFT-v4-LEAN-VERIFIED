import SFT.Chemistry.IonicPairing
import SFT.Chemistry.CovalentSharing
import SFT.Chemistry.ChemicalPhase
import SFT.Materials.MaterialCarrier
import SFT.Materials.GrainBoundary
namespace SFT.Materials.CeramicOrganization
open SFT.Chemistry

inductive LocalJoin (Carrier : Type) where
 | ionic : IonicPairing.Pair → LocalJoin Carrier
 | covalent : CovalentSharing.Shared Carrier → LocalJoin Carrier

def endpoints {Carrier : Type} : LocalJoin Carrier → String × String
 | .ionic p => (p.left.occurrence,p.right.occurrence)
 | .covalent p => (p.leftNucleus,p.rightNucleus)

def kind {Carrier : Type} : LocalJoin Carrier → String
 | .ionic _ => "ionic"
 | .covalent _ => "covalent"

def bondRow {Carrier : Type} (j : LocalJoin Carrier) := ((endpoints j).1,(endpoints j).2,kind j)

structure Record (Carrier : Type) where
 material : MaterialCarrier.Record Carrier
 inorganicNonmetallicSource : SFT.Host.Canonical.Value
 joins : List (LocalJoin Carrier)
 completeBonding : material.bonding = joins.map bondRow
 phase : ChemicalPhase.Boundary
 grains : List GrainBoundary.Carrier
 support : List String
 solid : List String
 pores : List String
 completePartition : ∀ x, x ∈ support ↔ x ∈ solid ∨ x ∈ pores
 disjoint : ∀ x, x ∈ solid → x ∈ pores → False
 phaseSupport : phase.graph.nodes = support
 grainSupport : ∀ g, g ∈ grains → ∀ x, x ∈ g.lattice.cells.graph.nodes → x ∈ solid
 joinSupport : ∀ j, j ∈ joins → (endpoints j).1 ∈ solid ∧ (endpoints j).2 ∈ solid
 processingConditions : SFT.Host.Canonical.Value

variable {Carrier : Type}

theorem ionicLocalClosure (p : IonicPairing.Pair) :
 SFT.Physics.FieldElectricDistinction.interaction (IonicPairing.physicalCharge p.left) (IonicPairing.physicalCharge p.right) = .oppositeHeld :=
 IonicPairing.opposedInteraction p

theorem covalentSameCarrier (p : CovalentSharing.Shared Carrier) :
 CovalentSharing.access p .left = CovalentSharing.access p .right := CovalentSharing.oneCarrierBothCentres p

theorem covalentDistinctCentres (p : CovalentSharing.Shared Carrier) :
 (endpoints (.covalent p)).1 ≠ (endpoints (.covalent p)).2 := p.distinctNuclei

theorem allBondsAccounted (r : Record Carrier) : r.material.bonding = r.joins.map bondRow := r.completeBonding

theorem noThirdJoiningRule (j : LocalJoin Carrier) :
 (∃ p, j = .ionic p) ∨ (∃ p, j = .covalent p) := by
 cases j with
 | ionic p => exact .inl ⟨p,rfl⟩
 | covalent p => exact .inr ⟨p,rfl⟩

theorem poreIsRetainedSupport (r : Record Carrier) (x : String) (held : x ∈ r.pores) : x ∈ r.support :=
 (r.completePartition x).mpr (.inr held)

theorem poreDistinctFromSolid (r : Record Carrier) (x : String) (held : x ∈ r.pores) : x ∉ r.solid :=
 fun solid => r.disjoint x solid held

theorem grainOrientationRetained (g : GrainBoundary.Carrier) (a b c : String)
 (left : GrainBoundary.grain g a b) (right : GrainBoundary.grain g a c) :
 g.orientation b = g.orientation c := GrainBoundary.grainCoherent left right

theorem phaseMemberInBulk (r : Record Carrier) (root x : String) (held : ChemicalPhase.InPhase r.phase root x) : x ∈ r.support := by
 have h := (ChemicalPhase.homogeneousMember r.phase root x held).1
 rw [r.phaseSupport] at h
 exact h

theorem grainMemberSolid (r : Record Carrier) (g : GrainBoundary.Carrier) (listed : g ∈ r.grains)
 (root x : String) (held : GrainBoundary.grain g root x) : x ∈ r.solid :=
 r.grainSupport g listed x (GrainBoundary.joinedHeld held).2

def interfaces (r : Record Carrier) := r.grains.map (fun g => (g,GrainBoundary.boundaryEdges g))

theorem allGrainsRetained (r : Record Carrier) : (interfaces r).map Prod.fst = r.grains := by
 unfold interfaces
 generalize r.grains = gs
 induction gs with
 | nil => rfl
 | cons g gs ih => exact congrArg (List.cons g) ih

def record (r : Record Carrier) := (r,r.joins.map bondRow,interfaces r)

theorem completeInputRetained (r : Record Carrier) : (record r).1 = r := rfl

def records (rs : List (Record Carrier)) := rs.map record

theorem base (r : Record Carrier) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Carrier)) (r : Record Carrier) : records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.CeramicOrganization
