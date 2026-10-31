import SFT.Physics.MatterScattering
namespace SFT.Physics.MatterDecay

inductive Carrier (Part Support State ClockState Clock : Type) where
  | label : String → MechanicalLocation.Held → Carrier Part Support State ClockState Clock
  | mechanical : MechanicalConservation.MechanicalCarrier Part Support State ClockState Clock → Carrier Part Support State ClockState Clock

inductive Destination (outputs : Nat) where
  | product : Fin outputs → Destination outputs
  | boundary : String → Destination outputs

structure Pairing (PhysicalCarrier : Type) (outputs : Nat) where
  carrier : PhysicalCarrier
  destination : Destination outputs
  sourceTrace : SFT.Host.Canonical.Value

structure Transition (Part Support State ClockState Clock : Type) where
  input : MatterAntiparticle.Constituent
  outputJoint : MatterAntiparticle.Constituent
  firstOutput : MatterAntiparticle.Constituent
  remainingOutputs : List MatterAntiparticle.Constituent
  lowerRecurrence : outputJoint.word.state.phaseCycle.length < input.word.state.phaseCycle.length
  inputReturn : List String
  inputPeriod : inputReturn.length = input.word.state.phaseCycle.length
  outputReturn : List String
  outputPeriod : outputReturn.length = outputJoint.word.state.phaseCycle.length
  completePairing : List (Pairing (Carrier Part Support State ClockState Clock) (remainingOutputs.length + 1))

variable {Part Support State ClockState Clock : Type}

def outputs (t : Transition Part Support State ClockState Clock) := t.firstOutput :: t.remainingOutputs

def released (t : Transition Part Support State ClockState Clock) :=
  t.completePairing.map (fun row => (t.input.word.sourceIdentity,row.carrier,row.sourceTrace))

def received (t : Transition Part Support State ClockState Clock) :=
  t.completePairing.map (fun row => (row.destination,row.carrier,row.sourceTrace))

theorem entireCarrierAndTracePaired (t : Transition Part Support State ClockState Clock) :
    (released t).map Prod.snd = (received t).map Prod.snd := by
  have all (rows : List (Pairing (Carrier Part Support State ClockState Clock) (t.remainingOutputs.length + 1))) :
      (rows.map (fun row => (t.input.word.sourceIdentity,row.carrier,row.sourceTrace))).map Prod.snd =
        (rows.map (fun row => (row.destination,row.carrier,row.sourceTrace))).map Prod.snd := by
    induction rows with
    | nil => rfl
    | cons row rest ih => exact congrArg (List.cons (row.carrier,row.sourceTrace)) ih
  exact all _

theorem everyConservedAggregatePaired (t : Transition Part Support State ClockState Clock)
    {Result : Type} (aggregate : List (Carrier Part Support State ClockState Clock × SFT.Host.Canonical.Value) → Result) :
    aggregate ((released t).map Prod.snd) = aggregate ((received t).map Prod.snd) :=
  congrArg aggregate (entireCarrierAndTracePaired t)

theorem everyOutputCarrierHasInput (t : Transition Part Support State ClockState Clock)
    (destination : Destination (t.remainingOutputs.length + 1))
    (carrier : Carrier Part Support State ClockState Clock) (trace : SFT.Host.Canonical.Value)
    (held : (destination,carrier,trace) ∈ received t) :
    (t.input.word.sourceIdentity,carrier,trace) ∈ released t := by
  obtain ⟨row,member,equal⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
  have same := congrArg Prod.snd equal
  have present := SFT.Foundation.Count.TraceDerivation.memMap
    (fun row : Pairing (Carrier Part Support State ClockState Clock) (t.remainingOutputs.length + 1) =>
      (t.input.word.sourceIdentity,row.carrier,row.sourceTrace)) row t.completePairing member
  change (t.input.word.sourceIdentity,(row.carrier,row.sourceTrace)) ∈ released t at present
  change (row.carrier,row.sourceTrace) = (carrier,trace) at same
  rw [same] at present
  exact present

theorem everyInputCarrierHasOutput (t : Transition Part Support State ClockState Clock)
    (row : Pairing (Carrier Part Support State ClockState Clock) (t.remainingOutputs.length + 1))
    (held : row ∈ t.completePairing) : (row.destination,row.carrier,row.sourceTrace) ∈ received t :=
  SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem noProductlessDisappearance (t : Transition Part Support State ClockState Clock) : 0 < (outputs t).length :=
  Nat.zero_lt_succ _

theorem notUnchangedSelfReturn (t : Transition Part Support State ClockState Clock) :
    t.outputJoint.word.state.phaseCycle.length ≠ t.input.word.state.phaseCycle.length :=
  Nat.ne_of_lt t.lowerRecurrence

theorem originalRecurrenceRetained (t : Transition Part Support State ClockState Clock) :
    SFT.QuantumComputation.ReversibleModel.phaseAction t.input.word.state t.inputReturn = .ok t.input.word.state :=
  QuantumPhysicalSpin.fullOrientationRecurrenceReturns _ _ t.inputPeriod

theorem productRecurrenceRetained (t : Transition Part Support State ClockState Clock) :
    SFT.QuantumComputation.ReversibleModel.phaseAction t.outputJoint.word.state t.outputReturn = .ok t.outputJoint.word.state :=
  QuantumPhysicalSpin.fullOrientationRecurrenceReturns _ _ t.outputPeriod
end SFT.Physics.MatterDecay
