import SFT.Materials.MaterialCarrier
import SFT.Physics.MechanicalEvents
namespace SFT.Materials.ProcessPath
open SFT.Physics.MechanicalEvents
open SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[68]: source-bound process/state/property records.
structure State (Composition Property : Type) where
 material : MaterialCarrier.Record Composition
 propertyRelations : Property
 conditions : SFT.Host.Canonical.Value

structure Record (Composition Property : Type) where
 first : Event (State Composition Property)
 last : Event (State Composition Property)
 path : Path first last
 routeBoundary : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {Composition Property : Type}

def stateTable (r : Record Composition Property) :=
 (events r.path).map (fun e => (e,e.carrier.material,e.carrier.propertyRelations))

theorem allStatesRecovered (r : Record Composition Property) : (stateTable r).map Prod.fst = events r.path := by
 unfold stateTable
 generalize events r.path = es
 induction es with
 | nil => rfl
 | cons e es ih => exact congrArg (List.cons e) ih

theorem everyIntermediateState (r : Record Composition Property) (e : Event (State Composition Property))
 (held : e ∈ events r.path) : (e,e.carrier.material,e.carrier.propertyRelations) ∈ stateTable r :=
 memMap _ _ _ held

theorem noInventedState (r : Record Composition Property) (row)
 (held : row ∈ stateTable r) :
 ∃ e ∈ events r.path, (e,e.carrier.material,e.carrier.propertyRelations) = row := memMapPreimage _ _ _ held

theorem completeStateCount (r : Record Composition Property) :
 (stateTable r).length = count r.path+1 :=
 (SFT.Foundation.CommonRefinement.mapLength _ _).trans (completeEventCount r.path)

theorem allProcessActions (r : Record Composition Property) :
 (changes r.path).map (fun row => (row.sourceIdentity,row.actionRecord)) = sourceRecords r.path :=
 allSourceRecordsRetained r.path

def append (r : Record Composition Property) (next : Event (State Composition Property))
 (step : Change r.last next) : Record Composition Property :=
 ⟨r.first,next,.append r.path step,r.routeBoundary,r.provenance⟩

theorem successorStates (r : Record Composition Property) (next : Event (State Composition Property))
 (step : Change r.last next) :
 stateTable (append r next step) = stateTable r++[(next,next.carrier.material,next.carrier.propertyRelations)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend
  (fun e : Event (State Composition Property) => (e,e.carrier.material,e.carrier.propertyRelations)) (events r.path) [next]

theorem successorActions (r : Record Composition Property) (next : Event (State Composition Property))
 (step : Change r.last next) : changes (append r next step).path = changes r.path++[row step] := rfl

theorem routeAndProvenanceRetained (r : Record Composition Property) (next : Event (State Composition Property))
 (step : Change r.last next) :
 (append r next step).routeBoundary = r.routeBoundary ∧ (append r next step).provenance = r.provenance := ⟨rfl,rfl⟩

def record (r : Record Composition Property) := (r,stateTable r,changes r.path)

theorem wholeInputRetained (r : Record Composition Property) : (record r).1 = r := rfl

theorem differentRoutesRemainDistinct (r s : Record Composition Property)
 (different : sourceRecords r.path ≠ sourceRecords s.path) : record r ≠ record s :=
 fun same => different (congrArg (fun x => sourceRecords x.1.path) same)

theorem endpointOnlyCannotReconstruct (r s : Record Composition Property)
 (different : sourceRecords r.path ≠ sourceRecords s.path)
 (sameEndpoints : (r.first,r.last) = (s.first,s.last))
 (recover : Event (State Composition Property) × Event (State Composition Property) → Record Composition Property)
 (left : recover (r.first,r.last) = r) (right : recover (s.first,s.last) = s) : False := by
 have same : r = s := left.symm.trans ((congrArg recover sameEndpoints).trans right)
 exact different (congrArg (fun x => sourceRecords x.path) same)

def initial (e : Event (State Composition Property)) (boundary provenance : SFT.Host.Canonical.Value) : Record Composition Property :=
 ⟨e,e,.one e,boundary,provenance⟩

theorem initialTable (e : Event (State Composition Property)) (boundary provenance : SFT.Host.Canonical.Value) :
 stateTable (initial e boundary provenance) = [(e,e.carrier.material,e.carrier.propertyRelations)] := rfl

def records (rs : List (Record Composition Property)) := rs.map record

theorem base (r : Record Composition Property) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Composition Property)) (r : Record Composition Property) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.ProcessPath
