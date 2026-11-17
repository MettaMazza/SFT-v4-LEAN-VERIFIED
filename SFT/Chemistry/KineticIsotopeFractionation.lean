import SFT.Chemistry.IsotopeExchange
namespace SFT.Chemistry.KineticIsotopeFractionation
open SFT.Host SFT.Physics.CapabilityValues
structure Interval where
 reaction : HeldLabel
 lightIsotope : HeldLabel
 heavyIsotope : HeldLabel
 rank : PositiveCount
 lightInitial : PositiveCount
 heavyInitial : PositiveCount
 lightProduct : PositiveCount
 heavyProduct : PositiveCount
 resourceIntervals : PositiveCount

def construct (reaction light heavy : HeldLabel) (rank li hi lp hp resource : PositiveCount) : Except String Interval := do
 if !(Text.equal reaction.family "reaction-path" && Text.equal light.family "isotope" && Text.equal heavy.family "isotope") then
  throw "complete kinetic isotope interval required"
 if IsotopeExchange.sameLabel light heavy || lp.value > li.value || hp.value > hi.value then
  throw "bounded distinct isotope path required"
 return ⟨reaction,light,heavy,rank,li,hi,lp,hp,resource⟩
def normalized (n d : Nat) : Nat × Nat := let g := Nat.gcd n d; (n/g,d/g)
def lightRate (r : Interval) : Nat × Nat := normalized r.lightProduct.value r.resourceIntervals.value
def heavyRate (r : Interval) : Nat × Nat := normalized r.heavyProduct.value r.resourceIntervals.value
def factor (r : Interval) : Nat × Nat := normalized r.lightProduct.value r.heavyProduct.value
def orientation (r : Interval) : Except String Value := do
 if r.lightProduct.value == r.heavyProduct.value then return .emptyOne "empty-One"
 return .label (← heldLabel "kinetic-isotope-orientation" (if r.lightProduct.value > r.heavyProduct.value then "light-faster" else "heavy-faster"))
def remainder (n : Nat) : Value := match n with
 | 0 => .emptyOne "empty-One"
 | n+1 => .count ⟨n+1,Nat.zero_lt_succ n⟩
def remaining (r : Interval) : Value × Value :=
 (remainder (r.lightInitial.value-r.lightProduct.value),remainder (r.heavyInitial.value-r.heavyProduct.value))
def completeSequence : Nat → List Interval → Bool
 | _,[] => true
 | n,r::rs => r.rank.value == n && completeSequence (n+1) rs
def commonIdentity : List Interval → Bool
 | [] => false
 | r::rs => rs.all fun s => IsotopeExchange.sameLabel r.reaction s.reaction && IsotopeExchange.sameLabel r.lightIsotope s.lightIsotope && IsotopeExchange.sameLabel r.heavyIsotope s.heavyIsotope
abbrev SeriesRow := (Nat × Nat) × (Nat × Nat) × (Nat × Nat) × Value
def project (r : Interval) : Except String SeriesRow := do return (lightRate r,heavyRate r,factor r,← orientation r)
def timeSeries (rows : List Interval) : Except String (List SeriesRow) := do
 if rows.isEmpty || !completeSequence 1 rows then throw "complete ordered kinetic series required"
 if !commonIdentity rows then throw "one complete reaction/isotope path required"
 rows.mapM project

def row (rank lp hp : Nat) : Except String Interval := do
 construct (← heldLabel "reaction-path" "electrolysis") (← heldLabel "isotope" "light") (← heldLabel "isotope" "heavy") (← count rank) (← count 8) (← count 8) (← count lp) (← count hp) (← count 2)
def first : Except String Interval := row 1 4 2
def second : Except String Interval := row 2 6 3
def identityWitness : Bool := match first with
 | .ok r => Text.equal r.reaction.label "electrolysis" && !IsotopeExchange.sameLabel r.lightIsotope r.heavyIsotope
 | .error _ => false
def supportWitness : Bool := match first,second with
 | .ok a,.ok b => [a.rank.value,b.rank.value] == [1,2]
 | .error _,.ok _ | .ok _,.error _ | .error _,.error _ => false
def eventsWitness : Bool := match first with
 | .ok r => r.lightProduct.value == 4 && r.heavyProduct.value == 2
 | .error _ => false
def ratesWitness : Bool := match first with
 | .ok r => lightRate r == (2,1) && heavyRate r == (1,1)
 | .error _ => false
def factorWitness : Bool := match first with
 | .ok r => factor r == (2,1)
 | .error _ => false
def orientationWitness : Bool := IsotopeExchange.transitionLabel (do orientation (← first)) "light-faster"
def countEquals (v : Value) (expected : Nat) : Bool := match v with
 | .count n => n.value == expected
 | .emptyOne _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false
def isAbsent : Value → Bool
 | .emptyOne _ => true
 | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false
def inventoryWitness : Bool := match first,row 1 8 8 with
 | .ok a,.ok b => countEquals (remaining a).1 4 && isAbsent (remaining b).1 && isAbsent (remaining b).2
 | .error _,.ok _ | .ok _,.error _ | .error _,.error _ => false
def successorWitness : Bool := match (do timeSeries [← first,← second]) with
 | .ok rs => match rs with
  | [] => false
  | _::tail => match tail with
   | [] => false
   | r::_ => r.2.2.1 == (2,1)
 | .error _ => false
theorem identityWitnessPassed : identityWitness = true := rfl
theorem supportWitnessPassed : supportWitness = true := rfl
theorem eventsWitnessPassed : eventsWitness = true := rfl
theorem ratesWitnessPassed : ratesWitness = true := rfl
theorem factorWitnessPassed : factorWitness = true := rfl
theorem orientationWitnessPassed : orientationWitness = true := rfl
theorem inventoryWitnessPassed : inventoryWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.KineticIsotopeFractionation
