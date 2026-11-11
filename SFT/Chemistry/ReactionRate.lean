import SFT.Foundation.CommonRefinement
import SFT.Chemistry.ReactionIdentity
import SFT.Mathematics.ExactRatioRelations
namespace SFT.Chemistry.ReactionRate
open SFT.Mathematics.ExactRatioRelations
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 completedEvents : PositiveCount
 recurrenceIntervals : PositiveCount
 observedBoundary : HeldLabel

def admit (r : Raw) : Except String Raw :=
 if SFT.Host.Text.equal r.observedBoundary.family "reaction-observation-boundary" then .ok r
 else .error "rate witness requires a registered observation boundary"
def rate (r : Raw) := ratio r.completedEvents.value r.recurrenceIntervals.value
 r.completedEvents.positive r.recurrenceIntervals.positive

theorem exactCountQuotient (r : Raw) : r.completedEvents.value*(rate r).denominator=
 (rate r).numerator*r.recurrenceIntervals.value := ratioValue _ _ _ _

theorem positiveRate (r : Raw) : 0<(rate r).numerator := (rate r).positive

structure Event where
 reactionIdentity : HeldLabel
 transition : ReactionIdentity.Reaction
 sourceRecord : SFT.Host.Canonical.Value
structure Observation where
 raw : Raw
 accepted : admit raw=.ok raw
 reactionIdentity : HeldLabel
 events : List Event
 recurrences : List HeldLabel
 completeEvents : events.length=raw.completedEvents.value
 completeRecurrences : recurrences.length=raw.recurrenceIntervals.value
 sameReaction : ∀ event∈events, event.reactionIdentity=reactionIdentity
 speciesAmounts : List (HeldLabel × PositiveCount)
 conditions : SFT.Host.Canonical.Value

theorem exactObservedQuotient (o : Observation) : o.events.length*(rate o.raw).denominator=
 (rate o.raw).numerator*o.recurrences.length := by
 rw [o.completeEvents,o.completeRecurrences]; exact exactCountQuotient _

theorem admittedBoundary (o : Observation) :
 SFT.Host.Text.equal o.raw.observedBoundary.family "reaction-observation-boundary"=true := by
 have accepted := o.accepted
 unfold admit at accepted
 cases h : SFT.Host.Text.equal o.raw.observedBoundary.family "reaction-observation-boundary"
 · rw [h] at accepted; cases accepted
 · rfl

def increment (n : PositiveCount) : PositiveCount := ⟨n.value+1,Nat.zero_lt_succ _⟩
def appendEvent (o : Observation) (event : Event) (same : event.reactionIdentity=o.reactionIdentity) : Observation where
 raw := {o.raw with completedEvents := increment o.raw.completedEvents}
 accepted := by
  unfold admit
  change (if SFT.Host.Text.equal o.raw.observedBoundary.family "reaction-observation-boundary" then _ else _)=_
  rw [admittedBoundary o]
  rfl
 reactionIdentity := o.reactionIdentity
 events := o.events++[event]
 recurrences := o.recurrences
 completeEvents := by rw [SFT.Foundation.CommonRefinement.appendLength,o.completeEvents]; rfl
 completeRecurrences := o.completeRecurrences
 sameReaction := by
  intro e held
  cases SFT.Foundation.Count.TraceDerivation.memAppendCases e o.events [event] held with
  | inl h => exact o.sameReaction e h
  | inr h => cases h with
    | head => exact same
    | tail _ h => cases h
 speciesAmounts := o.speciesAmounts
 conditions := o.conditions

def appendRecurrence (o : Observation) (interval : HeldLabel) : Observation where
 raw := {o.raw with recurrenceIntervals := increment o.raw.recurrenceIntervals}
 accepted := by
  unfold admit
  change (if SFT.Host.Text.equal o.raw.observedBoundary.family "reaction-observation-boundary" then _ else _)=_
  rw [admittedBoundary o]
  rfl
 reactionIdentity := o.reactionIdentity
 events := o.events
 recurrences := o.recurrences++[interval]
 completeEvents := o.completeEvents
 completeRecurrences := by rw [SFT.Foundation.CommonRefinement.appendLength,o.completeRecurrences]; rfl
 sameReaction := o.sameReaction
 speciesAmounts := o.speciesAmounts
 conditions := o.conditions

theorem eventSuccessorQuotient (o : Observation) (e : Event) (h : e.reactionIdentity=o.reactionIdentity) :
 (o.raw.completedEvents.value+1)*(rate (appendEvent o e h).raw).denominator=
 (rate (appendEvent o e h).raw).numerator*o.raw.recurrenceIntervals.value := exactCountQuotient (appendEvent o e h).raw
theorem recurrenceSuccessorQuotient (o : Observation) (interval : HeldLabel) :
 o.raw.completedEvents.value*(rate (appendRecurrence o interval).raw).denominator=
 (rate (appendRecurrence o interval).raw).numerator*(o.raw.recurrenceIntervals.value+1) := exactCountQuotient (appendRecurrence o interval).raw
theorem priorEventRetained (o : Observation) (e old : Event) (h : e.reactionIdentity=o.reactionIdentity)
 (held : old∈o.events) : old∈(appendEvent o e h).events :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem priorRecurrenceRetained (o : Observation) (interval old : HeldLabel) (held : old∈o.recurrences) :
 old∈(appendRecurrence o interval).recurrences := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem conditionsRetained (o : Observation) (e : Event) (h : e.reactionIdentity=o.reactionIdentity)
 (interval : HeldLabel) :
 (appendEvent o e h).conditions=o.conditions ∧ (appendRecurrence o interval).conditions=o.conditions := ⟨rfl,rfl⟩

def baseRaw (boundary : HeldLabel) : Raw := ⟨⟨1,by decide⟩,⟨1,by decide⟩,boundary⟩
theorem baseUnitRate (boundary : HeldLabel) :
 (rate (baseRaw boundary)).numerator=1 ∧ (rate (baseRaw boundary)).denominator=1 :=
 (SFT.Foundation.ExactOperations.normalizationOneIff 1 1 (by decide) (by decide)).mpr rfl

def base (event : Event) (interval boundary : HeldLabel)
 (family : SFT.Host.Text.equal boundary.family "reaction-observation-boundary"=true)
 (amounts : List (HeldLabel × PositiveCount)) (conditions : SFT.Host.Canonical.Value) : Observation where
 raw := baseRaw boundary
 accepted := by unfold admit baseRaw; rw [family]; rfl
 reactionIdentity := event.reactionIdentity
 events := [event]
 recurrences := [interval]
 completeEvents := rfl
 completeRecurrences := rfl
 sameReaction := by
  intro e held
  cases held with
  | head => rfl
  | tail _ h => cases h
 speciesAmounts := amounts
 conditions := conditions
end SFT.Chemistry.ReactionRate
