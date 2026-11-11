import SFT.Chemistry.ReactionMechanism
import SFT.Chemistry.ReactionRate
namespace SFT.Chemistry.CatalystCycle
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
structure Raw where
 entering : HeldLabel
 leaving : HeldLabel
 steps : PositiveCount

def admit (r : Raw) : Except String Raw :=
 if !(SFT.Host.Text.equal r.entering.family "chemical-carrier") || !decide (r.entering=r.leaving) then
 .error "cycle carrier must return with exact identity" else .ok r

theorem acceptedIdentity (r : Raw) (accepted : admit r=.ok r) : r.entering=r.leaving := by
 cases h : decide (r.entering=r.leaving)
 · unfold admit at accepted
   rw [h] at accepted
   cases f : !(SFT.Host.Text.equal r.entering.family "chemical-carrier") <;> rw [f] at accepted <;> cases accepted
 · exact of_decide_eq_true h

structure Cycle where
 raw : Raw
 accepted : admit raw=.ok raw
 steps : List ReactionMechanism.Step
 completeSteps : steps.length=raw.steps.value
 chemicalSteps : List ReactionMechanism.BoundStep
 completeChemicalSteps : chemicalSteps.map ReactionMechanism.BoundStep.step=steps
 path : ReactionMechanism.Chain raw.entering.label raw.leaving.label steps
 sourceRecord : SFT.Host.Canonical.Value

theorem exactCarrierReturn (c : Cycle) : c.raw.entering=c.raw.leaving := acceptedIdentity _ c.accepted

theorem closedCarrierPath (c : Cycle) :
 ReactionMechanism.Chain c.raw.entering.label c.raw.entering.label c.steps := by
 have same := congrArg (fun x : HeldLabel => x.label) (exactCarrierReturn c)
 have h := c.path
 rw [← same] at h
 exact h

theorem completeCycleCancellation (c : Cycle) :
 c.raw.entering.label::ReactionMechanism.outputs c.steps=
 ReactionMechanism.inputs c.steps++[c.raw.entering.label] :=
 ReactionMechanism.completeEndpointCancellation (closedCarrierPath c)

theorem positiveCycleSupport (c : Cycle) : 0<c.steps.length := by
 rw [c.completeSteps]
 exact c.raw.steps.positive

theorem completeCycleCarrierConservation (c : Cycle) (test : HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (ReactionMechanism.chemicalFlows c.chemicalSteps)=
 SFT.Physics.MatterConservedLabels.outputCount test (ReactionMechanism.chemicalFlows c.chemicalSteps) :=
 ReactionMechanism.wholeMechanismConserves _ _

def cyclesTrace (cycles : List Cycle) := cycles.map fun c => (c.raw.entering,c.steps,c.raw.leaving,c.sourceRecord)

theorem oneCycleBase (c : Cycle) : cyclesTrace [c]=[(c.raw.entering,c.steps,c.raw.leaving,c.sourceRecord)] := rfl

theorem appendRetainsFullCycles (cycles : List Cycle) (c : Cycle) :
 cyclesTrace (cycles++[c])=cyclesTrace cycles++[(c.raw.entering,c.steps,c.raw.leaving,c.sourceRecord)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

-- The actual source comparison retains more completed reaction recurrences
-- at the same positive interval, not a fitted catalytic rate coefficient.
structure RecurrenceExtension where
 before : ReactionRate.Observation
 event : ReactionRate.Event
 sameReaction : event.reactionIdentity=before.reactionIdentity
 cycle : Cycle
 cycleInEvent : cycle.raw.entering∈event.transition.trace.raw.conservedCarriers

def after (r : RecurrenceExtension) := ReactionRate.appendEvent r.before r.event r.sameReaction

theorem increasedRecurrenceSupport (r : RecurrenceExtension) :
 r.before.raw.completedEvents.value<(after r).raw.completedEvents.value := Nat.lt_succ_self _

theorem sameIntervalAndConditions (r : RecurrenceExtension) :
 (after r).raw.recurrenceIntervals=r.before.raw.recurrenceIntervals ∧
 (after r).conditions=r.before.conditions := ⟨rfl,rfl⟩

theorem increasedRateCrossProducts (r : RecurrenceExtension) :
 r.before.raw.completedEvents.value*(after r).raw.recurrenceIntervals.value<
 (after r).raw.completedEvents.value*r.before.raw.recurrenceIntervals.value :=
 Nat.mul_lt_mul_of_pos_right (Nat.lt_succ_self _) r.before.raw.recurrenceIntervals.positive

theorem exactIncreasedRateQuotient (r : RecurrenceExtension) :
 (r.before.raw.completedEvents.value+1)*(ReactionRate.rate (after r).raw).denominator=
 (ReactionRate.rate (after r).raw).numerator*r.before.raw.recurrenceIntervals.value :=
 ReactionRate.eventSuccessorQuotient _ _ _

def reversedRawStep (s : ReactionMechanism.Step) : ReactionMechanism.RawStep :=
 ⟨s.raw.identity,s.raw.outputState,s.raw.inputState⟩

theorem reversedStepAdmitted (s : ReactionMechanism.Step) :
 ReactionMechanism.admitStep (reversedRawStep s)=.ok (reversedRawStep s) := by
 have h := s.accepted
 unfold ReactionMechanism.admitStep at h
 cases a : SourceText.nonblank s.raw.identity <;>
  cases b : SourceText.nonblank s.raw.inputState <;>
  cases c : SourceText.nonblank s.raw.outputState <;>
  cases d : decide (s.raw.inputState=s.raw.outputState) <;>
  rw [a,b,c,d] at h <;> try cases h
 have different : s.raw.outputState≠s.raw.inputState := fun eq => (of_decide_eq_false d) eq.symm
 unfold ReactionMechanism.admitStep reversedRawStep
 change (if !SourceText.nonblank s.raw.identity || !SourceText.nonblank s.raw.outputState ||
  !SourceText.nonblank s.raw.inputState || decide (s.raw.outputState=s.raw.inputState) then _ else _)=_
 rw [a,c,b,decide_eq_false different]
 rfl

def reversedStep (s : ReactionMechanism.Step) : ReactionMechanism.Step :=
 ⟨reversedRawStep s,reversedStepAdmitted s⟩
def reverseSteps : List ReactionMechanism.Step → List ReactionMechanism.Step
 | [] => []
 | s::rest => reverseSteps rest++[reversedStep s]

theorem reversedTraversal {a b : String} {steps : List ReactionMechanism.Step}
 (path : ReactionMechanism.Chain a b steps) : ReactionMechanism.Chain b a (reverseSteps steps) := by
 induction path with
 | one s => exact .one (reversedStep s)
 | cons s tail adjacent ih =>
   exact ReactionMechanism.appendStep ih (reversedStep s) adjacent.symm

theorem reverseRetainsStepCount (steps : List ReactionMechanism.Step) : (reverseSteps steps).length=steps.length := by
 induction steps with
 | nil => rfl
 | cons s rest ih =>
   change (reverseSteps rest++[reversedStep s]).length=(s::rest).length
   rw [SFT.Foundation.CommonRefinement.appendLength,ih]
   rfl

theorem bothDirectionsShareCycle (c : Cycle) :
 ReactionMechanism.Chain c.raw.entering.label c.raw.entering.label c.steps ∧
 ReactionMechanism.Chain c.raw.entering.label c.raw.entering.label (reverseSteps c.steps) :=
 ⟨closedCarrierPath c,reversedTraversal (closedCarrierPath c)⟩

theorem composeCatalyticSegments {a b c : String} {left right : List ReactionMechanism.Step}
 (first : ReactionMechanism.Chain a b left) (second : ReactionMechanism.Chain b c right) :
 ReactionMechanism.Chain a c (left++right) := by
 induction first with
 | one s => exact .cons s second rfl
 | cons s tail adjacent ih => exact .cons s (ih second) adjacent

structure Alternative where
 cycle : Cycle
 initial : String
 terminal : String
 before : List ReactionMechanism.Step
 after : List ReactionMechanism.Step
 beforePath : ReactionMechanism.Chain initial cycle.raw.entering.label before
 afterPath : ReactionMechanism.Chain cycle.raw.entering.label terminal after

def originalPath (a : Alternative) := a.before++a.after
def catalyticPath (a : Alternative) := a.before++(a.cycle.steps++a.after)

theorem originalEndpoints (a : Alternative) : ReactionMechanism.Chain a.initial a.terminal (originalPath a) :=
 composeCatalyticSegments a.beforePath a.afterPath

theorem catalyticEndpoints (a : Alternative) : ReactionMechanism.Chain a.initial a.terminal (catalyticPath a) :=
 composeCatalyticSegments a.beforePath (composeCatalyticSegments (closedCarrierPath a.cycle) a.afterPath)

theorem unchangedNetEndpoints (a : Alternative) :
 a.initial::ReactionMechanism.outputs (originalPath a)=ReactionMechanism.inputs (originalPath a)++[a.terminal] ∧
 a.initial::ReactionMechanism.outputs (catalyticPath a)=ReactionMechanism.inputs (catalyticPath a)++[a.terminal] :=
 ⟨ReactionMechanism.completeEndpointCancellation (originalEndpoints a),
  ReactionMechanism.completeEndpointCancellation (catalyticEndpoints a)⟩

structure Catalyst where
 alternative : Alternative
 recurrence : RecurrenceExtension
 sameCycle : recurrence.cycle=alternative.cycle

theorem catalystReturnAndIncreasedRate (c : Catalyst) :
 c.alternative.cycle.raw.entering=c.alternative.cycle.raw.leaving ∧
 c.recurrence.before.raw.completedEvents.value*(after c.recurrence).raw.recurrenceIntervals.value<
 (after c.recurrence).raw.completedEvents.value*c.recurrence.before.raw.recurrenceIntervals.value :=
 ⟨exactCarrierReturn _,increasedRateCrossProducts _⟩

def originalRaw : Raw := ⟨⟨"chemical-carrier","catalyst-one",rfl,rfl⟩,
 ⟨"chemical-carrier","catalyst-one",rfl,rfl⟩,⟨3,by decide⟩⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
end SFT.Chemistry.CatalystCycle
