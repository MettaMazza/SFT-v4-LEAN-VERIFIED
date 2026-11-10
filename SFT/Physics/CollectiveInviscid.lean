import SFT.Physics.CollectiveFlow
namespace SFT.Physics.CollectiveInviscid
open MechanicalConservation
open SFT.Mathematics.FoldScalar

-- V3 INVISCID distinguishes the normal pressure channel from resolved
-- tangential momentum exchange, while retaining the original records.
inductive Channel where
 | normal (pressure : CollectivePressure.ClosedMagnitude)
 | tangential (momentum : Scalar)

def normalOnly : Network String Channel → Bool
 | [] => true
 | row :: rest => match row.carrier with
   | .normal _ => normalOnly rest
   | .tangential _ => false

theorem normalOnlyIff (rows : Network String Channel) :
 normalOnly rows = true ↔ ∀ row, row ∈ rows → ∃ pressure, row.carrier = .normal pressure := by
 induction rows with
 | nil =>
   constructor
   · intro _ row h; cases h
   · intro _; rfl
 | cons first rest ih =>
   cases channel : first.carrier with
   | normal value =>
     constructor
     · intro accepted row member
       have tail : normalOnly rest = true := by
         unfold normalOnly at accepted
         rw [channel] at accepted
         exact accepted
       cases member with
       | head => exact ⟨value,channel⟩
       | tail _ h => exact ih.mp tail row h
     · intro all
       unfold normalOnly
       rw [channel]
       exact ih.mpr (fun row member => all row (List.Mem.tail first member))
   | tangential value =>
     constructor
     · intro accepted
       unfold normalOnly at accepted
       rw [channel] at accepted
       cases accepted
     · intro all
       obtain ⟨pressure,equal⟩ := all first (List.Mem.head rest)
       rw [channel] at equal
       cases equal

structure InviscidFlow where
 flow : CollectiveFlow.Flow Channel
 admitted : normalOnly flow.transfers = true

theorem noTangentialTransfer (f : InviscidFlow) (row : Transfer String Channel)
 (member : row ∈ f.flow.transfers) (momentum : Scalar) : row.carrier ≠ .tangential momentum := by
 obtain ⟨pressure,h⟩ := (normalOnlyIff _).mp f.admitted row member
 intro other
 rw [h] at other
 cases other

theorem normalExchangeRemainsAdjacent (f : InviscidFlow) (row : Transfer String Channel)
 (member : row ∈ f.flow.transfers) :
 (row.source,row.destination) ∈ f.flow.cells.graph.edges ∧ ∃ pressure, row.carrier = .normal pressure :=
 ⟨f.flow.adjacent row member,(normalOnlyIff _).mp f.admitted row member⟩

theorem fullCarrierLedgerRetained (f : InviscidFlow) :
 outgoingSupport f.flow.transfers = incomingSupport f.flow.transfers := completeConservation _

structure CellState where
 pressure : CollectivePressure.ClosedMagnitude
 tangentialMotion : Scalar
 sourceIdentity : String

def updateNormal {State : Type} (cell : CellState)
 (boundary : CollectivePressure.BoundaryRecurrence State) (normalMomentum : Scalar) : CellState :=
 ⟨CollectivePressure.pressure boundary normalMomentum,cell.tangentialMotion,cell.sourceIdentity⟩

theorem tangentLabelRetained {State : Type} (cell : CellState)
 (boundary : CollectivePressure.BoundaryRecurrence State) (normalMomentum : Scalar) :
 (updateNormal cell boundary normalMomentum).tangentialMotion = cell.tangentialMotion := rfl

theorem sourceIdentityRetained {State : Type} (cell : CellState)
 (boundary : CollectivePressure.BoundaryRecurrence State) (normalMomentum : Scalar) :
 (updateNormal cell boundary normalMomentum).sourceIdentity = cell.sourceIdentity := rfl

theorem exactNormalPressure {State : Type} (cell : CellState)
 (boundary : CollectivePressure.BoundaryRecurrence State) (normalMomentum : Scalar) :
 (updateNormal cell boundary normalMomentum).pressure = CollectivePressure.pressure boundary normalMomentum := rfl

theorem normalSuccessor (source destination identity : String) (action : SFT.Host.Canonical.Value)
 (pressure : CollectivePressure.ClosedMagnitude) (rows : Network String Channel) :
 normalOnly (⟨source,destination,.normal pressure,identity,action⟩ :: rows) = normalOnly rows := rfl

theorem tangentialSuccessorRejected (source destination identity : String) (action : SFT.Host.Canonical.Value)
 (momentum : Scalar) (rows : Network String Channel) :
 normalOnly (⟨source,destination,.tangential momentum,identity,action⟩ :: rows) = false := rfl
end SFT.Physics.CollectiveInviscid
