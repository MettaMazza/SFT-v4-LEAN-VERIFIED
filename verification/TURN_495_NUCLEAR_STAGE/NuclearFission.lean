import SFT.Physics.NuclearReactions
namespace SFT.Physics.NuclearFission

structure Decomposition (Part Support State ClockState Clock : Type) where
  reaction : NuclearReactions.Reaction Part Support State ClockState Clock
  oneInput : reaction.moreInputs = []
  secondOutput : MatterHadrons.Joint
  restOutputs : List MatterHadrons.Joint
  multipleOutputs : reaction.moreOutputs = secondOutput :: restOutputs

variable {Part Support State ClockState Clock : Type}

theorem exactlyOneInput (d : Decomposition Part Support State ClockState Clock) :
    NuclearReactions.inputs d.reaction = [d.reaction.firstInput] := by
  unfold NuclearReactions.inputs
  rw [d.oneInput]

theorem completeOutputDecomposition (d : Decomposition Part Support State ClockState Clock) :
    NuclearReactions.outputs d.reaction = d.reaction.firstOutput :: d.secondOutput :: d.restOutputs := by
  unfold NuclearReactions.outputs
  rw [d.multipleOutputs]

theorem multipleRecurrentProducts (d : Decomposition Part Support State ClockState Clock) :
    2 ≤ (NuclearReactions.outputs d.reaction).length := by
  rw [completeOutputDecomposition d]
  exact Nat.le_add_left 2 d.restOutputs.length

theorem notSingleInternalExcitation (d : Decomposition Part Support State ClockState Clock)
    (single : MatterHadrons.Joint) : NuclearReactions.outputs d.reaction ≠ [single] := by
  intro equal
  have count := congrArg List.length equal
  have bound := multipleRecurrentProducts d
  rw [count] at bound
  exact Nat.not_succ_le_self 1 bound

theorem completeFissionCarrierClosure (d : Decomposition Part Support State ClockState Clock) :
    (NuclearReactions.sourceLedger d.reaction).map Prod.snd =
      (NuclearReactions.targetLedger d.reaction).map Prod.snd :=
  NuclearReactions.completeCarrierClosure d.reaction

theorem everyProductSeparatelyRecurrent (d : Decomposition Part Support State ClockState Clock)
    (joint : MatterHadrons.Joint) (held : joint ∈ NuclearReactions.outputs d.reaction) :
    SFT.QuantumComputation.ReversibleModel.phaseAction joint.whole.word.state joint.returnTrace = .ok joint.whole.word.state :=
  NuclearReactions.everyOutputWordRecurrent d.reaction joint held
end SFT.Physics.NuclearFission
