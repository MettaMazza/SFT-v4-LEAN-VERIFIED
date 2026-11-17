import SFT.Materials.RotationTotient
import SFT.Foundation.FractionReduction
import SFT.Host.Canonical
namespace SFT.Materials.HallPrimary
open SFT.Host SFT.Materials.RotationTotient

structure ReducedPart where
 numerator : Nat
 denominator : Nat
 numeratorPositive : 0 < numerator
 denominatorPositive : 0 < denominator
 withinOne : numerator ≤ denominator
 coprime : Nat.gcd numerator denominator = 1

def numeratorParts (denominator : PositiveCount) : (n : Nat) → n ≤ denominator.val → List ReducedPart
 | 0, _ => []
 | n+1, bound =>
  let earlier := numeratorParts denominator n (Nat.le_trans (Nat.le_succ n) bound)
  if h : Nat.gcd (n+1) denominator.val = 1 then
   earlier ++ [⟨n+1,denominator.val,Nat.zero_lt_succ n,denominator.property,bound,h⟩]
  else earlier

def oddParts : Nat → List ReducedPart
 | 0 => []
 | n+1 =>
  let denominator : PositiveCount := ⟨2*n+1,Nat.zero_lt_succ (2*n)⟩
  oddParts n ++ numeratorParts denominator denominator.val (Nat.le_refl _)

def primaryClasses (maxDenominator : PositiveCount) : List ReducedPart :=
 oddParts ((maxDenominator.val+1)/2)

def value (part : ReducedPart) : Canonical.Value := .object [
 ("numerator",.integer (.ofNat part.numerator)),
 ("denominator",.integer (.ofNat part.denominator))]

theorem reducedPositiveBounded (part : ReducedPart) :
 0 < part.numerator ∧ 0 < part.denominator ∧
 part.numerator ≤ part.denominator ∧ Nat.gcd part.numerator part.denominator = 1 :=
 ⟨part.numeratorPositive,part.denominatorPositive,part.withinOne,part.coprime⟩

theorem oddSuccessor (n : Nat) :
 oddParts (n+1) = oddParts n ++ numeratorParts ⟨2*n+1,Nat.zero_lt_succ (2*n)⟩ (2*n+1) (Nat.le_refl _) := rfl

def originalWitness : Bool :=
 let pairs := (primaryClasses ⟨7,by decide⟩).map (fun p => (p.numerator,p.denominator))
 pairs == [(1,1),(1,3),(2,3),(1,5),(2,5),(3,5),(4,5),(1,7),(2,7),(3,7),(4,7),(5,7),(6,7)]

theorem originalWitnessPassed : originalWitness = true := rfl
#print axioms numeratorParts
#print axioms oddParts
#print axioms primaryClasses
#print axioms value
#print axioms reducedPositiveBounded
#print axioms oddSuccessor
#print axioms originalWitness
#print axioms originalWitnessPassed
end SFT.Materials.HallPrimary
