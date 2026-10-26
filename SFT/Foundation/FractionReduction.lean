import Init.Data.Nat.Gcd
import SFT.Foundation.ExactCast
/-! Constructive arithmetic for the Fraction reduction required by
engine/exact.py::ExactPart.from_pair. The GCD function is exactly Nat.gcd;
these proofs avoid the axiom dependencies of its general library lemmas. -/
namespace SFT.Foundation.FractionReduction

def measure (x : (_ : Nat) ×' Nat) : Nat := x.casesOn fun m _ => m

def step (x : (_ : Nat) ×' Nat)
    (rec : (y : (_ : Nat) ×' Nat) → measure y < measure x → Nat) : Nat :=
  x.casesOn (motive := fun x => ((y : (_ : Nat) ×' Nat) → measure y < measure x → Nat) → Nat)
    (fun m n rec => if h : m = 0 then n else rec ⟨n%m,m⟩ (Nat.mod_lt n (Nat.pos_of_ne_zero h))) rec

def gcdFuel (fuel m n : Nat) (bound : m < fuel) : Nat :=
  WellFounded.Nat.fix.go measure step fuel ⟨m,n⟩ bound

theorem isBuiltin (m n : Nat) : gcdFuel (m+1) m n (Nat.lt_succ_self m) = Nat.gcd m n := by
  delta Nat.gcd Nat.gcd._unary WellFounded.Nat.fix
  simp only [WellFounded.Nat.eager_eq]
  rfl

theorem fuelStep (fuel m n : Nat) (bound : m < fuel+1) :
    gcdFuel (fuel+1) m n bound =
    if hm : m = 0 then n else gcdFuel fuel (n%m) m
      (Nat.lt_of_lt_of_le (Nat.mod_lt n (Nat.pos_of_ne_zero hm)) (Nat.le_of_lt_succ bound)) := rfl

theorem fuelIndependent (fuel other m n : Nat) (hf : m < fuel) (ho : m < other) :
    gcdFuel fuel m n hf = gcdFuel other m n ho := by
  induction fuel generalizing other m n with
  | zero => exact False.elim (Nat.not_lt_zero _ hf)
  | succ fuel ih =>
    cases other with
    | zero => exact False.elim (Nat.not_lt_zero _ ho)
    | succ other =>
      rw [fuelStep, fuelStep]
      if hm : m = 0 then
        rw [dite_eq_left hm, dite_eq_left hm]
      else
        rw [dite_eq_right hm, dite_eq_right hm]
        exact ih other (n%m) m _ _

theorem gcdZero (n : Nat) : Nat.gcd 0 n = n := by
  rw [← isBuiltin]
  rfl

theorem gcdStep (m n : Nat) (hm : m ≠ 0) : Nat.gcd m n = Nat.gcd (n%m) m := by
  rw [← isBuiltin, ← isBuiltin (n%m) m, fuelStep, dite_eq_right hm]
  exact fuelIndependent m (n%m+1) (n%m) m _ _

theorem subtractAdd (n d : Nat) (h : d ≤ n) : n-d+d = n := by
  induction d generalizing n with
  | zero => rfl
  | succ d ih =>
    cases n with
    | zero => exact False.elim (Nat.not_succ_le_zero _ h)
    | succ n =>
      rw [Nat.succ_sub_succ_eq_sub, Nat.add_succ, ih n (Nat.le_of_succ_le_succ h)]

theorem divisionTrace (fuel n d : Nat) (hd : 0 < d) (bound : n < fuel) :
    Nat.modCore.go d hd fuel n bound + d * Nat.div.go d hd fuel n bound = n := by
  induction fuel generalizing n with
  | zero => exact False.elim (Nat.not_lt_zero _ bound)
  | succ fuel ih =>
    rw [Nat.modCore.go.eq_1, Nat.div.go.eq_1]
    if h : d ≤ n then
      rw [dite_eq_left h, dite_eq_left h, Nat.mul_succ, ← Nat.add_assoc, ih]
      exact subtractAdd n d h
    else
      rw [dite_eq_right h, dite_eq_right h]
      rfl

theorem remainderQuotient (n d : Nat) (hd : 0 < d) : n%d + d*(n/d) = n := by
  cases n with
  | zero =>
    change 0 + d * Nat.div 0 d = 0
    delta Nat.div
    rw [dite_eq_left hd, Nat.div.go.eq_1, dite_eq_right (Nat.not_le_of_gt hd)]
    rfl
  | succ n =>
    change (if d ≤ n+1 then Nat.modCore (n+1) d else n+1) + d * Nat.div (n+1) d = n+1
    if h : d ≤ n+1 then
      rw [ite_eq_left h]
      delta Nat.modCore Nat.div
      rw [dite_eq_left hd, dite_eq_left hd]
      exact divisionTrace _ _ _ hd _
    else
      rw [ite_eq_right h]
      delta Nat.div
      rw [dite_eq_left hd, Nat.div.go.eq_1, dite_eq_right h]
      rfl

theorem mulAssoc (a b c : Nat) : a*b*c = a*(b*c) := by
  induction c with
  | zero => rfl
  | succ c ih => rw [Nat.mul_succ, Nat.mul_succ, Nat.mul_add, ih]

theorem addSubtractSame (a b k : Nat) : (a+k)-(b+k) = a-b := by
  induction k with
  | zero => rfl
  | succ k ih => rw [Nat.add_succ, Nat.add_succ, Nat.succ_sub_succ_eq_sub]; exact ih

theorem mulSubtract (k a b : Nat) : k*a-k*b = k*(a-b) := by
  induction b generalizing a with
  | zero => rfl
  | succ b ih =>
    cases a with
    | zero => rw [Nat.mul_zero, Nat.zero_sub, Nat.zero_sub, Nat.mul_zero]
    | succ a =>
      rw [Nat.mul_succ, Nat.mul_succ, addSubtractSame, Nat.succ_sub_succ_eq_sub]
      exact ih a

theorem dividesSubtract {k a b : Nat} (ha : k ∣ a) (hb : k ∣ b) : k ∣ a-b := by
  obtain ⟨x,hx⟩ := ha
  obtain ⟨y,hy⟩ := hb
  exact ⟨x-y, by rw [hx,hy,mulSubtract]⟩

theorem dividesRemainder {k n d : Nat} (hd : 0 < d) (hn : k ∣ n) (hkd : k ∣ d) :
    k ∣ n%d := by
  obtain ⟨a,ha⟩ := hkd
  have hproduct : k ∣ d*(n/d) := ⟨a*(n/d), by rw [ha,mulAssoc]⟩
  have difference := dividesSubtract hn hproduct
  have decomposition := congrArg (fun x => x-d*(n/d)) (remainderQuotient n d hd)
  rw [ExactCast.addSubtract] at decomposition
  exact decomposition.symm ▸ difference

theorem gcdDivides (m n : Nat) : Nat.gcd m n ∣ m ∧ Nat.gcd m n ∣ n := by
  induction m using Nat.strongRecOn generalizing n with
  | ind m ih =>
    if hm : m = 0 then
      subst m
      rw [gcdZero]
      exact ⟨⟨0,rfl⟩,⟨1,(Nat.mul_one n).symm⟩⟩
    else
      have hp := Nat.pos_of_ne_zero hm
      have prior := ih (n%m) (Nat.mod_lt n hp) m
      rw [gcdStep m n hm]
      obtain ⟨a,ha⟩ := prior.1
      obtain ⟨b,hb⟩ := prior.2
      refine ⟨⟨b,hb⟩,⟨a+b*(n/m),?_⟩⟩
      calc
        n = n%m + m*(n/m) := (remainderQuotient n m hp).symm
        _ = Nat.gcd (n%m) m*a + (Nat.gcd (n%m) m*b)*(n/m) :=
          (congrArg (fun z => z+m*(n/m)) ha).trans
            (congrArg (fun z => Nat.gcd (n%m) m*a+z*(n/m)) hb)
        _ = Nat.gcd (n%m) m * (a+b*(n/m)) := by rw [Nat.mul_add,mulAssoc]

theorem commonDivisorDividesGcd (k m n : Nat) (hm : k ∣ m) (hn : k ∣ n) :
    k ∣ Nat.gcd m n := by
  induction m using Nat.strongRecOn generalizing n with
  | ind m ih =>
    if hz : m = 0 then
      subst m
      rw [gcdZero]
      exact hn
    else
      have hp := Nat.pos_of_ne_zero hz
      rw [gcdStep m n hz]
      exact ih (n%m) (Nat.mod_lt n hp) m (dividesRemainder hp hn hm) hm

theorem gcdPositive (m n : Nat) (hn : 0 < n) : 0 < Nat.gcd m n := by
  apply Nat.pos_of_ne_zero
  intro hz
  obtain ⟨k,hk⟩ := (gcdDivides m n).2
  rw [hz,Nat.zero_mul] at hk
  exact Nat.ne_of_gt hn hk

theorem divisionFuelIndependent (fuel other n d : Nat) (hd : 0 < d)
    (hf : n < fuel) (ho : n < other) :
    Nat.div.go d hd fuel n hf = Nat.div.go d hd other n ho := by
  induction fuel generalizing other n with
  | zero => exact False.elim (Nat.not_lt_zero _ hf)
  | succ fuel ih =>
    cases other with
    | zero => exact False.elim (Nat.not_lt_zero _ ho)
    | succ other =>
      rw [Nat.div.go.eq_1, Nat.div.go.eq_1]
      if h : d ≤ n then
        rw [dite_eq_left h, dite_eq_left h]
        exact congrArg (fun k => k+1) (ih other (n-d) _ _)
      else rw [dite_eq_right h, dite_eq_right h]

theorem divisionRemoves (n d : Nat) (hd : 0 < d) (h : d ≤ n) : n/d = (n-d)/d+1 := by
  change Nat.div n d = Nat.div (n-d) d + 1
  delta Nat.div
  rw [dite_eq_left hd, dite_eq_left hd, Nat.div.go.eq_1, dite_eq_left h]
  exact congrArg (fun k => k+1) (divisionFuelIndependent n (n-d+1) (n-d) d hd _ _)

theorem divisionBelow (n d : Nat) (hd : 0 < d) (h : n < d) : n/d = 0 := by
  change Nat.div n d = 0
  delta Nat.div
  rw [dite_eq_left hd, Nat.div.go.eq_1, dite_eq_right (Nat.not_le_of_gt h)]

theorem divisionMultiple (d k : Nat) (hd : 0 < d) : (d*k)/d = k := by
  induction k with
  | zero => exact divisionBelow 0 d hd hd
  | succ k ih =>
    rw [Nat.mul_succ, divisionRemoves _ _ hd (Nat.le_add_left d (d*k)), ExactCast.addSubtract, ih]

theorem quotientFactor (n g : Nat) (hg : 0 < g) (divides : g ∣ n) : n = g*(n/g) := by
  obtain ⟨k,hk⟩ := divides
  have division : n/g = k := by rw [hk,divisionMultiple g k hg]
  exact hk.trans (congrArg (fun x => g*x) division.symm)

theorem quotientPositive (n g : Nat) (hn : 0 < n) (hg : 0 < g) (divides : g ∣ n) : 0 < n/g := by
  apply Nat.pos_of_ne_zero
  intro hz
  have factor := quotientFactor n g hg divides
  rw [hz,Nat.mul_zero] at factor
  exact Nat.ne_of_gt hn factor

theorem factorOfOne (k t : Nat) (h : k*t = 1) : k = 1 := by
  cases k with
  | zero => rw [Nat.zero_mul] at h; cases h
  | succ k =>
    cases t with
    | zero => cases h
    | succ t =>
      have bound : k+1 ≤ (k+1)*(t+1) := by
        rw [Nat.mul_succ]
        exact Nat.le_add_left _ _
      rw [h] at bound
      exact Nat.le_antisymm bound (Nat.succ_le_succ (Nat.zero_le k))

theorem reducedCoprime (n d : Nat) (hd : 0 < d) :
    (n / Nat.gcd n d).Coprime (d / Nat.gcd n d) := by
  let g := Nat.gcd n d
  let a := n/g
  let b := d/g
  let k := Nat.gcd a b
  have hg : 0 < g := gcdPositive n d hd
  have nf : n = g*a := quotientFactor n g hg (gcdDivides n d).1
  have df : d = g*b := quotientFactor d g hg (gcdDivides n d).2
  obtain ⟨x,hx⟩ := (gcdDivides a b).1
  obtain ⟨y,hy⟩ := (gcdDivides a b).2
  have kn : g*k ∣ n := ⟨x,nf.trans ((congrArg (fun z => g*z) hx).trans (mulAssoc g k x).symm)⟩
  have kd : g*k ∣ d := ⟨y,df.trans ((congrArg (fun z => g*z) hy).trans (mulAssoc g k y).symm)⟩
  obtain ⟨t,ht⟩ := commonDivisorDividesGcd (g*k) n d kn kd
  have equality : g*1 = g*(k*t) := (Nat.mul_one g).trans (ht.trans (mulAssoc g k t))
  have one : 1 = k*t := Nat.eq_of_mul_eq_mul_left hg equality
  exact factorOfOne k t one.symm

theorem divisorBound (k n : Nat) (hn : 0 < n) (divides : k ∣ n) : k ≤ n := by
  obtain ⟨x,hx⟩ := divides
  cases x with
  | zero =>
    have hz : n = 0 := hx
    exact False.elim (Nat.ne_of_gt hn hz)
  | succ x =>
    have h : k ≤ k*(x+1) := by rw [Nat.mul_succ]; exact Nat.le_add_left k _
    exact hx.symm ▸ h

theorem gcdSelf (n : Nat) : Nat.gcd n n = n := by
  if hz : n = 0 then subst n; exact gcdZero 0
  else
    have hp := Nat.pos_of_ne_zero hz
    have left := divisorBound _ n hp (gcdDivides n n).1
    have right := divisorBound n _ (gcdPositive n n hp)
      (commonDivisorDividesGcd n n n ⟨1,(Nat.mul_one n).symm⟩ ⟨1,(Nat.mul_one n).symm⟩)
    exact Nat.le_antisymm left right

theorem divisionSelf (n : Nat) (hn : 0 < n) : n/n = 1 := by
  have h := divisionMultiple n 1 hn
  rw [Nat.mul_one] at h
  exact h

end SFT.Foundation.FractionReduction
