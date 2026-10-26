import SFT.Foundation.ExactOperations

/-! Exact reduced Fraction identity needed by fold_dynamics.py's arbitrary
rational laws. Native arithmetic is retained; every theorem is constructive. -/
namespace SFT.Foundation.ExactValueIdentity
open FractionReduction ExactOperations ExactPartCarrier

theorem moduloFuelIndependent (fuel other n d : Nat) (hd : 0 < d)
    (hf : n < fuel) (ho : n < other) :
    Nat.modCore.go d hd fuel n hf = Nat.modCore.go d hd other n ho := by
  induction fuel generalizing other n with
  | zero => exact False.elim (Nat.not_lt_zero _ hf)
  | succ fuel ih =>
    cases other with
    | zero => exact False.elim (Nat.not_lt_zero _ ho)
    | succ other =>
      rw [Nat.modCore.go.eq_1,Nat.modCore.go.eq_1]
      if h : d ≤ n then
        rw [dite_eq_left h,dite_eq_left h]
        exact ih other (n-d) _ _
      else rw [dite_eq_right h,dite_eq_right h]

theorem moduloCore (n d : Nat) (hd : 0 < d) :
    n%d = Nat.modCore.go d hd (n+1) n (Nat.lt_succ_self n) := by
  cases n with
  | zero =>
    rw [Nat.modCore.go.eq_1,dite_eq_right (Nat.not_le_of_gt hd)]
    rfl
  | succ n =>
    change (if d ≤ n+1 then Nat.modCore (n+1) d else n+1) = _
    if h : d ≤ n+1 then
      rw [ite_eq_left h]
      delta Nat.modCore
      rw [dite_eq_left hd]
    else
      rw [ite_eq_right h,Nat.modCore.go.eq_1,dite_eq_right h]

theorem moduloBelow (n d : Nat) (hd : 0 < d) (h : n < d) : n%d = n := by
  rw [moduloCore n d hd,Nat.modCore.go.eq_1,dite_eq_right (Nat.not_le_of_gt h)]

theorem moduloRemoves (n d : Nat) (hd : 0 < d) (h : d ≤ n) : n%d = (n-d)%d := by
  rw [moduloCore n d hd,moduloCore (n-d) d hd,Nat.modCore.go.eq_1,dite_eq_left h]
  exact moduloFuelIndependent n (n-d+1) (n-d) d hd _ _

theorem moduloScale (k n d : Nat) (hk : 0 < k) (hd : 0 < d) :
    (k*n)%(k*d) = k*(n%d) := by
  induction n using Nat.strongRecOn with
  | ind n ih =>
    if h : d ≤ n then
      rw [moduloRemoves (k*n) (k*d) (Nat.mul_pos hk hd) (Nat.mul_le_mul_left k h),
        mulSubtract,moduloRemoves n d hd h]
      exact ih (n-d) (Nat.sub_lt (Nat.lt_of_lt_of_le hd h) hd)
    else
      have less := Nat.lt_of_not_ge h
      rw [moduloBelow (k*n) (k*d) (Nat.mul_pos hk hd) (Nat.mul_lt_mul_of_pos_left less hk),
        moduloBelow n d hd less]

theorem gcdScale (k m n : Nat) (hk : 0 < k) : Nat.gcd (k*m) (k*n) = k*Nat.gcd m n := by
  induction m using Nat.strongRecOn generalizing n with
  | ind m ih =>
    if hz : m = 0 then
      subst m
      rw [Nat.mul_zero,gcdZero,gcdZero]
    else
      have hm := Nat.pos_of_ne_zero hz
      rw [gcdStep (k*m) (k*n) (Nat.ne_of_gt (Nat.mul_pos hk hm)),
        moduloScale k n m hk hm,gcdStep m n hz]
      exact ih (n%m) (Nat.mod_lt n hm) m

theorem reducedDenominatorIdentity (p q : ExactPartCarrier.Part)
    (cross : p.numerator*q.denominator = q.numerator*p.denominator) :
    p.denominator = q.denominator := by
  have left : Nat.gcd (p.numerator*q.denominator) (p.denominator*q.denominator) = q.denominator := by
    rw [Nat.mul_comm p.numerator q.denominator,Nat.mul_comm p.denominator q.denominator,
      gcdScale q.denominator p.numerator p.denominator (denominatorPositive q),p.reduced,Nat.mul_one]
  have right : Nat.gcd (q.numerator*p.denominator) (p.denominator*q.denominator) = p.denominator := by
    rw [Nat.mul_comm q.numerator p.denominator,
      gcdScale p.denominator q.numerator q.denominator (denominatorPositive p),q.reduced,Nat.mul_one]
  have same := congrArg (fun n => Nat.gcd n (p.denominator*q.denominator)) cross
  exact right.symm.trans (same.symm.trans left)

theorem reducedValueIdentity (p q : ExactPartCarrier.Part)
    (cross : p.numerator*q.denominator = q.numerator*p.denominator) : p = q := by
  have den := reducedDenominatorIdentity p q cross
  have nums : p.numerator = q.numerator := by
    rw [den,Nat.mul_comm p.numerator q.denominator,Nat.mul_comm q.numerator q.denominator] at cross
    exact Nat.eq_of_mul_eq_mul_left (denominatorPositive q) cross
  exact partEquality p q nums den

theorem reducedValueIff (p q : ExactPartCarrier.Part) : p = q ↔
    p.numerator*q.denominator = q.numerator*p.denominator := by
  constructor
  · intro h; cases h; rfl
  · exact reducedValueIdentity p q

theorem normalizedRepresents (n d : Nat) (hn : 0 < n) (bound : n ≤ d)
    (p : ExactPartCarrier.Part) (cross : n*p.denominator = p.numerator*d) :
    normalizePart n d hn bound = p := by
  let q := normalizePart n d hn bound
  let g := Nat.gcd n d
  have hd := Nat.lt_of_lt_of_le hn bound
  have nf : n = g*q.numerator := normalizedNumeratorFactor n d hn hd
  have df : d = g*q.denominator := normalizedDenominatorFactor n d hn hd
  have scaled : g*(q.numerator*p.denominator) = g*(p.numerator*q.denominator) := by
    calc
      g*(q.numerator*p.denominator) = (g*q.numerator)*p.denominator := (mulAssoc _ _ _).symm
      _ = n*p.denominator := congrArg (fun x => x*p.denominator) nf.symm
      _ = p.numerator*d := cross
      _ = p.numerator*(g*q.denominator) := congrArg (fun x => p.numerator*x) df
      _ = g*(p.numerator*q.denominator) := by rw [← mulAssoc,Nat.mul_comm p.numerator g,mulAssoc]
  exact reducedValueIdentity q p (Nat.eq_of_mul_eq_mul_left (gcdPositive n d hd) scaled)

theorem castAdmitted (p : ExactPartCarrier.Part) :
    castPositive ⟨p.numerator,p.denominator,p.denominatorNonzero,p.reduced,p.positive⟩ = p := by
  apply partEquality
  · change ExactCast.castNumerator p.numerator p.denominator /
      Nat.gcd (ExactCast.castNumerator p.numerator p.denominator) p.denominator = p.numerator
    rw [ExactCast.castRetains _ _ (denominatorPositive p) p.throughOne,p.reduced,divisionOne]
  · change p.denominator /
      Nat.gcd (ExactCast.castNumerator p.numerator p.denominator) p.denominator = p.denominator
    rw [ExactCast.castRetains _ _ (denominatorPositive p) p.throughOne,p.reduced,divisionOne]

theorem castNormalizedAdmitted (n d : Nat) (hn : 0 < n) (hd : 0 < d) (bound : n ≤ d) :
    castPositive (normalizePositive n d hn hd) = normalizePart n d hn bound :=
  castAdmitted (normalizePart n d hn bound)

end SFT.Foundation.ExactValueIdentity
