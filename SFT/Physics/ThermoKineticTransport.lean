import SFT.Physics.ThermoPhaseEquilibrium
import SFT.Physics.FieldLocality
import SFT.Mathematics.CombinatorialArrangements
namespace SFT.Physics.ThermoKineticTransport
open MechanicalConservation MechanicalEvents FieldLocality
variable {State Carrier : Type} {adjacent : Event State → Event State → Prop}

structure Transport (adjacent : Event State → Event State → Prop) (Carrier : Type) where
 transfer : Transfer (Event State) Carrier
 path : Propagation adjacent transfer.source transfer.destination

theorem allStepsAdjacent (t : Transport adjacent Carrier) :
 ∀ row ∈ changes (trace t.path), adjacent row.before row.after := everyTransitionAdjacent t.path

theorem nontrivialArrivalHasPredecessor (t : Transport adjacent Carrier)
 (different : t.transfer.source ≠ t.transfer.destination) : ∃ prior, adjacent prior t.transfer.destination :=
 nonInitialHasPredecessor t.path different

def transferLedger (ts : List (Transport adjacent Carrier)) := ts.map Transport.transfer

theorem allTransportCarriersConserved (ts : List (Transport adjacent Carrier)) :
 outgoingSupport (transferLedger ts) = incomingSupport (transferLedger ts) := completeConservation _

theorem transportRetainsEveryRecord (ts : List (Transport adjacent Carrier)) :
 outgoingSupport (transferLedger ts) = (transferLedger ts).map Transfer.carrier := eachDepartureRetainsCarrier _

-- Collision mixing permutes complete local records, including their carriers,
-- source identities and action records. Repeated equal carriers stay distinct
-- through their retained occurrences in the record list.
structure Collision (Node Carrier : Type) where
 cell : Node
 before : List (Transfer Node Carrier)
 after : List (Transfer Node Carrier)
 localBefore : ∀ row, row ∈ before → row.source = cell ∧ row.destination = cell
 permutation : List.Perm after before

variable {Node : Type}

theorem permutationMembership {A : Type} {xs ys : List A} (p : List.Perm xs ys) :
 ∀ x, x ∈ xs ↔ x ∈ ys := by
 induction p with
 | nil => intro x; exact ⟨fun h => h,fun h => h⟩
 | cons a p ih =>
   intro x; constructor
   · intro h; cases h with
     | head => exact List.Mem.head _
     | tail _ h => exact List.Mem.tail _ ((ih x).mp h)
   · intro h; cases h with
     | head => exact List.Mem.head _
     | tail _ h => exact List.Mem.tail _ ((ih x).mpr h)
 | swap a b rest =>
   intro x; constructor <;> intro h <;> cases h with
   | head => exact List.Mem.tail _ (List.Mem.head _)
   | tail _ h => cases h with
     | head => exact List.Mem.head _
     | tail _ h => exact List.Mem.tail _ (List.Mem.tail _ h)
 | trans p q ih jq => intro x; exact ⟨fun h => (jq x).mp ((ih x).mp h),fun h => (ih x).mpr ((jq x).mpr h)⟩

theorem permutationLength {A : Type} {xs ys : List A} (p : List.Perm xs ys) : xs.length = ys.length := by
 induction p with
 | nil => rfl
 | cons a p ih => exact congrArg Nat.succ ih
 | swap a b rest => rfl
 | trans p q ih jq => exact ih.trans jq

theorem collisionRetainsEveryRecord (c : Collision Node Carrier) (row : Transfer Node Carrier) :
 row ∈ c.after ↔ row ∈ c.before := permutationMembership c.permutation row

theorem collisionRemainsLocal (c : Collision Node Carrier) (row : Transfer Node Carrier) (h : row ∈ c.after) :
 row.source = c.cell ∧ row.destination = c.cell := c.localBefore row ((collisionRetainsEveryRecord c row).mp h)

theorem collisionCountConserved (c : Collision Node Carrier) : c.after.length = c.before.length :=
 permutationLength c.permutation

theorem collisionBoundaryClosed (c : Collision Node Carrier) :
 outgoingSupport c.after = incomingSupport c.after := completeConservation _

abbrev generatedCollisionPermutations := SFT.Mathematics.CombinatorialArrangements.everyArrangementPermutesCarrier
abbrev closedObservationRetainsEnergy := @ThermoHeatWork.completeEnergyProvenance
abbrev closedLabelCannotBeReconstructed := @ThermoHeatWork.closedLabelNotReconstructible
abbrev successorRetainsPriorTransfers := @MechanicalConservation.appendRetainsPrior
abbrev joinedPropagationRetainsTrace := @FieldLocality.joinTrace
end SFT.Physics.ThermoKineticTransport
