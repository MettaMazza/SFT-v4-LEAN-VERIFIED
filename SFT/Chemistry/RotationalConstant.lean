import SFT.Chemistry.VibrationalFrequency
import SFT.Physics.MolecularLadders
namespace SFT.Chemistry.RotationalConstant
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues DihedralTorsion
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def exactAxisRotationalConstant (recurrence interval : CountInput) : Except String Ratio :=
 match recurrence with
 | .other => .error "a rotational constant requires positive recurrence and interval counts"
 | .count n => match interval with
  | .other => .error "a rotational constant requires positive recurrence and interval counts"
  | .count d => .ok ⟨n,d⟩
def repeatedEqualIntervalConstant (recurrence interval repetition : CountInput) : Except String Ratio :=
 match repetition with
 | .other => .error "axis-recurrence repetition requires a positive count"
 | .count k => match recurrence with
  | .other => .error "'NoneType' object has no attribute 'value'"
  | .count n => match interval with
   | .other => .error "'NoneType' object has no attribute 'value'"
   | .count d => exactAxisRotationalConstant
     (.count ⟨n.value*k.value,Nat.mul_pos n.positive k.positive⟩)
     (.count ⟨d.value*k.value,Nat.mul_pos d.positive k.positive⟩)
def rotationalLevelMultiple : CountInput → Except String PositiveCount
 | .other => .error "a rotational level requires a positive ordinal"
 | .count j => .ok ⟨j.value*(j.value+1),Nat.mul_pos j.positive (Nat.zero_lt_succ _)⟩
def adjacentRotationalGapMultiple : CountInput → Except String PositiveCount
 | .other => .error "a rotational gap requires a positive upper ordinal"
 | .count j => do
   let binary ← AlphaCovers.binaryCount
   if positive : 0<binary then
    pure ⟨binary*j.value,Nat.mul_pos positive j.positive⟩
   else throw "binary count is not positive"
def rotationalLevelRatio (constant : Height) (ordinal : CountInput) : Except String Ratio :=
 match constant with
 | .emptyOne | .otherEmptyOne _ | .invalid => .error "rotational level composition requires an exact positive constant"
 | .ratio c => do
   let multiple ← rotationalLevelMultiple ordinal
   pure ⟨⟨c.numerator.value*multiple.value,Nat.mul_pos c.numerator.positive multiple.positive⟩,c.denominator⟩
def unexcitedRotationalForm : Height := .emptyOne
structure Carrier where
 species : HeldLabel
 molecularState : HeldLabel
 geometry : HeldLabel
 geometryCoordinateCount : CountInput
 axis : HeldLabel
 axisEquivalenceClass : HeldLabel
 recurrence : CountInput
 interval : CountInput
 intervalUnit : HeldLabel
def validateCarrier (c : Carrier) : Except String Carrier :=
 if !Text.equal c.species.family "molecular-species" ||
    !Text.equal c.molecularState.family "molecular-state" ||
    !Text.equal c.geometry.family "generated-molecular-geometry" ||
    !VibrationalFrequency.isCount c.geometryCoordinateCount ||
    !Text.equal c.axis.family "rotational-axis" ||
    !(["principal-axis-A","principal-axis-B","principal-axis-C"].any fun s => Text.equal c.axis.label s) ||
    !Text.equal c.axisEquivalenceClass.family "rotational-axis-equivalence" ||
    !VibrationalFrequency.isCount c.recurrence || !VibrationalFrequency.isCount c.interval ||
    !Text.equal c.intervalUnit.family "observation-interval-unit" then
  .error "rotational carrier erased or altered a required finite field"
 else .ok c
def exactConstant (c : Carrier) : Except String Ratio := exactAxisRotationalConstant c.recurrence c.interval
theorem recurrenceCountsRetained (n d : PositiveCount) :
 exactAxisRotationalConstant (.count n) (.count d)=.ok ⟨n,d⟩ := rfl
theorem everyEqualIntervalRepetition (n d k : PositiveCount) :
 (repeatedEqualIntervalConstant (.count n) (.count d) (.count k)).map VibrationalFrequency.rationalValue =
 (exactAxisRotationalConstant (.count n) (.count d)).map VibrationalFrequency.rationalValue :=
 VibrationalFrequency.everyEqualIntervalRepetition n d k
theorem everyLevelMultiple (j : PositiveCount) :
 (rotationalLevelMultiple (.count j)).map (fun x => x.value)=.ok (j.value*(j.value+1)) := rfl
theorem everyAdjacentGap (j : PositiveCount) :
 (adjacentRotationalGapMultiple (.count j)).map (fun x => x.value)=.ok (2*j.value) := rfl
theorem adjacentLevelDifference (n : Nat) :
 (n+2)*(n+3)=(n+1)*(n+2)+2*(n+2) := MolecularLadders.rotationalAppend n
theorem unitAfterLaw (c : Carrier) (unit : HeldLabel) :
 exactConstant {c with intervalUnit:=unit}=exactConstant c := rfl
def constant : Ratio := ⟨⟨12,by decide⟩,⟨3,by decide⟩⟩
def ordinal (n : Nat) : PositiveCount := ⟨n+1,Nat.zero_lt_succ _⟩
theorem exactRatioWitness :
 (exactAxisRotationalConstant (.count constant.numerator) (.count constant.denominator)).map VibrationalFrequency.fractionPair=.ok (4,1) := rfl
theorem repeatedWitness :
 (repeatedEqualIntervalConstant (.count constant.numerator) (.count constant.denominator) (.count (ordinal 4))).map VibrationalFrequency.fractionPair=.ok (4,1) := rfl
theorem forcedLevelsWitness :
 ([0,1,2,3].map fun n => (rotationalLevelMultiple (.count (ordinal n))).map (fun x => x.value))=[.ok 2,.ok 6,.ok 12,.ok 20] := rfl
theorem forcedGapsWitness :
 ([0,1,2,3].map fun n => (adjacentRotationalGapMultiple (.count (ordinal n))).map (fun x => x.value))=[.ok 2,.ok 4,.ok 6,.ok 8] := rfl
theorem compositionWitness :
 (rotationalLevelRatio (.ratio constant) (.count (ordinal 2))).map VibrationalFrequency.fractionPair=.ok (48,1) := rfl
theorem emptyGroundWitness : unexcitedRotationalForm=.emptyOne := rfl
end SFT.Chemistry.RotationalConstant
