import SFT.Mathematics.ExactRatioRelations
import SFT.Foundation.ExactValueIdentity
import Init.Data.Nat.Lcm
namespace SFT.Mathematics.LeastCommonReturn
open SFT.Foundation.FractionReduction SFT.Foundation.ExactValueIdentity
open ExactRatioRelations

theorem leftFactor (a b : Nat) (hb : 0<b) : Nat.lcm a b=a*(b/Nat.gcd a b) := by
 let g := Nat.gcd a b
 have hg := gcdPositive a b hb
 have bf := quotientFactor b g hg (gcdDivides a b).2
 change (a*b)/g = _
 have h : a*b=g*(a*(b/g)) := by
  calc
   a*b=a*(g*(b/g)) := congrArg (fun x => a*x) bf
   _=g*(a*(b/g)) := by rw [← mulAssoc,Nat.mul_comm a g,mulAssoc]
 rw [h,divisionMultiple g _ hg]

theorem rightFactor (a b : Nat) (hb : 0<b) : Nat.lcm a b=b*(a/Nat.gcd a b) := by
 let g := Nat.gcd a b
 have hg := gcdPositive a b hb
 have af := quotientFactor a g hg (gcdDivides a b).1
 change (a*b)/g = _
 have h : a*b=g*(b*(a/g)) := by
  calc
   a*b=(g*(a/g))*b := congrArg (fun x => x*b) af
   _=g*(b*(a/g)) := by rw [mulAssoc,Nat.mul_comm (a/g) b]
 rw [h,divisionMultiple g _ hg]

theorem returnsBoth (a b : Nat) (hb : 0<b) : a ∣ Nat.lcm a b ∧ b ∣ Nat.lcm a b :=
 ⟨⟨b/Nat.gcd a b,leftFactor a b hb⟩,⟨a/Nat.gcd a b,rightFactor a b hb⟩⟩

theorem returnPositive (a b : Nat) (ha : 0<a) (hb : 0<b) : 0<Nat.lcm a b := by
 rw [leftFactor a b hb]
 exact Nat.mul_pos ha (quotientPositive b _ hb (gcdPositive a b hb) (gcdDivides a b).2)

theorem gcdTimesReturn (a b : Nat) (hb : 0<b) :
 Nat.gcd a b * Nat.lcm a b=a*b := by
 rw [leftFactor a b hb]
 have bf := quotientFactor b _ (gcdPositive a b hb) (gcdDivides a b).2
 calc
  Nat.gcd a b*(a*(b/Nat.gcd a b))=a*(Nat.gcd a b*(b/Nat.gcd a b)) := by
   rw [← mulAssoc,Nat.mul_comm (Nat.gcd a b) a,mulAssoc]
  _=a*b := congrArg (fun n => a*n) bf.symm

theorem dividesEveryReturn (a b c : Nat) (hb : 0<b) (hc : 0<c)
 (ac : a ∣ c) (bc : b ∣ c) : Nat.lcm a b ∣ c := by
 obtain ⟨u,hu⟩ := ac
 obtain ⟨v,hv⟩ := bc
 have habac : a*b ∣ a*c := ⟨v,by rw [hv,mulAssoc]⟩
 have habbc : a*b ∣ b*c := ⟨u,by rw [hu,← mulAssoc,Nat.mul_comm b a,mulAssoc]⟩
 have hg := commonDivisorDividesGcd (a*b) (a*c) (b*c) habac habbc
 rw [Nat.mul_comm a c,Nat.mul_comm b c,gcdScale c a b hc] at hg
 obtain ⟨k,hk⟩ := hg
 refine ⟨k,?_⟩
 apply cancelPositive (Nat.gcd a b) _ _ (gcdPositive a b hb)
 calc
  Nat.gcd a b*c = c*Nat.gcd a b := Nat.mul_comm _ _
  _ = (a*b)*k := hk
  _ = (Nat.gcd a b*Nat.lcm a b)*k := congrArg (fun n => n*k) (gcdTimesReturn a b hb).symm
  _ = Nat.gcd a b*(Nat.lcm a b*k) := mulAssoc _ _ _

theorem leastPositiveReturn (a b c : Nat) (hb : 0<b) (hc : 0<c)
 (ac : a ∣ c) (bc : b ∣ c) : Nat.lcm a b ≤ c :=
 divisorBound _ _ hc (dividesEveryReturn a b c hb hc ac bc)

def allPositive : List Nat → Prop
 | [] => True
 | p::ps => 0<p ∧ allPositive ps

def allDivide : List Nat → Nat → Prop
 | [],_ => True
 | p::ps,n => p ∣ n ∧ allDivide ps n

def joint (first : Nat) : List Nat → Nat
 | [] => first
 | p::ps => joint (Nat.lcm first p) ps

theorem dividesTrans {a b c : Nat} (ab : a ∣ b) (bc : b ∣ c) : a ∣ c := by
 obtain ⟨u,hu⟩ := ab
 obtain ⟨v,hv⟩ := bc
 exact ⟨u*v,hv.trans ((congrArg (fun n => n*v) hu).trans (mulAssoc a u v))⟩

theorem jointPositive (first : Nat) (ps : List Nat) (hf : 0<first)
 (hp : allPositive ps) : 0<joint first ps := by
 induction ps generalizing first with
 | nil => exact hf
 | cons p ps ih => exact ih (Nat.lcm first p) (returnPositive first p hf hp.1) hp.2

theorem jointCharacterization (first : Nat) (ps : List Nat) (n : Nat)
 (hf : 0<first) (hp : allPositive ps) (hn : 0<n) :
 joint first ps ∣ n ↔ first ∣ n ∧ allDivide ps n := by
 induction ps generalizing first with
 | nil => exact ⟨fun h => ⟨h,True.intro⟩,fun h => h.1⟩
 | cons p ps ih =>
  have step := ih (Nat.lcm first p) (returnPositive first p hf hp.1) hp.2
  constructor
  · intro h
    have hs := step.mp h
    have factors := returnsBoth first p hp.1
    exact ⟨dividesTrans factors.1 hs.1,dividesTrans factors.2 hs.1,hs.2⟩
  · intro h
    exact step.mpr ⟨dividesEveryReturn first p n hp.1 hn h.1 h.2.1,h.2.2⟩

theorem jointReturnsAll (first : Nat) (ps : List Nat) (hf : 0<first)
 (hp : allPositive ps) : first ∣ joint first ps ∧ allDivide ps (joint first ps) :=
 (jointCharacterization first ps (joint first ps) hf hp (jointPositive first ps hf hp)).mp
  ⟨1,(Nat.mul_one _).symm⟩

theorem jointIsLeast (first : Nat) (ps : List Nat) (n : Nat)
 (hf : 0<first) (hp : allPositive ps) (hn : 0<n)
 (common : first ∣ n ∧ allDivide ps n) : joint first ps ≤ n :=
 divisorBound _ _ hn ((jointCharacterization first ps n hf hp hn).mpr common)

theorem originalJointWitness : joint 2 [3,4]=12 := rfl

#print axioms allPositive
#print axioms allDivide
#print axioms joint
#print axioms dividesTrans
#print axioms jointPositive
#print axioms jointCharacterization
#print axioms jointReturnsAll
#print axioms jointIsLeast
#print axioms originalJointWitness
#print axioms leftFactor
#print axioms rightFactor
#print axioms returnsBoth
#print axioms returnPositive
#print axioms gcdTimesReturn
#print axioms dividesEveryReturn
#print axioms leastPositiveReturn
end SFT.Mathematics.LeastCommonReturn
