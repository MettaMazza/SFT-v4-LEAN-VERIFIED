import SFT.Physics.CosmoBackground
namespace SFT.Physics.CosmoLensing
open MechanicalEvents

variable {State : Type} {adjacent : Event State → Event State → Prop}

def curvedTrace {a : Event State} : {b : Event State} → FieldLocality.Propagation adjacent a b → GravityCurvature.Path (Event State) String a b
 | _,.one .(a) => .empty a
 | _,.append path change _ => .append (curvedTrace path) ⟨change.sourceIdentity⟩
termination_by structural _ path => path

theorem everyCurvingSourceRetained {a b : Event State} (path : FieldLocality.Propagation adjacent a b) :
 GravityCurvature.sources (curvedTrace path)=(changes (FieldLocality.trace path)).map (fun row => row.sourceIdentity) := by
 induction path with
 | one => rfl
 | append path change edge ih =>
  change GravityCurvature.sources (curvedTrace path) ++ [change.sourceIdentity] = _
  rw [ih]
  rw [FieldLocality.trace, MechanicalEvents.changes]
  have mapping (rows : List (MechanicalEvents.Row State)) :
   (rows ++ [MechanicalEvents.row change]).map (fun row => row.sourceIdentity)=rows.map (fun row => row.sourceIdentity) ++ [change.sourceIdentity] := by
   induction rows with
   | nil => rfl
   | cons row rest ih => exact congrArg (List.cons row.sourceIdentity) ih
  exact (mapping _).symm

structure ImagePath (State : Type) (adjacent : Event State → Event State → Prop) (emitter observer : Event State) where
 path : FieldLocality.Propagation adjacent emitter observer
 observedSupport : List String
 directionRecord : SFT.Host.Canonical.Value
 observationRecord : SFT.Host.Canonical.Value

variable {emitter observer : Event State}

def images (paths : List (ImagePath State adjacent emitter observer)) :=
 paths.map (fun row => (row,row.directionRecord,count (FieldLocality.trace row.path),row.observedSupport))

theorem completePathsRecovered (paths : List (ImagePath State adjacent emitter observer)) :
 (images paths).map Prod.fst=paths := by
 induction paths with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons row) ih

theorem imageMultiplicity (paths : List (ImagePath State adjacent emitter observer)) :
 (images paths).length=paths.length := by
 induction paths with
 | nil => rfl
 | cons row rest ih => exact congrArg Nat.succ ih

def arrivalPair (left right : ImagePath State adjacent emitter observer) :=
 (count (FieldLocality.trace left.path),count (FieldLocality.trace right.path))

theorem delayRetainsBothRecurrences (left right : ImagePath State adjacent emitter observer) :
 (arrivalPair left right).1=count (FieldLocality.trace left.path) ∧
 (arrivalPair left right).2=count (FieldLocality.trace right.path) := ⟨rfl,rfl⟩

theorem eachImageHasOriginalEndpoints (row : ImagePath State adjacent emitter observer) :
 ∀ step ∈ changes (FieldLocality.trace row.path), adjacent step.before step.after := FieldLocality.everyTransitionAdjacent _

theorem nonclosingDirectionsRequireDifferentPaths {Orientation : Type}
 (step : {first last : Event State} → GravityCurvature.Edge (Event State) String first last → Orientation → Orientation)
 (left right : ImagePath State adjacent emitter observer) (held : Orientation)
 (curved : GravityCurvature.nonclosing step (curvedTrace left.path) (curvedTrace right.path) held) :
 left.path ≠ right.path := by
 intro same
 have traceSame := congrArg (fun p => curvedTrace p) same
 exact (GravityCurvature.nonclosingIsPathDistinction step _ _ held curved) traceSame

theorem fullSupportProjection (paths : List (ImagePath State adjacent emitter observer)) :
 (images paths).map (fun row => row.2.2.2)=paths.map ImagePath.observedSupport := by
 induction paths with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons row.observedSupport) ih
end SFT.Physics.CosmoLensing
