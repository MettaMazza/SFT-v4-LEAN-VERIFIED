import SFT.Chemistry.BondClosure
import SFT.Physics.QuantumPhysicalExclusion
import SFT.Physics.QuantumPhysicalEntanglement
import SFT.Mathematics.GraphOperations
import SFT.Physics.FieldElectricPotential
namespace SFT.Chemistry.CovalentSharing
open SFT.Physics SFT.Foundation.Count.TraceDerivation

inductive Centre where
 | left | right

-- Both access records refer to the same retained carrier occurrence.
structure Shared (Carrier : Type) where
 carrier : Carrier
 leftNucleus : String
 rightNucleus : String
 distinctNuclei : leftNucleus ≠ rightNucleus
 channel : BondClosure.Channel

def nucleus {Carrier : Type} (shared : Shared Carrier) : Centre → String
 | .left => shared.leftNucleus
 | .right => shared.rightNucleus

def access {Carrier : Type} (shared : Shared Carrier) (_centre : Centre) : Carrier := shared.carrier

theorem oneCarrierBothCentres {Carrier : Type} (shared : Shared Carrier) :
 access shared .left = access shared .right := rfl

theorem identifiedCentres {Carrier : Type} (shared : Shared Carrier) :
 nucleus shared .left ≠ nucleus shared .right := shared.distinctNuclei

def ledger {Carrier : Type} (channels : List (Shared Carrier)) : List (Carrier × String × String) :=
 channels.map (fun shared => (shared.carrier,shared.leftNucleus,shared.rightNucleus))

theorem completeCarrierLedger {Carrier : Type} (channels : List (Shared Carrier)) :
 (ledger channels).map Prod.fst = channels.map Shared.carrier := by
 induction channels with
 | nil => rfl
 | cons first rest ih => exact congrArg (List.cons first.carrier) ih

theorem oneRecordPerChannel {Carrier : Type} (channels : List (Shared Carrier)) :
 (ledger channels).length = channels.length :=
 SFT.Foundation.CommonRefinement.mapLength _ _

def appendShared {Carrier : Type} (channels : List (Shared Carrier)) (next : Shared Carrier) := channels++[next]

theorem priorChannelRetained {Carrier : Type} (channels : List (Shared Carrier)) (next prior : Shared Carrier)
 (held : prior ∈ channels) : prior ∈ appendShared channels next := memAppendLeft _ _ _ held

theorem nextChannelRetained {Carrier : Type} (channels : List (Shared Carrier)) (next : Shared Carrier) :
 next ∈ appendShared channels next := memAppendRight _ _ _ (.head _)

theorem appendedCarrierLedger {Carrier : Type} (channels : List (Shared Carrier)) (next : Shared Carrier) :
 ledger (appendShared channels next) = ledger channels ++ [(next.carrier,next.leftNucleus,next.rightNucleus)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

structure ExchangeTrace (Word Cell : Type) where
 first : QuantumPhysicalExclusion.Occupant Word Cell
 second : QuantumPhysicalExclusion.Occupant Word Cell
 orientation : QuantumPhysicalIdentity.Pair (QuantumPhysicalExclusion.Occupant Word Cell) → MechanicalLocation.Held
 accepted : QuantumPhysicalExclusion.alternating orientation ⟨first,second⟩

theorem sameWordDistinctCell {Word Cell : Type} (trace : ExchangeTrace Word Cell)
 (sameWord : trace.first.word=trace.second.word) : trace.first.cell ≠ trace.second.cell :=
 QuantumPhysicalExclusion.admittedSameWordRequiresDistinctCell _ _ _ sameWord trace.accepted

theorem duplicateOccupationRejected {Word Cell : Type}
 (orientation : QuantumPhysicalIdentity.Pair (QuantumPhysicalExclusion.Occupant Word Cell) → MechanicalLocation.Held)
 (first second : QuantumPhysicalExclusion.Occupant Word Cell)
 (sameWord : first.word=second.word) (sameCell : first.cell=second.cell) :
 ¬ QuantumPhysicalExclusion.alternating orientation ⟨first,second⟩ :=
 QuantumPhysicalExclusion.identicalSameCellExcluded _ _ _ sameWord sameCell

structure Channel (Word Cell : Type) where
 shared : Shared (QuantumPhysicalExclusion.Occupant Word Cell)
 exchanges : List (ExchangeTrace Word Cell)

-- Complete original source observations remain attached to each channel.
def sharedRows {Word Cell : Type} (channels : List (Channel Word Cell)) := channels.map Channel.shared

theorem exchangeRecordsRetained {Word Cell : Type} (channels : List (Channel Word Cell))
 (next prior : Channel Word Cell) (held : prior ∈ channels) : prior ∈ channels++[next] := memAppendLeft _ _ _ held

inductive AllExchanges {Word Cell : Type} : List (Channel Word Cell) → Prop where
 | empty : AllExchanges []
 | step (first : Channel Word Cell) (rest : List (Channel Word Cell))
   (complete : ∀ second ∈ rest, ∃ trace, trace ∈ first.exchanges ∧
    trace.first=first.shared.carrier ∧ trace.second=second.shared.carrier)
   (tail : AllExchanges rest) : AllExchanges (first::rest)

theorem duplicateHeadRejected {Word Cell : Type} (first second : Channel Word Cell) (rest : List (Channel Word Cell))
 (held : second ∈ rest) (sameWord : first.shared.carrier.word=second.shared.carrier.word)
 (sameCell : first.shared.carrier.cell=second.shared.carrier.cell) : ¬ AllExchanges (first::rest) := by
 intro complete
 cases complete with
 | step _ _ pairs tail =>
   obtain ⟨trace,_,left,right⟩ := pairs second held
   have words : trace.first.word=trace.second.word := (congrArg QuantumPhysicalExclusion.Occupant.word left).trans
     (sameWord.trans (congrArg QuantumPhysicalExclusion.Occupant.word right).symm)
   have cells : trace.first.cell=trace.second.cell := (congrArg QuantumPhysicalExclusion.Occupant.cell left).trans
     (sameCell.trans (congrArg QuantumPhysicalExclusion.Occupant.cell right).symm)
   exact sameWordDistinctCell trace words cells

theorem singletonExclusion {Word Cell : Type} (channel : Channel Word Cell) : AllExchanges [channel] :=
 .step channel [] (fun _ held => nomatch held) .empty

structure BoundChannels (Word Cell : Type) where
 bond : BondClosure.Record
 channels : List (Channel Word Cell)
 nonempty : channels ≠ []
 occupation : AllExchanges channels
 sourceChannels : channels.map (fun c => c.shared.channel) = bond.support.raw.channels
 leftBinding : ∀ row ∈ channels, row.shared.leftNucleus=bond.support.raw.left
 rightBinding : ∀ row ∈ channels, row.shared.rightNucleus=bond.support.raw.right

theorem allNucleiBound {Word Cell : Type} (record : BoundChannels Word Cell) (row : Channel Word Cell) (held : row ∈ record.channels) :
 row.shared.leftNucleus=record.bond.support.raw.left ∧ row.shared.rightNucleus=record.bond.support.raw.right :=
 ⟨record.leftBinding row held,record.rightBinding row held⟩

theorem boundSourceRecurs {Word Cell : Type} (record : BoundChannels Word Cell) :
 SFT.QuantumComputation.ReversibleModel.phaseAction record.bond.recurrence.prepared.state
 (record.bond.interactionTrace.flatMap Prod.snd) = .ok record.bond.recurrence.prepared.state :=
 BondClosure.sourceInteractionReturns record.bond

theorem boundChannelCount {Word Cell : Type} (record : BoundChannels Word Cell) :
 record.channels.length = BondClosure.joiningMultiplicity record.bond.support := by
 have count := congrArg List.length record.sourceChannels
 rw [SFT.Foundation.CommonRefinement.mapLength] at count
 exact count
-- A shared channel is the retained joining relation between its two named nuclei.
def nuclearGraph {Carrier : Type} (shared : Shared Carrier) :
 SFT.Mathematics.GraphOperations.GeneratedGraph :=
 ⟨[shared.leftNucleus,shared.rightNucleus],[(shared.leftNucleus,shared.rightNucleus)]⟩

theorem internuclearPath {Carrier : Type} (shared : Shared Carrier) :
 SFT.Mathematics.GraphOperations.pathIsValid (nuclearGraph shared)
 [shared.leftNucleus,shared.rightNucleus] = true := by
 apply (SFT.Mathematics.GraphOperations.pathMeaning _ _).mpr
 refine ⟨rfl,?_,?_⟩
 · intro node held; exact held
 · intro edge held; exact held

theorem appendExclusion {Word Cell : Type} (channels : List (Channel Word Cell))
 (next : Channel Word Cell) (valid : AllExchanges channels)
 (compatible : ∀ prior ∈ channels, ∃ trace, trace ∈ prior.exchanges ∧
   trace.first=prior.shared.carrier ∧ trace.second=next.shared.carrier) :
 AllExchanges (channels++[next]) := by
 induction valid with
 | empty => exact singletonExclusion next
 | step first rest complete tail ih =>
   apply AllExchanges.step
   · intro second held
     cases memAppendCases second rest [next] held with
     | inl old => exact complete second old
     | inr added =>
       cases added with
       | head => exact compatible first (.head _)
       | tail _ impossible => cases impossible
   · exact ih (fun prior held => compatible prior (.tail first held))

theorem appendSharedSourceChannels {Word Cell : Type} (channels : List (Channel Word Cell))
 (next : Channel Word Cell) :
 (channels++[next]).map (fun c => c.shared.channel) =
 channels.map (fun c => c.shared.channel) ++ [next.shared.channel] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem everyBoundChannelConnects {Word Cell : Type} (record : BoundChannels Word Cell)
 (row : Channel Word Cell) (held : row ∈ record.channels) :
 SFT.Mathematics.GraphOperations.pathIsValid (nuclearGraph row.shared)
 [record.bond.support.raw.left,record.bond.support.raw.right] = true := by
 rw [← record.leftBinding row held,← record.rightBinding row held]
 exact internuclearPath row.shared
-- The source base and successor retain an actually closed BondClosure record.
def initialBound {Word Cell : Type} (bond : BondClosure.Record) (channel : Channel Word Cell)
 (source : [channel.shared.channel]=bond.support.raw.channels)
 (left : channel.shared.leftNucleus=bond.support.raw.left)
 (right : channel.shared.rightNucleus=bond.support.raw.right) : BoundChannels Word Cell where
 bond := bond
 channels := [channel]
 nonempty := by intro equal; cases equal
 occupation := singletonExclusion channel
 sourceChannels := source
 leftBinding := by
  intro row held
  cases held with
  | head => exact left
  | tail _ impossible => cases impossible
 rightBinding := by
  intro row held
  cases held with
  | head => exact right
  | tail _ impossible => cases impossible

def extendBound {Word Cell : Type} (prior : BoundChannels Word Cell)
 (next : Channel Word Cell) (closed : BondClosure.Record)
 (source : closed.support.raw.channels=prior.bond.support.raw.channels++[next.shared.channel])
 (left : closed.support.raw.left=prior.bond.support.raw.left)
 (right : closed.support.raw.right=prior.bond.support.raw.right)
 (nextLeft : next.shared.leftNucleus=closed.support.raw.left)
 (nextRight : next.shared.rightNucleus=closed.support.raw.right)
 (compatible : ∀ old ∈ prior.channels, ∃ trace, trace ∈ old.exchanges ∧
   trace.first=old.shared.carrier ∧ trace.second=next.shared.carrier) : BoundChannels Word Cell where
 bond := closed
 channels := prior.channels++[next]
 nonempty := by
  intro equal
  have member := memAppendRight next prior.channels [next] (.head [])
  rw [equal] at member
  cases member
 occupation := appendExclusion prior.channels next prior.occupation compatible
 sourceChannels := by
  rw [appendSharedSourceChannels,prior.sourceChannels,source]
 leftBinding := by
  intro row held
  cases memAppendCases row prior.channels [next] held with
  | inl old => exact (prior.leftBinding row old).trans left.symm
  | inr fresh =>
    cases fresh with
    | head => exact nextLeft
    | tail _ impossible => cases impossible
 rightBinding := by
  intro row held
  cases memAppendCases row prior.channels [next] held with
  | inl old => exact (prior.rightBinding row old).trans right.symm
  | inr fresh =>
    cases fresh with
    | head => exact nextRight
    | tail _ impossible => cases impossible

theorem boundPositiveMultiplicity {Word Cell : Type} (record : BoundChannels Word Cell) :
 0 < record.channels.length := by
 rw [boundChannelCount]
 exact BondClosure.joiningMultiplicityPositive record.bond.support

-- Instantiate the general exchange proof with the original retained electron labels.
-- The equality binds each occupant to the actual source joining channel label.
structure ElectronSupport (Cell : Type) where
 record : BoundChannels String Cell
 labelBinding : ∀ row ∈ record.channels, row.shared.carrier.word=row.shared.channel.label

theorem sourceElectronLabelRetained {Cell : Type} (support : ElectronSupport Cell)
 (row : Channel String Cell) (held : row ∈ support.record.channels) :
 SourceText.nonblank row.shared.carrier.word=true := by
 rw [support.labelBinding row held]
 exact row.shared.channel.labelHeld

theorem sourceElectronAccess {Cell : Type} (support : ElectronSupport Cell)
 (row : Channel String Cell) (held : row ∈ support.record.channels) :
 (access row.shared .left).word=row.shared.channel.label ∧
 (access row.shared .right).word=row.shared.channel.label :=
 ⟨support.labelBinding row held,support.labelBinding row held⟩
-- field_laws.py ELECTRIC_DISTINCTION: the opposed held source class is
-- independent of the positive source amount. Both nuclei couple to the one
-- retained electron source; no potential or orbital rule is introduced.
def nuclearSource (electron : FieldElectricDistinction.Charge)
 (amount : SFT.Foundation.ExactOperations.PositiveFraction) : FieldElectricDistinction.Charge :=
 ⟨amount,MechanicalLocation.opposite electron.held⟩

theorem sharedElectricClass (electron : FieldElectricDistinction.Charge)
 (leftAmount rightAmount : SFT.Foundation.ExactOperations.PositiveFraction) :
 FieldElectricDistinction.interaction electron (nuclearSource electron leftAmount)=.oppositeHeld ∧
 FieldElectricDistinction.interaction electron (nuclearSource electron rightAmount)=.oppositeHeld := by
 cases electron with
 | mk amount held => cases held <;> exact ⟨rfl,rfl⟩

theorem heldConventionIndependent (electron : FieldElectricDistinction.Charge)
 (amount : SFT.Foundation.ExactOperations.PositiveFraction) :
 FieldElectricDistinction.interaction (FieldElectricDistinction.reverse electron)
 (FieldElectricDistinction.reverse (nuclearSource electron amount)) =
 FieldElectricDistinction.interaction electron (nuclearSource electron amount) :=
 FieldElectricDistinction.reversingBothRetainsClass _ _

end SFT.Chemistry.CovalentSharing




