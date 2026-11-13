import SFT.Physics.ThermoResponse
import SFT.Materials.MaterialCarrier
namespace SFT.Materials.ExcitationSeparation
open SFT.Physics SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

structure Record (C : Type) (context : ThermoResponse.HeldContext) where
 material : MaterialCarrier.Record C
 probe : ThermoResponse.Probe context
 before : MechanicalLocation.Displacement String
 after : MechanicalLocation.Displacement String
 firstIdentity : after.first.referenceIdentity = before.first.referenceIdentity
 secondIdentity : after.second.referenceIdentity = before.second.referenceIdentity
 firstSupport : after.first.support = before.first.support
 secondSupport : after.second.support = before.second.support
 directionHeld : after.held = before.held
 bondLabel : String
 bondHeld : (before.first.referenceIdentity,before.second.referenceIdentity,bondLabel) ∈ material.bonding
 beforeReading : probe.responseBefore.value = .positive .forward before.separation
 afterReading : probe.responseAfter.value = .positive .forward after.separation
 conditions : SFT.Host.Canonical.Value
 temperatureBoundary : SFT.Host.Canonical.Value

variable {C : Type} {context : ThermoResponse.HeldContext}

def separationChange (r : Record C context) := ThermoResponse.responseChange r.probe

def excitationChange (r : Record C context) := ThermoResponse.sourceChange r.probe

def response (r : Record C context) := ThermoResponse.coefficient r.probe

theorem exactSeparationChange (r : Record C context) :
 separationChange r = subtract (.positive .forward r.after.separation) (.positive .forward r.before.separation) := by
 unfold separationChange ThermoResponse.responseChange
 rw [r.beforeReading,r.afterReading]

theorem generatedRecurrence (context : ThermoResponse.HeldContext) :
 SFT.Physics.GeneratorThreeDerivation.FirstReturn context.source context.recurrence :=
 ThermoResponse.recurrenceIsGenerated context

theorem allReadingsRecur (r : Record C context) :
 r.probe.sourceBefore.recurrenceState ∈ context.source::context.recurrence ∧
 r.probe.sourceAfter.recurrenceState ∈ context.source::context.recurrence ∧
 r.probe.responseBefore.recurrenceState ∈ context.source::context.recurrence ∧
 r.probe.responseAfter.recurrenceState ∈ context.source::context.recurrence :=
 ThermoResponse.allReadingsInSameRecurrence r.probe

theorem sameConstituentPair (r : Record C context) :
 r.after.first.referenceIdentity = r.before.first.referenceIdentity ∧
 r.after.second.referenceIdentity = r.before.second.referenceIdentity ∧
 r.after.first.support = r.before.first.support ∧
 r.after.second.support = r.before.second.support ∧ r.after.held = r.before.held :=
 ⟨r.firstIdentity,r.secondIdentity,r.firstSupport,r.secondSupport,r.directionHeld⟩

theorem retainedAdjacency (r : Record C context) :
 (r.after.first.referenceIdentity,r.after.second.referenceIdentity,r.bondLabel) ∈ r.material.bonding := by
 rw [r.firstIdentity,r.secondIdentity]
 exact r.bondHeld

theorem responseFromOriginalChanges (r : Record C context) :
 response r = ThermoTemperature.divideScalar (separationChange r) (excitationChange r) := rfl

theorem unchangedExcitationBoundary (r : Record C context)
 (same : r.probe.sourceAfter.value = r.probe.sourceBefore.value) :
 response r = .error "division by structural empty-One is undefined" :=
 ThermoResponse.sourceChangeBoundary r.probe same

theorem exactOrientedResponse (r : Record C context) (a b : Orientation) (x y : PositiveFraction)
 (separation : separationChange r = .positive a x) (excitation : excitationChange r = .positive b y) :
 response r = .ok (.positive (productOrientation a b) (quotientMagnitude x y)) :=
 ThermoResponse.orientedCoefficient r.probe a b x y separation excitation

def record (r : Record C context) := (r,excitationChange r,separationChange r,response r)

theorem materialIdentityRetained (r : Record C context) : (record r).1.material = r.material := rfl

theorem completeAdjacencyRetained (r : Record C context) :
 (record r).1.material.bonding = r.material.bonding := rfl

theorem conditionsRetained (r : Record C context) :
 (record r).1.conditions = r.conditions ∧ (record r).1.temperatureBoundary = r.temperatureBoundary := ⟨rfl,rfl⟩

def records (rs : List (Record C context)) := rs.map record

theorem base (r : Record C context) : records [r] = [record r] := rfl

theorem successor (rs : List (Record C context)) (r : Record C context) :
 records (rs ++ [r]) = records rs ++ [record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.ExcitationSeparation
