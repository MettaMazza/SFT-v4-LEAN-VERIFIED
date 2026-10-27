import SFT.Mathematics.GeometryTopology
import SFT.Mathematics.GraphReachability
namespace SFT.Mathematics.GeometryTopology
open DiscreteObjects CombinatorialArrangements SFT.Foundation.Count.TraceDerivation

-- Finite support is used only to justify termination; it does not cap depth.
structure DepthState (boundary : Boundary) where
  unseen : List String
  visiting : List String
  held : String
  heldCovered : held ∈ unseen ∨ held ∈ visiting
  facesCovered : ∀ edge, edge ∈ boundary → edge.1 ∈ unseen ∨ edge.1 ∈ visiting

def depthOrder (boundary : Boundary) : WellFoundedRelation (DepthState boundary) :=
  invImage (fun state => state.unseen.length) Nat.lt_wfRel

def childDepthState (boundary : Boundary) (state : DepthState boundary)
    (face : String) (member : face ∈ faces boundary state.held) : DepthState boundary where
  unseen := remainder state.unseen state.held
  visiting := state.visiting ++ [state.held]
  held := face
  heldCovered := GraphOperations.coverageAfterVisit _ _ _ _
    (state.facesCovered (face,state.held) ((facesMeaning boundary state.held face).mp member))
  facesCovered := fun edge he => GraphOperations.coverageAfterVisit _ _ _ _ (state.facesCovered edge he)

theorem childDepthDecreases (boundary : Boundary) (state : DepthState boundary)
    (fresh : has state.visiting state.held ≠ true) (face : String)
    (member : face ∈ faces boundary state.held) :
    (depthOrder boundary).rel (childDepthState boundary state face member) state := by
  apply remainderShorter
  cases state.heldCovered with
  | inl h => exact h
  | inr h => exact False.elim (fresh ((hasIff _ _).mpr h))

-- Original left-to-right child evaluation, including the first error.
def depthMaximum : List (Except String Nat) → Except String Nat
  | [] => .ok 0
  | .error message :: _ => .error message
  | .ok value :: rest => match depthMaximum rest with
    | .error message => .error message
    | .ok other => .ok (max value other)

def depthBody (boundary : Boundary) (state : DepthState boundary)
    (recur : (next : DepthState boundary) → (depthOrder boundary).rel next state → Except String Nat) : Except String Nat :=
  if seen : has state.visiting state.held = true then
    .error "boundary descent cannot contain a return cycle"
  else
    match depthMaximum ((faces boundary state.held).attach.map (fun face =>
      recur (childDepthState boundary state face.val face.property)
        (childDepthDecreases boundary state seen face.val face.property))) with
    | .error message => .error message
    | .ok height => .ok (height + 1)

def boundaryDepth (boundary : Boundary) : DepthState boundary → Except String Nat :=
  (depthOrder boundary).wf.fix (depthBody boundary)

theorem boundaryDepthEquation (boundary : Boundary) (state : DepthState boundary) :
    boundaryDepth boundary state = depthBody boundary state (fun next _ => boundaryDepth boundary next) := by
  unfold boundaryDepth
  rw [WellFounded.fix_eq]

def initialDepthState (boundary : Boundary) (cell : String) : DepthState boundary where
  unseen := cell :: boundary.map Prod.fst
  visiting := []
  held := cell
  heldCovered := Or.inl (List.Mem.head _)
  facesCovered := fun edge he => Or.inl (List.Mem.tail cell (memMap Prod.fst edge boundary he))

def cellDimension (cells : List String) (boundary : Boundary) (cell : String) : Except String Nat :=
  if incidenceWellFormed cells boundary && has cells cell then
    boundaryDepth boundary (initialDepthState boundary cell)
  else .error "dimension requires a registered finite incidence complex"

theorem depthRejectsCycle (boundary : Boundary) (state : DepthState boundary)
    (seen : state.held ∈ state.visiting) :
    boundaryDepth boundary state = .error "boundary descent cannot contain a return cycle" := by
  rw [boundaryDepthEquation]
  unfold depthBody
  rw [dite_eq_left ((hasIff _ _).mpr seen)]

theorem attachedMapEmpty {α β : Type} (xs : List α) (f : {x // x ∈ xs} → β)
    (empty : xs = []) : xs.attach.map f = [] := by
  cases empty
  rfl

theorem depthLeaf (boundary : Boundary) (state : DepthState boundary)
    (fresh : ¬ state.held ∈ state.visiting) (leaf : faces boundary state.held = []) :
    boundaryDepth boundary state = .ok 1 := by
  rw [boundaryDepthEquation]
  unfold depthBody
  rw [dite_eq_right (fun h => fresh ((hasIff _ _).mp h)), attachedMapEmpty _ _ leaf]
  rfl

theorem dimensionRejectsInvalid (cells : List String) (boundary : Boundary) (cell : String)
    (invalid : (incidenceWellFormed cells boundary && has cells cell) = false) :
    cellDimension cells boundary cell = .error "dimension requires a registered finite incidence complex" := by
  unfold cellDimension
  rw [invalid]
  rfl

theorem depthSuccessfulPositive (boundary : Boundary) (state : DepthState boundary) (height : Nat)
    (success : boundaryDepth boundary state = .ok height) : 0 < height := by
  rw [boundaryDepthEquation] at success
  unfold depthBody at success
  split at success
  · cases success
  · split at success
    · cases success
    · cases success
      exact Nat.zero_lt_succ _

def heightMaximum : List Nat → Nat
  | [] => 0
  | n :: rest => max n (heightMaximum rest)

mutual
inductive DepthDerivation (boundary : Boundary) : List String → String → Nat → Prop where
  | node (visiting : List String) (held : String) (heights : List Nat)
      (fresh : ¬ held ∈ visiting)
      (children : FaceDerivations boundary (visiting ++ [held]) (faces boundary held) heights) :
      DepthDerivation boundary visiting held (heightMaximum heights + 1)
inductive FaceDerivations (boundary : Boundary) : List String → List String → List Nat → Prop where
  | nil (visiting : List String) : FaceDerivations boundary visiting [] []
  | cons (visiting : List String) (face : String) (height : Nat) (rest : List String) (heights : List Nat)
      (first : DepthDerivation boundary visiting face height)
      (others : FaceDerivations boundary visiting rest heights) :
      FaceDerivations boundary visiting (face :: rest) (height :: heights)
end

theorem maximumDerivations {α : Type} (boundary : Boundary) (visiting : List String)
    (label : α → String) (evaluate : α → Except String Nat)
    (supported : ∀ a n, evaluate a = .ok n → DepthDerivation boundary visiting (label a) n)
    (items : List α) (height : Nat) (success : depthMaximum (items.map evaluate) = .ok height) :
    ∃ heights, FaceDerivations boundary visiting (items.map label) heights ∧ heightMaximum heights = height := by
  induction items generalizing height with
  | nil =>
    cases success
    exact ⟨[], FaceDerivations.nil visiting, rfl⟩
  | cons a rest ih =>
    cases first : evaluate a with
    | error e => simp only [List.map,first,depthMaximum] at success; cases success
    | ok n =>
      cases tail : depthMaximum (rest.map evaluate) with
      | error e => simp only [List.map,first,depthMaximum,tail] at success; cases success
      | ok m =>
        simp only [List.map,first,depthMaximum,tail] at success
        cases success
        obtain ⟨heights,derivations,same⟩ := ih m tail
        exact ⟨n::heights,FaceDerivations.cons visiting (label a) n _ _ (supported a n first) derivations,
          congrArg (max n) same⟩

theorem pmapLabels {P : String → Prop} (items : List String) (supported : ∀ x, x ∈ items → P x) :
    (List.pmap (fun x h => (⟨x,h⟩ : {x // P x})) items supported).map Subtype.val = items := by
  induction items with
  | nil => rfl
  | cons a rest ih => exact congrArg (List.cons a) (ih (fun x h => supported x (List.Mem.tail a h)))

theorem attachedLabels (items : List String) : items.attach.map Subtype.val = items :=
  pmapLabels items (fun _ h => h)

theorem boundaryDepthDerivation (boundary : Boundary) (state : DepthState boundary) :
    ∀ height, boundaryDepth boundary state = .ok height →
      DepthDerivation boundary state.visiting state.held height := by
  apply (depthOrder boundary).wf.induction state
  intro current ih height success
  rw [boundaryDepthEquation] at success
  unfold depthBody at success
  split at success
  · cases success
  · rename_i fresh
    split at success
    · cases success
    · rename_i n result
      cases success
      obtain ⟨heights,children,same⟩ := maximumDerivations boundary (current.visiting ++ [current.held])
        Subtype.val
        (fun face : {x // x ∈ faces boundary current.held} =>
          boundaryDepth boundary (childDepthState boundary current face.val face.property))
        (fun face value h => ih (childDepthState boundary current face.val face.property)
          (childDepthDecreases boundary current fresh face.val face.property) value h)
        (faces boundary current.held).attach n result
      rw [attachedLabels] at children
      rw [← same]
      exact DepthDerivation.node current.visiting current.held heights (fun h => fresh ((hasIff _ _).mpr h)) children

theorem maximumFromDerivations {α : Type} (boundary : Boundary) (visiting : List String)
    (label : α → String) (evaluate : α → Except String Nat)
    (supported : ∀ a n, DepthDerivation boundary visiting (label a) n → evaluate a = .ok n)
    (items : List α) (heights : List Nat)
    (children : FaceDerivations boundary visiting (items.map label) heights) :
    depthMaximum (items.map evaluate) = .ok (heightMaximum heights) := by
  induction items generalizing heights with
  | nil => cases children; rfl
  | cons a rest ih =>
    cases children with
    | cons _ _ n _ ns first others =>
      change depthMaximum (evaluate a :: rest.map evaluate) = .ok (max n (heightMaximum ns))
      rw [supported a n first]
      unfold depthMaximum
      rw [ih ns others]

theorem derivationComputesDepth (boundary : Boundary) (state : DepthState boundary) :
    ∀ height, DepthDerivation boundary state.visiting state.held height →
      boundaryDepth boundary state = .ok height := by
  apply (depthOrder boundary).wf.induction state
  intro current ih height derivation
  cases derivation with
  | node _ _ heights fresh children =>
    have notSeen : has current.visiting current.held ≠ true := fun h => fresh ((hasIff _ _).mp h)
    have attachedChildren : FaceDerivations boundary (current.visiting ++ [current.held])
        ((faces boundary current.held).attach.map Subtype.val) heights := by
      rw [attachedLabels]
      exact children
    have result := maximumFromDerivations boundary (current.visiting ++ [current.held]) Subtype.val
      (fun face : {x // x ∈ faces boundary current.held} =>
        boundaryDepth boundary (childDepthState boundary current face.val face.property))
      (fun face value h => ih (childDepthState boundary current face.val face.property)
        (childDepthDecreases boundary current notSeen face.val face.property) value h)
      (faces boundary current.held).attach heights attachedChildren
    rw [boundaryDepthEquation]
    unfold depthBody
    rw [dite_eq_right notSeen,result]

theorem boundaryDepthIffDerivation (boundary : Boundary) (state : DepthState boundary) (height : Nat) :
    boundaryDepth boundary state = .ok height ↔ DepthDerivation boundary state.visiting state.held height :=
  ⟨boundaryDepthDerivation boundary state height, derivationComputesDepth boundary state height⟩

theorem dimensionIffDerivation (cells : List String) (boundary : Boundary) (cell : String) (height : Nat)
    (admitted : (incidenceWellFormed cells boundary && has cells cell) = true) :
    cellDimension cells boundary cell = .ok height ↔ DepthDerivation boundary [] cell height := by
  unfold cellDimension
  rw [admitted]
  exact boundaryDepthIffDerivation boundary (initialDepthState boundary cell) height

end SFT.Mathematics.GeometryTopology


