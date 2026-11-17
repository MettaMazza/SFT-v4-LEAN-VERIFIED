import SFT.Chemistry.IsotopeExchange
namespace SFT.Chemistry.RadiochemicalSeparation
open SFT.Host SFT.Physics.CapabilityValues
structure Ledger where
 target : HeldLabel
 contaminant : HeldLabel
 feedTarget : PositiveCount
 feedContaminant : PositiveCount
 productTarget : PositiveCount
 productContaminant : PositiveCount
 wasteTarget : PositiveCount
 wasteContaminant : PositiveCount

def construct (target contaminant : HeldLabel) (ft fc pt pc wt wc : PositiveCount) : Except String Ledger := do
 if !(Text.equal target.family "target-species" && Text.equal contaminant.family "contaminant-species") || Text.equal target.label contaminant.label then
  throw "distinct target and contaminant identities required"
 if !(ft.value == pt.value+wt.value && fc.value == pc.value+wc.value) then
  throw "complete target and contaminant balance required"
 return ⟨target,contaminant,ft,fc,pt,pc,wt,wc⟩
def normalized (n d : Nat) : Nat × Nat := let g := Nat.gcd n d; (n/g,d/g)
def recovery (l : Ledger) : Nat × Nat := normalized l.productTarget.value l.feedTarget.value
def decontaminationFactor (l : Ledger) : Nat × Nat :=
 normalized (l.feedContaminant.value*l.productTarget.value) (l.feedTarget.value*l.productContaminant.value)
def residualCustody (feed product : PositiveCount) : Except String Value := do
 if product.value > feed.value then throw "product cannot exceed feed"
 match feed.value-product.value with
 | 0 => return .emptyOne "empty-One"
 | n+1 => return .count ⟨n+1,Nat.zero_lt_succ n⟩
def completeRecovery (l : Ledger) : Except String Value := residualCustody l.feedTarget l.productTarget
def ledger : Except String Ledger := do
 construct (← heldLabel "target-species" "Sc") (← heldLabel "contaminant-species" "V")
  (← count 10) (← count 12) (← count 8) (← count 2) (← count 2) (← count 10)
def identityWitness : Bool := match ledger with
 | .ok l => !IsotopeExchange.sameLabel l.target l.contaminant
 | .error _ => false
def streamsWitness : Bool := match ledger with
 | .ok l => [l.feedTarget,l.productTarget,l.wasteTarget].length == 3
 | .error _ => false
def inventoryWitness : Bool := match ledger with
 | .ok l => [l.feedTarget,l.feedContaminant,l.productTarget,l.productContaminant,l.wasteTarget,l.wasteContaminant].all (fun n => n.value > 0)
 | .error _ => false
def balanceWitness : Bool := match ledger with
 | .ok l => l.feedTarget.value == 10 && l.feedContaminant.value == 12
 | .error _ => false
def recoveryWitness : Bool := match ledger with
 | .ok l => recovery l == (4,5)
 | .error _ => false
def decontaminationWitness : Bool := match ledger with
 | .ok l => decontaminationFactor l == (24,5)
 | .error _ => false
def absenceWitness : Bool := match (do residualCustody (← count 10) (← count 10)) with
 | .ok (.emptyOne _) => match (do completeRecovery (← ledger)) with
  | .ok (.count n) => n.value == 2
  | .ok (.emptyOne _) | .ok (.ratio _ _) | .ok (.label _) | .ok (.word _) | .ok (.pair _ _) | .ok (.table _) | .error _ => false
 | .ok (.count _) | .ok (.ratio _ _) | .ok (.label _) | .ok (.word _) | .ok (.pair _ _) | .ok (.table _) | .error _ => false
def extensionWitness : Bool := match ledger with
 | .ok l => l.productTarget.value+l.wasteTarget.value == l.feedTarget.value
 | .error _ => false
theorem identityWitnessPassed : identityWitness = true := rfl
theorem streamsWitnessPassed : streamsWitness = true := rfl
theorem inventoryWitnessPassed : inventoryWitness = true := rfl
theorem balanceWitnessPassed : balanceWitness = true := rfl
theorem recoveryWitnessPassed : recoveryWitness = true := rfl
theorem decontaminationWitnessPassed : decontaminationWitness = true := rfl
theorem absenceWitnessPassed : absenceWitness = true := rfl
theorem extensionWitnessPassed : extensionWitness = true := rfl

theorem acceptedSpeciesBalance (target contaminant : HeldLabel) (ft fc pt pc wt wc : PositiveCount) (result : Ledger)
 (accepted : construct target contaminant ft fc pt pc wt wc = .ok result) :
 ft.value = pt.value+wt.value ∧ fc.value = pc.value+wc.value := by
 unfold construct at accepted
 cases guard0 : (!(Text.equal target.family "target-species" && Text.equal contaminant.family "contaminant-species") || Text.equal target.label contaminant.label) with
 | true => rw [guard0] at accepted; cases accepted
 | false =>
  rw [guard0] at accepted
  cases targetBalance : (ft.value == pt.value+wt.value) with
  | false => rw [targetBalance] at accepted; cases accepted
  | true =>
   rw [targetBalance] at accepted
   cases contaminantBalance : (fc.value == pc.value+wc.value) with
   | false => rw [contaminantBalance] at accepted; cases accepted
   | true => exact ⟨Nat.eq_of_beq_eq_true targetBalance,Nat.eq_of_beq_eq_true contaminantBalance⟩
end SFT.Chemistry.RadiochemicalSeparation
