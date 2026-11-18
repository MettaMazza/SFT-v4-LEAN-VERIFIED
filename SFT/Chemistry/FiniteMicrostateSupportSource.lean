import SFT.Chemistry.FiniteMicrostateSupportExperiment
import SFT.Chemistry.CrossPropertyMolecularVectorSource
namespace SFT.Chemistry.FiniteMicrostateSupportSource
open SFT.Host SFT.Host.Canonical SFT.Physics FiniteMicrostateSupportExperiment
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
-- Both original validators use precisely the same compact ensure_ascii=False hash.
abbrev canonicalPayloadHash := CrossPropertyMolecularVectorSource.canonicalPayloadHash
abbrev uniqueCount := CrossPropertyMolecularVectorSource.uniqueCount
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
def attachPayload (row payload : Value) (hash : String) : Value := match row with
 | .object fields => .object ((fields.filter fun (key,_) => !(Text.equal key "target_payload" || Text.equal key "target_payload_hash")) ++
   [("target_payload",payload),("target_payload_hash",.text hash)])
 | .null | .boolean _ | .integer _ | .text _ | .array _ => row
def populationClass : String := "direct-molecular-state-population-and-transition-record"
def calorimetricClass : String := "evaluated-finite-calorimetric-state-row"
def isClass (row : Target) (name : String) : Bool := sameValue (get row.row "source_class") (.text name)
def nonemptyCells (row : Target) : Bool := match get (get row.row "target_payload") "cells" with
 | .array (_::_) => true
 | .array [] | .null | .boolean _ | .integer _ | .text _ | .object _ => false
def calorimetricKeys (row : Target) : Bool := match get row.row "target_payload" with
 | .object fields => fields.length==7 && ["target_id","source_class","temperature_inscription_kelvin","heat_capacity_inscription",
   "entropy_inscription","held_gibbs_reference_relation_inscription","enthalpy_reference_relation_inscription"].all
    (fun key => fields.any fun (name,_) => Text.equal key name)
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false
def boundaryRow (row : Target) : Bool :=
 sameValue (get (get row.row "target_payload") "temperature_inscription_kelvin") (.text "1700.")
def sourceRows (identityBytes targetBytes primaryBytes waterBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(primaryBytes,primaryPath,primaryHash),(waterBytes,waterPath,waterHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "THERMO-001 registered source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 if !sameValue (get targets "schema") (.text "sft-v3-finite-microstate-withheld-targets/1") ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) ||
  !sameValue (get targets "identity_registry_hash") (.text identityHash) ||
  !sameValue (get targets "complete_target_count") (.integer 387) || targetRows.length != 387 then
  throw "THERMO-001 withheld registry changed"
 let resolved ← (ids.zip targetRows).mapM fun (id,target) => do
  if !sameValue (get id "target_id") (get target "target_id") || !sameValue (get id "source_class") (get target "source_class") then
   throw "THERMO-001 source identity/target binding changed"
  let hash := canonicalPayloadHash target
  let targetId ← field id "target_id" >>= text
  let value ← CapabilityValues.heldLabel "external-record-payload-hash" hash
  pure (⟨targetId,attachPayload id target hash,.label value⟩ : Target)
 let population := resolved.filter fun row => isClass row populationClass
 let calorimetric := resolved.filter fun row => isClass row calorimetricClass
 if resolved.length != 387 || uniqueCount (resolved.map Target.targetId) != 387 || population.length != 330 || calorimetric.length != 57 ||
  !(population.all nonemptyCells) || !(calorimetric.all calorimetricKeys) || (calorimetric.filter boundaryRow).length != 2 then
  throw "THERMO-001 complete external structure surface changed"
 pure resolved
-- Exact default json.dumps(..., sort_keys=True) formatting for the original
-- no-target-hash-in-prediction control (ASCII escaping; comma/colon spaces).
mutual
 def spacedRender : Value → String
  | .text s => Canonical.quote s
  | .integer i => Canonical.render (.integer i)
  | .boolean b => if b then "true" else "false"
  | .null => "null"
  | .array xs => Text.intercalate "" ["[",Text.intercalate ", " (spacedValues xs),"]"]
  | .object fields => Text.intercalate "" ["{",Text.intercalate ", " ((Canonical.sortFields (spacedFields fields)).map Prod.snd),"}"]
 def spacedValues : List Value → List String
  | [] => []
  | first::rest => spacedRender first::spacedValues rest
 def spacedFields : List (String × Value) → List (String × String)
  | [] => []
  | (key,value)::rest => (key,Text.intercalate "" [Canonical.quote key,": ",spacedRender value])::spacedFields rest
end
end SFT.Chemistry.FiniteMicrostateSupportSource
