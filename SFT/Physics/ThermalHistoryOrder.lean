import SFT.Physics.ThermalHistoryThresholds
import SFT.Physics.ThermoTemperatureOrder
namespace SFT.Physics.ThermalHistoryOrder
open SFT.Foundation.ExactOperations
open ThermalHistory
set_option maxHeartbeats 100000000
private theorem integerNotLess (a b : Nat) (bound : b≤a) : ¬Int.ofNat a<Int.ofNat b := by
 intro h
 change Int.NonNeg (Int.subNatNat b (a+1)) at h
 unfold Int.subNatNat at h
 have positive := RunningConvergence.orderedDifferencePositive _ _ (Nat.lt_succ_of_le bound)
 cases hd : (a+1)-b with
 | zero => rw [hd] at positive; cases positive
 | succ n => rw [hd] at h; cases h
private theorem naturalComparison (a b : Nat) :
 decide (Int.ofNat a<Int.ofNat b) = decide (a<b) := by
 by_cases h : a<b
 · rw [decide_eq_true h,decide_eq_true (CommonScaleAxis.integerNaturalLess a b h)]
 · rw [decide_eq_false h,decide_eq_false (integerNotLess a b (Nat.le_of_not_lt h))]

theorem originalPositiveComparison (a b : PositiveFraction) :
 (BoundaryGrowth.asFraction a).blt (BoundaryGrowth.asFraction b) =
 decide (a.numerator*b.denominator < b.numerator*a.denominator) := by
 rcases a with ⟨na,ad,adnz,acop,ap⟩
 rcases b with ⟨nb,bd,bdnz,bcop,bp⟩
 unfold Rat.blt BoundaryGrowth.asFraction
 dsimp only
 cases na with
 | zero => cases ap
 | succ na =>
  cases nb with
  | zero => cases bp
  | succ nb =>
   have notNeg : ¬Int.ofNat (na+1)<0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (na+2)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   have notZero : Int.ofNat (na+1)≠0 := fun h => Nat.noConfusion (congrArg Int.toNat h)
   have notNonpos : ¬Int.ofNat (nb+1)≤0 := by
    intro h
    change Int.NonNeg (Int.subNatNat 0 (nb+1)) at h
    unfold Int.subNatNat at h
    rw [Nat.sub_zero] at h
    cases h
   rw [decide_eq_false notNeg,if_neg notZero,decide_eq_false notNonpos,Bool.and_false,Bool.false_and]
   change decide (Int.ofNat ((na+1)*bd)<Int.ofNat ((nb+1)*ad)) = _
   exact naturalComparison _ _

def insertPositive (value : PositiveFraction) : List PositiveFraction → List PositiveFraction
 | [] => [value]
 | x::xs => if x.numerator*value.denominator < value.numerator*x.denominator
   then value::x::xs else x::insertPositive value xs
def sortPositive : List PositiveFraction → List PositiveFraction
 | [] => []
 | x::xs => insertPositive x (sortPositive xs)

theorem originalInsertionProjection (value : PositiveFraction) (xs : List PositiveFraction) :
 insertDescending (BoundaryGrowth.asFraction value) (xs.map BoundaryGrowth.asFraction) =
 (insertPositive value xs).map BoundaryGrowth.asFraction := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  rw [List.map_cons]
  unfold insertDescending insertPositive
  rw [originalPositiveComparison]
  by_cases h : x.numerator*value.denominator < value.numerator*x.denominator
  · rw [if_pos h,decide_eq_true h]; rfl
  · rw [if_neg h,decide_eq_false h]
    exact congrArg (List.cons (BoundaryGrowth.asFraction x)) ih

theorem originalSortProjection (xs : List PositiveFraction) :
 sortDescending (xs.map BoundaryGrowth.asFraction) =
 (sortPositive xs).map BoundaryGrowth.asFraction := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  rw [List.map_cons,sortDescending,ih,originalInsertionProjection]
  rfl

def Descending (a b : PositiveFraction) : Prop := ThermoTemperatureOrder.magnitudeLE b a
private theorem descendingTrans (a b c : PositiveFraction) (ab : Descending a b) (bc : Descending b c) :
 Descending a c := ThermoTemperatureOrder.magnitudeOrderTransitive c b a bc ab
private theorem insertedAll (P : PositiveFraction → Prop) (value : PositiveFraction)
 (xs : List PositiveFraction) (held : P value) (all : ∀ x,x ∈ xs → P x) :
 ∀ x,x ∈ insertPositive value xs → P x := by
 induction xs with
 | nil => intro x member; cases member with
   | head => exact held
   | tail _ empty => cases empty
 | cons a xs ih =>
  intro x member
  change x ∈ (if a.numerator*value.denominator < value.numerator*a.denominator then value::a::xs else a::insertPositive value xs) at member
  split at member
  ·
    cases member with
    | head => exact held
    | tail _ tail => exact all x tail
  · cases member with
    | head => exact all a (List.Mem.head _)
    | tail _ tail => exact ih (fun x hx => all x (List.Mem.tail _ hx)) x tail

theorem originalInsertionDescending (value : PositiveFraction) (xs : List PositiveFraction)
 (ordered : xs.Pairwise Descending) : (insertPositive value xs).Pairwise Descending := by
 induction xs with
 | nil => exact List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
 | cons x xs ih =>
  cases ordered with
  | cons head tail =>
   unfold insertPositive
   split
   next greater =>
    apply List.Pairwise.cons
    · intro y member
      cases member with
      | head => exact Nat.le_of_lt greater
      | tail _ member => exact descendingTrans value x y (Nat.le_of_lt greater) (head y member)
    · exact List.Pairwise.cons head tail
   next notGreater =>
    exact List.Pairwise.cons (insertedAll (Descending x) value xs (Nat.le_of_not_lt notGreater) head) (ih tail)

theorem originalPositiveSortDescending (xs : List PositiveFraction) : (sortPositive xs).Pairwise Descending := by
 induction xs with
 | nil => exact List.Pairwise.nil
 | cons x xs ih => exact originalInsertionDescending x (sortPositive xs) ih
private theorem mappedDescending (xs : List PositiveFraction) (ordered : xs.Pairwise Descending) :
 (xs.map BoundaryGrowth.asFraction).Pairwise (fun a b => a.blt b=false) := by
 induction xs with
 | nil => exact List.Pairwise.nil
 | cons x xs ih =>
  cases ordered with
  | cons head tail =>
   apply List.Pairwise.cons
   · intro q member
     obtain ⟨y,hy,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage BoundaryGrowth.asFraction q xs member
     cases eq
     rw [originalPositiveComparison]
     exact decide_eq_false (Nat.not_lt_of_ge (head y hy))
   · exact ih tail

theorem originalSortDescending (xs : List PositiveFraction) :
 (sortDescending (xs.map BoundaryGrowth.asFraction)).Pairwise (fun a b => a.blt b=false) := by
 rw [originalSortProjection]
 exact mappedDescending (sortPositive xs) (originalPositiveSortDescending xs)
private theorem reverseAuxAppend {α : Type} (xs ys zs : List α) :
 xs.reverseAux (ys++zs) = xs.reverseAux ys ++ zs := by
 induction xs generalizing ys with
 | nil => rfl
 | cons a xs ih => exact ih (a::ys)
private theorem reverseCons {α : Type} (x : α) (xs : List α) :
 (x::xs).reverse = xs.reverse ++ [x] := reverseAuxAppend xs [] [x]
private theorem appendNil {α : Type} (xs : List α) : xs++[] = xs := by
 induction xs with
 | nil => rfl
 | cons a xs ih => exact congrArg (List.cons a) ih

private theorem positiveGuardLoop (xs : List PositiveFraction) (acc : List Rat) :
 List.mapM.loop (fun q => requirePositive q "threshold") (xs.map BoundaryGrowth.asFraction) acc =
 .ok (acc.reverse ++ xs.map BoundaryGrowth.asFraction) := by
 induction xs generalizing acc with
 | nil => exact congrArg Except.ok (appendNil acc.reverse).symm
 | cons x xs ih =>
   rw [List.map_cons,List.mapM.loop.eq_2,ThermalHistoryTransport.admittedPositive]
   change List.mapM.loop _ (xs.map BoundaryGrowth.asFraction) (BoundaryGrowth.asFraction x::acc) = _
   rw [ih,reverseCons]
   exact congrArg Except.ok (VacuumLedgerProofs.appendAssociative acc.reverse [_] _)

theorem originalThresholdGuard (xs : List PositiveFraction) :
 (xs.map BoundaryGrowth.asFraction).mapM (fun q => requirePositive q "threshold") =
 .ok (xs.map BoundaryGrowth.asFraction) := by
 change List.mapM.loop _ _ [] = _
 rw [positiveGuardLoop]
 rfl

theorem originalAcceptedThresholds (first : PositiveFraction) (rest : List PositiveFraction)
 (distinct : ThermalHistory.distinct ((first::rest).map BoundaryGrowth.asFraction)=true) :
 orderedThresholds ((first::rest).map BoundaryGrowth.asFraction) =
 .ok (sortDescending ((first::rest).map BoundaryGrowth.asFraction)) := by
 unfold orderedThresholds
 change (do
  let exact ← ((first::rest).map BoundaryGrowth.asFraction).mapM (fun q => requirePositive q "threshold")
  if !ThermalHistory.distinct exact then throw "epoch thresholds must retain distinct exact records"
  pure (sortDescending exact)) = _
 rw [originalThresholdGuard]
 dsimp only [Except.bind,Bind.bind]
 rw [distinct]
 rfl

theorem originalAcceptedDescending (first : PositiveFraction) (rest : List PositiveFraction)
 (distinct : ThermalHistory.distinct ((first::rest).map BoundaryGrowth.asFraction)=true) :
 ∃ result, orderedThresholds ((first::rest).map BoundaryGrowth.asFraction)=.ok result ∧
 result.Pairwise (fun a b => a.blt b=false) ∧ result.Perm ((first::rest).map BoundaryGrowth.asFraction) :=
 ⟨_,originalAcceptedThresholds first rest distinct,originalSortDescending _,
  ThermalHistoryThresholds.originalSortRetains _⟩

end SFT.Physics.ThermalHistoryOrder
