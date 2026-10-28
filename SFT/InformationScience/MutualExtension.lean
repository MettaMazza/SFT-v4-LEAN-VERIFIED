import SFT.InformationScience.MutualDecisions
import SFT.InformationScience.EntropyExtension
import SFT.Mathematics.OrderHeldExtension
namespace SFT.InformationScience.MutualExtension
open MutualObservation MutualParts
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Mathematics.DiscreteObjects
open SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

theorem validSuccessor (support : List String) (observation : Observation) (fresh value : String)
    (valid : validateObservation support observation = .ok observation) (new : ¬ fresh ∈ support) :
    validateObservation (support ++ [fresh]) (observation ++ [(fresh,value)]) = .ok (observation ++ [(fresh,value)]) :=
  validationFromPartition _ _ (EntropyExtension.validSuccessor _ _ _ _ (partitionValidity _ _ _ valid) new)

theorem jointSuccessor (support : List String) (left right : Observation) (fresh lv rv a b : String)
    (new : ¬ fresh ∈ support) :
    jointMembers (support ++ [fresh]) (left ++ [(fresh,lv)]) (right ++ [(fresh,rv)]) a b =
      jointMembers support left right a b ++ (if lv = a ∧ rv = b then [fresh] else []) := by
  induction support with
  | nil =>
    change (match belongs (left ++ [(fresh,lv)]) a fresh && belongs (right ++ [(fresh,rv)]) b fresh with
      | true => [fresh] | false => []) = _
    unfold belongs
    rw [imageLastWins,imageLastWins]
    change (match decide (lv = a) && decide (rv = b) with | true => [fresh] | false => []) =
      [] ++ (if lv = a ∧ rv = b then [fresh] else [])
    by_cases hl : lv = a <;> by_cases hr : rv = b
    · rw [decide_eq_true hl,decide_eq_true hr,ite_eq_left ⟨hl,hr⟩]; rfl
    · rw [decide_eq_true hl,decide_eq_false hr,ite_eq_right (fun h => hr h.2)]; rfl
    · rw [decide_eq_false hl,decide_eq_true hr,ite_eq_right (fun h => hl h.1)]; rfl
    · rw [decide_eq_false hl,decide_eq_false hr,ite_eq_right (fun h => hl h.1)]; rfl
  | cons state rest ih =>
    have different : fresh ≠ state := by intro eq; cases eq; exact new (List.Mem.head _)
    have tail : ¬ fresh ∈ rest := fun hm => new (List.Mem.tail state hm)
    have sameL : belongs (left ++ [(fresh,lv)]) a state = belongs left a state := by
      unfold belongs; rw [EntropyExtension.oldImage _ _ _ _ different]
    have sameR : belongs (right ++ [(fresh,rv)]) b state = belongs right b state := by
      unfold belongs; rw [EntropyExtension.oldImage _ _ _ _ different]
    change (match belongs (left ++ [(fresh,lv)]) a state && belongs (right ++ [(fresh,rv)]) b state with
      | true => state :: jointMembers (rest ++ [fresh]) (left ++ [(fresh,lv)]) (right ++ [(fresh,rv)]) a b
      | false => jointMembers (rest ++ [fresh]) (left ++ [(fresh,lv)]) (right ++ [(fresh,rv)]) a b) = _
    rw [sameL,sameR,ih tail]
    change (match belongs left a state && belongs right b state with
      | true => state :: (jointMembers rest left right a b ++ (if lv = a ∧ rv = b then [fresh] else []))
      | false => jointMembers rest left right a b ++ (if lv = a ∧ rv = b then [fresh] else [])) =
      (match belongs left a state && belongs right b state with
        | true => state :: jointMembers rest left right a b | false => jointMembers rest left right a b) ++
      (if lv = a ∧ rv = b then [fresh] else [])
    cases belongs left a state && belongs right b state <;> rfl

theorem conditionalJoint (support : List String) (targetMap givenMap : Observation) (a b : String) :
    conditionalMembers support targetMap givenMap a b = jointMembers support givenMap targetMap a b :=
  (SFT.Mathematics.OrderOperations.boundFilterConjunction _ _ _).symm

theorem conditionalSuccessor (support : List String) (targetMap givenMap : Observation) (fresh tv gv a b : String)
    (new : ¬ fresh ∈ support) :
    conditionalMembers (support ++ [fresh]) (targetMap ++ [(fresh,tv)]) (givenMap ++ [(fresh,gv)]) a b =
      conditionalMembers support targetMap givenMap a b ++ (if gv = a ∧ tv = b then [fresh] else []) := by
  rw [conditionalJoint,conditionalJoint,jointSuccessor _ _ _ _ _ _ _ _ new]

theorem chosenJoint (support : List String) (left right : Observation) (fresh lv rv : String)
    (new : ¬ fresh ∈ support) :
    jointMembers (support ++ [fresh]) (left ++ [(fresh,lv)]) (right ++ [(fresh,rv)]) lv rv =
      jointMembers support left right lv rv ++ [fresh] := by
  rw [jointSuccessor _ _ _ _ _ _ _ _ new,ite_eq_left ⟨rfl,rfl⟩]

theorem otherJoint (support : List String) (left right : Observation) (fresh lv rv a b : String)
    (new : ¬ fresh ∈ support) (other : ¬ (lv = a ∧ rv = b)) :
    jointMembers (support ++ [fresh]) (left ++ [(fresh,lv)]) (right ++ [(fresh,rv)]) a b =
      jointMembers support left right a b := by
  rw [jointSuccessor _ _ _ _ _ _ _ _ new,ite_eq_right other,SymbolExtension.appendNil]

theorem singletonValid (state label : String) : validateObservation [state] [(state,label)] = .ok [(state,label)] :=
  validationFromPartition _ _ (EntropyExtension.singletonValid _ _)

theorem singletonJoint (state leftLabel rightLabel : String) :
    jointMembers [state] [(state,leftLabel)] [(state,rightLabel)] leftLabel rightLabel = [state] := by
  have h := chosenJoint [] [] [] state leftLabel rightLabel (by intro h; cases h)
  exact h

theorem singletonConditional (state targetLabel givenLabel : String) :
    conditionalMembers [state] [(state,targetLabel)] [(state,givenLabel)] givenLabel targetLabel = [state] := by
  rw [conditionalJoint,singletonJoint]

theorem singletonWhole (state : String) (part : SFT.Foundation.ExactOperations.PositiveFraction)
    (h : countPart 1 (Nat.zero_lt_succ 0) [state] = .part part) :
    part.numerator = 1 ∧ part.denominator = 1 := by
  have eq := ExactCell.part.inj h
  rw [← eq]
  exact (SFT.Foundation.ExactOperations.normalizationOneIff 1 1 (Nat.zero_lt_succ 0) (Nat.zero_lt_succ 0)).mpr rfl

theorem jointPartSuccessor (support : List String) (left right : Observation) (fresh lv rv a b : String)
    (new : ¬ fresh ∈ support) (positive : 0 < (support ++ [fresh]).length)
    (ha : a ∈ labels (support ++ [fresh]) (left ++ [(fresh,lv)]))
    (hb : b ∈ labels (support ++ [fresh]) (right ++ [(fresh,rv)]))
    (part : SFT.Foundation.ExactOperations.PositiveFraction)
    (h : (MutualJoint.makeRow (support ++ [fresh]) positive (left ++ [(fresh,lv)])
      (right ++ [(fresh,rv)]) a b ha hb).jointPart = .part part) :
    (jointMembers support left right a b ++ (if lv = a ∧ rv = b then [fresh] else [])).length * part.denominator =
      part.numerator * (support.length+1) := by
  have ratio := (MutualJoint.rowJointValue _ _ _ _ _ _ _ _ _ h).2
  rw [jointSuccessor _ _ _ _ _ _ _ _ new,appendLength support [fresh]] at ratio
  exact ratio

theorem conditionalPartSuccessor (support : List String) (targetMap givenMap : Observation) (fresh tv gv a b : String)
    (new : ¬ fresh ∈ support)
    (ha : a ∈ labels (support ++ [fresh]) (givenMap ++ [(fresh,gv)]))
    (part : SFT.Foundation.ExactOperations.PositiveFraction)
    (h : (MutualConditional.makeRow (support ++ [fresh]) (targetMap ++ [(fresh,tv)])
      (givenMap ++ [(fresh,gv)]) a b ha).exactGivenPart = .part part) :
    (conditionalMembers support targetMap givenMap a b ++ (if gv = a ∧ tv = b then [fresh] else [])).length * part.denominator =
      part.numerator * (fibre support givenMap a ++ (if gv = a then [fresh] else [])).length := by
  have ratio := (MutualConditional.rowValue _ _ _ _ _ _ _ h).2
  rw [conditionalSuccessor _ _ _ _ _ _ _ _ new,EntropyExtension.fibreSuccessor _ _ _ _ _ new] at ratio
  exact ratio

end SFT.InformationScience.MutualExtension
