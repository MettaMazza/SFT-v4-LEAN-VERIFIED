import SFT.Chemistry.TemperatureCorrespondenceExperiment
import SFT.Chemistry.TemperatureCorrespondenceAnalysis
import SFT.Chemistry.CrossPropertyMolecularVectorSource
namespace SFT.Chemistry.TemperatureCorrespondenceSource
open SFT.Host SFT.Host.Canonical SFT.Physics TemperatureCorrespondenceExperiment
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev canonicalPayloadHash := CrossPropertyMolecularVectorSource.canonicalPayloadHash
structure Target where
 targetId : String
 row : Value
 value : Value
structure SourceFile where
 path : String
 bytes : ByteArray
def sourceFiles : List (String × String) := [("experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("experiments/external_sources/physics/snapshots/nist-acoustic-boltzmann-2017.pdf","sha256:1cbb21f0e5817270b5e028105aa79fea22017fd84130c2c4b79d1492fb37e418"),("experiments/external_sources/physics/snapshots/nist-electronic-boltzmann-2011.pdf","sha256:187066b5390d57a3c058e0a34f6c7803a659045ba714ca4b25eed7b84b212bbb")]
def attachPayload (row payload : Value) (hash : String) : Value := match row with
 | .object fields => .object ((fields.filter fun (key,_) => !(Text.equal key "target_payload" || Text.equal key "target_payload_hash")) ++
   [("target_payload",payload),("target_payload_hash",.text hash)])
 | .null | .boolean _ | .integer _ | .text _ | .array _ => row
def sourceRows (identityBytes targetBytes primaryBytes physicsBytes : ByteArray)
 (files : List SourceFile) (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),(physicsBytes,physicsPath,physicsHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-002 registered source changed: " path)
  pure ()
 let _ ← sourceFiles.mapM fun (path,hash) => do
  let actual ← match files.find? (fun item => Text.equal item.path path) with
   | some value => pure value
   | none => throw (Text.append "registered source file not supplied: " path)
  if !bytesMatch actual.bytes hash then throw (Text.append "THERMO-002 registered source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "schema") (.text "sft-v3-chemical-temperature-withheld-targets/1") ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) ||
  !sameValue (get targets "complete_target_count") (.integer 3) ||
  !sameValue (get targets "measurement_routes_physically_distinct") (.boolean true) ||
  !sameValue (get targets "all_registered_rows_retained") (.boolean true) || targetRows.length != 3 then
  throw "THERMO-002 withheld target registry changed"
 let resolved ← (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") || !sameValue (get id "source_class") (get target "source_class") then
   throw "THERMO-002 identity/target binding changed"
  let targetId ← field id "target_id" >>= identityString
  pure (⟨targetId,attachPayload id target (canonicalPayloadHash target),target⟩ : Target)
 let acoustic ← match resolved with
  | _::second::_ => pure second.value
  | [] | [_] => throw "tuple index out of range"
 if !sameValue (get acoustic "chemical_composition_identity") (.text "argon") ||
  !sameValue (get acoustic "phase_identity") (.text "gas") ||
  !sameValue (get acoustic "equilibrium_reference_identity") (.text "triple-point-of-water") then
  throw "THERMO-002 acoustic chemical context changed"
 pure resolved
-- Hash custody fixes the released payloads to the original integer records.
-- This decoder preserves signed and Boolean integer fields for adverse inputs.
def integerText (s : String) : Option Int :=
 let chars := LeptonDecimal.trimCodes LeptonDecimal.intSpaceCodes (Text.chars s)
 match chars with
 | [] => none
 | '-'::tail => (LeptonDecimal.exponentTail tail 0 false).map fun n => match n with
   | 0 => .ofNat 0
   | k+1 => .negSucc k
 | '+'::tail => (LeptonDecimal.exponentTail tail 0 false).map Int.ofNat
 | _ => (LeptonDecimal.exponentTail chars 0 false).map Int.ofNat
def integer (v : Value) : Except String Int := match v with
 | .integer n => .ok n
 | .boolean b => .ok (if b then 1 else 0)
 | .text s => match integerText s with
   | some n => .ok n
   | none => .error (Text.intercalate "" ["invalid literal for int() with base 10: '",s,"'"])
 | .null => .error "int() argument must be a string, a bytes-like object or a number, not 'NoneType'"
 | .array _ => .error "int() argument must be a string, a bytes-like object or a number, not 'list'"
 | .object _ => .error "int() argument must be a string, a bytes-like object or a number, not 'dict'"
def intervalRecord (row : Value) : Except String TemperatureCorrespondenceAnalysis.IntervalRecord := do
 let lower ← field row "measured_interval_lower_scaled_numerator" >>= integer
 let upper ← field row "measured_interval_upper_scaled_numerator" >>= integer
 let center ← field row "measured_center_scaled_numerator" >>= integer
 let uncertainty ← field row "measured_standard_uncertainty_scaled_numerator" >>= integer
 pure ⟨lower,upper,center,uncertainty⟩
def exactTemperatureAnalysis (rows : List Target) : Except String Value := do
 match rows with
 | [common,acoustic,electronic] =>
  let numerator ← field common.value "exact_si_common_carrier_scaled_numerator" >>= integer
  let denominator ← field common.value "common_scale_denominator" >>= integer
  let a ← intervalRecord acoustic.value
  let e ← intervalRecord electronic.value
  let composition ← field acoustic.value "chemical_composition_identity" >>= text
  let phase ← field acoustic.value "phase_identity" >>= text
  let reference ← field acoustic.value "equilibrium_reference_identity" >>= text
  let kinetic ← field acoustic.value "temperature_measures_average_kinetic_energy"
  let noise ← field electronic.value "noise_power_depends_on_resistance_and_temperature"
  let accuracy ← field electronic.value "reported_relation_accuracy_parts_per_million" >>= integer
  pure (TemperatureCorrespondenceAnalysis.exactTemperatureAnalysis
   ⟨numerator,denominator,a,e,composition,phase,reference,
    sameValue kinetic (.boolean true),sameValue noise (.boolean true),accuracy⟩)
 | [] | [_] | [_,_] => throw "not enough values to unpack (expected 3)"
 | _::_::_::_::_ => throw "too many values to unpack (expected 3)"
end SFT.Chemistry.TemperatureCorrespondenceSource
