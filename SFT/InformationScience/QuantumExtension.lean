import SFT.InformationScience.QuantumObservation
namespace SFT.InformationScience.QuantumExtension
open QuantumSupport QuantitySupport
open SFT.Foundation.CommonRefinement

theorem supportSuccessor (labels positions : List String) (support : List Word) (fresh : String)
    (h : completeFoldSupport labels positions = .ok support) (new : ¬ fresh ∈ positions) :
    completeFoldSupport labels (positions ++ [fresh]) = .ok (extendWords labels support) := by
  have original := (QuantumSupport.supportAdmission _ _).mp ⟨support,h⟩
  have nonempty : (positions ++ [fresh]).isEmpty = false := by cases positions <;> rfl
  have canonical := EntropyExtension.freshDistinct positions fresh original.2.2.2 new
  obtain ⟨extended,he⟩ := (QuantumSupport.supportAdmission _ _).mpr ⟨original.1,original.2.1,nonempty,canonical⟩
  have result := QuantumSupport.supportResult _ _ _ he
  rw [appendLength] at result
  change extended = words labels (positions.length+1) at result
  rw [QuantitySupport.positionSuccessorOrder,← QuantumSupport.supportResult _ _ _ h] at result
  rw [← result]
  exact he

theorem provenanceSuccessor (positions : List String) (word : Word) (fresh label : String)
    (length : word.length = positions.length) :
    (positions ++ [fresh]).zip (word ++ [label]) = positions.zip word ++ [(fresh,label)] := by
  induction positions generalizing word with
  | nil => cases word with
    | nil => rfl
    | cons _ _ => cases length
  | cons position rest ih => cases word with
    | nil => cases length
    | cons held tail => exact congrArg (List.cons (position,held)) (ih tail (Nat.succ.inj length))

theorem admittedProvenanceSuccessor (labels positions : List String) (support : List Word)
    (h : completeFoldSupport labels positions = .ok support) (word : Word) (member : word ∈ support)
    (fresh label : String) :
    (positions ++ [fresh]).zip (word ++ [label]) = positions.zip word ++ [(fresh,label)] :=
  provenanceSuccessor _ _ _ _ (((supportMembership _ _ _ h word).mp member).1)

theorem successorDistinct (labels positions : List String) (support : List Word) (fresh : String)
    (h : completeFoldSupport labels positions = .ok support) (new : ¬ fresh ∈ positions) :
    SFT.Mathematics.DiscreteObjects.distinct (extendWords labels support) = true :=
  supportDistinct _ _ _ (supportSuccessor labels positions support fresh h new)

theorem successorTrace (labels positions : List String) (support : List Word) (fresh : String)
    (h : completeFoldSupport labels positions = .ok support) (new : ¬ fresh ∈ positions) :
    ∃ first second tail, labels = first :: second :: tail ∧
      QuantumUnits.informationUnitTrace labels (positions ++ [fresh]) =
        .ok (QuantumUnits.traceRows first second 0 (positions ++ [fresh])) :=
  QuantumUnits.admittedTrace _ _ _ (supportSuccessor labels positions support fresh h new)

theorem firstPositionSupport (labels : List String) (position : String) (support : List Word)
    (h : completeFoldSupport labels [position] = .ok support) : support = labels.map (fun label => [label]) :=
  (QuantumSupport.supportResult _ _ _ h).trans (firstPositionWords labels)

theorem twoLabelBase : completeFoldSupport ["held-a","held-b"] ["p1"] = .ok [["held-a"],["held-b"]] := rfl

end SFT.InformationScience.QuantumExtension
