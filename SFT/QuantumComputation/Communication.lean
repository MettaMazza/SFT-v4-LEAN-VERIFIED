import SFT.QuantumComputation.Entanglement
import SFT.QuantumComputation.GateLaw
namespace SFT.QuantumComputation.Communication
open SFT.QuantumComputation.ReversibleModel SFT.QuantumComputation.ReversibleComposition
open SFT.QuantumComputation.ReversibleApplication SFT.QuantumComputation.ReversibleObservation
open SFT.QuantumComputation.StateComposition SFT.QuantumComputation.GateLaw
open SFT.InformationScience.EncodingMaps

theorem receiverSupportRetained (sender receiver joint selected : State)
    (senderAdmitted : makeState sender.branches sender.phaseCycle = .ok sender)
    (receiverAdmitted : makeState receiver.branches receiver.phaseCycle = .ok receiver)
    (composed : compose sender receiver = .ok joint)
    (mapping : Classification) (label : String) (record : List Record)
    (observed : observe joint mapping label = .ok (selected,record)) (receiverRow : Word × String) :
    receiverRow ∈ receiver.branches ↔ ∃ senderRow row,
      row ∈ record.map Prod.fst ∧ Cell sender receiver senderRow receiverRow row := by
  rw [(observationReconstruction joint selected mapping label record observed).1]
  exact rightMarginalExactly sender receiver joint senderAdmitted receiverAdmitted composed receiverRow

theorem localSenderProvenance (sender transformed receiver joint : State) (gate : Gate)
    (applied : applyGate sender gate false = .ok transformed)
    (composed : compose transformed receiver = .ok joint) (row : Word × String) :
    row ∈ joint.branches ↔ ∃ original sent received,
      original ∈ sender.branches ∧
      lookupFirst gate.wordMap original.1 = some sent.1 ∧
      shiftPhase sender.phaseCycle (gate.phaseSuccessors.length % sender.phaseCycle.length) original.2 = some sent.2 ∧
      Cell transformed receiver sent received row := by
  constructor
  · intro held
    obtain ⟨sent,received,cell⟩ := (compositionRowsExactly transformed receiver joint composed row).mp held
    obtain ⟨original,originalHeld,word,phase⟩ := (exactGateBranch sender transformed gate applied sent).mp cell.1
    exact ⟨original,sent,received,originalHeld,word,phase,cell⟩
  · intro ⟨original,sent,received,_,_,_,cell⟩
    exact (compositionRowsExactly transformed receiver joint composed row).mpr ⟨sent,received,cell⟩
theorem senderSupportRetained (sender receiver joint selected : State)
    (senderAdmitted : makeState sender.branches sender.phaseCycle = .ok sender)
    (receiverAdmitted : makeState receiver.branches receiver.phaseCycle = .ok receiver)
    (composed : compose sender receiver = .ok joint)
    (mapping : Classification) (label : String) (record : List Record)
    (observed : observe joint mapping label = .ok (selected,record)) (senderRow : Word × String) :
    senderRow ∈ sender.branches ↔ ∃ receiverRow row,
      row ∈ record.map Prod.fst ∧ Cell sender receiver senderRow receiverRow row := by
  rw [(observationReconstruction joint selected mapping label record observed).1]
  exact leftMarginalExactly sender receiver joint senderAdmitted receiverAdmitted composed senderRow

theorem completeCommunicationRecordCost (sender receiver joint selected : State)
    (composed : compose sender receiver = .ok joint)
    (mapping : Classification) (label : String) (record : List Record)
    (observed : observe joint mapping label = .ok (selected,record)) :
    record.length = sender.branches.length * receiver.branches.length :=
  (observationReconstruction joint selected mapping label record observed).2.trans
    (compositionCount sender receiver joint composed)

end SFT.QuantumComputation.Communication
