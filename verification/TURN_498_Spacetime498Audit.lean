import SFT.Physics.MechanicalLocation
import SFT.Physics.FieldLocality
namespace SFT.Physics.SpacetimeEvent
open MechanicalEvents MechanicalDuration MechanicalLocation FieldLocality

-- spacetime_gravity_laws.py EVENT_RELATION: retain the source transition,
-- generated recurrence clock, spatial relation and complete causal predecessor.
structure Relation (State Clock Support : Type)
    (adjacent : Event State → Event State → Prop) where
  source : Event State
  before : Event State
  after : Event State
  transition : Change before after
  clock : Recurrence Clock
  spatial : Displacement Support
  predecessors : Propagation adjacent source before
  terminalAdjacent : adjacent before after

def completePath {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
    (r : Relation State Clock Support adjacent) : Propagation adjacent r.source r.after :=
  .append r.predecessors r.transition r.terminalAdjacent

def transitionRecord {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
    (r : Relation State Clock Support adjacent) := row r.transition

def eventRecords {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
    (r : Relation State Clock Support adjacent) := events (trace (completePath r))

def causalRecords {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
    (r : Relation State Clock Support adjacent) := changes (trace (completePath r))

def elapsedRelation {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
    (r : Relation State Clock Support adjacent) := elapsed (trace (completePath r)) r.clock

variable {State Clock Support : Type} {adjacent : Event State → Event State → Prop}

theorem retainsBothStates (r : Relation State Clock Support adjacent) :
 (transitionRecord r).before = r.before ∧ (transitionRecord r).after = r.after := ⟨rfl,rfl⟩

theorem retainsSourceAction (r : Relation State Clock Support adjacent) :
 (transitionRecord r).sourceIdentity = r.transition.sourceIdentity ∧
 (transitionRecord r).actionRecord = r.transition.actionRecord := ⟨rfl,rfl⟩

theorem completePredecessorEvents (r : Relation State Clock Support adjacent) :
 eventRecords r = events (trace r.predecessors) ++ [r.after] := rfl

theorem completePredecessorChanges (r : Relation State Clock Support adjacent) :
 causalRecords r = changes (trace r.predecessors) ++ [transitionRecord r] := rfl

theorem addsExactlyOneTransition (r : Relation State Clock Support adjacent) :
 count (trace (completePath r)) = count (trace r.predecessors)+1 :=
 successorAddsOne _ _

theorem clockRelationPresent (r : Relation State Clock Support adjacent) :
 elapsedRelation r ≠ .emptyOne := successorDurationPresent _ _ _

theorem completePathPositive (r : Relation State Clock Support adjacent) :
 0 < count (trace (completePath r)) := by
 rw [addsExactlyOneTransition]
 exact Nat.zero_lt_succ _

theorem recurrenceRatioExact (r : Relation State Clock Support adjacent) :
 count (trace (completePath r)) *
   (positiveRatio (trace (completePath r)) r.clock (completePathPositive r)).denominator =
 (positiveRatio (trace (completePath r)) r.clock (completePathPositive r)).numerator * count r.clock.path := by
 exact exactRecurrenceRatio _ _ _

theorem allPredecessorsAdjacent (r : Relation State Clock Support adjacent) :
 ∀ entry ∈ causalRecords r, adjacent entry.before entry.after :=
 everyTransitionAdjacent (completePath r)

theorem fullSourceTrace (r : Relation State Clock Support adjacent) :
 (causalRecords r).map (fun x => (x.sourceIdentity,x.actionRecord)) =
 sourceRecords (trace (completePath r)) := allSourceRecordsRetained _

theorem spatialSupportPositive (r : Relation State Clock Support adjacent) :
 0 < r.spatial.separation.numerator := r.spatial.separation.positive

def extend (r : Relation State Clock Support adjacent) (next : Event State)
    (step : Change r.after next) (edge : adjacent r.after next)
    (spatial : Displacement Support) : Relation State Clock Support adjacent :=
 ⟨r.source,r.after,next,step,r.clock,spatial,completePath r,edge⟩

theorem extensionPreservesEvents (r : Relation State Clock Support adjacent)
 (next : Event State) (step : Change r.after next) (edge : adjacent r.after next)
 (spatial : Displacement Support) :
 eventRecords (extend r next step edge spatial) = eventRecords r ++ [next] := rfl

theorem extensionPreservesChanges (r : Relation State Clock Support adjacent)
 (next : Event State) (step : Change r.after next) (edge : adjacent r.after next)
 (spatial : Displacement Support) :
 causalRecords (extend r next step edge spatial) = causalRecords r ++ [row step] := rfl

theorem extensionRetainsSourceAndClock (r : Relation State Clock Support adjacent)
 (next : Event State) (step : Change r.after next) (edge : adjacent r.after next)
 (spatial : Displacement Support) :
 (extend r next step edge spatial).source = r.source ∧
 (extend r next step edge spatial).clock = r.clock := ⟨rfl,rfl⟩

theorem distinctSpatialRelationRetained (r s : Relation State Clock Support adjacent)
 (different : r.spatial ≠ s.spatial) : r ≠ s :=
 fun equal => different (congrArg Relation.spatial equal)

theorem distinctClockRetained (r s : Relation State Clock Support adjacent)
 (different : r.clock ≠ s.clock) : r ≠ s :=
 fun equal => different (congrArg Relation.clock equal)

theorem distinctSourceRetained (r s : Relation State Clock Support adjacent)
 (different : r.source ≠ s.source) : r ≠ s :=
 fun equal => different (congrArg Relation.source equal)

theorem fullRelationReconstruction (r : Relation State Clock Support adjacent) :
 (⟨r.source,r.before,r.after,r.transition,r.clock,r.spatial,r.predecessors,r.terminalAdjacent⟩ :
 Relation State Clock Support adjacent) = r := rfl
end SFT.Physics.SpacetimeEvent

#print axioms SFT.Physics.SpacetimeEvent.Relation
#print axioms SFT.Physics.SpacetimeEvent.completePath
#print axioms SFT.Physics.SpacetimeEvent.transitionRecord
#print axioms SFT.Physics.SpacetimeEvent.eventRecords
#print axioms SFT.Physics.SpacetimeEvent.causalRecords
#print axioms SFT.Physics.SpacetimeEvent.elapsedRelation
#print axioms SFT.Physics.SpacetimeEvent.retainsBothStates
#print axioms SFT.Physics.SpacetimeEvent.retainsSourceAction
#print axioms SFT.Physics.SpacetimeEvent.completePredecessorEvents
#print axioms SFT.Physics.SpacetimeEvent.completePredecessorChanges
#print axioms SFT.Physics.SpacetimeEvent.addsExactlyOneTransition
#print axioms SFT.Physics.SpacetimeEvent.clockRelationPresent
#print axioms SFT.Physics.SpacetimeEvent.completePathPositive
#print axioms SFT.Physics.SpacetimeEvent.recurrenceRatioExact
#print axioms SFT.Physics.SpacetimeEvent.allPredecessorsAdjacent
#print axioms SFT.Physics.SpacetimeEvent.fullSourceTrace
#print axioms SFT.Physics.SpacetimeEvent.spatialSupportPositive
#print axioms SFT.Physics.SpacetimeEvent.extend
#print axioms SFT.Physics.SpacetimeEvent.extensionPreservesEvents
#print axioms SFT.Physics.SpacetimeEvent.extensionPreservesChanges
#print axioms SFT.Physics.SpacetimeEvent.extensionRetainsSourceAndClock
#print axioms SFT.Physics.SpacetimeEvent.distinctSpatialRelationRetained
#print axioms SFT.Physics.SpacetimeEvent.distinctClockRetained
#print axioms SFT.Physics.SpacetimeEvent.distinctSourceRetained
#print axioms SFT.Physics.SpacetimeEvent.fullRelationReconstruction