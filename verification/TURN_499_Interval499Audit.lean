import SFT.Physics.SpacetimeEvent
namespace SFT.Physics.SpacetimeInterval
open SFT.Foundation.ExactOperations MechanicalEvents MechanicalDuration MechanicalLocation

-- INTERVAL in spacetime_gravity_laws.py. Reference descriptions vary;
-- the complete exact separation and causal records are retained.
structure Separation (Causal : Type) where
  temporal : Duration
  spatial : PositiveFraction
  orientation : Held
  causal : Causal

structure Description (Causal : Type) where
  separation : Separation Causal
  referenceLabels : List String

variable {Causal : Type}
def canonical (d : Description Causal) : Separation Causal := d.separation

def relabel (d : Description Causal) (labels : List String) : Description Causal :=
 ⟨d.separation,labels⟩

def equivalent (a b : Description Causal) : Prop := canonical a = canonical b

def representative (s : Separation Causal) : Description Causal := ⟨s,[]⟩

theorem reflexive (a : Description Causal) : equivalent a a := rfl

theorem symmetric (a b : Description Causal) (h : equivalent a b) : equivalent b a := h.symm

theorem transitive (a b c : Description Causal) (h : equivalent a b) (k : equivalent b c) :
 equivalent a c := h.trans k

theorem allReferenceLabelsInvariant (d : Description Causal) (labels : List String) :
 canonical (relabel d labels) = canonical d := rfl

theorem representativeExact (s : Separation Causal) : canonical (representative s) = s := rfl

theorem canonicalExactlyOriginalEquivalence (a b : Description Causal) :
 canonical a = canonical b ↔ equivalent a b := ⟨fun h => h,fun h => h⟩

theorem sameClassExactlyReferenceChange (a b : Description Causal) :
 equivalent a b ↔ relabel a b.referenceLabels = b := by
 constructor
 · intro h
   cases a with
   | mk a la => cases b with
     | mk b lb => change a=b at h; cases h; rfl
 · intro h
   have key := congrArg (@canonical Causal) h
   exact key

theorem temporalPreserved (a b : Description Causal) (h : equivalent a b) :
 a.separation.temporal = b.separation.temporal := congrArg Separation.temporal h

theorem spatialPreserved (a b : Description Causal) (h : equivalent a b) :
 a.separation.spatial = b.separation.spatial := congrArg Separation.spatial h

theorem orientationPreserved (a b : Description Causal) (h : equivalent a b) :
 a.separation.orientation = b.separation.orientation := congrArg Separation.orientation h

theorem causalPreserved (a b : Description Causal) (h : equivalent a b) :
 a.separation.causal = b.separation.causal := congrArg Separation.causal h

theorem fullSeparationSuffices (a b : Description Causal)
 (t : a.separation.temporal = b.separation.temporal)
 (s : a.separation.spatial = b.separation.spatial)
 (o : a.separation.orientation = b.separation.orientation)
 (c : a.separation.causal = b.separation.causal) : equivalent a b := by
 cases a with
 | mk a la => cases b with
   | mk b lb => cases a with
     | mk ta sa oa ca => cases b with
       | mk tb sb ob cb => cases t; cases s; cases o; cases c; rfl

-- The universal property is pointwise; no quotient or function-extensionality
-- axiom is used to identify the canonical interval.
def descend {Result : Type} (f : Description Causal → Result) (s : Separation Causal) : Result :=
 f (representative s)

theorem invariantFactorsThroughInterval {Result : Type} (f : Description Causal → Result)
 (invariant : ∀ d labels, f (relabel d labels) = f d) (d : Description Causal) :
 descend f (canonical d) = f d := invariant d []

theorem factorUniqueAtEverySeparation {Result : Type} (f : Description Causal → Result)
 (g : Separation Causal → Result) (factor : ∀ d, g (canonical d) = f d)
 (s : Separation Causal) : g s = descend f s := factor (representative s)

-- Attach the canonical construction to the already generated event relation.
def fromEvent {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
 (r : SpacetimeEvent.Relation State Clock Support adjacent) : Separation (List (Row State)) :=
 ⟨SpacetimeEvent.elapsedRelation r,r.spatial.separation,r.spatial.held,SpacetimeEvent.causalRecords r⟩

theorem eventClockRetained {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
 (r : SpacetimeEvent.Relation State Clock Support adjacent) :
 (fromEvent r).temporal = SpacetimeEvent.elapsedRelation r := rfl

theorem eventOrientedSupportRetained {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
 (r : SpacetimeEvent.Relation State Clock Support adjacent) :
 (fromEvent r).spatial = r.spatial.separation ∧ (fromEvent r).orientation = r.spatial.held := ⟨rfl,rfl⟩

theorem eventCausalRecordsRetained {State Clock Support : Type} {adjacent : Event State → Event State → Prop}
 (r : SpacetimeEvent.Relation State Clock Support adjacent) :
 (fromEvent r).causal = SpacetimeEvent.causalRecords r := rfl

theorem changedTemporalExcluded (a b : Description Causal)
 (different : a.separation.temporal ≠ b.separation.temporal) : ¬ equivalent a b :=
 fun h => different (temporalPreserved a b h)

theorem changedSpatialExcluded (a b : Description Causal)
 (different : a.separation.spatial ≠ b.separation.spatial) : ¬ equivalent a b :=
 fun h => different (spatialPreserved a b h)

theorem changedCausalExcluded (a b : Description Causal)
 (different : a.separation.causal ≠ b.separation.causal) : ¬ equivalent a b :=
 fun h => different (causalPreserved a b h)
end SFT.Physics.SpacetimeInterval

#print axioms SFT.Physics.SpacetimeInterval.Separation
#print axioms SFT.Physics.SpacetimeInterval.Description
#print axioms SFT.Physics.SpacetimeInterval.canonical
#print axioms SFT.Physics.SpacetimeInterval.relabel
#print axioms SFT.Physics.SpacetimeInterval.equivalent
#print axioms SFT.Physics.SpacetimeInterval.representative
#print axioms SFT.Physics.SpacetimeInterval.reflexive
#print axioms SFT.Physics.SpacetimeInterval.symmetric
#print axioms SFT.Physics.SpacetimeInterval.transitive
#print axioms SFT.Physics.SpacetimeInterval.allReferenceLabelsInvariant
#print axioms SFT.Physics.SpacetimeInterval.representativeExact
#print axioms SFT.Physics.SpacetimeInterval.canonicalExactlyOriginalEquivalence
#print axioms SFT.Physics.SpacetimeInterval.sameClassExactlyReferenceChange
#print axioms SFT.Physics.SpacetimeInterval.temporalPreserved
#print axioms SFT.Physics.SpacetimeInterval.spatialPreserved
#print axioms SFT.Physics.SpacetimeInterval.orientationPreserved
#print axioms SFT.Physics.SpacetimeInterval.causalPreserved
#print axioms SFT.Physics.SpacetimeInterval.fullSeparationSuffices
#print axioms SFT.Physics.SpacetimeInterval.descend
#print axioms SFT.Physics.SpacetimeInterval.invariantFactorsThroughInterval
#print axioms SFT.Physics.SpacetimeInterval.factorUniqueAtEverySeparation
#print axioms SFT.Physics.SpacetimeInterval.fromEvent
#print axioms SFT.Physics.SpacetimeInterval.eventClockRetained
#print axioms SFT.Physics.SpacetimeInterval.eventOrientedSupportRetained
#print axioms SFT.Physics.SpacetimeInterval.eventCausalRecordsRetained
#print axioms SFT.Physics.SpacetimeInterval.changedTemporalExcluded
#print axioms SFT.Physics.SpacetimeInterval.changedSpatialExcluded
#print axioms SFT.Physics.SpacetimeInterval.changedCausalExcluded