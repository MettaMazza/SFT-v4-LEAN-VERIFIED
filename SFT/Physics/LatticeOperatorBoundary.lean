import SFT.Physics.LatticeOperatorCausality
import SFT.Foundation.FoldAssembly
namespace SFT.Physics.LatticeOperatorBoundary
open LatticeOperator LatticeOperatorCausality SFT.Foundation Count.TraceDerivation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

theorem originalAxisMagnitudeBound (ticks : Nat) (a : AxisPosition)
 (held : a∈positions ticks) : axisMagnitude a≤ticks := by
 induction ticks with
 | zero =>
  cases held with
  | head => exact Nat.le_refl 0
  | tail _ h => cases h
 | succ t ih =>
  rw [originalAxisTickSuccessor] at held
  cases memAppendCases a (positions t) [.lower (t+1),.upper (t+1)] held with
  | inl h => exact Nat.le_trans (ih h) (Nat.le_succ t)
  | inr h =>
   cases h with
   | head => exact Nat.le_refl _
   | tail _ h =>
    cases h with
    | head => exact Nat.le_refl _
    | tail _ h => cases h

theorem originalPositionsDistinct (ticks : Nat) : (positions ticks).Nodup := by
 induction ticks with
 | zero => exact List.Pairwise.cons (fun _ h => nomatch h) List.Pairwise.nil
 | succ t ih =>
  rw [originalAxisTickSuccessor]
  apply FoldAssembly.disjointAppendNodup _ _ ih
  · apply List.Pairwise.cons
    · intro b hb eq
      cases hb with
      | head => cases eq
      | tail _ h => cases h
    · exact List.Pairwise.cons (fun _ h => nomatch h) List.Pairwise.nil
  · intro a ha hnew
    have bound := originalAxisMagnitudeBound t a ha
    cases hnew with
    | head => exact Nat.not_succ_le_self t bound
    | tail _ h =>
     cases h with
     | head => exact Nat.not_succ_le_self t bound
     | tail _ h => cases h

private theorem distinctRows (alphabet : List AxisPosition) (rows : List (List AxisPosition))
 (ha : alphabet.Nodup) (hr : rows.Nodup) :
 (alphabet.flatMap (fun a => rows.map (List.cons a))).Nodup := by
 induction alphabet with
 | nil => exact List.Pairwise.nil
 | cons a rest ih =>
  cases ha with
  | cons fresh tail =>
   apply FoldAssembly.disjointAppendNodup _ _
    (nodupMapInjective (List.cons a) (fun _ _ eq => List.cons.inj eq |>.2) rows hr) (ih tail)
   intro row inFirst inRest
   obtain ⟨xs,_,eqx⟩ := memMapPreimage (List.cons a) row rows inFirst
   obtain ⟨b,hb,inB⟩ := CommonRefinement.memFlatMapOrigin _ rest row inRest
   obtain ⟨ys,_,eqy⟩ := memMapPreimage (List.cons b) row rows inB
   exact fresh b hb (List.cons.inj (eqx.trans eqy.symm)).1

theorem originalCoordinatesDistinct (alphabet : List AxisPosition) (d : Nat)
 (unique : alphabet.Nodup) : (coordinates alphabet d).Nodup := by
 induction d with
 | zero => exact List.Pairwise.cons (fun _ h => nomatch h) List.Pairwise.nil
 | succ d ih => exact distinctRows alphabet (coordinates alphabet d) unique ih

theorem originalBallDistinct (d ticks : Nat) : (ball d ticks).Nodup := by
 have filtered (xs : List (List AxisPosition)) (h : xs.Nodup) :
  (xs.filter (fun axes => radius axes≤ticks)).Nodup := by
  induction xs with
  | nil => exact List.Pairwise.nil
  | cons a xs ih =>
   cases h with
   | cons fresh tail =>
    by_cases keep : radius a≤ticks
    · rw [List.filter_cons_of_pos (p := fun axes => decide (radius axes≤ticks)) (show (decide (radius a≤ticks))=true from decide_eq_true keep)]
      apply List.Pairwise.cons
      · intro b hb eq
        exact fresh b ((SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ b).mp hb).1 eq
      · exact ih tail
    · rw [List.filter_cons_of_neg (p := fun axes => decide (radius axes≤ticks)) (by rw [decide_eq_false keep]; intro h; cases h)]
      exact ih tail
 exact filtered _ (originalCoordinatesDistinct (positions ticks) d (originalPositionsDistinct ticks))

private theorem radiusAccumulator (axes : List AxisPosition) (acc : Nat) :
 (axes.map axisMagnitude).foldl (·+·) acc=acc+radius axes := by
 induction axes generalizing acc with
 | nil => rfl
 | cons a rest ih =>
  change (rest.map axisMagnitude).foldl (·+·) (acc+axisMagnitude a)=
   acc+(rest.map axisMagnitude).foldl (·+·) (0+axisMagnitude a)
  rw [ih,ih,Nat.zero_add,Nat.add_assoc]

theorem originalAxisWithinRadius (axes : List AxisPosition) (a : AxisPosition)
 (held : a∈axes) : axisMagnitude a≤radius axes := by
 induction axes with
 | nil => cases held
 | cons b rest ih =>
  have shape : radius (b::rest)=axisMagnitude b+radius rest :=
   (radiusAccumulator rest (0+axisMagnitude b)).trans (congrArg (fun n => n+radius rest) (Nat.zero_add _))
  rw [shape]
  cases held with
  | head => exact Nat.le_add_right _ _
  | tail _ h => exact Nat.le_trans (ih h) (Nat.le_add_left _ _)

theorem originalNewBoundaryExactly (d ticks : Nat) (axes : List AxisPosition)
 (held : axes∈ball d (ticks+1)) : axes∉ball d ticks ↔ radius axes=ticks+1 := by
 have next := (originalBallCoverage d (ticks+1) axes).mp held
 constructor
 · intro notOld
   have above : ¬radius axes≤ticks := by
    intro bound
    apply notOld
    apply (originalBallCoverage d ticks axes).mpr
    refine ⟨next.1,?_,bound⟩
    intro a ha
    have inNext := next.2.1 a ha
    have axisBound := Nat.le_trans (originalAxisWithinRadius axes a ha) bound
    rw [originalAxisTickSuccessor] at inNext
    cases memAppendCases a (positions ticks) [.lower (ticks+1),.upper (ticks+1)] inNext with
    | inl h => exact h
    | inr h =>
     cases h with
     | head => exact False.elim (Nat.not_succ_le_self ticks axisBound)
     | tail _ h =>
      cases h with
      | head => exact False.elim (Nat.not_succ_le_self ticks axisBound)
      | tail _ h => cases h
   exact Nat.le_antisymm next.2.2 (Nat.lt_of_not_ge above)
 · intro eq old
   have bound := (originalBallCoverage d ticks axes).mp old
   rw [eq] at bound
   exact Nat.not_succ_le_self ticks bound.2.2
end SFT.Physics.LatticeOperatorBoundary
