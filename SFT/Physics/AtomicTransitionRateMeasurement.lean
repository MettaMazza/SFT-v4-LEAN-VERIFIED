import SFT.Physics.AtomicTransitionRateProofs
import SFT.Physics.AtomicTransitionRateRecords
namespace SFT.Physics.AtomicTransitionRateMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals AtomicTransitionRateRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def measuredInterval (record : Value) (sourceKey : String) : Except String (Rat × Rat) := do
 let row ← field (← field (← field record "sources") sourceKey) "reported_record"
 let centre ← decimalField row "lifetime_seconds"
 let spread ← decimalField row "standard_uncertainty_seconds"
 let lower ← RunningConvergence.positiveTake centre spread
 pure (lower,add centre spread)
def allowedExampleLifetime (record : Value) : Except String Rat := do
 let row ← field (← field (← field (← field record "sources") "nist_atomic_spectroscopy") "reported_record") "allowed_helium_example"
 let value ← text (← field row "transition_probability_per_second")
 let rate ← match LeptonDecimal.exponent (Text.chars value) with
  | none => .error "ValueError: invalid literal for int() with base 10"
  | some rate => .ok rate
 AtomicTransitionRate.exactLifetime [.fraction (normalize rate 1 (by decide))]
def label : String := "sealed-E1-gap-cube-E2-gap-five-and-reciprocal-lifetime-match-NIST-equations__hydrogenic-rate-four-cross-locks__complete-metastable-lifetime-vector-passed"
def classificationFromRecord (record : Value) : Except String String := do
 let row ← field (← field (← field record "sources") "nist_atomic_spectroscopy") "reported_record"
 let e1 ← AtomicTransitionRate.electricMultipoleExponent (.count (.integer 1))
 let e2 ← AtomicTransitionRate.electricMultipoleExponent (.count (.integer 2))
 if !sameValue (← field row "E1_gap_exponent") (.integer (.ofNat e1)) then
  throw "sealed E1 exponent differs from NIST"
 if !sameValue (← field row "E2_gap_exponent") (.integer (.ofNat e2)) then
  throw "sealed E2 exponent differs from NIST"
 if !sameValue (← field row "M1_gap_exponent") (.integer (.ofNat e1)) then
  throw "NIST M1 adverse exponent boundary changed"
 if !sameValue (← field row "lifetime_relation") (.text "tau_k=(sum_i A_ki)^-1") then
  throw "NIST lifetime reciprocal relation changed"
 let gapPower ← match ← field row "hydrogenic_gap_scaling_exponent" with
  | .integer n => .ok n
  | .boolean b => .ok (if b then 1 else 0)
  | .text _ => .error "hydrogenic gap-cube composition failed"
  | .null => .error "hydrogenic gap-cube composition failed"
  | .array _ => .error "hydrogenic gap-cube composition failed"
  | .object _ => .error "hydrogenic gap-cube composition failed"
 if !sameValue (.integer (gapPower*Int.ofNat e1)) (.integer 6) then throw "hydrogenic gap-cube composition failed"
 if !sameValue (← field row "hydrogenic_strength_scaling") (.text "inverse-square") || !sameValue (← field row "hydrogenic_rate_scaling_exponent") (.integer 4) then
  throw "hydrogenic rate exponent cross-lock failed"
 let allowed ← allowedExampleLifetime record
 let _ ← ["nist_argon_metastable","nist_aluminium_clock"].foldlM (fun (_ : Unit) key => do
  let measured ← measuredInterval record key
  if !allowed.blt measured.1 then throw "registered metastable lifetime does not exceed the allowed example"
  pure ()) ()
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := match AtomicTransitionRate.electricMultipoleExponent (.count (.integer 1)) with
 | .error _ => false
 | .ok e1 => match AtomicTransitionRate.electricMultipoleExponent (.count (.integer 2)) with
  | .error _ => false
  | .ok e2 => e1==3 && e2==5
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.AtomicTransitionRateMeasurement
