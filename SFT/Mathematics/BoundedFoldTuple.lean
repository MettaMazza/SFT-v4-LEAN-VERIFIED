import SFT.Mathematics.OrbitOrderExistence
import SFT.Mathematics.LeastCommonReturn
namespace SFT.Mathematics.BoundedFoldTuple
open OrbitOrderIdentity OrbitCycleSupport OrbitOrderExistence
open SFT.Foundation.FractionReduction

-- The recurrent component certificate is obtained from the original odd-core
-- search, not from a selected period. Transient denominators reuse OrbitBinaryDepth.
structure Component where
 rank : Nat
 denominator : Nat
 positive : 0 < rank
 bound : rank ≤ denominator
 reduced : Nat.gcd rank denominator = 1
 odd : denominator % 2 = 1
 period : Nat
 first : FirstBinaryOrder denominator period

theorem componentExists (p q : Nat) (positive : 0 < p) (bound : p ≤ q)
 (reduced : Nat.gcd p q = 1) (odd : q%2=1) :
 ∃ c : Component, c.rank=p ∧ c.denominator=q := by
 obtain ⟨period,_,first,_⟩ := firstOrderExists q (Nat.lt_of_lt_of_le positive bound) odd
 exact ⟨⟨p,q,positive,bound,reduced,odd,period,first⟩,rfl,rfl⟩

def componentAt (c : Component) (n : Nat) := rankIterate c.rank c.denominator n

theorem periodReturns (c : Component) : componentAt c c.period = c.rank :=
 (exactExecutedReturnIffOrder _ _ _ c.positive c.bound c.reduced).mpr c.first.2.1

theorem multipleReturns (c : Component) (k : Nat) : componentAt c (c.period*k)=c.rank := by
 induction k with
 | zero => rfl
 | succ k ih =>
   unfold componentAt at *
   rw [Nat.mul_succ,iterateAddition,ih]
   exact periodReturns c

theorem returnExactlyMultiple (c : Component) (n : Nat) : componentAt c n=c.rank ↔ c.period ∣ n := by
 constructor
 · intro returned
   have split := remainderQuotient n c.period c.first.1
   have shift : componentAt c n=componentAt c (n%c.period) := by
     calc
       componentAt c n = componentAt c ((n%c.period)+c.period*(n/c.period)) := congrArg (componentAt c) split.symm
       _ = componentAt c (c.period*(n/c.period)+(n%c.period)) := congrArg (componentAt c) (Nat.add_comm _ _)
       _ = componentAt c (n%c.period) := by
         unfold componentAt
         rw [iterateAddition,show rankIterate c.rank c.denominator (c.period*(n/c.period))=c.rank from multipleReturns c (n/c.period)]
   have remReturns : componentAt c (n%c.period)=c.rank := shift.symm.trans returned
   have remZero : n%c.period=0 := by
     cases h : n%c.period with
     | zero => rfl
     | succ k =>
       have bad := c.first.2.2 (k+1) (Nat.zero_lt_succ _) (h ▸ Nat.mod_lt n c.first.1)
       have hit := (exactExecutedReturnIffOrder _ _ _ c.positive c.bound c.reduced).mp remReturns
       rw [h] at hit
       exact False.elim (bad hit)
   exact ⟨n/c.period,by rw [remZero,Nat.zero_add] at split; exact split.symm⟩
 · intro divides
   obtain ⟨k,hk⟩ := divides
   rw [hk]
   exact multipleReturns c k

def configuration (cs : List Component) (n : Nat) : List Nat := cs.map (fun c => componentAt c n)
def initial (cs : List Component) : List Nat := cs.map Component.rank

theorem configurationReturns (cs : List Component) (n : Nat) :
 configuration cs n = initial cs ↔ LeastCommonReturn.allDivide (cs.map Component.period) n := by
 induction cs with
 | nil => exact ⟨fun _ => True.intro,fun _ => rfl⟩
 | cons c cs ih =>
   constructor
   · intro same
     have head : componentAt c n=c.rank := List.cons.inj same |>.1
     have tail : configuration cs n=initial cs := List.cons.inj same |>.2
     exact ⟨(returnExactlyMultiple c n).mp head,ih.mp tail⟩
   · intro held
     exact (congrArg (fun h => h::configuration cs n) ((returnExactlyMultiple c n).mpr held.1)).trans (congrArg (List.cons c.rank) (ih.mpr held.2))

theorem periodsPositive (cs : List Component) : LeastCommonReturn.allPositive (cs.map Component.period) := by
 induction cs with
 | nil => exact True.intro
 | cons c cs ih => exact ⟨c.first.1,ih⟩

def jointPeriod (first : Component) (rest : List Component) :=
 LeastCommonReturn.joint first.period (rest.map Component.period)

theorem jointReturns (first : Component) (rest : List Component) :
 configuration (first::rest) (jointPeriod first rest)=initial (first::rest) :=
 (configurationReturns _ _).mpr (LeastCommonReturn.jointReturnsAll _ _ first.first.1 (periodsPositive rest))

theorem jointIsFirst (first : Component) (rest : List Component) (n : Nat) (positive : 0<n)
 (returned : configuration (first::rest) n=initial (first::rest)) : jointPeriod first rest ≤ n :=
 LeastCommonReturn.jointIsLeast _ _ _ first.first.1 (periodsPositive rest) positive
  ((configurationReturns _ _).mp returned)
end SFT.Mathematics.BoundedFoldTuple
