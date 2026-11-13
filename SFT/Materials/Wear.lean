import SFT.Materials.ProcessPath
import SFT.Physics.MechanicalConservation
namespace SFT.Materials.Wear
open SFT.Physics.MechanicalEvents SFT.Physics.MechanicalConservation
open SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[74]: complete contact/load/motion history.
structure State (Content Friction : Type) where
 firstSurface : MaterialCarrier.Record Content
 secondSurface : MaterialCarrier.Record Content
 loadMotion : SFT.Host.Canonical.Value
 friction : Friction

structure Record (Content Friction : Type) where
 first : Event (State Content Friction)
 last : Event (State Content Friction)
 path : Path first last
 transfer : Row (State Content Friction) → Network String (MaterialCarrier.Constituent Content)
 debrisSites : List String
 contactBoundary : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {Content Friction : Type}

def transfers (r : Record Content Friction) := (changes r.path).flatMap r.transfer

def debris (r : Record Content Friction) :=
 (transfers r).filter (fun t => SFT.Mathematics.DiscreteObjects.has r.debrisSites t.destination)

def frictionHistory (r : Record Content Friction) := (events r.path).map (fun e => (e,e.carrier.friction))

def surfaceHistory (r : Record Content Friction) :=
 (events r.path).map (fun e => (e,e.carrier.firstSurface,e.carrier.secondSurface,e.carrier.loadMotion))

theorem allSurfaceStatesRecovered (r : Record Content Friction) :
 (surfaceHistory r).map Prod.fst = events r.path := by
 unfold surfaceHistory
 generalize events r.path = es
 induction es with
 | nil => rfl
 | cons e es ih => exact congrArg (List.cons e) ih

theorem allFrictionStatesRecovered (r : Record Content Friction) :
 (frictionHistory r).map Prod.fst = events r.path := by
 unfold frictionHistory
 generalize events r.path = es
 induction es with
 | nil => rfl
 | cons e es ih => exact congrArg (List.cons e) ih

theorem transferredContentConserved (r : Record Content Friction) :
 outgoingSupport (transfers r) = incomingSupport (transfers r) := completeConservation _

theorem debrisExactly (r : Record Content Friction) (t) : t ∈ debris r ↔
 t ∈ transfers r ∧ t.destination ∈ r.debrisSites := by
 have h := SFT.Mathematics.DiscreteObjects.filterMemberIff
  (fun t : Transfer String (MaterialCarrier.Constituent Content) => SFT.Mathematics.DiscreteObjects.has r.debrisSites t.destination) (transfers r) t
 constructor
 · intro held
   have p := h.mp held
   exact ⟨p.1,(SFT.Mathematics.DiscreteObjects.hasIff _ _).mp p.2⟩
 · intro held
   exact h.mpr ⟨held.1,(SFT.Mathematics.DiscreteObjects.hasIff _ _).mpr held.2⟩

theorem debrisStillHasContent (r : Record Content Friction) :
 outgoingSupport (debris r) = incomingSupport (debris r) := completeConservation _

theorem exactSurfaceStateCount (r : Record Content Friction) :
 (surfaceHistory r).length = count r.path+1 :=
 (SFT.Foundation.CommonRefinement.mapLength _ _).trans (completeEventCount r.path)

theorem everyContactAction (r : Record Content Friction) :
 (changes r.path).map (fun q => (q.sourceIdentity,q.actionRecord)) = sourceRecords r.path :=
 allSourceRecordsRetained _

def record (r : Record Content Friction) :=
 (r,surfaceHistory r,frictionHistory r,transfers r,debris r,changes r.path)

theorem wholeInputRetained (r : Record Content Friction) : (record r).1 = r := rfl

theorem frictionDoesNotEraseTransfer (r s : Record Content Friction)
 (_sameFriction : frictionHistory r = frictionHistory s)
 (different : transfers r ≠ transfers s) : record r ≠ record s :=
 fun equal => different (congrArg (fun x => transfers x.1) equal)

theorem changedSurfaceRetained (r s : Record Content Friction)
 (different : r.last.carrier.firstSurface.bonding ≠ s.last.carrier.firstSurface.bonding) : record r ≠ record s :=
 fun equal => different (congrArg (fun x => x.1.last.carrier.firstSurface.bonding) equal)

def append (r : Record Content Friction) (next : Event (State Content Friction))
 (step : Change r.last next) : Record Content Friction :=
 ⟨r.first,next,.append r.path step,r.transfer,r.debrisSites,r.contactBoundary,r.provenance⟩

theorem successorSurfaceHistory (r : Record Content Friction) (next) (step : Change r.last next) :
 surfaceHistory (append r next step) = surfaceHistory r++[(next,next.carrier.firstSurface,next.carrier.secondSurface,next.carrier.loadMotion)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend
 (fun e : Event (State Content Friction) => (e,e.carrier.firstSurface,e.carrier.secondSurface,e.carrier.loadMotion)) (events r.path) [next]

theorem successorFrictionHistory (r : Record Content Friction) (next) (step : Change r.last next) :
 frictionHistory (append r next step) = frictionHistory r++[(next,next.carrier.friction)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend
 (fun e : Event (State Content Friction) => (e,e.carrier.friction)) (events r.path) [next]

theorem contactBoundaryHeld (r : Record Content Friction) (next) (step : Change r.last next) :
 (append r next step).contactBoundary = r.contactBoundary := rfl

def records (rs : List (Record Content Friction)) := rs.map record

theorem base (r : Record Content Friction) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Content Friction)) (r : Record Content Friction) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.Wear
