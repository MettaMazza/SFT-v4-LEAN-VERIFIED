import SFT.Physics.FieldGeometricDilution
namespace SFT.Physics.FieldGravitation
open SFT.Mathematics.FoldScalar

-- field_laws.py: the weak relational boundary retains inertial source,
-- generated geometric support and observed free-motion response together.
structure Gravitation (Part Support State ClockState Clock Node Cell : Type) where
  source : FieldSourceResponse.Source (MechanicalMomentum.Momentum Part Support State ClockState) Node
  field : FieldSourceResponse.Field source Cell (MechanicalAcceleration.Acceleration Support State ClockState Clock)
  present : 0 < field.support.length

def dilution {Part Support State ClockState Clock Node Cell : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell) : FieldGeometricDilution.Distribution Cell :=
  ⟨g.source.observation.carrier.content,g.field.support,g.present⟩

def sourceResponses {Part Support State ClockState Clock Node Cell : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell) :=
  MechanicalMomentum.cells g.field.responses (FieldGeometricDilution.share (dilution g))

theorem allObservedResponsesRetained {Part Support State ClockState Clock Node Cell : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell) :
    (sourceResponses g).map Prod.fst = g.field.responses := MechanicalMomentum.cellsRetainEveryPart _ _

theorem universalSourceShare {Part Support State ClockState Clock Node Cell : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell)
    (response : FieldSourceResponse.Response g.source Cell (MechanicalAcceleration.Acceleration Support State ClockState Clock))
    (included : response ∈ g.field.responses) :
    (response,FieldGeometricDilution.share (dilution g)) ∈ sourceResponses g :=
  (MechanicalMomentum.cellMembership _ _ _ _).mpr ⟨included,rfl⟩

theorem exactGeometricDilution {Part Support State ClockState Clock Node Cell : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell) :
    g.source.observation.carrier.content.numerator * (FieldGeometricDilution.share (dilution g)).denominator =
      (FieldGeometricDilution.share (dilution g)).numerator *
        (g.source.observation.carrier.content.denominator * g.field.support.length) := FieldGeometricDilution.exactShare (dilution g)

theorem responseIsObservedMotionChange {Part Support State ClockState Clock Node Cell : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell)
    (r : FieldSourceResponse.Response g.source Cell (MechanicalAcceleration.Acceleration Support State ClockState Clock)) :
    MechanicalAcceleration.value r.observation.carrier = dividePositive
      (subtract (MechanicalAcceleration.velocityScalar (MechanicalAcceleration.after r.observation.carrier))
        (MechanicalAcceleration.velocityScalar (MechanicalAcceleration.before r.observation.carrier)))
      (MechanicalAcceleration.duration r.observation.carrier) := rfl

theorem everyResponseHasSourceTrace {Part Support State ClockState Clock Node Cell : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell)
    (r : FieldSourceResponse.Response g.source Cell (MechanicalAcceleration.Acceleration Support State ClockState Clock)) :
    (MechanicalEvents.changes r.propagation).map (fun x => (x.sourceIdentity,x.actionRecord)) =
      MechanicalEvents.sourceRecords r.propagation := MechanicalEvents.allSourceRecordsRetained _

-- An added description label cannot split an unchanged inertial source response.
def physicalProjection {Part Support State ClockState Clock Node Cell Label : Type}
    (description : Gravitation Part Support State ClockState Clock Node Cell × Label) := description.1

theorem noChargeFamilySelection {Part Support State ClockState Clock Node Cell Label : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell) (left right : Label) :
    physicalProjection (g,left) = physicalProjection (g,right) := rfl

theorem conservedSourceContent {Part Support State ClockState Clock Node Cell : Type}
    (g : Gravitation Part Support State ClockState Clock Node Cell) :
    (dilution g).source = g.source.observation.carrier.content := rfl

end SFT.Physics.FieldGravitation
