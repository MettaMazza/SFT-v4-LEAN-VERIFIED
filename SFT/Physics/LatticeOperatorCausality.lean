import SFT.Physics.LatticeOperator
import SFT.Mathematics.DiscreteComplement
namespace SFT.Physics.LatticeOperatorCausality
open LatticeOperator SFT.Foundation Count.TraceDerivation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- The actual source product contains exactly the dimension-length coordinate lists
-- whose axes occur in the original ordered alphabet.
theorem originalProductCoverage (alphabet : List AxisPosition) (d : Nat)
 (axes : List AxisPosition) : axes ∈ coordinates alphabet d ↔
 axes.length=d ∧ ∀ a, a∈axes → a∈alphabet := by
 induction d generalizing axes with
 | zero =>
  constructor
  · intro h
    cases h with
    | head => exact ⟨rfl,fun _ h => nomatch h⟩
    | tail _ h => cases h
  · intro h
    cases axes with
    | nil => exact List.Mem.head _
    | cons a rest => cases h.1
 | succ d ih =>
  constructor
  · intro h
    obtain ⟨a,ha,hm⟩ := CommonRefinement.memFlatMapOrigin _ alphabet axes h
    obtain ⟨rest,hr,eq⟩ := memMapPreimage (List.cons a) axes (coordinates alphabet d) hm
    cases eq
    have p := (ih rest).mp hr
    exact ⟨congrArg Nat.succ p.1,fun x hx => by
     cases hx with
     | head => exact ha
     | tail _ ht => exact p.2 x ht⟩
  · intro h
    cases axes with
    | nil => cases h.1
    | cons a rest =>
     have len : rest.length=d := Nat.succ.inj h.1
     have ha : a∈alphabet := h.2 a (List.Mem.head _)
     have hr : rest∈coordinates alphabet d := (ih rest).mpr
      ⟨len,fun x hx => h.2 x (List.Mem.tail _ hx)⟩
     exact CommonRefinement.memFlatMap _ alphabet a _ ha (memMap (List.cons a) rest _ hr)

theorem originalBallCoverage (d ticks : Nat) (axes : List AxisPosition) :
 axes∈ball d ticks ↔ axes.length=d ∧
 (∀ a, a∈axes → a∈positions ticks) ∧ radius axes≤ticks := by
 constructor
 · intro h
   have p := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ axes).mp h
   have q := (originalProductCoverage (positions ticks) d axes).mp p.1
   exact ⟨q.1,q.2,of_decide_eq_true p.2⟩
 · intro h
   exact (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ axes).mpr
    ⟨(originalProductCoverage (positions ticks) d axes).mpr ⟨h.1,h.2.1⟩,
     decide_eq_true h.2.2⟩
private theorem rangeLoopAppend (n : Nat) (acc : List Nat) :
 List.range.loop n acc=List.range.loop n [] ++ acc := by
 have assoc (xs ys zs : List Nat) : (xs++ys)++zs=xs++(ys++zs) := by
  induction xs with
  | nil => rfl
  | cons a xs ih => exact congrArg (List.cons a) ih
 induction n generalizing acc with
 | zero => rfl
 | succ n ih =>
  change List.range.loop n (n::acc)=List.range.loop n [n] ++ acc
  rw [ih (n::acc),ih [n],assoc]
  rfl
private theorem rangeSuccessor (n : Nat) : List.range (n+1)=List.range n ++ [n] :=
 rangeLoopAppend n [n]
private theorem positionAppend (xs ys : List Nat) :
 (xs++ys).flatMap (fun i => [AxisPosition.lower (i+1),.upper (i+1)])=
 xs.flatMap (fun i => [AxisPosition.lower (i+1),.upper (i+1)]) ++
 ys.flatMap (fun i => [AxisPosition.lower (i+1),.upper (i+1)]) := by
 induction xs with
 | nil => rfl
 | cons x xs ih =>
  change AxisPosition.lower (x+1)::AxisPosition.upper (x+1)::((xs++ys).flatMap _) =
   AxisPosition.lower (x+1)::AxisPosition.upper (x+1)::(xs.flatMap _ ++ ys.flatMap _)
  rw [ih]
theorem originalAxisTickSuccessor (ticks : Nat) :
 positions (ticks+1)=positions ticks ++ [.lower (ticks+1),.upper (ticks+1)] := by
 unfold positions
 rw [rangeSuccessor,positionAppend]
 rfl

theorem originalEarlierCellRetained (d ticks : Nat) (axes : List AxisPosition)
 (held : axes∈ball d ticks) : axes∈ball d (ticks+1) := by
 have h := (originalBallCoverage d ticks axes).mp held
 apply (originalBallCoverage d (ticks+1) axes).mpr
 refine ⟨h.1,?_,Nat.le_trans h.2.2 (Nat.le_succ ticks)⟩
 intro a ha
 rw [originalAxisTickSuccessor]
 exact memAppendLeft _ _ _ (h.2.1 a ha)
end SFT.Physics.LatticeOperatorCausality
