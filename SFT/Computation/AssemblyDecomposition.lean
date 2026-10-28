import SFT.Computation.ProcessFailure
import SFT.Computation.CircuitComposition
namespace SFT.Computation.AssemblyDecomposition
open StateTransition StateComposition

-- Exact inverse to the retained serial Path operation at any declared cut.
theorem pathDecompose (system : System) (initial terminal : String)
    (left right before : List String) (path : Path system initial (left ++ right) before terminal) :
    ∃ middle first second, before = first ++ second ∧
      Path system initial left first middle ∧ Path system middle right second terminal := by
  induction left generalizing initial before with
  | nil => exact ⟨initial,[],before,rfl,.identity initial,path⟩
  | cons action rest ih =>
    cases path with
    | next state action target actions prior terminal edge later =>
      obtain ⟨middle,first,second,eq,one,two⟩ := ih target prior later
      exact ⟨middle,initial :: first,second,congrArg (List.cons initial) eq,
        .next initial action target rest first middle edge one,two⟩

theorem serialIffDecomposable (system : System) (initial terminal : String)
    (left right before : List String) :
    Path system initial (left ++ right) before terminal ↔
      ∃ middle first second, before = first ++ second ∧
        Path system initial left first middle ∧ Path system middle right second terminal := by
  constructor
  · exact pathDecompose _ _ _ _ _ _
  · intro ⟨middle,first,second,eq,one,two⟩
    rw [eq]
    exact pathSerial _ _ _ _ _ _ _ _ one two

theorem nativeDecomposition (system : System) (initial : String)
    (left right trace : List String) (executed : run system initial (left ++ right) = .ok trace) :
    ∃ middle terminal first second,
      trace = (first ++ second) ++ [terminal] ∧
      runFrom system initial left = .ok (first ++ [middle]) ∧
      runFrom system middle right = .ok (second ++ [terminal]) := by
  obtain ⟨held,before,terminal,eq,path⟩ := nativePath _ _ _ _ executed
  obtain ⟨middle,first,second,split,one,two⟩ := pathDecompose _ _ _ _ _ _ path
  exact ⟨middle,terminal,first,second,split ▸ eq,
    (runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ one),
    (runFromMeaning _ _ _ _).mpr (pathExecution _ _ _ _ _ two)⟩

-- Independent support is a product of retained original observations. It
-- introduces no shared state, communication, timing or scheduling operation.
structure ParallelRecord where
  leftSystem : System
  rightSystem : System
  leftInitial : String
  rightInitial : String
  leftActions : List String
  rightActions : List String
  leftObservation : Except String (List String)
  rightObservation : Except String (List String)

def Reconstructs (record : ParallelRecord) : Prop :=
  run record.leftSystem record.leftInitial record.leftActions = record.leftObservation ∧
  run record.rightSystem record.rightInitial record.rightActions = record.rightObservation

theorem parallelReconstruction (left right : System) (li ri : String) (la ra : List String) :
    Reconstructs ⟨left,right,li,ri,la,ra,run left li la,run right ri ra⟩ := ⟨rfl,rfl⟩

theorem componentObservationUnique (first second : ParallelRecord)
    (one : Reconstructs first) (two : Reconstructs second)
    (ls : first.leftSystem = second.leftSystem) (rs : first.rightSystem = second.rightSystem)
    (li : first.leftInitial = second.leftInitial) (ri : first.rightInitial = second.rightInitial)
    (la : first.leftActions = second.leftActions) (ra : first.rightActions = second.rightActions) :
    first.leftObservation = second.leftObservation ∧ first.rightObservation = second.rightObservation := by
  constructor
  · rw [← one.1,← two.1,ls,li,la]
  · rw [← one.2,← two.2,rs,ri,ra]

theorem parallelComponents (record : ParallelRecord) (reconstructs : Reconstructs record) :
    (run record.leftSystem record.leftInitial record.leftActions,
      run record.rightSystem record.rightInitial record.rightActions) =
      (record.leftObservation,record.rightObservation) := by
  rw [reconstructs.1,reconstructs.2]

end SFT.Computation.AssemblyDecomposition
