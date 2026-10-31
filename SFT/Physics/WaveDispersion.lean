import SFT.Physics.WavePolarization
namespace SFT.Physics.WaveDispersion
open SFT.Foundation.Count.TraceDerivation

-- A registered response retains each recurrence, spatial repeat and causal path.
structure Response (Support State Clock Cell : Type) where
  spatial : WaveSpeedRelation.SpatialRepeat Support State Clock
  start : MechanicalEvents.Event Cell
  adjacent : MechanicalEvents.Event Cell → MechanicalEvents.Event Cell → Prop
  arrival : FieldLocality.Arrival adjacent start
  phase : MechanicalAngularMotion.Position spatial.wave.cycle

variable {Label Support State Clock Cell : Type}

def records (labels : List Label) (rule : Label → Response Support State Clock Cell) :=
  labels.map (fun label => (label,rule label,WaveSpeedRelation.speed (rule label).spatial))

theorem everyLabelRetained (labels : List Label) (rule : Label → Response Support State Clock Cell) :
    (records labels rule).map Prod.fst = labels := by
  induction labels with
  | nil => rfl
  | cons a rest ih => exact congrArg (List.cons a) ih

theorem everyResponseRetained (labels : List Label) (rule : Label → Response Support State Clock Cell) :
    (records labels rule).map (fun row => row.2.1) = labels.map rule := by
  induction labels with
  | nil => rfl
  | cons a rest ih => exact congrArg (List.cons (rule a)) ih

theorem labelHasExactSpeed (rule : Label → Response Support State Clock Cell) (label : Label) :
    WaveSpeedRelation.speed (rule label).spatial =
      SFT.Mathematics.ExactRatioRelations.compose (WaveSpeedRelation.wavelength (rule label).spatial)
        (WavePeriodFrequency.frequency (rule label).spatial.wave) := rfl

theorem responseIsCausal (r : Response Support State Clock Cell) :
    ∀ row ∈ MechanicalEvents.changes (FieldLocality.trace r.arrival.propagation),
      r.adjacent row.before row.after := FieldLocality.everyTransitionAdjacent _

theorem phaseRetainsWholeRecurrence (r : Response Support State Clock Cell) :
    MechanicalEvents.changes r.phase.initialPath ++ MechanicalEvents.changes r.phase.remainingPath =
      MechanicalEvents.changes r.spatial.wave.cycle.recurrence.path := MechanicalAngularMotion.wholeTrace _

-- Distinct registered arrival timings remain distinct through every common
-- positive number of spatial repeats. Counts are generated path counts.
def repeatedTiming (r : Response Support State Clock Cell) (repeats : Nat) :=
  repeats * MechanicalEvents.count (FieldLocality.trace r.arrival.propagation)

theorem timingSeparationPersists (a b : Response Support State Clock Cell) (repeats : Nat)
    (positive : 0 < repeats)
    (different : MechanicalEvents.count (FieldLocality.trace a.arrival.propagation) ≠
      MechanicalEvents.count (FieldLocality.trace b.arrival.propagation)) :
    repeatedTiming a repeats ≠ repeatedTiming b repeats := by
  intro eq
  exact different (SFT.Mathematics.ExactRatioRelations.cancelPositive repeats _ _ positive eq)

theorem changedSpeedChangesResponse (a b : Response Support State Clock Cell)
    (different : WaveSpeedRelation.speed a.spatial ≠ WaveSpeedRelation.speed b.spatial) : a ≠ b :=
  fun eq => different (congrArg (fun r => WaveSpeedRelation.speed r.spatial) eq)

theorem successorPreservesLabels (labels : List Label) (rule : Label → Response Support State Clock Cell) (label : Label) :
    records (labels ++ [label]) rule = records labels rule ++ [(label,rule label,WaveSpeedRelation.speed (rule label).spatial)] :=
  ReferenceRealization.mapAppendOne _ _ _
end SFT.Physics.WaveDispersion
