import SFT.Physics.NuclearFission
namespace SFT.Physics.NuclearFusion
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar

def totalInertia (first : MatterHadrons.Joint) : List MatterHadrons.Joint → PositiveFraction
  | [] => first.whole.inertial
  | next::rest => sumMagnitude first.whole.inertial (totalInertia next rest)

structure Composition (Part Support State ClockState Clock : Type) where
  reaction : NuclearReactions.Reaction Part Support State ClockState Clock
  secondInput : MatterHadrons.Joint
  restInputs : List MatterHadrons.Joint
  multipleInputs : reaction.moreInputs = secondInput :: restInputs
  oneOutput : reaction.moreOutputs = []
  binding : NuclearBinding.Composition Support State Clock
  boundIsOutput : binding.bound = reaction.firstOutput
  separatedIsCompleteInput : binding.separated = totalInertia reaction.firstInput reaction.moreInputs

variable {Part Support State ClockState Clock : Type}

def completeRecord (c : Composition Part Support State ClockState Clock) :=
  (NuclearReactions.inputs c.reaction,NuclearReactions.outputs c.reaction,
    c.reaction.channels,NuclearBinding.releasedRecord c.binding)

theorem completeIncidentComposition (c : Composition Part Support State ClockState Clock) :
    NuclearReactions.inputs c.reaction = c.reaction.firstInput :: c.secondInput :: c.restInputs := by
  unfold NuclearReactions.inputs; rw [c.multipleInputs]

theorem multipleIncidentWords (c : Composition Part Support State ClockState Clock) :
    2 ≤ (NuclearReactions.inputs c.reaction).length := by
  rw [completeIncidentComposition c]
  exact Nat.le_add_left 2 c.restInputs.length

theorem exactlyOneBoundProduct (c : Composition Part Support State ClockState Clock) :
    NuclearReactions.outputs c.reaction = [c.binding.bound] := by
  unfold NuclearReactions.outputs
  rw [c.oneOutput,c.boundIsOutput]

theorem wholeInputExceedsBoundSupport (c : Composition Part Support State ClockState Clock) :
    rightCross (totalInertia c.reaction.firstInput c.reaction.moreInputs) c.reaction.firstOutput.whole.inertial <
      leftCross (totalInertia c.reaction.firstInput c.reaction.moreInputs) c.reaction.firstOutput.whole.inertial := by
  rw [← c.separatedIsCompleteInput,← c.boundIsOutput]
  exact c.binding.releasedPositive

theorem completeFusionCarrierClosure (c : Composition Part Support State ClockState Clock) :
    (NuclearReactions.sourceLedger c.reaction).map Prod.snd =
      (NuclearReactions.targetLedger c.reaction).map Prod.snd := NuclearReactions.completeCarrierClosure c.reaction

theorem namedPositiveRelease (c : Composition Part Support State ClockState Clock) :
    (NuclearBinding.releasedRecord c.binding).1 = c.binding.destination ∧
      0 < (NuclearBinding.releasedEnergy c.binding).numerator :=
  ⟨rfl,(NuclearBinding.releasedEnergy c.binding).positive⟩

theorem sourceMassEnergyRelease (c : Composition Part Support State ClockState Clock) :
    ((NuclearBinding.reduction c.binding).numerator *
      ((WaveSpeedRelation.speed c.binding.limit).numerator * (WaveSpeedRelation.speed c.binding.limit).numerator)) *
      (NuclearBinding.releasedEnergy c.binding).denominator =
    (NuclearBinding.releasedEnergy c.binding).numerator *
      ((NuclearBinding.reduction c.binding).denominator *
       ((WaveSpeedRelation.speed c.binding.limit).denominator * (WaveSpeedRelation.speed c.binding.limit).denominator)) :=
  NuclearBinding.exactReleasedEnergy c.binding

theorem productRecurrenceRetained (c : Composition Part Support State ClockState Clock) :
    SFT.QuantumComputation.ReversibleModel.phaseAction c.binding.bound.whole.word.state c.binding.bound.returnTrace =
      .ok c.binding.bound.whole.word.state := NuclearBinding.boundRecurrenceRetained c.binding
end SFT.Physics.NuclearFusion
