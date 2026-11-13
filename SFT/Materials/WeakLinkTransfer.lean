import SFT.Materials.PairedCarrier
import SFT.Physics.MechanicalConservation
namespace SFT.Materials.WeakLinkTransfer
open SFT.Physics SFT.QuantumComputation.ReversibleModel
open SFT.QuantumComputation.ReversiblePhase SFT.QuantumComputation.PhaseInterference

structure Link where
 transfer : MechanicalConservation.Transfer QuantumPhysicalState.Prepared
   (QuantumPhysicalIdentity.Pair MechanicalLocation.Held)
 pairedLabel : MechanicalLocation.Held
 paired : transfer.carrier = PairedCarrier.pair pairedLabel
 phaseTrace : List String
 generated : phaseAction transfer.source.state phaseTrace = .ok transfer.destination.state
 conditions : SFT.Host.Canonical.Value

def phaseDistinction (link : Link) :=
 link.phaseTrace.length % link.transfer.source.state.phaseCycle.length

theorem completePhaseTransfer (link : Link) :
 shiftBranches link.transfer.source.state.phaseCycle (phaseDistinction link)
  link.transfer.source.state.branches = some link.transfer.destination.state.branches :=
 (phaseActionSource _ _ _ link.generated).2

theorem sameCycleRetained (link : Link) :
 link.transfer.destination.state.phaseCycle = link.transfer.source.state.phaseCycle :=
 (phaseActionSource _ _ _ link.generated).1

theorem inversePhaseRecurrence (link : Link) :
 shiftBranches link.transfer.source.state.phaseCycle
  (inverseShift (phaseDistinction link) link.transfer.source.state.phaseCycle.length)
  link.transfer.destination.state.branches = some link.transfer.source.state.branches := by
 have cycle := admittedPhaseCycle link.transfer.source.state link.transfer.source.admitted
 have positive : 0 < link.transfer.source.state.phaseCycle.length :=
  Nat.lt_of_lt_of_le (by decide : 0 < 2) cycle.2.2
 exact branchPhaseInverse _ cycle.2.1 positive (phaseDistinction link)
  (Nat.mod_lt _ positive) _ _
  (admittedPhaseMember _ link.transfer.source.admitted) (completePhaseTransfer link)

theorem samePhaseDistinctionSameResult (left right : Link)
 (source : left.transfer.source.state = right.transfer.source.state)
 (distinction : phaseDistinction left = phaseDistinction right) :
 left.transfer.destination.state = right.transfer.destination.state := by
 have l := completePhaseTransfer left
 have r := completePhaseTransfer right
 rw [source,distinction] at l
 have branches := Option.some.inj (l.symm.trans r)
 have cycles := (sameCycleRetained left).trans
  ((congrArg State.phaseCycle source).trans (sameCycleRetained right).symm)
 exact (congrArg (fun b => State.mk b left.transfer.destination.state.phaseCycle) branches).trans
  (congrArg (State.mk right.transfer.destination.state.branches) cycles)

def network (links : List Link) := links.map Link.transfer

theorem pairIdentityAcrossLink (links : List Link) :
 MechanicalConservation.outgoingSupport (network links) =
 MechanicalConservation.incomingSupport (network links) :=
 MechanicalConservation.completeConservation _

theorem actualPairRetained (link : Link) :
 link.transfer.carrier.left = link.pairedLabel ∧
 link.transfer.carrier.right = MechanicalLocation.opposite link.pairedLabel := by
 rw [link.paired]
 exact ⟨rfl,rfl⟩

def record (link : Link) := (link,phaseDistinction link)
def records (links : List Link) := links.map record

theorem base (link : Link) : records [link] = [record link] := rfl

theorem successor (links : List Link) (next : Link) :
 records (links ++ [next]) = records links ++ [record next] := by
 induction links with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head)) ih

end SFT.Materials.WeakLinkTransfer
