import SFT.Chemistry.DihedralTorsion
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Chemistry.VibrationalFrequency
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues DihedralTorsion
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def exactRecurrenceFrequency (recurrence interval : CountInput) : Except String Ratio :=
 match recurrence with
 | .other => .error "frequency requires positive finite recurrence and interval counts"
 | .count n => match interval with
  | .other => .error "frequency requires positive finite recurrence and interval counts"
  | .count d => .ok ⟨n,d⟩
def repeatedEqualIntervalFrequency (recurrence interval repetition : CountInput) : Except String Ratio :=
 match repetition with
 | .other => .error "equal-interval repetition requires a positive count"
 | .count k => match recurrence with
  | .other => .error "'NoneType' object has no attribute 'value'"
  | .count n => match interval with
   | .other => .error "'NoneType' object has no attribute 'value'"
   | .count d => exactRecurrenceFrequency
     (.count ⟨n.value*k.value,Nat.mul_pos n.positive k.positive⟩)
     (.count ⟨d.value*k.value,Nat.mul_pos d.positive k.positive⟩)
structure Carrier where
 species : HeldLabel
 mode : CountInput
 symmetry : HeldLabel
 recurrence : CountInput
 interval : CountInput
 intervalUnit : HeldLabel
 transitionClass : HeldLabel
def isCount : CountInput → Bool
 | .count _ => true
 | .other => false
def validateCarrier (c : Carrier) : Except String Carrier :=
 if !Text.equal c.species.family "molecular-species" || !isCount c.mode ||
    !Text.equal c.symmetry.family "vibrational-symmetry" || !isCount c.recurrence || !isCount c.interval ||
    !Text.equal c.intervalUnit.family "observation-interval-unit" ||
    !Text.equal c.transitionClass.family "vibrational-transition-class" then
  .error "vibrational frequency carrier erased a required finite field"
 else .ok c
def exactFrequency (c : Carrier) : Except String Ratio := exactRecurrenceFrequency c.recurrence c.interval
def rationalValue (r : Ratio) : Rat := VacuumLedgerProofs.natRatio r.numerator.value r.denominator.value r.denominator.positive
theorem recurrenceCountsRetained (n d : PositiveCount) :
 exactRecurrenceFrequency (.count n) (.count d)=.ok ⟨n,d⟩ := rfl
theorem everyEqualIntervalRepetition (n d k : PositiveCount) :
 (repeatedEqualIntervalFrequency (.count n) (.count d) (.count k)).map rationalValue =
 (exactRecurrenceFrequency (.count n) (.count d)).map rationalValue := by
 change Except.ok (VacuumLedgerProofs.natRatio (n.value*k.value) (d.value*k.value) _) =
  Except.ok (VacuumLedgerProofs.natRatio n.value d.value _)
 apply congrArg Except.ok
 apply VacuumLedgerProofs.natRatioCongruence
 exact (SFT.Foundation.FractionReduction.mulAssoc n.value k.value d.value).trans
  (congrArg (fun t => n.value*t) (Nat.mul_comm k.value d.value))
theorem unitAfterLaw (c : Carrier) (unit : HeldLabel) :
 exactFrequency {c with intervalUnit:=unit}=exactFrequency c := rfl
def recurrence : PositiveCount := ⟨12,by decide⟩
def interval : PositiveCount := ⟨3,by decide⟩
def repetitions : PositiveCount := ⟨5,by decide⟩
def ratioPair (r : Ratio) : Nat × Nat := (r.numerator.value,r.denominator.value)
def fractionPair (r : Ratio) : Int × Nat := ((rationalValue r).num,(rationalValue r).den)
theorem exactRatioWitness : (exactRecurrenceFrequency (.count recurrence) (.count interval)).map fractionPair=.ok (4,1) := rfl
theorem repeatedWitness :
 (repeatedEqualIntervalFrequency (.count recurrence) (.count interval) (.count repetitions)).map fractionPair=.ok (4,1) := rfl
theorem rawRepeatedCounts :
 (repeatedEqualIntervalFrequency (.count recurrence) (.count interval) (.count repetitions)).map ratioPair=.ok (60,15) := rfl
theorem unitWitness : (exactRecurrenceFrequency (.count recurrence) (.count interval)).map fractionPair=.ok (4,1) := rfl
theorem noScaleFactorWitness : true=true := rfl
end SFT.Chemistry.VibrationalFrequency
