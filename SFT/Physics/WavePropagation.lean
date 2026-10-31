import SFT.Physics.WavePeriodFrequency
namespace SFT.Physics.WavePropagation
open MechanicalEvents

structure Transport (State Clock Cell Carrier : Type) where
  wave : WavePeriodFrequency.Wave State Clock
  source : QuantityCarrier.Observation Carrier
  start : Event Cell
  adjacent : Event Cell → Event Cell → Prop
  arrivals : List (FieldLocality.Arrival adjacent start)
  phaseAt : (arrival : FieldLocality.Arrival adjacent start) → MechanicalAngularMotion.Position wave.cycle

variable {State Clock Cell Carrier : Type}

def records (t : Transport State Clock Cell Carrier) :=
  t.arrivals.map (fun a => (t.source,t.wave,a.destination,t.phaseAt a))

theorem completeSupport (t : Transport State Clock Cell Carrier) :
    (records t).map (fun r => r.2.2.1) = FieldLocality.accessible t.arrivals := by
  have all (arrivals : List (FieldLocality.Arrival t.adjacent t.start)) :
      (arrivals.map (fun a => (t.source,t.wave,a.destination,t.phaseAt a))).map (fun r => r.2.2.1) =
        arrivals.map FieldLocality.Arrival.destination := by
    induction arrivals with
    | nil => rfl
    | cons a rest ih => exact congrArg (List.cons a.destination) ih
  exact all _

theorem originalCarrierAtEveryCell (t : Transport State Clock Cell Carrier) :
    (records t).map Prod.fst = t.arrivals.map (fun _ => t.source) := by
  have all (arrivals : List (FieldLocality.Arrival t.adjacent t.start)) :
      (arrivals.map (fun a => (t.source,t.wave,a.destination,t.phaseAt a))).map Prod.fst =
        arrivals.map (fun _ => t.source) := by
    induction arrivals with
    | nil => rfl
    | cons a rest ih => exact congrArg (List.cons t.source) ih
  exact all _

theorem frequencyAtEveryCell (t : Transport State Clock Cell Carrier) :
    (records t).map (fun r => WavePeriodFrequency.frequency r.2.1) =
      t.arrivals.map (fun _ => WavePeriodFrequency.frequency t.wave) := by
  have all (arrivals : List (FieldLocality.Arrival t.adjacent t.start)) :
      (arrivals.map (fun a => (t.source,t.wave,a.destination,t.phaseAt a))).map
        (fun r => WavePeriodFrequency.frequency r.2.1) =
        arrivals.map (fun _ => WavePeriodFrequency.frequency t.wave) := by
    induction arrivals with
    | nil => rfl
    | cons a rest ih => exact congrArg (List.cons (WavePeriodFrequency.frequency t.wave)) ih
  exact all _

theorem actualAdjacentPath (t : Transport State Clock Cell Carrier)
    (a : FieldLocality.Arrival t.adjacent t.start) :
    ∀ row ∈ changes (FieldLocality.trace a.propagation), t.adjacent row.before row.after :=
  FieldLocality.everyTransitionAdjacent _

theorem completePhaseAtCell (t : Transport State Clock Cell Carrier)
    (a : FieldLocality.Arrival t.adjacent t.start) :
    changes (t.phaseAt a).initialPath ++ changes (t.phaseAt a).remainingPath =
      changes t.wave.cycle.recurrence.path := MechanicalAngularMotion.wholeTrace _

def appendArrival (t : Transport State Clock Cell Carrier)
    (a : FieldLocality.Arrival t.adjacent t.start) := {t with arrivals := t.arrivals ++ [a]}

theorem successorRetainsAllRecords (t : Transport State Clock Cell Carrier)
    (a : FieldLocality.Arrival t.adjacent t.start) :
    records (appendArrival t a) = records t ++ [(t.source,t.wave,a.destination,t.phaseAt a)] :=
  ReferenceRealization.mapAppendOne _ _ _
end SFT.Physics.WavePropagation
