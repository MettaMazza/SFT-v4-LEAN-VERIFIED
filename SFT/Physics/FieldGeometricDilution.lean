import SFT.Physics.FieldSourceResponse
import SFT.Foundation.ExactValueIdentity
namespace SFT.Physics.FieldGeometricDilution
open SFT.Foundation.ExactOperations SFT.Mathematics.ExactRatioRelations

structure Distribution (Cell : Type) where
  source : PositiveFraction
  boundary : List Cell
  present : 0 < boundary.length

def share {Cell : Type} (d : Distribution Cell) : PositiveFraction :=
  normalizePositive d.source.numerator (d.source.denominator*d.boundary.length) d.source.positive
    (Nat.mul_pos (Nat.pos_of_ne_zero d.source.denominatorNonzero) d.present)

def responses {Cell : Type} (d : Distribution Cell) := d.boundary.map (fun cell => (cell,share d))

theorem exactShare {Cell : Type} (d : Distribution Cell) :
    d.source.numerator * (share d).denominator =
      (share d).numerator * (d.source.denominator*d.boundary.length) := normalizedValuePreserved _ _ _ _

theorem allBoundaryCellsRetained {Cell : Type} (d : Distribution Cell) :
    (responses d).map Prod.fst = d.boundary := MechanicalMomentum.cellsRetainEveryPart _ _

theorem noMissingResponse {Cell : Type} (d : Distribution Cell) :
    (responses d).length = d.boundary.length := MechanicalMomentum.cellsCount _ _

theorem everyCellGetsShare {Cell : Type} (d : Distribution Cell) (cell : Cell) (present : cell ∈ d.boundary) :
    (cell,share d) ∈ responses d := (MechanicalMomentum.cellMembership _ _ _ _).mpr ⟨present,rfl⟩

theorem noSelectedProfile {Cell : Type} (d : Distribution Cell) (cell : Cell) (value : PositiveFraction)
    (present : (cell,value) ∈ responses d) : value = share d :=
  ((MechanicalMomentum.cellMembership _ _ _ _).mp present).2

-- Reduced positive ratios have one representative for each exact cross product.
theorem positiveValueIdentity (p q : PositiveFraction)
    (cross : p.numerator*q.denominator = q.numerator*p.denominator) : p = q := by
  have left : Nat.gcd (p.numerator*q.denominator) (p.denominator*q.denominator) = q.denominator := by
    rw [Nat.mul_comm p.numerator q.denominator,Nat.mul_comm p.denominator q.denominator,
      SFT.Foundation.ExactValueIdentity.gcdScale q.denominator p.numerator p.denominator
        (Nat.pos_of_ne_zero q.denominatorNonzero),p.reduced,Nat.mul_one]
  have right : Nat.gcd (q.numerator*p.denominator) (p.denominator*q.denominator) = p.denominator := by
    rw [Nat.mul_comm q.numerator p.denominator,
      SFT.Foundation.ExactValueIdentity.gcdScale p.denominator q.numerator q.denominator
        (Nat.pos_of_ne_zero p.denominatorNonzero),q.reduced,Nat.mul_one]
  have same := congrArg (fun n => Nat.gcd n (p.denominator*q.denominator)) cross
  have den := right.symm.trans (same.symm.trans left)
  have nums : p.numerator = q.numerator := by
    rw [den,Nat.mul_comm p.numerator q.denominator,Nat.mul_comm q.numerator q.denominator] at cross
    exact cancelPositive q.denominator _ _ (Nat.pos_of_ne_zero q.denominatorNonzero) cross
  cases p
  cases q
  cases nums
  cases den
  rfl

theorem shareUnique {Cell : Type} (d : Distribution Cell) (candidate : PositiveFraction)
    (conserved : d.source.numerator*candidate.denominator =
      candidate.numerator*(d.source.denominator*d.boundary.length)) : candidate = share d := by
  let n := d.source.denominator*d.boundary.length
  have hn : 0 < n := Nat.mul_pos (Nat.pos_of_ne_zero d.source.denominatorNonzero) d.present
  apply positiveValueIdentity
  apply cancelPositive n _ _ hn
  have actual := exactShare d
  change d.source.numerator*(share d).denominator = (share d).numerator*n at actual
  change d.source.numerator*candidate.denominator = candidate.numerator*n at conserved
  calc
    n*(candidate.numerator*(share d).denominator) = (candidate.numerator*n)*(share d).denominator := by rw [← SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm n candidate.numerator]
    _ = (d.source.numerator*candidate.denominator)*(share d).denominator := congrArg (fun x => x*(share d).denominator) conserved.symm
    _ = (d.source.numerator*(share d).denominator)*candidate.denominator := by rw [SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm candidate.denominator (share d).denominator,← SFT.Foundation.FractionReduction.mulAssoc]
    _ = ((share d).numerator*n)*candidate.denominator := congrArg (fun x => x*candidate.denominator) actual
    _ = n*((share d).numerator*candidate.denominator) := by rw [Nat.mul_comm (share d).numerator n,SFT.Foundation.FractionReduction.mulAssoc]

theorem positiveNormalizationRepresents (n d : Nat) (hn : 0 < n) (hd : 0 < d)
    (p : PositiveFraction) (cross : n*p.denominator = p.numerator*d) :
    normalizePositive n d hn hd = p := by
  let q := normalizePositive n d hn hd
  let g := Nat.gcd n d
  have hg : 0 < g := SFT.Foundation.FractionReduction.gcdPositive n d hd
  have nf : n = g*q.numerator := normalizedNumeratorFactor n d hn hd
  have df : d = g*q.denominator := normalizedDenominatorFactor n d hn hd
  apply positiveValueIdentity
  apply cancelPositive g _ _ hg
  calc
    g*(q.numerator*p.denominator) = (g*q.numerator)*p.denominator := (SFT.Foundation.FractionReduction.mulAssoc _ _ _).symm
    _ = n*p.denominator := congrArg (fun x => x*p.denominator) nf.symm
    _ = p.numerator*d := cross
    _ = p.numerator*(g*q.denominator) := congrArg (fun x => p.numerator*x) df
    _ = g*(p.numerator*q.denominator) := by rw [← SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm p.numerator g,SFT.Foundation.FractionReduction.mulAssoc]

theorem commonCountScaleCancels (k n d : Nat) (hk : 0 < k) (hn : 0 < n) (hd : 0 < d) :
    normalizePositive (k*n) (k*d) (Nat.mul_pos hk hn) (Nat.mul_pos hk hd) =
      normalizePositive n d hn hd := by
  apply positiveNormalizationRepresents
  rw [SFT.Foundation.FractionReduction.mulAssoc,normalizedValuePreserved,← SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm k (normalizePositive n d hn hd).numerator,SFT.Foundation.FractionReduction.mulAssoc]

end SFT.Physics.FieldGeometricDilution
