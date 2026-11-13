import SFT.Mathematics.BoundedFoldSupport
namespace SFT.Mathematics.BoundedFoldTransient
open OrbitOrderIdentity OrbitCycleSupport OrbitBinaryDepth
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
open SFT.Foundation.ExactOperations SFT.Foundation.ExactPartCarrier
open BoundedFoldSupport (Input)

-- Factor the supplied positive denominator. Both depth and odd core are
-- obtained from its exact division trace, not chosen scientific inputs.
theorem denominatorDecomposes (q : Nat) (positive : 0<q) :
 ∃ depth core, 0<core ∧ core%2=1 ∧ q=2^depth*core := by
 induction q using Nat.strongRecOn with
 | ind q ih =>
   by_cases odd : q%2=1
   · exact ⟨0,q,positive,odd,(Nat.one_mul q).symm⟩
   · have even : q%2=0 := by
       cases h : q%2 with
       | zero => rfl
       | succ k =>
         have below := Nat.mod_lt q (by decide : 0<2)
         rw [h] at below
         have small : k<1 := Nat.lt_of_succ_lt_succ below
         have zero : k=0 := Nat.eq_zero_of_le_zero (Nat.le_of_lt_succ small)
         exact False.elim (odd (h.trans (congrArg Nat.succ zero)))
     have shape := remainderQuotient q 2 (by decide)
     rw [even,Nat.zero_add] at shape
     have halfPositive : 0<q/2 := by
       apply Nat.pos_of_ne_zero
       intro zero
       rw [zero,Nat.mul_zero] at shape
       exact Nat.ne_of_gt positive shape.symm
     have smaller : q/2<q := by
       calc
         q/2 = q/2+0 := (Nat.add_zero _).symm
         _ < q/2+q/2 := Nat.add_lt_add_left halfPositive _
         _ = 2*(q/2) := (Nat.two_mul _).symm
         _ = q := shape
     obtain ⟨a,m,hm,oddm,decomposed⟩ := ih (q/2) smaller halfPositive
     refine ⟨a+1,m,hm,oddm,?_⟩
     calc
       q = 2*(q/2) := shape.symm
       _ = 2*(2^a*m) := congrArg (Nat.mul 2) decomposed
       _ = 2^(a+1)*m := by rw [Nat.pow_succ,Nat.mul_comm (2^a) 2,mulAssoc]

theorem foldScale (g p q : Nat) (hg : 0<g) (hq : 0<q) :
 foldRank (g*p) (g*q)=g*foldRank p q := by
 unfold foldRank
 rw [mulAssoc,moduloScale g (p*2) q hg hq]
 by_cases zero : (p*2)%q=0
 · rw [zero,Nat.mul_zero]
   rfl
 · have nonzero : g*((p*2)%q)≠0 := Nat.ne_of_gt (Nat.mul_pos hg (Nat.pos_of_ne_zero zero))
   rw [ite_eq_right nonzero,ite_eq_right zero]

theorem iterateScale (g p q n : Nat) (hg : 0<g) (hq : 0<q) :
 rankIterate (g*p) (g*q) n=g*rankIterate p q n := by
 induction n with
 | zero => rfl
 | succ n ih =>
   change foldRank (rankIterate (g*p) (g*q) n) (g*q) = g*foldRank (rankIterate p q n) q
   rw [ih,foldScale g _ q hg hq]

def normalizedAt (x : Input) (n : Nat) : Part :=
 normalizePart (rankIterate x.rank x.denominator n) x.denominator
  (iterateBounds _ _ _ x.positive x.bound).1 (iterateBounds _ _ _ x.positive x.bound).2

theorem oddAfterDepth (x : Input) (depth core : Nat) (corePositive : 0<core)
 (odd : core%2=1) (decomposition : x.denominator=2^depth*core) (k : Nat) :
 (normalizedAt x (depth+k)).denominator=core := by
 unfold normalizedAt
 rw [actualNormalizedDenominator x.rank x.denominator (depth+k) x.positive x.bound]
 have h := executedDenominatorAfterDepth x.rank core depth k corePositive odd (decomposition ▸ x.reduced)
 rw [← decomposition] at h
 exact h

theorem eventuallyOdd (x : Input) :
 ∃ depth, ∀ k, (normalizedAt x (depth+k)).denominator%2=1 := by
 obtain ⟨depth,core,hc,odd,shape⟩ := denominatorDecomposes x.denominator
   (Nat.lt_of_lt_of_le x.positive x.bound)
 refine ⟨depth,?_⟩
 intro k
 rw [oddAfterDepth x depth core hc odd shape k]
 exact odd

theorem commonTransientExists (xs : List Input) :
 ∃ depth, ∀ x, x ∈ xs → ∀ k, (normalizedAt x (depth+k)).denominator%2=1 := by
 induction xs with
 | nil => exact ⟨0,fun _ impossible => by cases impossible⟩
 | cons x xs ih =>
   obtain ⟨a,ha⟩ := eventuallyOdd x
   obtain ⟨b,hb⟩ := ih
   let depth := max a b
   have bounds : a≤depth ∧ b≤depth := by
     change a≤max a b ∧ b≤max a b
     by_cases h : a≤b
     · rw [Nat.max_def,ite_eq_left h]
       exact ⟨h,Nat.le_refl _⟩
     · rw [Nat.max_def,ite_eq_right h]
       exact ⟨Nat.le_refl _,Nat.le_of_lt (Nat.lt_of_not_ge h)⟩
   refine ⟨depth,?_⟩
   intro y member k
   cases member with
   | head =>
     have shape : depth+k=a+((depth-a)+k) := by
       rw [← Nat.add_assoc,Nat.add_comm a (depth-a),subtractAdd depth a bounds.1]
     rw [shape]
     exact ha _
   | tail _ member =>
     have shape : depth+k=b+((depth-b)+k) := by
       rw [← Nat.add_assoc,Nat.add_comm b (depth-b),subtractAdd depth b bounds.2]
     rw [shape]
     exact hb y member _

theorem sourceReturnIff (x : Input) (depth n : Nat) (c : BoundedFoldTuple.Component)
 (rankHeld : c.rank=(normalizedAt x depth).numerator)
 (denominatorHeld : c.denominator=(normalizedAt x depth).denominator) :
 rankIterate x.rank x.denominator (depth+n)=rankIterate x.rank x.denominator depth ↔
 BoundedFoldTuple.componentAt c n=c.rank := by
 let raw := rankIterate x.rank x.denominator depth
 let g := Nat.gcd raw x.denominator
 have positive := (iterateBounds _ _ depth x.positive x.bound).1
 have denPositive := Nat.lt_of_lt_of_le x.positive x.bound
 have gp : 0<g := gcdPositive raw x.denominator denPositive
 have nf : raw=g*c.rank := by
   rw [rankHeld]
   exact normalizedNumeratorFactor raw x.denominator positive denPositive
 have df : x.denominator=g*c.denominator := by
   rw [denominatorHeld]
   exact normalizedDenominatorFactor raw x.denominator positive denPositive
 have trace : rankIterate x.rank x.denominator (depth+n)=g*BoundedFoldTuple.componentAt c n := by
   rw [iterateAddition]
   change rankIterate raw x.denominator n=_
   rw [nf,df]
   exact iterateScale g c.rank c.denominator n gp (Nat.lt_of_lt_of_le c.positive c.bound)
 constructor
 · intro returned
   apply ExactRatioRelations.cancelPositive g _ _ gp
   exact trace.symm.trans (returned.trans nf)
 · intro returned
   exact trace.trans ((congrArg (Nat.mul g) returned).trans nf.symm)

inductive Aligned (depth : Nat) : List Input → List BoundedFoldTuple.Component → Prop
 | nil : Aligned depth [] []
 | cons {x xs c cs} : c.rank=(normalizedAt x depth).numerator →
     c.denominator=(normalizedAt x depth).denominator →
     Aligned depth xs cs → Aligned depth (x::xs) (c::cs)

theorem alignedComponentsExist (xs : List Input) (depth : Nat)
 (odd : ∀ x, x ∈ xs → (normalizedAt x depth).denominator%2=1) :
 ∃ cs, Aligned depth xs cs := by
 induction xs with
 | nil => exact ⟨[],Aligned.nil⟩
 | cons x xs ih =>
   let p := normalizedAt x depth
   obtain ⟨c,rankHeld,denHeld⟩ := BoundedFoldTuple.componentExists p.numerator p.denominator
     p.positive p.throughOne p.reduced (odd x (List.Mem.head _))
   obtain ⟨cs,tail⟩ := ih (fun y member => odd y (List.Mem.tail _ member))
   exact ⟨c::cs,Aligned.cons rankHeld denHeld tail⟩

theorem sourceTupleReturnIff (xs : List Input) (cs : List BoundedFoldTuple.Component)
 (depth n : Nat) (aligned : Aligned depth xs cs) :
 BoundedFoldSupport.configuration xs (depth+n)=BoundedFoldSupport.configuration xs depth ↔
 BoundedFoldTuple.configuration cs n=BoundedFoldTuple.initial cs := by
 induction aligned with
 | nil => exact ⟨fun _ => rfl,fun _ => rfl⟩
 | @cons x xs c cs hr hd tail ih =>
   have head := sourceReturnIff x depth n c hr hd
   constructor
   · intro same
     have a := List.cons.inj same |>.1
     have b := List.cons.inj same |>.2
     exact (congrArg (fun h => h::BoundedFoldTuple.configuration cs n) (head.mp a)).trans
       (congrArg (List.cons c.rank) (ih.mp b))
   · intro same
     have a := List.cons.inj same |>.1
     have b := List.cons.inj same |>.2
     exact (congrArg (fun h => h::BoundedFoldSupport.configuration xs (depth+n)) (head.mpr a)).trans
       (congrArg (List.cons (rankIterate x.rank x.denominator depth)) (ih.mpr b))

theorem everyPositiveTupleRecurrent (x : Input) (xs : List Input) :
 ∃ depth period, 0<period ∧
 BoundedFoldSupport.configuration (x::xs) (depth+period)=BoundedFoldSupport.configuration (x::xs) depth ∧
 (∀ n, 0<n → BoundedFoldSupport.configuration (x::xs) (depth+n)=BoundedFoldSupport.configuration (x::xs) depth → period≤n) := by
 obtain ⟨depth,allOdd⟩ := commonTransientExists (x::xs)
 have odd : ∀ y, y ∈ x::xs → (normalizedAt y depth).denominator%2=1 := by
   intro y member
   exact allOdd y member 0
 obtain ⟨cs,aligned⟩ := alignedComponentsExist (x::xs) depth odd
 cases aligned with
 | @cons x xs c cs hr hd tail =>
   let period := BoundedFoldTuple.jointPeriod c cs
   have whole := Aligned.cons hr hd tail
   have equivalence := sourceTupleReturnIff (x::xs) (c::cs) depth period whole
   refine ⟨depth,period,LeastCommonReturn.jointPositive _ _ c.first.1 (BoundedFoldTuple.periodsPositive cs),
     equivalence.mpr (BoundedFoldTuple.jointReturns c cs),?_⟩
   intro n positive returned
   exact BoundedFoldTuple.jointIsFirst c cs n positive ((sourceTupleReturnIff _ _ depth n whole).mp returned)


theorem originalJointCertificate (x : Input) (xs : List Input) :
 ∃ depth c cs, Aligned depth (x::xs) (c::cs) ∧
 BoundedFoldSupport.configuration (x::xs) (depth+BoundedFoldTuple.jointPeriod c cs)=BoundedFoldSupport.configuration (x::xs) depth ∧
 (∀ n, 0<n → BoundedFoldSupport.configuration (x::xs) (depth+n)=BoundedFoldSupport.configuration (x::xs) depth → BoundedFoldTuple.jointPeriod c cs≤n) := by
 obtain ⟨depth,allOdd⟩ := commonTransientExists (x::xs)
 obtain ⟨cs,aligned⟩ := alignedComponentsExist (x::xs) depth (fun y member => allOdd y member 0)
 cases aligned with
 | @cons x xs c cs hr hd tail =>
   have whole := Aligned.cons hr hd tail
   refine ⟨depth,c,cs,whole,?_,?_⟩
   · exact (sourceTupleReturnIff _ _ depth _ whole).mpr (BoundedFoldTuple.jointReturns c cs)
   · intro n positive returned
     exact BoundedFoldTuple.jointIsFirst c cs n positive ((sourceTupleReturnIff _ _ depth n whole).mp returned)

end SFT.Mathematics.BoundedFoldTransient
