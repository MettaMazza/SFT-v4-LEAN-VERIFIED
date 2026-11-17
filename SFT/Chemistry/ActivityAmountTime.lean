import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.ActivityAmountTime
open SFT.Host SFT.Physics.CapabilityValues
structure Ledger where
 nuclide : HeldLabel
 species : HeldLabel
 initialOccurrences : PositiveCount
 transformations : PositiveCount
 resourceIntervals : PositiveCount

def admissible (r : Ledger) : Bool := Text.equal r.nuclide.family "nuclide" &&
 Text.equal r.species.family "chemical-species" && decide (r.transformations.value ≤ r.initialOccurrences.value)
def construct (nuclide species : HeldLabel) (initial transformations intervals : PositiveCount) : Except String Ledger :=
 let r := Ledger.mk nuclide species initial transformations intervals
 if admissible r then .ok r else .error "bounded nuclide activity ledger required"
def activity (r : Ledger) : Value := .ratio r.transformations r.resourceIntervals
def retainedAmount (r : Ledger) : Except String Value :=
 let left := r.initialOccurrences.value-r.transformations.value
 if left==0 then .ok (.emptyOne "empty-One") else do return .count (← count left)

theorem activityCountedRatio (r : Ledger) : activity r = .ratio r.transformations r.resourceIntervals := rfl
theorem fullyTransformed (r : Ledger) (h : r.initialOccurrences.value = r.transformations.value) :
 retainedAmount r = .ok (.emptyOne "empty-One") := by
 unfold retainedAmount
 rw [h, Nat.sub_self]
 rfl

def original (i : Nat := 5) (e : Nat := 2) (t : Nat := 3) : Except String Ledger := do
 construct (← heldLabel "nuclide" "n") (← heldLabel "chemical-species" "s") (← count i) (← count e) (← count t)
def check (p : Ledger → Bool) : Bool := match original with
 | .error _ => false
 | .ok r => p r
def identityWitness : Bool := check (fun r => Text.equal r.nuclide.label "n")
def amountWitness : Bool := check (fun r => r.initialOccurrences.value==5)
def eventsWitness : Bool := check (fun r => r.transformations.value==2)
def timeWitness : Bool := check (fun r => r.resourceIntervals.value==3)
def reducedFraction (r : Ledger) : Nat × Nat :=
 let g := Nat.gcd r.transformations.value r.resourceIntervals.value
 (r.transformations.value/g,r.resourceIntervals.value/g)
def activityWitness : Bool := check (fun r => let pair := reducedFraction r;pair.1==2 && pair.2==3)
def remainingWitness : Bool := check (fun r => match retainedAmount r with
 | .ok (.count n) => n.value==3
 | .ok (.emptyOne _) | .ok (.ratio _ _) | .ok (.label _) | .ok (.word _) | .ok (.pair _ _) | .ok (.table _) | .error _ => false)
def absenceWitness : Bool := match original 2 2 1 >>= retainedAmount with
 | .ok (.emptyOne _) => true
 | .ok (.count _) | .ok (.ratio _ _) | .ok (.label _) | .ok (.word _) | .ok (.pair _ _) | .ok (.table _) | .error _ => false
def successorWitness : Bool := match original 5 3 3 with
 | .error _ => false
 | .ok r => let pair := reducedFraction r;pair.1==1 && pair.2==1
theorem identityWitnessPassed : identityWitness = true := rfl
theorem amountWitnessPassed : amountWitness = true := rfl
theorem eventsWitnessPassed : eventsWitness = true := rfl
theorem timeWitnessPassed : timeWitness = true := rfl
theorem activityWitnessPassed : activityWitness = true := rfl
theorem remainingWitnessPassed : remainingWitness = true := rfl
theorem absenceWitnessPassed : absenceWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.ActivityAmountTime
