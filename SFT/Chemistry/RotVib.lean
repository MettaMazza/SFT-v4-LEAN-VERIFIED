import SFT.Chemistry.Infrared
import SFT.Mathematics.CategoryIdentity
namespace SFT.Chemistry.RotVib
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation
abbrev Value := SFT.Host.Canonical.Value

structure Rotation (molecule : Infrared.Molecule) where
 recurrence : SFT.Physics.MechanicalDuration.Recurrence (List MolecularGeometry.Relation)
 startsAtGeometry : recurrence.first.carrier=molecule.orientations
 sourceRecord : Value

abbrev Vibration (molecule : Infrared.Molecule) := Infrared.State molecule
abbrev Joint (molecule : Infrared.Molecule) := Rotation molecule × Vibration molecule

def compose {m : Infrared.Molecule} (rotations : List (Rotation m)) (vibrations : List (Vibration m)) : List (Joint m) :=
 rotations.flatMap (fun r => vibrations.map (fun v => (r,v)))

theorem compositionComplete {m : Infrared.Molecule} (rotations : List (Rotation m))
 (vibrations : List (Vibration m)) (r : Rotation m) (v : Vibration m) :
 (r,v)∈compose rotations vibrations ↔ r∈rotations ∧ v∈vibrations := by
 constructor
 · intro held
   obtain ⟨a,ha,member⟩ := memFlatMapOrigin _ _ _ held
   obtain ⟨b,hb,equal⟩ := memMapPreimage _ _ _ member
   cases equal
   exact ⟨ha,hb⟩
 · intro h
   exact memFlatMap _ _ r _ h.1 (memMap _ _ _ h.2)

theorem rotationReturnsGeometry {m : Infrared.Molecule} (r : Rotation m) :
 r.recurrence.last.carrier=m.orientations := r.recurrence.returnsToCarrier.trans r.startsAtGeometry

theorem vibrationReturns {m : Infrared.Molecule} (v : Vibration m) :
 v.internalRecurrence.last.carrier=v.internalRecurrence.first.carrier := Infrared.recurrenceReturns v

theorem appendRotation {m : Infrared.Molecule} (rotations : List (Rotation m))
 (vibrations : List (Vibration m)) (r : Rotation m) :
 compose (rotations++[r]) vibrations=compose rotations vibrations++vibrations.map (fun v => (r,v)) := by
 unfold compose
 rw [SFT.Mathematics.CategoryIdentity.flatMapAppend]
 exact congrArg (fun tail => rotations.flatMap (fun a => vibrations.map (fun b => (a,b)))++tail)
  (SFT.Mathematics.CategoryIdentity.appendNil _)

theorem appendVibrationComplete {m : Infrared.Molecule} (rotations : List (Rotation m))
 (vibrations : List (Vibration m)) (new : Vibration m) (r : Rotation m) (v : Vibration m) :
 (r,v)∈compose rotations (vibrations++[new]) ↔ r∈rotations ∧ (v∈vibrations ∨ v=new) := by
 constructor
 · intro held
   have h := (compositionComplete _ _ _ _).mp held
   cases memAppendCases v vibrations [new] h.2 with
   | inl old => exact ⟨h.1,.inl old⟩
   | inr added => cases added with
     | head => exact ⟨h.1,.inr rfl⟩
     | tail _ impossible => cases impossible
 · intro h
   apply (compositionComplete _ _ _ _).mpr
   refine ⟨h.1,?_⟩
   cases h.2 with
   | inl old => exact memAppendLeft _ _ _ old
   | inr equal => cases equal; exact memAppendRight _ _ _ (.head [])

structure Transition (molecule : Infrared.Molecule) where
 before : Joint molecule
 after : Joint molecule
 recurrence : SFT.Physics.MechanicalDuration.Recurrence Value
 response : SFT.Physics.CapabilityValues.PositiveCount
 allowedRecord : Value
 sourceRecord : Value

structure Spectrum (molecule : Infrared.Molecule) where
 rotations : List (Rotation molecule)
 vibrations : List (Vibration molecule)
 transitions : List (Transition molecule)
 endpoints : ∀ row∈transitions,
  row.before∈compose rotations vibrations ∧ row.after∈compose rotations vibrations
 method : SFT.Physics.CapabilityValues.HeldLabel
 conditions : Value
 population : Value
 resolution : Value

def frequency {m : Infrared.Molecule} (row : Transition m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :=
 SFT.Mathematics.ExactRatioRelations.ratio
  (SFT.Physics.MechanicalEvents.count reference.path)
  (SFT.Physics.MechanicalEvents.count row.recurrence.path)
  reference.hasTransition row.recurrence.hasTransition

theorem frequencyExact {m : Infrared.Molecule} (row : Transition m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :
 SFT.Physics.MechanicalEvents.count reference.path*(frequency row reference).denominator=
 (frequency row reference).numerator*SFT.Physics.MechanicalEvents.count row.recurrence.path :=
 SFT.Foundation.ExactOperations.normalizedValuePreserved _ _ reference.hasTransition row.recurrence.hasTransition

def pattern {m : Infrared.Molecule} (spectrum : Spectrum m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :=
 spectrum.transitions.map (fun row => (row,frequency row reference,row.response.value))

theorem everyTransitionRetained {m : Infrared.Molecule} (spectrum : Spectrum m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) (row : Transition m)
 (held : row∈spectrum.transitions) :
 (row,frequency row reference,row.response.value)∈pattern spectrum reference := memMap _ _ _ held

theorem noInventedTransition {m : Infrared.Molecule} (spectrum : Spectrum m)
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value)
 (item : Transition m × SFT.Foundation.ExactOperations.PositiveFraction × Nat)
 (held : item∈pattern spectrum reference) : ∃ row∈spectrum.transitions,
 (row,frequency row reference,row.response.value)=item := memMapPreimage _ _ _ held

theorem bothCoordinatesHeld {m : Infrared.Molecule} (spectrum : Spectrum m) (row : Transition m)
 (held : row∈spectrum.transitions) :
 (row.before.1∈spectrum.rotations ∧ row.before.2∈spectrum.vibrations) ∧
 (row.after.1∈spectrum.rotations ∧ row.after.2∈spectrum.vibrations) :=
 ⟨(compositionComplete _ _ _ _).mp (spectrum.endpoints row held).1,
  (compositionComplete _ _ _ _).mp (spectrum.endpoints row held).2⟩

def extend {m : Infrared.Molecule} (spectrum : Spectrum m)
 (rotations : List (Rotation m)) (vibrations : List (Vibration m)) (added : List (Transition m))
 (ends : ∀ row∈added,
  row.before∈compose (spectrum.rotations++rotations) (spectrum.vibrations++vibrations) ∧
  row.after∈compose (spectrum.rotations++rotations) (spectrum.vibrations++vibrations)) : Spectrum m where
 rotations := spectrum.rotations++rotations
 vibrations := spectrum.vibrations++vibrations
 transitions := spectrum.transitions++added
 endpoints := by
  intro row held
  cases memAppendCases row spectrum.transitions added held with
  | inl old =>
    have h := bothCoordinatesHeld spectrum row old
    exact ⟨(compositionComplete _ _ _ _).mpr ⟨memAppendLeft _ _ _ h.1.1,memAppendLeft _ _ _ h.1.2⟩,
      (compositionComplete _ _ _ _).mpr ⟨memAppendLeft _ _ _ h.2.1,memAppendLeft _ _ _ h.2.2⟩⟩
  | inr new => exact ends row new
 method := spectrum.method
 conditions := spectrum.conditions
 population := spectrum.population
 resolution := spectrum.resolution

theorem extensionPattern {m : Infrared.Molecule} (spectrum : Spectrum m)
 (rotations : List (Rotation m)) (vibrations : List (Vibration m)) (added : List (Transition m))
 (ends : ∀ row∈added,
  row.before∈compose (spectrum.rotations++rotations) (spectrum.vibrations++vibrations) ∧
  row.after∈compose (spectrum.rotations++rotations) (spectrum.vibrations++vibrations))
 (reference : SFT.Physics.MechanicalDuration.Recurrence Value) :
 pattern (extend spectrum rotations vibrations added ends) reference=pattern spectrum reference++
 added.map (fun row => (row,frequency row reference,row.response.value)) :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem singletonComposition {m : Infrared.Molecule} (r : Rotation m) (v : Vibration m) :
 compose [r] [v]=[(r,v)] := rfl

theorem extensionBoundary {m : Infrared.Molecule} (spectrum : Spectrum m)
 (rotations : List (Rotation m)) (vibrations : List (Vibration m)) (added : List (Transition m))
 (ends : ∀ row∈added,
  row.before∈compose (spectrum.rotations++rotations) (spectrum.vibrations++vibrations) ∧
  row.after∈compose (spectrum.rotations++rotations) (spectrum.vibrations++vibrations)) :
 (extend spectrum rotations vibrations added ends).method=spectrum.method ∧
 (extend spectrum rotations vibrations added ends).conditions=spectrum.conditions ∧
 (extend spectrum rotations vibrations added ends).population=spectrum.population ∧
 (extend spectrum rotations vibrations added ends).resolution=spectrum.resolution := ⟨rfl,rfl,rfl,rfl⟩

end SFT.Chemistry.RotVib
