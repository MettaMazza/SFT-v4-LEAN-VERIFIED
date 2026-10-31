import SFT.Physics.NuclearRadioactivity
namespace SFT.Physics.NuclearReactions

inductive Endpoint (count : Nat) where
  | word : Fin count → Endpoint count
  | boundary : String → Endpoint count

inductive Carrier (Part Support State ClockState Clock : Type) where
  | material : MatterHadrons.Joint → Carrier Part Support State ClockState Clock
  | physical : MatterDecay.Carrier Part Support State ClockState Clock → Carrier Part Support State ClockState Clock

structure Row (PhysicalCarrier : Type) (inputs outputs : Nat) where
  source : Endpoint inputs
  target : Endpoint outputs
  carrier : PhysicalCarrier
  provenance : SFT.Host.Canonical.Value

structure Reaction (Part Support State ClockState Clock : Type) where
  firstInput : MatterHadrons.Joint
  moreInputs : List MatterHadrons.Joint
  firstOutput : MatterHadrons.Joint
  moreOutputs : List MatterHadrons.Joint
  channels : List (Row (Carrier Part Support State ClockState Clock) (moreInputs.length + 1) (moreOutputs.length + 1))

variable {Part Support State ClockState Clock : Type}

def inputs (r : Reaction Part Support State ClockState Clock) := r.firstInput :: r.moreInputs

def outputs (r : Reaction Part Support State ClockState Clock) := r.firstOutput :: r.moreOutputs

def sourceLedger (r : Reaction Part Support State ClockState Clock) := r.channels.map (fun row => (row.source,row.carrier,row.provenance))

def targetLedger (r : Reaction Part Support State ClockState Clock) := r.channels.map (fun row => (row.target,row.carrier,row.provenance))

theorem completeCarrierClosure (r : Reaction Part Support State ClockState Clock) :
    (sourceLedger r).map Prod.snd = (targetLedger r).map Prod.snd := by
  have all (rows : List (Row (Carrier Part Support State ClockState Clock) (r.moreInputs.length + 1) (r.moreOutputs.length + 1))) :
      (rows.map (fun row => (row.source,row.carrier,row.provenance))).map Prod.snd =
        (rows.map (fun row => (row.target,row.carrier,row.provenance))).map Prod.snd := by
    induction rows with
    | nil => rfl
    | cons row rest ih => exact congrArg (List.cons (row.carrier,row.provenance)) ih
  exact all _

theorem everyAggregateConserved (r : Reaction Part Support State ClockState Clock) {Result : Type}
    (aggregate : List (Carrier Part Support State ClockState Clock × SFT.Host.Canonical.Value) → Result) :
    aggregate ((sourceLedger r).map Prod.snd) = aggregate ((targetLedger r).map Prod.snd) :=
  congrArg aggregate (completeCarrierClosure r)

theorem everyChannelHasSourceAndTarget (r : Reaction Part Support State ClockState Clock)
    (row : Row (Carrier Part Support State ClockState Clock) (r.moreInputs.length + 1) (r.moreOutputs.length + 1))
    (held : row ∈ r.channels) :
    (row.source,row.carrier,row.provenance) ∈ sourceLedger r ∧
      (row.target,row.carrier,row.provenance) ∈ targetLedger r :=
  ⟨SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held,SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held⟩

theorem sourceAndTargetCounts (r : Reaction Part Support State ClockState Clock) :
    (sourceLedger r).length = r.channels.length ∧ (targetLedger r).length = r.channels.length :=
  ⟨SFT.Foundation.CommonRefinement.mapLength _ _,SFT.Foundation.CommonRefinement.mapLength _ _⟩

theorem everyTargetFromOriginalChannel (r : Reaction Part Support State ClockState Clock)
    (target : Endpoint (r.moreOutputs.length + 1)) (carrier : Carrier Part Support State ClockState Clock)
    (provenance : SFT.Host.Canonical.Value) (held : (target,carrier,provenance) ∈ targetLedger r) :
    ∃ row ∈ r.channels, (row.target,row.carrier,row.provenance) = (target,carrier,provenance) :=
  SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held

theorem everyInputWordRecurrent (r : Reaction Part Support State ClockState Clock)
    (joint : MatterHadrons.Joint) (_held : joint ∈ inputs r) :
    SFT.QuantumComputation.ReversibleModel.phaseAction joint.whole.word.state joint.returnTrace = .ok joint.whole.word.state :=
  MatterHadrons.jointRecurrenceRetained joint

theorem everyOutputWordRecurrent (r : Reaction Part Support State ClockState Clock)
    (joint : MatterHadrons.Joint) (_held : joint ∈ outputs r) :
    SFT.QuantumComputation.ReversibleModel.phaseAction joint.whole.word.state joint.returnTrace = .ok joint.whole.word.state :=
  MatterHadrons.jointRecurrenceRetained joint
end SFT.Physics.NuclearReactions
