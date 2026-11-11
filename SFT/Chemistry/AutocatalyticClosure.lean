import SFT.Chemistry.ReactionNetwork
namespace SFT.Chemistry.AutocatalyticClosure
open SFT.Mathematics.GraphOperations
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev Raw := CatalystCycle.Raw
abbrev admit := CatalystCycle.admit

structure Event where
 network : ReactionNetwork.Network
 action : CatalystCycle.Catalyst
 reactionHeld : action.recurrence.event.transition∈network.steps
 product : HeldLabel
 productIsCatalyst : product=action.alternative.cycle.raw.entering
 inputBefore : List String
 inputAfter : List String
 completeInputs : action.recurrence.event.transition.trace.raw.reactants=
  inputBefore++(product.label::inputAfter)
 resourceNonempty : inputBefore++inputAfter≠[]
 outputBefore : List String
 outputMiddle : List String
 outputAfter : List String
 completeOutputs : action.recurrence.event.transition.trace.raw.products=
  outputBefore++(product.label::(outputMiddle++(product.label::outputAfter)))
 feedback : ∃ trace, ReturnTrace (ReactionNetwork.graph network).edges product.label [product.label] trace
 sourceRecord : SFT.Host.Canonical.Value

def resources (e : Event) := e.inputBefore++e.inputAfter

theorem returnedSameIdentity (e : Event) : e.action.alternative.cycle.raw.leaving=e.product :=
 (CatalystCycle.exactCarrierReturn _).symm.trans e.productIsCatalyst.symm

theorem positiveResourceSupport (e : Event) : 0<(resources e).length := by
 cases h : resources e with
 | nil => exact False.elim (e.resourceNonempty h)
 | cons first rest => exact Nat.zero_lt_succ _

theorem productAcceleratesOwnFormation (e : Event) :
 e.action.recurrence.before.raw.completedEvents.value*(CatalystCycle.after e.action.recurrence).raw.recurrenceIntervals.value<
 (CatalystCycle.after e.action.recurrence).raw.completedEvents.value*e.action.recurrence.before.raw.recurrenceIntervals.value :=
 CatalystCycle.increasedRateCrossProducts _

theorem productionCarrierBalance (e : Event) (test : HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (ReactionIdentity.flows e.action.recurrence.event.transition.placements)=
 SFT.Physics.MatterConservedLabels.outputCount test (ReactionIdentity.flows e.action.recurrence.event.transition.placements) :=
 ReactionIdentity.noCarrierLoss _ _

theorem fullInputAccounting (e : Event) :
 e.action.recurrence.event.transition.trace.raw.reactants=e.inputBefore++(e.product.label::e.inputAfter) := e.completeInputs

theorem returnedAndNewProductRecorded (e : Event) :
 e.action.recurrence.event.transition.trace.raw.products=
 e.outputBefore++(e.product.label::(e.outputMiddle++(e.product.label::e.outputAfter))) := e.completeOutputs

-- Every execution step removes its complete nonempty source resource word.
inductive Run (identity : HeldLabel) : List String → List String → List Event → Prop where
 | empty (remaining : List String) : Run identity remaining remaining []
 | step (e : Event) (remaining final : List String) (events : List Event)
   (sameProduct : e.product=identity)
   (tail : Run identity remaining final events) :
   Run identity (resources e++remaining) final (e::events)

def consumed : List Event → List String
 | [] => []
 | e::rest => resources e++consumed rest

def products (events : List Event) := events.map Event.product

def history (events : List Event) := events.map fun e =>
 (e.product,e.action.alternative.cycle.sourceRecord,e.action.recurrence.event.transition,
 resources e,e.sourceRecord)

theorem completeResourcePartition {identity : HeldLabel} {initial final : List String} {events : List Event}
 (run : Run identity initial final events) : initial=consumed events++final := by
 induction run with
 | empty => rfl
 | step e remaining final events same tail ih =>
   change resources e++remaining=(resources e++consumed events)++final
   rw [ih,SFT.Mathematics.ExactTraceArithmetic.appendAssociative]

theorem resourceCountPartition {identity : HeldLabel} {initial final : List String} {events : List Event}
 (run : Run identity initial final events) : initial.length=(consumed events).length+final.length := by
 rw [completeResourcePartition run,SFT.Foundation.CommonRefinement.appendLength]

theorem eventsBoundedByConsumed (events : List Event) : events.length≤(consumed events).length := by
 induction events with
 | nil => exact Nat.le_refl _
 | cons e rest ih =>
   change rest.length+1≤(resources e++consumed rest).length
   rw [SFT.Foundation.CommonRefinement.appendLength,Nat.add_comm (resources e).length]
   exact Nat.add_le_add ih (positiveResourceSupport e)

theorem finiteProductionBound {identity : HeldLabel} {initial final : List String} {events : List Event}
 (run : Run identity initial final events) : events.length≤initial.length := by
 rw [resourceCountPartition run]
 exact Nat.le_trans (eventsBoundedByConsumed events) (Nat.le_add_right _ _)

theorem emptyResourcesStop {identity : HeldLabel} {final : List String} {events : List Event}
 (run : Run identity [] final events) : events=[] := by
 have h := finiteProductionBound run
 cases events with
 | nil => rfl
 | cons e rest => exact False.elim (Nat.not_succ_le_zero _ h)

theorem everyProductSameIdentity {identity : HeldLabel} {initial final : List String} {events : List Event}
 (run : Run identity initial final events) (e : Event) (held : e∈events) : e.product=identity := by
 induction run with
 | empty => cases held
 | step first remaining final events same tail ih =>
   cases held with
   | head => exact same
   | tail _ member => exact ih member

theorem productCountExactlyCycles (events : List Event) : (products events).length=events.length :=
 SFT.Foundation.CommonRefinement.mapLength _ _

theorem oneEventBase (e : Event) : Run e.product (resources e) [] [e] := by
 have h := Run.step e [] [] [] rfl (Run.empty [])
 rw [SFT.Mathematics.CategoryIdentity.appendNil] at h
 exact h

theorem appendRun {identity : HeldLabel} {initial middle final : List String} {first second : List Event}
 (prior : Run identity initial middle first) (following : Run identity middle final second) :
 Run identity initial final (first++second) := by
 induction prior with
 | empty => exact following
 | step e remaining boundary events same tail ih => exact .step e remaining final _ same (ih following)

theorem oneCycleSuccessor {identity : HeldLabel} {initial remaining : List String} {events : List Event}
 (e : Event) (prior : Run identity initial (resources e++remaining) events) (same : e.product=identity) :
 Run identity initial remaining (events++[e]) :=
 appendRun prior (.step e remaining remaining [] same (.empty remaining))

theorem successorHistory (events : List Event) (e : Event) :
 history (events++[e])=history events++history [e] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem successorAddsOneProduct (events : List Event) (e : Event) :
 products (events++[e])=products events++[e.product] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Chemistry.AutocatalyticClosure
