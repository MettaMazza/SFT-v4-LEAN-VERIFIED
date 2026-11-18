import SFT.Chemistry.EquilibriumBondLengthExperiment
import SFT.Chemistry.JointCorrelationTargets
import SFT.Physics.MolecularSpectroscopyRecords
import SFT.Physics.CapabilityValues
import SFT.Host.SHA256Chunks
namespace SFT.Chemistry.EquilibriumBondLengthSource
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals
abbrev field := JointCorrelationTargets.field
-- The original JSON integer domain includes Python's Boolean integer subtype.
def integer : Value → Except String Int
 | .integer n => .ok n
 | .boolean b => .ok (if b then 1 else 0)
 | .null | .text _ | .array _ | .object _ => .error "both arguments should be Rational instances"
-- Original _fraction: normalize first, then require a strictly positive result.
def fraction (row : Value) : Except String Rat := do
 let n ← field row "numerator" >>= integer
 let d ← field row "denominator" >>= integer
 if hd : d.natAbs = 0 then
  throw (Text.intercalate "" ["Fraction(",render (.integer n),", 0)"])
 else
  let numerator := if @decide (Int.lt d 0) (Int.decLt _ _) then -n else n
  let value := normalize numerator d.natAbs (Nat.pos_of_ne_zero hd)
  if !(@decide (Int.lt 0 value.num) (Int.decLt _ _)) then
   throw "PROP-001 external interval left the positive exact domain"
  pure value
-- Original _ratio retains the normalized positive fraction as a capability value.
def ratio (value : Rat) : Except String CapabilityValues.Value := do
 if !(@decide (Int.lt 0 value.num) (Int.decLt _ _)) then
  throw "PROP-001 ratio must be positive"
 let numerator ← CapabilityValues.count value.num.natAbs
 let denominator ← CapabilityValues.count value.den
 pure (.ratio numerator denominator)
def loadScale (bytes : ByteArray) (document : Value) : Except String (Rat × Rat × Rat) := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) EquilibriumBondLengthExperiment.scaleHash then
  throw "PROP-001 scale input changed"
 let schema := (field document "schema").toOption.getD .null
 let absent := (field document "target_values_absent").toOption.getD .null
 if !RunningConvergenceMeasurement.sameValue schema (.text "sft-v3-equilibrium-bond-length-scale-input/1") ||
    !RunningConvergenceMeasurement.sameValue absent (.boolean true) then
  throw "PROP-001 public scale input contains a target"
 let row ← field document "registered_scale_input"
 let central ← field row "central" >>= fraction
 let lower ← field row "lower" >>= fraction
 let upper ← field row "upper" >>= fraction
 pure (central,lower,upper)
end SFT.Chemistry.EquilibriumBondLengthSource
