import SFT.Physics.GravityGeodesicBridge
import SFT.Physics.FieldActionReaction
import SFT.Physics.MatterMassEnergy
namespace SFT.Physics.GravityFieldSource
open MechanicalEvents MechanicalConservation

abbrev Energy (Support State Clock : Type) := MatterMassEnergy.Conversion Support State Clock

structure Change (Support State Clock : Type)
 (adjacent : Event (Energy Support State Clock) → Event (Energy Support State Clock) → Prop) where
 first : Event (Energy Support State Clock)
 last : Event (Energy Support State Clock)
 propagation : FieldLocality.Propagation adjacent first last
 left : GravityCurvature.Path (Event (Energy Support State Clock)) String first last
 right : GravityCurvature.Path (Event (Energy Support State Clock)) String first last

variable {Support State Clock : Type}
variable {adjacent : Event (Energy Support State Clock) → Event (Energy Support State Clock) → Prop}

def sourceEnergy (change : Change Support State Clock adjacent) := MatterMassEnergy.value change.first.carrier

def transfer (change : Change Support State Clock adjacent) :
 Transfer (Event (Energy Support State Clock)) (Change Support State Clock adjacent) :=
 ⟨change.first,change.last,change,change.first.carrier.inertial.sourceIdentity,change.first.record⟩

def ledger (changes : List (Change Support State Clock adjacent)) := changes.map transfer

theorem everyChangeHasPositiveSource (change : Change Support State Clock adjacent) :
 0 < (sourceEnergy change).numerator := MatterMassEnergy.positiveEnergy change.first.carrier

theorem transferRetainsWholeChange (change : Change Support State Clock adjacent) :
 (transfer change).carrier=change := rfl

theorem transferRetainsSource (change : Change Support State Clock adjacent) :
 (transfer change).source=change.first ∧ (transfer change).sourceIdentity=change.first.carrier.inertial.sourceIdentity := ⟨rfl,rfl⟩

theorem everyPropagationStepAdjacent (change : Change Support State Clock adjacent) :
 ∀ row ∈ MechanicalEvents.changes (FieldLocality.trace change.propagation), adjacent row.before row.after :=
 FieldLocality.everyTransitionAdjacent change.propagation

theorem distinctArrivalHasPredecessor (change : Change Support State Clock adjacent) (distinct : change.first ≠ change.last) :
 ∃ prior, adjacent prior change.last := FieldLocality.nonInitialHasPredecessor change.propagation distinct

theorem everySourceRecordRetained (change : Change Support State Clock adjacent) :
 (MechanicalEvents.changes (FieldLocality.trace change.propagation)).map (fun row => (row.sourceIdentity,row.actionRecord)) =
 MechanicalEvents.sourceRecords (FieldLocality.trace change.propagation) :=
 MechanicalEvents.allSourceRecordsRetained _

theorem completeChangesRetained (changes : List (Change Support State Clock adjacent)) :
 (ledger changes).map Transfer.carrier=changes := by
 induction changes with
 | nil => rfl
 | cons change rest ih => exact congrArg (List.cons change) ih

theorem closedCarrierConservation (changes : List (Change Support State Clock adjacent)) :
 outgoingSupport (ledger changes)=incomingSupport (ledger changes) := completeConservation _

theorem closedEnergyReadingsConserved (changes : List (Change Support State Clock adjacent)) :
 (outgoingSupport (ledger changes)).map sourceEnergy=(incomingSupport (ledger changes)).map sourceEnergy :=
 congrArg (List.map sourceEnergy) (closedCarrierConservation changes)

theorem interiorChangeExactlyOutwardTransfer
 (inside : Event (Energy Support State Clock) → Bool) (changes : List (Change Support State Clock adjacent)) :
 (FieldSourceContinuity.interiorLosses inside (ledger changes)).map Prod.snd =
 (FieldSourceContinuity.boundaryOutflow inside (ledger changes)).map Prod.snd :=
 FieldSourceContinuity.lossExactlyOutflow inside _

theorem interiorEnergyExactlyOutwardEnergy
 (inside : Event (Energy Support State Clock) → Bool) (changes : List (Change Support State Clock adjacent)) :
 ((FieldSourceContinuity.interiorLosses inside (ledger changes)).map Prod.snd).map sourceEnergy =
 ((FieldSourceContinuity.boundaryOutflow inside (ledger changes)).map Prod.snd).map sourceEnergy :=
 congrArg (List.map sourceEnergy) (interiorChangeExactlyOutwardTransfer inside changes)

theorem noUnrecordedOutwardChange
 (inside : Event (Energy Support State Clock) → Bool) (changes : List (Change Support State Clock adjacent))
 (t : Transfer (Event (Energy Support State Clock)) (Change Support State Clock adjacent))
 (out : t ∈ FieldSourceContinuity.outward inside (ledger changes)) :
 t ∈ ledger changes ∧ inside t.source=true ∧ inside t.destination=false :=
 FieldSourceContinuity.noUnrecordedOutflow inside _ t out

theorem noOmittedOutwardChange
 (inside : Event (Energy Support State Clock) → Bool) (changes : List (Change Support State Clock adjacent))
 (change : Change Support State Clock adjacent) (member : transfer change ∈ ledger changes)
 (sourceInside : inside change.first=true) (destinationOutside : inside change.last=false) :
 transfer change ∈ FieldSourceContinuity.outward inside (ledger changes) :=
 FieldSourceContinuity.noOmittedOutflow inside _ _ member sourceInside destinationOutside
end SFT.Physics.GravityFieldSource
