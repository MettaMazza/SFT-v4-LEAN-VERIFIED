import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.RadiochemicalEquilibrium
open SFT.Host SFT.Physics.CapabilityValues
structure Interval where
 parent : HeldLabel
 daughter : HeldLabel
 rank : PositiveCount
 parentTransformations : PositiveCount
 daughterTransformations : PositiveCount
 resourceIntervals : PositiveCount

def construct (p d : HeldLabel) (rank parentEvents daughterEvents resource : PositiveCount) : Except String Interval :=
 if Text.equal p.family "parent-nuclide" && Text.equal d.family "daughter-nuclide" then
  .ok ⟨p,d,rank,parentEvents,daughterEvents,resource⟩
 else .error "held parent/daughter identities required"
def fraction (n d : Nat) : Nat × Nat := let g := Nat.gcd n d; (n/g,d/g)
def parentActivity (row : Interval) : Nat × Nat := fraction row.parentTransformations.value row.resourceIntervals.value
def daughterActivity (row : Interval) : Nat × Nat := fraction row.daughterTransformations.value row.resourceIntervals.value
def daughterParentRatio (row : Interval) : Value := .ratio row.daughterTransformations row.parentTransformations
def ratioFraction (row : Interval) : Nat × Nat := fraction row.daughterTransformations.value row.parentTransformations.value
def fractionEqual (a b : Nat × Nat) : Bool := a.1==b.1 && a.2==b.2
def sameLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def orderedFrom (rank : Nat) : List Interval → Bool
 | [] => true
 | row::rows => row.rank.value==rank && orderedFrom (rank+1) rows

def equilibriumRegime (rows : List Interval) : Except String Value := match rows with
 | [] => .ok (.emptyOne "empty-One")
 | first::rest => do
  if !orderedFrom 1 rows then throw "complete ordered interval support required"
  if !(rest.all (fun row => sameLabel row.parent first.parent && sameLabel row.daughter first.daughter)) then
   throw "one parent/daughter recurrence required"
  let f := ratioFraction first
  if !(rest.all (fun row => fractionEqual (ratioFraction row) f)) then return .emptyOne "empty-One"
  let n ← count f.1
  let d ← count f.2
  let label := if fractionEqual f (1,1) then "secular-One-ratio" else "transient-held-ratio"
  let regime ← heldLabel "equilibrium-regime" label
  return .pair (.label regime) (.ratio n d)

def row (rank p d : Nat) : Except String Interval := do
 construct (← heldLabel "parent-nuclide" "p") (← heldLabel "daughter-nuclide" "d")
  (← count rank) (← count p) (← count d) (← count 2)
def transientRows : Except String (List Interval) := do return [← row 1 2 4,← row 2 3 6]
def secularRows : Except String (List Interval) := do return [← row 1 2 2,← row 2 3 3]
def hasRegime (result : Except String Value) (name : String) (numerator denominator : Nat) : Bool := match result with
 | .error _ => false
 | .ok value => match value with
  | .pair left right => match left with
   | .label label => match right with
    | .ratio n d => Text.equal label.label name && n.value==numerator && d.value==denominator
    | .emptyOne _ | .count _ | .label _ | .word _ | .pair _ _ | .table _ => false
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .table _ => false
def identityWitness : Bool := match row 1 2 4 with | .error _ => false | .ok s => Text.equal s.parent.label "p" && Text.equal s.daughter.label "d"
def supportWitness : Bool := match transientRows with | .error _ => false | .ok rows => orderedFrom 1 rows
def activityWitness : Bool := match row 1 2 4 with | .error _ => false | .ok s => fractionEqual (parentActivity s) (1,1) && fractionEqual (daughterActivity s) (2,1)
def ratioWitness : Bool := match row 1 2 4 with | .error _ => false | .ok s => fractionEqual (ratioFraction s) (2,1)
def transientWitness : Bool := hasRegime (transientRows >>= equilibriumRegime) "transient-held-ratio" 2 1
def secularWitness : Bool := hasRegime (secularRows >>= equilibriumRegime) "secular-One-ratio" 1 1
def absenceWitness : Bool := match (do equilibriumRegime [← row 1 2 4,← row 2 3 3]) with
 | .ok (.emptyOne _) => true
 | .ok (.count _) | .ok (.ratio _ _) | .ok (.label _) | .ok (.word _) | .ok (.pair _ _) | .ok (.table _) | .error _ => false
def successorWitness : Bool := hasRegime (do equilibriumRegime ((← transientRows)++[← row 3 4 8])) "transient-held-ratio" 2 1

theorem emptyRegime : equilibriumRegime [] = .ok (.emptyOne "empty-One") := rfl
theorem identityWitnessPassed : identityWitness = true := rfl
theorem supportWitnessPassed : supportWitness = true := rfl
theorem activityWitnessPassed : activityWitness = true := rfl
theorem ratioWitnessPassed : ratioWitness = true := rfl
theorem transientWitnessPassed : transientWitness = true := rfl
theorem secularWitnessPassed : secularWitness = true := rfl
theorem absenceWitnessPassed : absenceWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.RadiochemicalEquilibrium
