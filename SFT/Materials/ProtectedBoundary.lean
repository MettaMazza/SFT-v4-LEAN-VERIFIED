import SFT.Physics.CollectiveTopological
namespace SFT.Materials.ProtectedBoundary
open SFT.Physics.CollectiveTopological SFT.Mathematics.GraphOperations

-- The original carrier is joint: the boundary representative retains its
-- actual generated connection to the bulk, rather than an independent label.
structure Joint where
 complex : Complex
 origin : String
 bulkPath : List String
 boundaryPath : List String
 bulkEndpoints : endpoints bulkPath = (some origin,some origin)
 jointHistory : Trace complex bulkPath boundaryPath
 nontrivial : ¬ sameClass complex bulkPath [origin]
 gapFaces : List GeneratedGraph
 facesHeld : ∀ face, face ∈ gapFaces → face ∈ complex.faces
 conditions : SFT.Host.Canonical.Value

def gapComplex (j : Joint) : Complex where
 cells := j.complex.cells
 faces := j.gapFaces
 boundaryRecords := j.complex.boundaryRecords
 faceContained := fun face held => j.complex.faceContained face (j.facesHeld face held)

theorem gapStepIsJointStep (j : Joint) {a b : List String}
 (step : Elementary (gapComplex j) a b) : Elementary j.complex a b := by
 cases step with
 | face face held left right before after ls rs boundary source target =>
  exact .face face (j.facesHeld face held) left right before after ls rs boundary source target

theorem gapHistoryIsJointHistory (j : Joint) {a b : List String}
 (history : Trace (gapComplex j) a b) : Trace j.complex a b := by
 induction history with
 | identity valid => exact .identity _ valid
 | append prior step ih => exact .append ih (gapStepIsJointStep j step)

theorem boundaryClassForced (j : Joint) (path : List String) :
 sameClass j.complex j.bulkPath path ↔ sameClass j.complex j.boundaryPath path :=
 completeClassInvariant j.jointHistory path

theorem boundaryReturn (j : Joint) :
 endpoints j.boundaryPath = (some j.origin,some j.origin) :=
 (traceBoundary j.jointHistory).symm.trans j.bulkEndpoints

theorem boundarySupported (j : Joint) :
 pathIsValid j.complex.cells.graph j.boundaryPath = true := traceTargetValid j.jointHistory

theorem boundaryCannotContract (j : Joint) :
 ¬ sameClass j.complex j.boundaryPath [j.origin] :=
 differentClassRetained j.jointHistory [j.origin] j.nontrivial

theorem boundaryNontrivial (j : Joint) : j.boundaryPath ≠ [j.origin] := by
 intro same
 have valid := boundarySupported j
 rw [same] at valid
 have identity : Trace j.complex j.boundaryPath [j.origin] := by
  rw [same]
  exact .identity _ valid
 exact boundaryCannotContract j identity

theorem compatibleBackscatterAbsent (j : Joint) :
 ¬ Trace (gapComplex j) j.boundaryPath [j.origin] :=
 fun removal => boundaryCannotContract j (gapHistoryIsJointHistory j removal)

theorem removalClosesBulkDistinction (j : Joint)
 (removal : Trace (gapComplex j) j.boundaryPath [j.origin]) :
 sameClass j.complex j.bulkPath [j.origin] :=
 traceCompose j.jointHistory (gapHistoryIsJointHistory j removal)

theorem protectionAfterEveryAllowedHistory (j : Joint) {next : List String}
 (history : Trace (gapComplex j) j.boundaryPath next) :
 endpoints next = (some j.origin,some j.origin) ∧
 ¬ sameClass j.complex next [j.origin] :=
 ⟨(traceBoundary (gapHistoryIsJointHistory j history)).symm.trans (boundaryReturn j),
 differentClassRetained (gapHistoryIsJointHistory j history) [j.origin] (boundaryCannotContract j)⟩

def records (joints : List Joint) := joints.map (fun j => (j,j.boundaryPath))

theorem base (j : Joint) : records [j] = [(j,j.boundaryPath)] := rfl

theorem successor (joints : List Joint) (next : Joint) :
 records (joints ++ [next]) = records joints ++ [(next,next.boundaryPath)] := by
 induction joints with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (head,head.boundaryPath)) ih

end SFT.Materials.ProtectedBoundary
