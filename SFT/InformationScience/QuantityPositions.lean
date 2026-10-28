import SFT.InformationScience.QuantityProfile
namespace SFT.InformationScience.QuantityPositions
open QuantitySupport QuantityProfile
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

def positionCheck (support : List Word) (labels : List String) (first second : String) (before after : Nat) : Bool :=
  (words labels before).all (fun pre => (words labels after).all (fun post =>
    has support (pre ++ first :: post) && has support (pre ++ second :: post)))

def traceChecks (support : List Word) (labels : List String) (first second : String) : Nat → List String → Bool
  | _,[] => true
  | index,_ :: rest => positionCheck support labels first second index rest.length &&
      traceChecks support labels first second (index+1) rest

def unitTrace (positions : List String) : List (String × String) :=
  positions.map (fun position => (position,"one-Fold-distinction"))

def distinctionPositionTrace (labels positions : List String) : Except String (List (String × String)) :=
  match completeWordSupport labels positions with
  | .error e => .error e
  | .ok support => match labels with
    | [] => .error "ValueError: information support requires at least one generated distinction"
    | first :: rest => match rest with
      | [] => .error "ValueError: information support requires at least one generated distinction"
      | second :: _ =>
        if traceChecks support labels first second 0 positions then .ok (unitTrace positions)
        else .error "ValueError: position does not independently realize the Fold distinction"

theorem positionCheckPasses (labels : List String) (first second : String) (before after : Nat)
    (hf : first ∈ labels) (hs : second ∈ labels) :
    positionCheck (words labels (before+(after+1))) labels first second before after = true := by
  apply (allTrueIffMembers _ _).mpr
  intro pre hp
  apply (allTrueIffMembers _ _).mpr
  intro post ht
  exact (andTrue _ _).mpr ⟨(hasIff _ _).mpr (independentPosition _ _ _ _ _ _ hp ht hf),
    (hasIff _ _).mpr (independentPosition _ _ _ _ _ _ hp ht hs)⟩

theorem traceChecksPass (labels : List String) (first second : String) (positions : List String) (index : Nat)
    (hf : first ∈ labels) (hs : second ∈ labels) :
    traceChecks (words labels (index+positions.length)) labels first second index positions = true := by
  induction positions generalizing index with
  | nil => rfl
  | cons position rest ih =>
    apply (andTrue _ _).mpr
    refine ⟨positionCheckPasses labels first second index rest.length hf hs,?_⟩
    have size : index + (rest.length+1) = (index+1) + rest.length := by
      rw [Nat.add_assoc,Nat.add_comm 1 rest.length]
    change traceChecks (words labels (index+(rest.length+1))) labels first second (index+1) rest = true
    rw [size]
    exact ih (index+1)

theorem admittedTrace (labels positions : List String) (support : List Word)
    (h : completeWordSupport labels positions = .ok support) :
    distinctionPositionTrace labels positions = .ok (unitTrace positions) := by
  have valid := (supportAdmission _ _).mp ⟨support,h⟩
  cases labels with
  | nil => exact False.elim (valid.1 (by decide))
  | cons first rest =>
    cases rest with
    | nil => exact False.elim (valid.1 (by change 1 < 2; decide))
    | cons second tail =>
      unfold distinctionPositionTrace
      rw [h]
      have checked := traceChecksPass (first::second::tail) first second positions 0
        (List.Mem.head _) (List.Mem.tail first (List.Mem.head _))
      rw [Nat.zero_add] at checked
      change (if traceChecks support (first::second::tail) first second 0 positions then .ok (unitTrace positions) else .error "ValueError: position does not independently realize the Fold distinction" : Except String (List (String × String))) = _
      rw [supportResult _ _ _ h,checked]
      rfl

theorem traceErrorPreserved (labels positions : List String) (error : String)
    (h : completeWordSupport labels positions = .error error) :
    distinctionPositionTrace labels positions = .error error := by
  unfold distinctionPositionTrace; rw [h]

theorem traceLength (positions : List String) : (unitTrace positions).length = positions.length :=
  SFT.Foundation.CommonRefinement.mapLength _ _

theorem traceMembership (positions : List String) (position unit : String) :
    (position,unit) ∈ unitTrace positions ↔ position ∈ positions ∧ unit = "one-Fold-distinction" := by
  constructor
  · intro h
    obtain ⟨p,hp,eq⟩ := memMapPreimage (fun p => (p,"one-Fold-distinction")) (position,unit) positions h
    have ep := congrArg Prod.fst eq
    have eu := congrArg Prod.snd eq
    cases ep
    exact ⟨hp,eu.symm⟩
  · intro h
    cases h.2
    exact memMap (fun p => (p,"one-Fold-distinction")) position positions h.1

theorem traceComposition (left right : List String) : unitTrace (left ++ right) = unitTrace left ++ unitTrace right :=
  SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem traceSuccessor (positions : List String) (fresh : String) :
    unitTrace (positions ++ [fresh]) = unitTrace positions ++ [(fresh,"one-Fold-distinction")] :=
  traceComposition positions [fresh]

end SFT.InformationScience.QuantityPositions
