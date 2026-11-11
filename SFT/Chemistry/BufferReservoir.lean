import SFT.Chemistry.ProtonTransfer
import SFT.Chemistry.AmountCount
namespace SFT.Chemistry.BufferReservoir
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Reservoir where
 pair : ConjugatePair.Pair
 protonated : PositiveCount
 deprotonated : PositiveCount

def responseModes (_reservoir : Reservoir) : HeldLabel × HeldLabel :=
 (⟨"buffer-response","accept-added-proton",rfl,rfl⟩,
  ⟨"buffer-response","supply-proton-to-added-base",rfl,rfl⟩)
theorem modesDistinct (reservoir : Reservoir) : (responseModes reservoir).1≠(responseModes reservoir).2 := by
 intro equal
 have h := congrArg SFT.Physics.CapabilityValues.HeldLabel.label equal
 exact (by decide : "accept-added-proton"≠"supply-proton-to-added-base") h

-- A response consumes one retained source unit per transition; the count bound follows by induction.
inductive Consumption : Nat → Nat → Nat → Prop where
 | initial (available : Nat) : Consumption available 0 available
 | next {available used remaining : Nat} : Consumption available used (remaining+1) →
   Consumption available (used+1) remaining

theorem consumptionBalance {available used remaining : Nat} (trace : Consumption available used remaining) :
 used+remaining=available := by
 induction trace with
 | initial => exact Nat.zero_add _
 | @next k r prior ih =>
   calc
    (k+1)+r = k+(r+1) := (Nat.add_right_comm k 1 r).trans (Nat.add_assoc k r 1)
    _ = available := ih

theorem finiteCapacity {available used remaining : Nat} (trace : Consumption available used remaining) :
 used≤available := by
 rw [←consumptionBalance trace]
 exact Nat.le_add_right _ _

theorem cannotExceedCapacity (available used remaining : Nat) (excess : available<used) :
 ¬Consumption available used remaining := fun trace => Nat.not_lt_of_ge (finiteCapacity trace) excess

theorem extendConsumption {available used remaining : Nat}
 (trace : Consumption available used remaining) (extra : Nat) :
 Consumption (available+extra) used (remaining+extra) := by
 induction trace with
 | initial => exact .initial _
 | @next k r prior ih =>
   apply Consumption.next
   rw [Nat.add_right_comm r extra 1]
   exact ih

theorem exactCapacityAttained (available : Nat) : Consumption available available 0 := by
 induction available with
 | zero => exact .initial 0
 | succ n ih => exact .next (extendConsumption ih 1)

def acidResult (reservoir : Reservoir) (used remaining : Nat) :=
 (reservoir.pair,reservoir.protonated.value+used,remaining)
def baseResult (reservoir : Reservoir) (used remaining : Nat) :=
 (reservoir.pair,remaining,reservoir.deprotonated.value+used)

theorem acidTotalRetained (reservoir : Reservoir) {used remaining : Nat}
 (trace : Consumption reservoir.deprotonated.value used remaining) :
 (acidResult reservoir used remaining).2.1+(acidResult reservoir used remaining).2.2=
 reservoir.protonated.value+reservoir.deprotonated.value := by
 change (reservoir.protonated.value+used)+remaining=_
 rw [Nat.add_assoc,consumptionBalance trace]

theorem baseTotalRetained (reservoir : Reservoir) {used remaining : Nat}
 (trace : Consumption reservoir.protonated.value used remaining) :
 (baseResult reservoir used remaining).2.1+(baseResult reservoir used remaining).2.2=
 reservoir.protonated.value+reservoir.deprotonated.value := by
 change remaining+(reservoir.deprotonated.value+used)=_
 calc
  remaining+(reservoir.deprotonated.value+used) = (used+remaining)+reservoir.deprotonated.value := by
   rw [Nat.add_comm reservoir.deprotonated.value used,←Nat.add_assoc,Nat.add_comm remaining used]
  _ = _ := congrArg (fun n => n+reservoir.deprotonated.value) (consumptionBalance trace)

theorem pairRetained (reservoir : Reservoir) (used remaining : Nat) :
 (acidResult reservoir used remaining).1=reservoir.pair ∧
 (baseResult reservoir used remaining).1=reservoir.pair := ⟨rfl,rfl⟩

def acidTransition (reservoir : Reservoir) :=
 (reservoir.pair.raw.deprotonated,reservoir.pair.raw.protonated,reservoir.pair.raw.proton)
def baseTransition (reservoir : Reservoir) :=
 (reservoir.pair.raw.protonated,reservoir.pair.raw.deprotonated,reservoir.pair.raw.proton)
def acidTrace (reservoir : Reservoir) (used : Nat) := List.replicate used (acidTransition reservoir)
def baseTrace (reservoir : Reservoir) (used : Nat) := List.replicate used (baseTransition reservoir)

theorem uptakeIsOriginalConjugate (reservoir : Reservoir) :
 ConjugatePair.accept reservoir.pair.raw (acidTransition reservoir).1 (acidTransition reservoir).2.2=
 some (acidTransition reservoir).2.1 := ConjugatePair.uptakeAfterDonation reservoir.pair.raw

theorem donationIsOriginalConjugate (reservoir : Reservoir) :
 ConjugatePair.donate reservoir.pair.raw=((baseTransition reservoir).2.1,(baseTransition reservoir).2.2) := rfl

theorem acidTraceComplete (reservoir : Reservoir) (used : Nat) :
 (acidTrace reservoir used).length=used := by
 induction used with
 | zero => rfl
 | succ n ih => exact congrArg Nat.succ ih
theorem baseTraceComplete (reservoir : Reservoir) (used : Nat) :
 (baseTrace reservoir used).length=used := by
 induction used with
 | zero => rfl
 | succ n ih => exact congrArg Nat.succ ih

def append (reservoir : Reservoir) (acid base : PositiveCount) : Reservoir :=
 ⟨reservoir.pair,⟨reservoir.protonated.value+acid.value,Nat.lt_of_lt_of_le reservoir.protonated.positive (Nat.le_add_right _ _)⟩,
 ⟨reservoir.deprotonated.value+base.value,Nat.lt_of_lt_of_le reservoir.deprotonated.positive (Nat.le_add_right _ _)⟩⟩
theorem extendedAcidCapacity (reservoir : Reservoir) (acid base : PositiveCount) :
 reservoir.deprotonated.value<(append reservoir acid base).deprotonated.value := Nat.lt_add_of_pos_right base.positive
theorem extendedBaseCapacity (reservoir : Reservoir) (acid base : PositiveCount) :
 reservoir.protonated.value<(append reservoir acid base).protonated.value := Nat.lt_add_of_pos_right acid.positive
theorem extensionRetainsPair (reservoir : Reservoir) (acid base : PositiveCount) :
 (append reservoir acid base).pair=reservoir.pair := rfl

theorem extensionRetainsAcidTrace (reservoir : Reservoir) (acid base : PositiveCount) (used : Nat) :
 acidTrace (append reservoir acid base) used=acidTrace reservoir used := rfl
theorem extensionRetainsBaseTrace (reservoir : Reservoir) (acid base : PositiveCount) (used : Nat) :
 baseTrace (append reservoir acid base) used=baseTrace reservoir used := rfl

def initial : Reservoir := ⟨⟨ConjugatePair.originalPair,ConjugatePair.originalPairAdmitted⟩,⟨1,by decide⟩,⟨1,by decide⟩⟩
def original : Reservoir := ⟨initial.pair,⟨2,by decide⟩,⟨3,by decide⟩⟩
theorem initialAcidResponse : Consumption initial.deprotonated.value 1 0 := .next (.initial 1)
theorem initialBaseResponse : Consumption initial.protonated.value 1 0 := .next (.initial 1)
theorem originalSupport : original.protonated.value=2 ∧ original.deprotonated.value=3 := ⟨rfl,rfl⟩
end SFT.Chemistry.BufferReservoir
