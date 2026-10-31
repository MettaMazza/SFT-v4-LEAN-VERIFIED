import SFT.Physics.CosmoSpatialFlatness
namespace SFT.Physics.CosmoSpatialFlatness
open SFT.Foundation.ExactOperations SFT.Foundation.FractionReduction
abbrev PositivePart := PositiveFraction

def asRat (p : PositivePart) : Rat := ⟨.ofNat p.numerator,p.denominator,p.denominatorNonzero,p.reduced⟩
def naturalTotal (parts : List PositivePart) (n : Nat := 0) (d : Nat := 1) : Nat × Nat :=
 match parts with
 | [] => (n,d)
 | p::ps => naturalTotal ps (n*p.denominator+p.numerator*d) (d*p.denominator)

theorem addMul (a b c : Nat) : (a+b)*c=a*c+b*c := by
 rw [Nat.mul_comm (a+b) c,Nat.mul_add,Nat.mul_comm c a,Nat.mul_comm c b]
theorem mulLeftComm (a b c : Nat) : a*(b*c)=b*(a*c) := by
 rw [←mulAssoc,Nat.mul_comm a b,mulAssoc]
theorem addLeftComm (a b c : Nat) : a+(b+c)=b+(a+c) := by
 rw [←Nat.add_assoc,Nat.add_comm a b,Nat.add_assoc]

theorem exactIntegerAccumulation (parts : List PositivePart) (n d : Nat) :
 total (parts.map asRat) (.ofNat n) (.ofNat d)=
 (.ofNat (naturalTotal parts n d).1,.ofNat (naturalTotal parts n d).2) := by
 induction parts generalizing n d with
 | nil => rfl
 | cons p ps ih => exact ih _ _

theorem naturalTotalScaled (parts : List PositivePart) (n d k : Nat) :
 naturalTotal parts (n*k) (d*k)=((naturalTotal parts n d).1*k,(naturalTotal parts n d).2*k) := by
 induction parts generalizing n d with
 | nil => rfl
 | cons p ps ih =>
  change naturalTotal ps (n*k*p.denominator+p.numerator*(d*k)) (d*k*p.denominator)=_
  have hn : n*k*p.denominator+p.numerator*(d*k)=(n*p.denominator+p.numerator*d)*k := by
   conv => lhs; simp only [addMul,Nat.mul_add,mulAssoc,Nat.mul_comm,mulLeftComm]
   conv => rhs; simp only [addMul,Nat.mul_add,mulAssoc,Nat.mul_comm,mulLeftComm]
  have hd : d*k*p.denominator=(d*p.denominator)*k := by
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm]
   conv => rhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm]
  rw [hn,hd]
  exact ih _ _

theorem totalAppend (xs ys : List PositivePart) (n d : Nat) :
 naturalTotal (xs++ys) n d=naturalTotal ys (naturalTotal xs n d).1 (naturalTotal xs n d).2 := by
 induction xs generalizing n d with
 | nil => rfl
 | cons p ps ih => exact ih _ _

theorem splitScaled (p a b : PositivePart) (n d : Nat)
 (split : (a.numerator*b.denominator+b.numerator*a.denominator)*p.denominator=
   p.numerator*(a.denominator*b.denominator)) :
 (((n*a.denominator+a.numerator*d)*b.denominator+b.numerator*(d*a.denominator))*p.denominator,
   (d*a.denominator*b.denominator)*p.denominator)=
 ((n*p.denominator+p.numerator*d)*(a.denominator*b.denominator),
   (d*p.denominator)*(a.denominator*b.denominator)) := by
 apply Prod.ext
 · calc
    _ = n*(a.denominator*b.denominator*p.denominator)+
       d*((a.numerator*b.denominator+b.numerator*a.denominator)*p.denominator) := by
         conv => lhs; simp only [addMul,Nat.mul_add,mulAssoc,Nat.mul_comm,mulLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm]
         conv => rhs; simp only [addMul,Nat.mul_add,mulAssoc,Nat.mul_comm,mulLeftComm,Nat.add_assoc,Nat.add_comm,addLeftComm]
    _ = n*(a.denominator*b.denominator*p.denominator)+d*(p.numerator*(a.denominator*b.denominator)) := by rw [split]
    _ = _ := by
      conv => lhs; simp only [addMul,Nat.mul_add,mulAssoc,Nat.mul_comm,mulLeftComm]
      conv => rhs; simp only [addMul,Nat.mul_add,mulAssoc,Nat.mul_comm,mulLeftComm]
 ·
   conv => lhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm]
   conv => rhs; simp only [mulAssoc,Nat.mul_comm,mulLeftComm]

theorem splitPreservesNaturalClosure (tail : List PositivePart) (p a b : PositivePart) (n d : Nat)
 (split : (a.numerator*b.denominator+b.numerator*a.denominator)*p.denominator=
   p.numerator*(a.denominator*b.denominator))
 (closed : (naturalTotal (p::tail) n d).1=(naturalTotal (p::tail) n d).2) :
 (naturalTotal (a::b::tail) n d).1=(naturalTotal (a::b::tail) n d).2 := by
 have pairEq := congrArg (fun pair : Nat × Nat => naturalTotal tail pair.1 pair.2) (splitScaled p a b n d split)
 change naturalTotal tail (((n*a.denominator+a.numerator*d)*b.denominator+b.numerator*(d*a.denominator))*p.denominator)
  ((d*a.denominator*b.denominator)*p.denominator)=
  naturalTotal tail ((n*p.denominator+p.numerator*d)*(a.denominator*b.denominator))
   ((d*p.denominator)*(a.denominator*b.denominator)) at pairEq
 rw [naturalTotalScaled,naturalTotalScaled] at pairEq
 have hN := congrArg Prod.fst pairEq
 have hD := congrArg Prod.snd pairEq
 change (naturalTotal (a::b::tail) n d).1*p.denominator=(naturalTotal (p::tail) n d).1*(a.denominator*b.denominator) at hN
 change (naturalTotal (a::b::tail) n d).2*p.denominator=(naturalTotal (p::tail) n d).2*(a.denominator*b.denominator) at hD
 rw [closed] at hN
 exact Nat.eq_of_mul_eq_mul_right (Nat.pos_of_ne_zero p.denominatorNonzero) (hN.trans hD.symm)

theorem positiveMapped (parts : List PositivePart) : positiveParts (parts.map asRat)=true := by
 induction parts with
 | nil => rfl
 | cons p ps ih =>
  change (decide (0 < Int.ofNat p.numerator) && positiveParts (ps.map asRat))=true
  have h : decide (0 < Int.ofNat p.numerator)=true := by
   cases hn : p.numerator with
   | zero => exact False.elim ((Nat.ne_of_gt p.positive) hn)
   | succ n =>
    apply decide_eq_true
    change (Int.subNatNat (n+1) 1).NonNeg
    unfold Int.subNatNat
    rw [Nat.succ_sub_succ_eq_sub,Nat.zero_sub]
    exact .mk _
  rw [h,ih]
  rfl

theorem everyPositiveSplitPreservesClosure (beforeParts tail : List PositivePart) (p a b : PositivePart)
 (split : (a.numerator*b.denominator+b.numerator*a.denominator)*p.denominator=
   p.numerator*(a.denominator*b.denominator))
 (closed : (naturalTotal (beforeParts++p::tail)).1=(naturalTotal (beforeParts++p::tail)).2) :
 (naturalTotal (beforeParts++a::b::tail)).1=(naturalTotal (beforeParts++a::b::tail)).2 := by
 rw [totalAppend] at closed ⊢
 exact splitPreservesNaturalClosure tail p a b _ _ split closed


theorem asRatPositive (p : PositivePart) : 0 < (asRat p).num := by
 change 0 < Int.ofNat p.numerator
 cases hn : p.numerator with
 | zero => exact False.elim ((Nat.ne_of_gt p.positive) hn)
 | succ n =>
  change (Int.subNatNat (n+1) 1).NonNeg
  unfold Int.subNatNat
  rw [Nat.succ_sub_succ_eq_sub,Nat.zero_sub]
  exact .mk _

theorem everyPositiveRatRepresented (r : Rat) (positive : 0 < r.num) :
 ∃ p : PositivePart, asRat p=r := by
 cases r with
 | mk' num den hd hr =>
  cases num with
  | ofNat n =>
   cases n with
   | zero => cases positive
   | succ n => exact ⟨⟨n+1,den,hd,hr,Nat.zero_lt_succ n⟩,rfl⟩
  | negSucc n => cases positive

theorem everyAdmittedFamilyRepresented (parts : List Rat) (positive : positiveParts parts=true) :
 ∃ ps : List PositivePart, ps.map asRat=parts := by
 induction parts with
 | nil => exact ⟨[],rfl⟩
 | cons p ps ih =>
  change (decide (0<p.num) && positiveParts ps)=true at positive
  cases hp : decide (0<p.num) with
  | false => rw [hp] at positive; cases positive
  | true =>
   rw [hp] at positive
   obtain ⟨q,hq⟩ := everyPositiveRatRepresented p (of_decide_eq_true hp)
   obtain ⟨qs,hqs⟩ := ih positive
   exact ⟨q::qs,(congrArg (fun x => x::qs.map asRat) hq).trans (congrArg (p::.) hqs)⟩

theorem closedMappedExactly (parts : List PositivePart) (nonempty : (parts.map asRat).isEmpty=false) :
 closedPartition (parts.map asRat)=.ok .emptyOne ↔ (naturalTotal parts).1=(naturalTotal parts).2 := by
 have h := closedExactly (parts.map asRat) nonempty (positiveMapped parts)
 constructor
 · intro closed
   have equality := h.mp closed
   have hi := exactIntegerAccumulation parts 0 1
   exact Int.ofNat.inj ((congrArg Prod.fst hi).symm.trans (equality.trans (congrArg Prod.snd hi)))
 · intro equality
   apply h.mpr
   have hi := exactIntegerAccumulation parts 0 1
   exact (congrArg Prod.fst hi).trans ((congrArg Int.ofNat equality).trans (congrArg Prod.snd hi).symm)

theorem mappedAppend (xs ys : List PositivePart) : (xs++ys).map asRat=xs.map asRat++ys.map asRat := by
 induction xs with
 | nil => rfl
 | cons p ps ih => exact congrArg (asRat p :: .) ih

theorem mappedLength (ps : List PositivePart) : (ps.map asRat).length=ps.length := by
 induction ps with
 | nil => rfl
 | cons p ps ih => exact congrArg Nat.succ ih

theorem refinementPreservesClosedPartition (beforeParts tail : List PositivePart) (p a b : PositivePart)
 (split : (a.numerator*b.denominator+b.numerator*a.denominator)*p.denominator=
   p.numerator*(a.denominator*b.denominator))
 (closed : closedPartition ((beforeParts++p::tail).map asRat)=.ok .emptyOne) :
 refinePartition ((beforeParts++p::tail).map asRat) (.integer (.ofNat beforeParts.length)) (asRat a) (asRat b)=
   .ok ((beforeParts++a::b::tail).map asRat) ∧
 closedPartition ((beforeParts++a::b::tail).map asRat)=.ok .emptyOne := by
 have nonemptyOld : ((beforeParts++p::tail).map asRat).isEmpty=false := by cases beforeParts <;> rfl
 have nonemptyNew : ((beforeParts++a::b::tail).map asRat).isEmpty=false := by cases beforeParts <;> rfl
 constructor
 · have splitRational : splitEquals (asRat p) (asRat a) (asRat b) := congrArg Int.ofNat split
   have h := refineRetainsPrefix (beforeParts.map asRat) (tail.map asRat) (asRat p) (asRat a) (asRat b)
    (asRatPositive a) (asRatPositive b) splitRational
   rw [mappedLength] at h
   change refineAt _ beforeParts.length _ _ = _
   rw [mappedAppend,mappedAppend]
   exact h
 · exact (closedMappedExactly _ nonemptyNew).mpr
    (everyPositiveSplitPreservesClosure beforeParts tail p a b split ((closedMappedExactly _ nonemptyOld).mp closed))

inductive PositiveRefinements : List PositivePart → List PositivePart → Prop where
 | base (ps : List PositivePart) : PositiveRefinements ps ps
 | step {start : List PositivePart} (beforeParts tail : List PositivePart) (p a b : PositivePart)
   (split : (a.numerator*b.denominator+b.numerator*a.denominator)*p.denominator=
     p.numerator*(a.denominator*b.denominator))
   (prior : PositiveRefinements start (beforeParts++p::tail)) :
   PositiveRefinements start (beforeParts++a::b::tail)

theorem allFiniteRefinementsPreserveAbsence {start finish : List PositivePart}
 (steps : PositiveRefinements start finish)
 (closed : closedPartition (start.map asRat)=.ok .emptyOne) :
 closedPartition (finish.map asRat)=.ok .emptyOne := by
 induction steps with
 | base => exact closed
 | step beforeParts tail p a b split prior ih =>
  exact (refinementPreservesClosedPartition beforeParts tail p a b split ih).2

end SFT.Physics.CosmoSpatialFlatness
