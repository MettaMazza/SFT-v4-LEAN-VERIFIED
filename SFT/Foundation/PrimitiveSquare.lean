import SFT.Foundation.PrimitiveMaps
namespace SFT.Foundation.PrimitiveMaps
open ExactOperations ExactPartCarrier ExactValueIdentity FractionReduction

theorem mulInterchange (a b c d : Nat) : (a*b)*(c*d) = (a*c)*(b*d) := by
  rw [mulAssoc,mulAssoc]
  have middle : b*(c*d) = c*(b*d) := by
    rw [← mulAssoc,Nat.mul_comm b c,mulAssoc]
  exact congrArg (fun x => a*x) middle

theorem equalNormalizationsCross (n d m e : Nat) (hn : 0 < n) (hm : 0 < m)
    (hnd : n ≤ d) (hme : m ≤ e)
    (eq : normalizePart n d hn hnd = normalizePart m e hm hme) : n*e = m*d := by
  let p := normalizePart n d hn hnd
  let q := normalizePart m e hm hme
  have nd := Nat.lt_of_lt_of_le hn hnd
  have me := Nat.lt_of_lt_of_le hm hme
  have nf : n = Nat.gcd n d * p.numerator := normalizedNumeratorFactor n d hn nd
  have df : d = Nat.gcd n d * p.denominator := normalizedDenominatorFactor n d hn nd
  have mf : m = Nat.gcd m e * q.numerator := normalizedNumeratorFactor m e hm me
  have ef : e = Nat.gcd m e * q.denominator := normalizedDenominatorFactor m e hm me
  have nums : p.numerator = q.numerator := congrArg Part.numerator eq
  have dens : p.denominator = q.denominator := congrArg Part.denominator eq
  calc
    n*e = (Nat.gcd n d*p.numerator)*(Nat.gcd m e*q.denominator) := by rw [← nf,← ef]
    _ = (Nat.gcd n d*Nat.gcd m e)*(p.numerator*q.denominator) := mulInterchange _ _ _ _
    _ = (Nat.gcd m e*Nat.gcd n d)*(q.numerator*p.denominator) := by rw [nums,dens,Nat.mul_comm (Nat.gcd n d) (Nat.gcd m e)]
    _ = (Nat.gcd m e*q.numerator)*(Nat.gcd n d*p.denominator) := (mulInterchange _ _ _ _).symm
    _ = m*d := by rw [← mf,← df]

theorem naturalSquareStrict (a b : Nat) (h : a < b) : a*a < b*b :=
  Nat.lt_of_le_of_lt (Nat.mul_le_mul_right a (Nat.le_of_lt h))
    (Nat.mul_lt_mul_of_pos_left h (Nat.lt_of_le_of_lt (Nat.zero_le a) h))

theorem naturalSquareInjective (a b : Nat) (h : a*a = b*b) : a = b := by
  cases Nat.lt_trichotomy a b with
  | inl less =>
    have impossible := naturalSquareStrict a b less
    rw [h] at impossible
    exact False.elim (Nat.lt_irrefl _ impossible)
  | inr cases =>
    cases cases with
    | inl equal => exact equal
    | inr greater =>
      have impossible := naturalSquareStrict b a greater
      rw [h] at impossible
      exact False.elim (Nat.lt_irrefl _ impossible)

theorem squareInjective (p q : Part) (h : squarePart p = squarePart q) : p = q := by
  have cross := equalNormalizationsCross _ _ _ _
    (Nat.mul_pos p.positive p.positive) (Nat.mul_pos q.positive q.positive)
    (Nat.mul_le_mul p.throughOne p.throughOne) (Nat.mul_le_mul q.throughOne q.throughOne) h
  apply reducedValueIdentity p q
  apply naturalSquareInjective
  rw [mulInterchange p.numerator q.denominator p.numerator q.denominator,
    mulInterchange q.numerator p.denominator q.numerator p.denominator]
  exact cross

theorem cancelStrictLeft (k a b : Nat) (h : k*a < k*b) : a < b := by
  apply Nat.lt_of_not_ge
  intro reversed
  exact Nat.not_lt_of_ge (Nat.mul_le_mul_left k reversed) h

theorem squareStrictlyContracts (p : Part) (proper : p.numerator < p.denominator) :
    (squarePart p).numerator*p.denominator < p.numerator*(squarePart p).denominator := by
  let n := p.numerator
  let d := p.denominator
  let g := Nat.gcd (n*n) (d*d)
  have nf : n*n = g*(squarePart p).numerator :=
    normalizedNumeratorFactor _ _ (Nat.mul_pos p.positive p.positive)
      (Nat.mul_pos (denominatorPositive p) (denominatorPositive p))
  have df : d*d = g*(squarePart p).denominator :=
    normalizedDenominatorFactor _ _ (Nat.mul_pos p.positive p.positive)
      (Nat.mul_pos (denominatorPositive p) (denominatorPositive p))
  apply cancelStrictLeft g
  calc
    g*((squarePart p).numerator*d) = (n*n)*d := by rw [← mulAssoc,← nf]
    _ < (n*d)*d := Nat.mul_lt_mul_of_pos_right
      (Nat.mul_lt_mul_of_pos_left proper p.positive) (denominatorPositive p)
    _ = n*(d*d) := mulAssoc _ _ _
    _ = g*(n*(squarePart p).denominator) := by rw [df,← mulAssoc,Nat.mul_comm n g,mulAssoc]

theorem properSquareNotFixed (p : Part) (proper : p.numerator < p.denominator) : squarePart p ≠ p := by
  intro fixed
  have strict := squareStrictlyContracts p proper
  rw [fixed] at strict
  exact Nat.lt_irrefl _ strict

theorem squareOneFixed : squarePart one = one := by
  apply partEquality <;> rfl

theorem squareRemainsProper (p : Part) (proper : p.numerator < p.denominator) :
    (squarePart p).numerator < (squarePart p).denominator := by
  apply Nat.lt_of_not_ge
  intro reversed
  have bound := Nat.mul_le_mul p.throughOne reversed
  rw [Nat.mul_comm p.denominator (squarePart p).numerator] at bound
  exact Nat.not_lt_of_ge bound (squareStrictlyContracts p proper)

theorem partStrictTrans (a b c : Part) (ab : strictlyLarger a b) (bc : strictlyLarger b c) :
    strictlyLarger a c := by
  apply cancelStrictLeft b.denominator
  calc
    b.denominator*(c.numerator*a.denominator) = (c.numerator*b.denominator)*a.denominator := by
      rw [← mulAssoc,Nat.mul_comm b.denominator c.numerator]
    _ < (b.numerator*c.denominator)*a.denominator := Nat.mul_lt_mul_of_pos_right bc (denominatorPositive a)
    _ = (b.numerator*a.denominator)*c.denominator := by
      rw [mulAssoc,Nat.mul_comm c.denominator a.denominator,← mulAssoc]
    _ < (a.numerator*b.denominator)*c.denominator := Nat.mul_lt_mul_of_pos_right ab (denominatorPositive c)
    _ = b.denominator*(a.numerator*c.denominator) := by
      rw [Nat.mul_comm a.numerator b.denominator,mulAssoc]

theorem everyPositiveSquareIterateContracts (n : Nat) (p : Part)
    (proper : p.numerator < p.denominator) :
    strictlyLarger p (applyWord (List.replicate (n+1) Primitive.square) p) := by
  induction n generalizing p with
  | zero => exact squareStrictlyContracts p proper
  | succ n ih =>
    have tail := ih (squarePart p) (squareRemainsProper p proper)
    exact partStrictTrans p (squarePart p)
      (applyWord (List.replicate (n+1) Primitive.square) (squarePart p))
      (squareStrictlyContracts p proper) tail

theorem properSquareHasNoPositiveReturn (n : Nat) (p : Part)
    (proper : p.numerator < p.denominator) :
    applyWord (List.replicate (n+1) Primitive.square) p ≠ p := by
  intro eq
  have strict := everyPositiveSquareIterateContracts n p proper
  rw [eq] at strict
  exact Nat.lt_irrefl _ strict

theorem nonproperPartIsOne (p : Part) (h : ¬ p.numerator < p.denominator) : p = one := by
  have equal := Nat.le_antisymm p.throughOne (Nat.le_of_not_gt h)
  apply reducedValueIdentity p one
  change p.numerator*1 = 1*p.denominator
  rw [Nat.mul_one,Nat.one_mul]
  exact equal

theorem squareIterationsFixOne (n : Nat) :
    applyWord (List.replicate n Primitive.square) one = one := by
  induction n with
  | zero => rfl
  | succ n ih =>
    change applyWord (List.replicate n Primitive.square) (squarePart one) = one
    rw [squareOneFixed]
    exact ih

theorem squarePositiveReturnIffOne (n : Nat) (p : Part) :
    applyWord (List.replicate (n+1) Primitive.square) p = p ↔ p = one := by
  constructor
  · intro returned
    by_cases proper : p.numerator < p.denominator
    · exact False.elim (properSquareHasNoPositiveReturn n p proper returned)
    · exact nonproperPartIsOne p proper
  · intro equal
    cases equal
    exact squareIterationsFixOne (n+1)

end SFT.Foundation.PrimitiveMaps
