import SFT.Chemistry.ReactionIdentity
namespace SFT.Chemistry.ReactionMechanism
structure RawStep where
 identity : String
 inputState : String
 outputState : String

def admitStep (s : RawStep) : Except String RawStep :=
 if !SourceText.nonblank s.identity || !SourceText.nonblank s.inputState || !SourceText.nonblank s.outputState ||
 decide (s.inputState=s.outputState) then
 .error "elementary step requires a named non-identity transition"
 else .ok s
structure Step where
 raw : RawStep
 accepted : admitStep raw=.ok raw

def composable : List Step → Bool
 | [] => true
 | [_] => true
 | a::b::rest => decide (a.raw.outputState=b.raw.inputState) && composable (b::rest)

structure Raw where
 overall : ReactionIdentity.Trace
 steps : List Step

def admit (r : Raw) : Except String Raw :=
 if r.steps.isEmpty then .error "mechanism requires at least one elementary step"
 else if !composable r.steps then .error "mechanism steps do not compose"
 else .ok r

structure Mechanism where
 raw : Raw
 accepted : admit raw=.ok raw

inductive Chain : String → String → List Step → Prop where
 | one (s : Step) : Chain s.raw.inputState s.raw.outputState [s]
 | cons {b c : String} {rows : List Step} (s : Step) (tail : Chain b c rows)
   (adjacent : s.raw.outputState=b) : Chain s.raw.inputState c (s::rows)

theorem appendStep {a b : String} {rows : List Step} (chain : Chain a b rows)
 (next : Step) (adjacent : b=next.raw.inputState) :
 Chain a next.raw.outputState (rows++[next]) := by
 induction chain with
 | one s => exact .cons s (.one next) adjacent
 | cons s tail held ih => exact .cons s (ih adjacent) held

def inputs (rows : List Step) := rows.map fun s => s.raw.inputState
def outputs (rows : List Step) := rows.map fun s => s.raw.outputState

theorem completeEndpointCancellation {a b : String} {rows : List Step}
 (chain : Chain a b rows) : a::outputs rows = inputs rows++[b] := by
 induction chain with
 | one s => rfl
 | cons s tail adjacent ih =>
   change s.raw.inputState::s.raw.outputState::_ = s.raw.inputState::_
   rw [adjacent]
   exact congrArg (List.cons s.raw.inputState) ih

theorem chainFromComposable (first : Step) (rest : List Step)
 (passed : composable (first::rest)=true) : ∃ last, Chain first.raw.inputState last (first::rest) := by
 induction rest generalizing first with
 | nil => exact ⟨first.raw.outputState,.one first⟩
 | cons next rest ih =>
   change (decide (first.raw.outputState=next.raw.inputState) && composable (next::rest))=true at passed
   cases edge : decide (first.raw.outputState=next.raw.inputState) <;>
    cases tail : composable (next::rest) <;> rw [edge,tail] at passed
   · cases passed
   · cases passed
   · cases passed
   · obtain ⟨last,path⟩ := ih next tail
     exact ⟨last,.cons first path (of_decide_eq_true edge)⟩

theorem acceptedHasCompleteChain (m : Mechanism) : ∃ first last, Chain first last m.raw.steps := by
 have accepted := m.accepted
 cases rows : m.raw.steps with
 | nil => unfold admit at accepted; rw [rows] at accepted; cases accepted
 | cons first rest =>
   have passed : composable (first::rest)=true := by
    cases h : composable (first::rest)
    · unfold admit at accepted; rw [rows,h] at accepted; cases accepted
    · rfl
   obtain ⟨last,chain⟩ := chainFromComposable first rest passed
   exact ⟨first.raw.inputState,last,chain⟩

theorem priorStepRetained (rows : List Step) (next old : Step) (held : old∈rows) :
 old∈rows++[next] := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

structure BoundStep where
 step : Step
 reaction : ReactionIdentity.Reaction

-- All elementary source reactions retain their complete occurrence records.
def chemicalFlows (steps : List BoundStep) := ReactionIdentity.flows (steps.flatMap fun s => s.reaction.placements)

theorem eachStepConserves (s : BoundStep) (test : ReactionIdentity.HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (ReactionIdentity.flows s.reaction.placements)=
 SFT.Physics.MatterConservedLabels.outputCount test (ReactionIdentity.flows s.reaction.placements) :=
 ReactionIdentity.noCarrierLoss _ _

theorem wholeMechanismConserves (steps : List BoundStep) (test : ReactionIdentity.HeldLabel → Bool) :
 SFT.Physics.MatterConservedLabels.inputCount test (chemicalFlows steps)=
 SFT.Physics.MatterConservedLabels.outputCount test (chemicalFlows steps) := ReactionIdentity.noCarrierLoss _ _

theorem chainCarrierConservation {a b : String} {rows : List Step} (chain : Chain a b rows)
 (carriers : String → List ReactionIdentity.HeldLabel)
 (closed : ∀ row ∈ rows, carriers row.raw.inputState=carriers row.raw.outputState) : carriers a=carriers b := by
 induction chain with
 | one s => exact closed s (.head _)
 | cons s tail adjacent ih =>
   have first := closed s (.head _)
   rw [adjacent] at first
   exact first.trans (ih (fun row held => closed row (.tail s held)))

theorem boundCarrierSteps (steps : List BoundStep) (carriers : String → List ReactionIdentity.HeldLabel)
 (binding : ∀ row ∈ steps, row.reaction.trace.raw.conservedCarriers=carriers row.step.raw.inputState ∧
 row.reaction.trace.raw.conservedCarriers=carriers row.step.raw.outputState)
 (step : Step) (held : step∈steps.map BoundStep.step) : carriers step.raw.inputState=carriers step.raw.outputState := by
 induction steps with
 | nil => cases held
 | cons row rest ih =>
   cases held with
   | head => exact (binding row (.head _)).1.symm.trans (binding row (.head _)).2
   | tail _ later => exact ih (fun r h => binding r (.tail row h)) later

structure BoundMechanism where
 mechanism : Mechanism
 steps : List BoundStep
 stepBinding : steps.map BoundStep.step=mechanism.raw.steps
 firstState : String
 finalState : String
 chain : Chain firstState finalState mechanism.raw.steps
 overall : ReactionIdentity.Reaction
 overallBinding : overall.trace=mechanism.raw.overall
 organization : String → List String
 inputBinding : ∀ row ∈ steps, row.reaction.trace.raw.reactants=organization row.step.raw.inputState
 outputBinding : ∀ row ∈ steps, row.reaction.trace.raw.products=organization row.step.raw.outputState
 overallInput : overall.trace.raw.reactants=organization firstState
 overallOutput : overall.trace.raw.products=organization finalState
 carriers : String → List ReactionIdentity.HeldLabel
 carrierBinding : ∀ row ∈ steps, row.reaction.trace.raw.conservedCarriers=carriers row.step.raw.inputState ∧
  row.reaction.trace.raw.conservedCarriers=carriers row.step.raw.outputState
 overallCarriers : overall.trace.raw.conservedCarriers=carriers firstState

theorem completeOverallRetained (m : BoundMechanism) : m.overall.trace=m.mechanism.raw.overall := m.overallBinding

theorem internalStatesCancel (m : BoundMechanism) :
 m.firstState::outputs m.mechanism.raw.steps=inputs m.mechanism.raw.steps++[m.finalState] :=
 completeEndpointCancellation m.chain

theorem sameOverallEndpoints (m : BoundMechanism) :
 m.mechanism.raw.overall.raw.reactants=m.organization m.firstState ∧
 m.mechanism.raw.overall.raw.products=m.organization m.finalState := by
 rw [← m.overallBinding]; exact ⟨m.overallInput,m.overallOutput⟩

theorem completeEndpointCarriers (m : BoundMechanism) :
 m.overall.trace.raw.conservedCarriers=m.carriers m.finalState := by
 apply m.overallCarriers.trans
 apply chainCarrierConservation m.chain m.carriers
 intro row held
 rw [← m.stepBinding] at held
 exact boundCarrierSteps m.steps m.carriers m.carrierBinding row held

def retainedStepHistory (steps : List BoundStep) := steps.map fun s => (s.step,s.reaction.trace)
theorem completeStepWord (steps : List BoundStep) : (retainedStepHistory steps).map Prod.fst=steps.map BoundStep.step := by
 induction steps with
 | nil => rfl
 | cons s rest ih => exact congrArg (List.cons s.step) ih

theorem sourceSuccessor (steps : List BoundStep) (next : BoundStep) :
 retainedStepHistory (steps++[next])=retainedStepHistory steps++[(next.step,next.reaction.trace)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Chemistry.ReactionMechanism
