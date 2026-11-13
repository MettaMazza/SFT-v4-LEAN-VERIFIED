import SFT.Materials.ProcessPath
import SFT.Materials.Microstructure
namespace SFT.Materials.HeatTreatment
open SFT.Physics.MechanicalEvents SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[72]: thermal/time records over the complete process.
structure ThermalState (Property : Type) where
 microstructure : Microstructure.Record
 temperature : SFT.Host.Canonical.Value
 time : SFT.Host.Canonical.Value
 property : Property

structure Record (Composition Property : Type) where
 process : ProcessPath.Record Composition (ThermalState Property)
 coolingBoundary : SFT.Host.Canonical.Value
 specimenBoundary : SFT.Host.Canonical.Value

variable {Composition Property : Type}

def observation (e : Event (ProcessPath.State Composition (ThermalState Property))) :=
 (e,e.carrier.propertyRelations.time,e.carrier.propertyRelations.temperature,
 e.carrier.propertyRelations.microstructure,e.carrier.propertyRelations.property)

def thermalPath (r : Record Composition Property) := (events r.process.path).map observation

theorem allEventsRecovered (r : Record Composition Property) :
 (thermalPath r).map Prod.fst = events r.process.path := by
 unfold thermalPath
 generalize events r.process.path = es
 induction es with
 | nil => rfl
 | cons e es ih => exact congrArg (List.cons e) ih

theorem everyThermalState (r : Record Composition Property) (e)
 (held : e ∈ events r.process.path) : observation e ∈ thermalPath r := memMap _ _ _ held

theorem noInventedThermalState (r : Record Composition Property) (value)
 (held : value ∈ thermalPath r) : ∃ e ∈ events r.process.path, observation e = value :=
 memMapPreimage _ _ _ held

theorem exactThermalPathCount (r : Record Composition Property) :
 (thermalPath r).length = count r.process.path+1 :=
 (SFT.Foundation.CommonRefinement.mapLength _ _).trans (completeEventCount r.process.path)

def transition (q : Row (ProcessPath.State Composition (ThermalState Property))) :=
 (q,q.before.carrier.propertyRelations,q.after.carrier.propertyRelations)

def transitions (r : Record Composition Property) := (changes r.process.path).map transition

theorem allTransitionsRecovered (r : Record Composition Property) :
 (transitions r).map Prod.fst = changes r.process.path := by
 unfold transitions
 generalize changes r.process.path = rows
 induction rows with
 | nil => rfl
 | cons row rows ih => exact congrArg (List.cons row) ih

theorem phaseDefectAndMicrostructure (r : Record Composition Property) (q)
 (held : q ∈ changes r.process.path) : transition q ∈ transitions r := memMap _ _ _ held

theorem completeProvenance (r : Record Composition Property) :
 (changes r.process.path).map (fun row => (row.sourceIdentity,row.actionRecord)) = sourceRecords r.process.path :=
 allSourceRecordsRetained _

def append (r : Record Composition Property) (next : Event (ProcessPath.State Composition (ThermalState Property)))
 (step : Change r.process.last next) : Record Composition Property :=
 ⟨ProcessPath.append r.process next step,r.coolingBoundary,r.specimenBoundary⟩

theorem successorThermalPath (r : Record Composition Property) (next) (step : Change r.process.last next) :
 thermalPath (append r next step) = thermalPath r++[observation next] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend observation (events r.process.path) [next]

theorem successorTransitions (r : Record Composition Property) (next) (step : Change r.process.last next) :
 transitions (append r next step) = transitions r++[transition (row step)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend transition (changes r.process.path) [row step]

theorem coolingAndSpecimenHeld (r : Record Composition Property) (next) (step : Change r.process.last next) :
 (append r next step).coolingBoundary = r.coolingBoundary ∧
 (append r next step).specimenBoundary = r.specimenBoundary := ⟨rfl,rfl⟩

def record (r : Record Composition Property) := (r,thermalPath r,transitions r,ProcessPath.record r.process)

theorem wholeInputRetained (r : Record Composition Property) : (record r).1 = r := rfl

theorem differentRoutesDistinguished (r s : Record Composition Property)
 (different : sourceRecords r.process.path ≠ sourceRecords s.process.path) : record r ≠ record s :=
 fun equal => different (congrArg (fun x => sourceRecords x.1.process.path) equal)

theorem endpointOnlyCannotRecoverRoute (r s : Record Composition Property)
 (same : (r.process.first,r.process.last) = (s.process.first,s.process.last))
 (different : sourceRecords r.process.path ≠ sourceRecords s.process.path)
 (recover : Event (ProcessPath.State Composition (ThermalState Property)) ×
 Event (ProcessPath.State Composition (ThermalState Property)) → Record Composition Property)
 (left : recover (r.process.first,r.process.last) = r)
 (right : recover (s.process.first,s.process.last) = s) : False := by
 have eq : r = s := left.symm.trans ((congrArg recover same).trans right)
 exact different (congrArg (fun x => sourceRecords x.process.path) eq)

def records (rs : List (Record Composition Property)) := rs.map record

theorem base (r : Record Composition Property) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Composition Property)) (r : Record Composition Property) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.HeatTreatment
