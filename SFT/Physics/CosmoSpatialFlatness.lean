import SFT.Physics.CosmoBranchBoundary
import SFT.Mathematics.FoldScalar
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.CosmoSpatialFlatness
open SFT.Mathematics.FoldScalar SFT.Physics.GeneratorOperations

-- Exact unreduced Fraction accumulation. Numerator zero is host arithmetic,
-- while the public absence result is the existing empty-One constructor.
def total (parts : List Rat) (n : Int := 0) (d : Int := 1) : Int × Int :=
 match parts with
 | [] => (n,d)
 | p::ps => total ps (n*(Int.ofNat p.den)+p.num*d) (d*(Int.ofNat p.den))

def positiveParts (parts : List Rat) : Bool := parts.all fun p => decide (0 < p.num)

def closedPartition (parts : List Rat) : Except String Scalar :=
 if parts.isEmpty || !positiveParts parts then
  .error "a cosmic partition requires exact positive parts"
 else if (total parts).1=(total parts).2 then .ok .emptyOne
 else .error "the registered component family does not close to the One"

-- The explicit non-Fraction case preserves closed_partition's type guard.
def fractionsOnly : List (Option Rat) → Option (List Rat)
 | [] => some []
 | none::_ => none
 | some p::ps => (fractionsOnly ps).map (p::.)
def closedPartitionInput (parts : List (Option Rat)) : Except String Scalar :=
 match fractionsOnly parts with
 | none => .error "a cosmic partition requires exact positive parts"
 | some ps => closedPartition ps

def splitEquals (parent first second : Rat) : Prop :=
 (first.num*(Int.ofNat second.den)+second.num*(Int.ofNat first.den))*(Int.ofNat parent.den)=
 parent.num*((Int.ofNat first.den)*(Int.ofNat second.den))
instance (p a b : Rat) : Decidable (splitEquals p a b) := inferInstanceAs (Decidable (_ = _))

def refineAt : List Rat → Nat → Rat → Rat → Except String (List Rat)
 | [],_,_,_ => .error "partition refinement requires one retained component"
 | p::ps,0,a,b =>
  if 0<a.num ∧ 0<b.num ∧ splitEquals p a b then .ok (a::b::ps)
  else .error "refinement must be a positive exact split of one component"
 | p::ps,k+1,a,b => (refineAt ps k a b).map (p::.)

def refinePartition (parts : List Rat) (index : CountInput) (first second : Rat) : Except String (List Rat) :=
 match index with
 | .boolean false => refineAt parts 0 first second
 | .boolean true => refineAt parts 1 first second
 | .integer (.negSucc _) => .error "partition refinement requires one retained component"
 | .integer (.ofNat i) => refineAt parts i first second

theorem closedExactly (parts : List Rat) (nonempty : parts.isEmpty=false)
 (positive : positiveParts parts=true) :
 closedPartition parts=.ok .emptyOne ↔ (total parts).1=(total parts).2 := by
 unfold closedPartition
 rw [nonempty,positive]
 change (if (total parts).1=(total parts).2 then Except.ok Scalar.emptyOne else Except.error _) = _ ↔ _
 constructor
 · intro h
   by_cases same : (total parts).1=(total parts).2
   · exact same
   · rw [ite_eq_right same] at h; cases h
 · intro h; rw [ite_eq_left h]

theorem emptyRejected : closedPartition []=.error "a cosmic partition requires exact positive parts" := rfl

theorem positiveSplitAccepted (p a b : Rat) (tail : List Rat)
 (ha : 0<a.num) (hb : 0<b.num) (same : splitEquals p a b) :
 refineAt (p::tail) 0 a b=.ok (a::b::tail) := by
 unfold refineAt
 rw [ite_eq_left ⟨ha,hb,same⟩]

theorem refineRetainsPrefix (beforeParts suffix : List Rat) (p a b : Rat)
 (ha : 0<a.num) (hb : 0<b.num) (same : splitEquals p a b) :
 refineAt (beforeParts++p::suffix) beforeParts.length a b=.ok (beforeParts++a::b::suffix) := by
 induction beforeParts with
 | nil => exact positiveSplitAccepted p a b suffix ha hb same
 | cons q qs ih => exact congrArg (fun r => r.map (q::.)) ih


end SFT.Physics.CosmoSpatialFlatness
