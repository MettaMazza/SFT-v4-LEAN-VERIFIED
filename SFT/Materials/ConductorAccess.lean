import SFT.Materials.CarrierAccess
import SFT.Physics.CollectiveBand
import SFT.Mathematics.ExactRatioRelations
namespace SFT.Materials.ConductorAccess
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.FractionReduction SFT.Foundation.ExactOperations

-- V3 obligations.py ELEC-CONDUCTOR-CLASS: occupied/access support, retained
-- filling and finite activation gap, at the declared transport conditions.
-- These records hold the declared carrier relations; they introduce no fitted
-- conductivity law or numerical threshold.
structure Relation where
 nodes : List String
 edges : List Edge
 graph : GeneratedGraph
 accepted : makeGraph nodes edges = .ok graph

structure Activation where
 relation : Relation
 gap : PositiveFraction

structure Boundary where
 occupied : List String
 accessible : List String
 direct : Relation
 activated : Option Activation
 conditions : String
 band : SFT.Physics.CollectiveBand.Boundary
 directBandSupport : ∀ label, label ∈ direct.graph.nodes ↔
   ∃ trace, trace ∈ SFT.Physics.CollectiveBand.support band ∧ band.observedClass trace = label
 occupiedHeld : ∀ label, label ∈ occupied → label ∈ direct.graph.nodes
 accessibleHeld : ∀ label, label ∈ accessible → label ∈ direct.graph.nodes
 activatedBandSupport : ∀ a, activated = some a → ∀ label,
   label ∈ a.relation.graph.nodes ↔ label ∈ direct.graph.nodes

def directPaths (b : Boundary) := CarrierAccess.paths b.direct.graph b.occupied b.accessible
def activatedPaths (b : Boundary) :=
 match b.activated with
 | none => []
 | some a => CarrierAccess.paths a.relation.graph b.occupied b.accessible

inductive Class where
 | conductor | semiconductor | insulator
 deriving DecidableEq

def classify (b : Boundary) : Class :=
 match directPaths b with
 | _ :: _ => .conductor
 | [] => match activatedPaths b with
   | _ :: _ => .semiconductor
   | [] => .insulator

theorem conductorExactly (b : Boundary) : classify b = .conductor ↔ directPaths b ≠ [] := by
 unfold classify
 cases hd : directPaths b with
 | nil =>
   cases activatedPaths b <;> constructor
   · intro h; cases h
   · intro h; exact False.elim (h rfl)
   · intro h; cases h
   · intro h; exact False.elim (h rfl)
 | cons first rest =>
   constructor
   · intro _ h; cases h
   · intro _; rfl

theorem semiconductorExactly (b : Boundary) : classify b = .semiconductor ↔
 directPaths b = [] ∧ activatedPaths b ≠ [] := by
 unfold classify
 cases hd : directPaths b with
 | nil =>
   cases ha : activatedPaths b with
   | nil =>
     constructor
     · intro h; cases h
     · intro h; exact False.elim (h.2 rfl)
   | cons first rest =>
     constructor
     · intro _; exact ⟨rfl,fun h => by cases h⟩
     · intro _; rfl
 | cons first rest =>
   constructor
   · intro h; cases h
   · intro h; cases h.1

theorem insulatorExactly (b : Boundary) : classify b = .insulator ↔
 directPaths b = [] ∧ activatedPaths b = [] := by
 unfold classify
 cases hd : directPaths b with
 | nil =>
   cases ha : activatedPaths b with
   | nil => constructor <;> intro _; exact ⟨rfl,rfl⟩; rfl
   | cons first rest =>
     constructor
     · intro h; cases h
     · intro h; cases h.2
 | cons first rest =>
   constructor
   · intro h; cases h
   · intro h; cases h.1

theorem directPathExactly (b : Boundary) (source target : String) :
 (source,target) ∈ directPaths b ↔ source ∈ b.occupied ∧ target ∈ b.accessible ∧
 PathWitness b.direct.graph source target :=
 CarrierAccess.connectionExactly b.direct.nodes b.direct.edges b.direct.graph b.direct.accepted _ _ _ _

theorem activatedPathExactly (b : Boundary) (a : Activation) (held : b.activated = some a)
 (source target : String) :
 (source,target) ∈ activatedPaths b ↔ source ∈ b.occupied ∧ target ∈ b.accessible ∧
 PathWitness a.relation.graph source target := by
 unfold activatedPaths
 rw [held]
 exact CarrierAccess.connectionExactly a.relation.nodes a.relation.edges
  a.relation.graph a.relation.accepted _ _ _ _

theorem noActivationNoActivatedPaths (b : Boundary) (held : b.activated = none) :
 activatedPaths b = [] := by unfold activatedPaths; rw [held]

theorem insulationExcludesDirectPaths (b : Boundary) (insulating : classify b = .insulator) :
 ∀ source, source ∈ b.occupied → ∀ target, target ∈ b.accessible →
   ¬ PathWitness b.direct.graph source target :=
 (CarrierAccess.noConnectionExactly _ _ _ b.direct.accepted _ _).mp
  ((insulatorExactly b).mp insulating).1

theorem insulationExcludesActivatedPaths (b : Boundary) (insulating : classify b = .insulator)
 (a : Activation) (held : b.activated = some a) :
 ∀ source, source ∈ b.occupied → ∀ target, target ∈ b.accessible →
   ¬ PathWitness a.relation.graph source target := by
 have empty := ((insulatorExactly b).mp insulating).2
 unfold activatedPaths at empty
 rw [held] at empty
 exact (CarrierAccess.noConnectionExactly _ _ _ a.relation.accepted _ _).mp empty

theorem completeClassification (b : Boundary) :
 classify b = .conductor ∨ classify b = .semiconductor ∨ classify b = .insulator := by
 cases classify b with
 | conductor => exact .inl rfl
 | semiconductor => exact .inr (.inl rfl)
 | insulator => exact .inr (.inr rfl)

theorem classificationUnique (b : Boundary) (a c : Class)
 (ha : classify b = a) (hc : classify b = c) : a = c := ha.symm.trans hc

def record (b : Boundary) := (b, directPaths b, activatedPaths b, classify b)

theorem fillingGapConditionsRetained (b : Boundary) :
 (record b).1.occupied = b.occupied ∧ (record b).1.accessible = b.accessible ∧
 (record b).1.activated = b.activated ∧ (record b).1.conditions = b.conditions :=
 ⟨rfl,rfl,rfl,rfl⟩

theorem occupiedComesFromCompleteBand (b : Boundary) (label : String)
 (held : label ∈ b.occupied) :
 ∃ trace, trace ∈ SFT.Physics.CollectiveBand.support b.band ∧ b.band.observedClass trace = label :=
 (b.directBandSupport label).mp (b.occupiedHeld label held)

theorem accessibleComesFromCompleteBand (b : Boundary) (label : String)
 (held : label ∈ b.accessible) :
 ∃ trace, trace ∈ SFT.Physics.CollectiveBand.support b.band ∧ b.band.observedClass trace = label :=
 (b.directBandSupport label).mp (b.accessibleHeld label held)

theorem activationRetainsBandSupport (b : Boundary) (a : Activation) (held : b.activated = some a)
 (label : String) : label ∈ a.relation.graph.nodes ↔
 ∃ trace, trace ∈ SFT.Physics.CollectiveBand.support b.band ∧ b.band.observedClass trace = label :=
 (b.activatedBandSupport a held label).trans (b.directBandSupport label)

theorem activationGapPositive (a : Activation) :
 0 < a.gap.numerator ∧ 0 < a.gap.denominator :=
 ⟨a.gap.positive,Nat.pos_of_ne_zero a.gap.denominatorNonzero⟩
end SFT.Materials.ConductorAccess
