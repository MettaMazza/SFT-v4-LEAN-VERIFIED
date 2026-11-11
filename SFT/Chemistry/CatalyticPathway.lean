import SFT.Chemistry.CatalystCycle
import SFT.Chemistry.ReactionActivation
import SFT.Chemistry.ReactionThermochemistry
namespace SFT.Chemistry.CatalyticPathway
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Path where
 activation : ReactionActivation.Path
 conditions : HeldLabel
 energies : List ReactionThermochemistry.Record
 completeEnergySteps : energies.map (fun e => e.reaction)=activation.mechanism.steps.map (fun s => s.reaction)
 sameConditions : ∀ e∈energies, e.raw.conditions=conditions

def support (p : Path) := ReactionActivation.increment p.activation

def lower (original alternative : Path) : Bool := decide (support alternative<support original)

theorem lowerExactly (original alternative : Path) :
 lower original alternative=true ↔ support alternative<support original := by
 unfold lower
 constructor
 · exact of_decide_eq_true
 · exact decide_eq_true

theorem cannotSelectHigher (original alternative : Path)
 (held : support original≤support alternative) : lower original alternative=false := by
 unfold lower
 exact decide_eq_false (Nat.not_lt_of_ge held)

theorem cannotSelectTie (original alternative : Path) (same : support original=support alternative) :
 lower original alternative=false := cannotSelectHigher _ _ (Nat.le_of_eq same)

structure Comparison where
 original : Path
 alternative : Path
 sameInitial : original.activation.mechanism.firstState=alternative.activation.mechanism.firstState
 sameTerminal : original.activation.mechanism.finalState=alternative.activation.mechanism.finalState
 sameReaction : original.activation.mechanism.overall=alternative.activation.mechanism.overall
 sameConditions : original.conditions=alternative.conditions
 sameReference : original.activation.reference=alternative.activation.reference
 cycle : CatalystCycle.Cycle
 before : List ReactionMechanism.Step
 after : List ReactionMechanism.Step
 cycleIncluded : alternative.activation.mechanism.mechanism.raw.steps=before++(cycle.steps++after)

theorem sameOverallReaction (p : Comparison) :
 p.original.activation.mechanism.mechanism.raw.overall=p.alternative.activation.mechanism.mechanism.raw.overall := by
 rw [← p.original.activation.mechanism.overallBinding,← p.alternative.activation.mechanism.overallBinding,p.sameReaction]

theorem originalIntermediatesCancel (p : Comparison) :
 p.original.activation.mechanism.firstState::ReactionMechanism.outputs p.original.activation.mechanism.mechanism.raw.steps=
 ReactionMechanism.inputs p.original.activation.mechanism.mechanism.raw.steps++[p.original.activation.mechanism.finalState] :=
 ReactionMechanism.internalStatesCancel _

theorem alternativeIntermediatesCancel (p : Comparison) :
 p.original.activation.mechanism.firstState::ReactionMechanism.outputs p.alternative.activation.mechanism.mechanism.raw.steps=
 ReactionMechanism.inputs p.alternative.activation.mechanism.mechanism.raw.steps++[p.original.activation.mechanism.finalState] := by
 rw [p.sameInitial,p.sameTerminal]
 exact ReactionMechanism.internalStatesCancel _

theorem everyStepBalanced (p : Path) (step : ReactionMechanism.BoundStep)
 (held : step∈p.activation.mechanism.steps) (test : HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (ReactionIdentity.flows step.reaction.placements)=
 SFT.Physics.MatterConservedLabels.outputCount test (ReactionIdentity.flows step.reaction.placements) :=
 ReactionMechanism.eachStepConserves _ _

theorem completePathBalanced (p : Path) (test : HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (ReactionMechanism.chemicalFlows p.activation.mechanism.steps)=
 SFT.Physics.MatterConservedLabels.outputCount test (ReactionMechanism.chemicalFlows p.activation.mechanism.steps) :=
 ReactionMechanism.wholeMechanismConserves _ _

theorem catalystReturns (p : Comparison) : p.cycle.raw.entering=p.cycle.raw.leaving :=
 CatalystCycle.exactCarrierReturn _

theorem completeCycleRetained (p : Comparison) :
 p.alternative.activation.mechanism.mechanism.raw.steps=p.before++(p.cycle.steps++p.after) := p.cycleIncluded

theorem activationIsLeast (p : Path) (added : Nat)
 (crosses : ReactionActivation.count (ReactionActivation.peak p.activation)≤added+ReactionActivation.count p.activation.first) :
 support p≤added := ReactionActivation.leastCrossing _ _ crosses

theorem activationReachesEveryState (p : Path) (state : ReactionActivation.State)
 (held : state∈p.activation.first::p.activation.rest) :
 ReactionActivation.count state≤support p+ReactionActivation.count p.activation.first :=
 ReactionActivation.everyBoundaryReached _ _ held

theorem activationPeakRetained (p : Path) :
 ReactionActivation.peak p.activation∈p.activation.first::p.activation.rest := ReactionActivation.peakIsSourceBoundary _

structure Selected where
 comparison : Comparison
 accepted : lower comparison.original comparison.alternative=true

theorem selectedStrictlyLower (p : Selected) : support p.comparison.alternative<support p.comparison.original :=
 (lowerExactly _ _).mp p.accepted

theorem selectedOriginalSupportNotMinimal (p : Selected) :
 ¬support p.comparison.original≤support p.comparison.alternative := Nat.not_le_of_lt (selectedStrictlyLower p)

def sourceTrace (p : Comparison) :=
 (ReactionMechanism.retainedStepHistory p.original.activation.mechanism.steps,
 ReactionMechanism.retainedStepHistory p.alternative.activation.mechanism.steps,
 p.original.activation.first::p.original.activation.rest,
 p.alternative.activation.first::p.alternative.activation.rest,
 p.original.energies,p.alternative.energies,p.original.conditions,p.cycle.sourceRecord)

-- A balanced extension returning to the existing endpoint keeps that endpoint.
theorem balancedExtensionEndpoints (p : Path) (cycle : CatalystCycle.Cycle)
 (atEndpoint : p.activation.mechanism.finalState=cycle.raw.entering.label) :
 ReactionMechanism.Chain p.activation.mechanism.firstState p.activation.mechanism.finalState
 (p.activation.mechanism.mechanism.raw.steps++cycle.steps) := by
 have h := CatalystCycle.closedCarrierPath cycle
 rw [← atEndpoint] at h
 exact CatalystCycle.composeCatalyticSegments p.activation.mechanism.chain h

theorem balancedExtensionCancellation (p : Path) (cycle : CatalystCycle.Cycle)
 (atEndpoint : p.activation.mechanism.finalState=cycle.raw.entering.label) :
 p.activation.mechanism.firstState::ReactionMechanism.outputs (p.activation.mechanism.mechanism.raw.steps++cycle.steps)=
 ReactionMechanism.inputs (p.activation.mechanism.mechanism.raw.steps++cycle.steps)++[p.activation.mechanism.finalState] :=
 ReactionMechanism.completeEndpointCancellation (balancedExtensionEndpoints p cycle atEndpoint)

theorem energySuccessor (energies : List ReactionThermochemistry.Record) (next : ReactionThermochemistry.Record) :
 (energies++[next]).map (fun e => e.reaction)=energies.map (fun e => e.reaction)++[next.reaction] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem activationSuccessor (p : Path) (fresh : ReactionActivation.State) :
 ReactionActivation.count (ReactionActivation.maximum p.activation.first (p.activation.rest++[fresh]))-
 ReactionActivation.count p.activation.first=
 if ReactionActivation.count (ReactionActivation.peak p.activation)<ReactionActivation.count fresh then
 ReactionActivation.count fresh-ReactionActivation.count p.activation.first else support p :=
 ReactionActivation.successorIncrement _ _

theorem everyPriorStateRetained (p : Path) (fresh old : ReactionActivation.State)
 (held : old∈p.activation.first::p.activation.rest) : old∈p.activation.first::(p.activation.rest++[fresh]) :=
 ReactionActivation.successorRetainsPrior _ _ _ held

theorem completeChemicalSuccessor (steps : List ReactionMechanism.BoundStep) (next : ReactionMechanism.BoundStep) :
 ReactionMechanism.retainedStepHistory (steps++[next])=
 ReactionMechanism.retainedStepHistory steps++[(next.step,next.reaction.trace)] :=
 ReactionMechanism.sourceSuccessor _ _
end SFT.Chemistry.CatalyticPathway
