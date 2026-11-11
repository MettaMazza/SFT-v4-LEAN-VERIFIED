import SFT.Chemistry.ReactionRate
namespace SFT.Chemistry.KineticOrder
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
structure Raw where
 reactant : String
 dependencies : List HeldLabel

def admit (r : Raw) : Except String Raw :=
 if !SourceText.nonblank r.reactant ||
 !(r.dependencies.all fun d => SFT.Host.Text.equal d.family "kinetic-dependency") then
 .error "kinetic order requires one reactant and retained dependency occurrences"
 else .ok r

inductive Order where
 | empty
 | positive : PositiveCount → Order

def order : List HeldLabel → Order
 | [] => .empty
 | first::rest => .positive ⟨rest.length+1,Nat.zero_lt_succ _⟩

theorem emptyExactly (rows : List HeldLabel) : order rows=.empty ↔ rows=[] := by
 constructor
 · intro h
   cases rows with
   | nil => rfl
   | cons first rest => cases h
 · intro h; rw [h]; rfl

theorem positiveExactly (first : HeldLabel) (rest : List HeldLabel) :
 order (first::rest)=.positive ⟨(first::rest).length,Nat.zero_lt_succ _⟩ := rfl

def record (r : Raw) := (r.reactant,r.dependencies,order r.dependencies)
theorem completeOccurrenceWord (r : Raw) : (record r).2.1=r.dependencies := rfl

def appendDependency (r : Raw) (fresh : HeldLabel) : Raw := {r with dependencies:=r.dependencies++[fresh]}
theorem appendRetainsCoordinate (r : Raw) (fresh : HeldLabel) :
 (appendDependency r fresh).reactant=r.reactant := rfl

theorem appendRetainsOccurrence (r : Raw) (fresh prior : HeldLabel) (held : prior∈r.dependencies) :
 prior∈(appendDependency r fresh).dependencies := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem appendMultiplicity (r : Raw) (fresh : HeldLabel) :
 (appendDependency r fresh).dependencies.length=r.dependencies.length+1 :=
 SFT.Foundation.CommonRefinement.appendLength _ _

theorem base (dependency : HeldLabel) : order [dependency]=.positive ⟨1,by decide⟩ := rfl

-- Raw labels are retained with repetitions: distinct occurrences are positions,
-- not a deduplicated set of label strings.
structure Intervention where
 reactant : String
 beforeAmount : PositiveCount
 afterAmount : PositiveCount
 changedCoordinate : beforeAmount.value≠afterAmount.value
 coordinate : HeldLabel
 coordinateName : coordinate.label=reactant
 priorCoordinates : List (HeldLabel × PositiveCount)
 laterCoordinates : List (HeldLabel × PositiveCount)
 beforeRate : ReactionRate.Observation
 afterRate : ReactionRate.Observation
 beforeAmounts : beforeRate.speciesAmounts=priorCoordinates++((coordinate,beforeAmount)::laterCoordinates)
 afterAmounts : afterRate.speciesAmounts=priorCoordinates++((coordinate,afterAmount)::laterCoordinates)
 sameReaction : beforeRate.reactionIdentity=afterRate.reactionIdentity
 sameBoundary : beforeRate.raw.observedBoundary=afterRate.raw.observedBoundary
 sameConditions : beforeRate.conditions=afterRate.conditions
 sourceTrace : SFT.Host.Canonical.Value

structure DependencyOccurrence where
 label : HeldLabel
 sourceIntervention : Intervention
 family : SFT.Host.Text.equal label.family "kinetic-dependency"=true

structure Census where
 raw : Raw
 accepted : admit raw=.ok raw
 interventions : List Intervention
 conditions : SFT.Host.Canonical.Value
 reactionIdentity : HeldLabel
 contextBound : ∀ row∈interventions, row.beforeRate.conditions=conditions ∧
  row.beforeRate.reactionIdentity=reactionIdentity ∧ row.reactant=raw.reactant
 occurrences : List DependencyOccurrence
 completeOccurrences : occurrences.map DependencyOccurrence.label=raw.dependencies
 sourceHeld : ∀ d∈occurrences, d.sourceIntervention∈interventions
 coordinateBound : ∀ d∈occurrences, d.sourceIntervention.reactant=raw.reactant

theorem noUnrecordedOccurrence (c : Census) (label : HeldLabel) (held : label∈c.raw.dependencies) :
 ∃ d∈c.occurrences, d.label=label ∧ d.sourceIntervention∈c.interventions := by
 rw [← c.completeOccurrences] at held
 obtain ⟨d,hd,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
 exact ⟨d,hd,eq,c.sourceHeld d hd⟩

theorem completeCensusMultiplicity (c : Census) : c.occurrences.length=c.raw.dependencies.length := by
 rw [← c.completeOccurrences]
 exact (SFT.Foundation.CommonRefinement.mapLength _ _).symm

def appendIndependentRow (c : Census) (row : Intervention)
 (context : row.beforeRate.conditions=c.conditions ∧ row.beforeRate.reactionIdentity=c.reactionIdentity ∧ row.reactant=c.raw.reactant) : Census where
 raw := c.raw
 accepted := c.accepted
 interventions := c.interventions++[row]
 conditions := c.conditions
 reactionIdentity := c.reactionIdentity
 contextBound := by
  intro r held
  cases SFT.Foundation.Count.TraceDerivation.memAppendCases r c.interventions [row] held with
  | inl h => exact c.contextBound r h
  | inr h => cases h with
    | head => exact context
    | tail _ h => cases h
 occurrences := c.occurrences
 completeOccurrences := c.completeOccurrences
 sourceHeld := fun d held => SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ (c.sourceHeld d held)
 coordinateBound := c.coordinateBound

theorem noNewOccurrenceNoOrderChange (c : Census) (row : Intervention)
 (context : row.beforeRate.conditions=c.conditions ∧ row.beforeRate.reactionIdentity=c.reactionIdentity ∧ row.reactant=c.raw.reactant) :
 order (appendIndependentRow c row context).raw.dependencies=order c.raw.dependencies := rfl

theorem priorInterventionRetained (c : Census) (row old : Intervention)
 (context : row.beforeRate.conditions=c.conditions ∧ row.beforeRate.reactionIdentity=c.reactionIdentity ∧ row.reactant=c.raw.reactant) (held : old∈c.interventions) :
 old∈(appendIndependentRow c row context).interventions := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

def appendForcedOccurrence (c : Census) (fresh : DependencyOccurrence)
 (held : fresh.sourceIntervention∈c.interventions)
 (coordinate : fresh.sourceIntervention.reactant=c.raw.reactant)
 (accepted : admit (appendDependency c.raw fresh.label)=.ok (appendDependency c.raw fresh.label)) : Census where
 raw := appendDependency c.raw fresh.label
 accepted := accepted
 interventions := c.interventions
 conditions := c.conditions
 reactionIdentity := c.reactionIdentity
 contextBound := c.contextBound
 occurrences := c.occurrences++[fresh]
 completeOccurrences := by
  rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,c.completeOccurrences]
  rfl
 sourceHeld := by
  intro d hd
  cases SFT.Foundation.Count.TraceDerivation.memAppendCases d c.occurrences [fresh] hd with
  | inl h => exact c.sourceHeld d h
  | inr h => cases h with
    | head => exact held
    | tail _ h => cases h
 coordinateBound := by
  intro d hd
  cases SFT.Foundation.Count.TraceDerivation.memAppendCases d c.occurrences [fresh] hd with
  | inl h => exact c.coordinateBound d h
  | inr h => cases h with
    | head => exact coordinate
    | tail _ h => cases h

theorem forcedSuccessorMultiplicity (c : Census) (fresh : DependencyOccurrence)
 (held : fresh.sourceIntervention∈c.interventions)
 (coordinate : fresh.sourceIntervention.reactant=c.raw.reactant)
 (accepted : admit (appendDependency c.raw fresh.label)=.ok (appendDependency c.raw fresh.label)) :
 (appendForcedOccurrence c fresh held coordinate accepted).raw.dependencies.length=c.raw.dependencies.length+1 :=
 appendMultiplicity _ _
end SFT.Chemistry.KineticOrder
