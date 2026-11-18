import SFT.Chemistry.CrossPropertyMolecularVectorExperiment
namespace SFT.Chemistry.CrossPropertyMolecularVectorSource
open SFT.Host SFT.Host.Canonical SFT.Physics CrossPropertyMolecularVectorExperiment
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- _canonical_payload_hash uses ensure_ascii=False, distinct from the engine's
-- canonical record hashing. Preserve its exact UTF-8 payload serialization.
def payloadEscape (c : Char) : String :=
 if c.toNat < 127 then Canonical.escapeChar c else String.ofList [c]
def payloadQuote (s : String) : String := Text.intercalate "" ["\"",Text.join ((Text.chars s).map payloadEscape),"\""]
mutual
 def payloadRender : Value → String
  | .text s => payloadQuote s
  | .integer i => Canonical.render (.integer i)
  | .boolean b => if b then "true" else "false"
  | .null => "null"
  | .array xs => Text.intercalate "" ["[",Text.intercalate "," (payloadValues xs),"]"]
  | .object fields => Text.intercalate "" ["{",Text.intercalate "," ((Canonical.sortFields (payloadFields fields)).map Prod.snd),"}"]
 def payloadValues : List Value → List String
  | [] => []
  | first::rest => payloadRender first::payloadValues rest
 def payloadFields : List (String × Value) → List (String × String)
  | [] => []
  | (key,value)::rest => (key,Text.intercalate "" [payloadQuote key,":",payloadRender value])::payloadFields rest
end
def canonicalPayloadHash (value : Value) : String :=
 Text.append "sha256:" (SHA256.digest (payloadRender value).toUTF8)
def truth : Value → Bool
 | .null => false
 | .boolean b => b
 | .integer (.ofNat 0) => false
 | .integer (.ofNat (_+1)) | .integer (.negSucc _) => true
 | .text s => !(Text.equal s "")
 | .array xs => !xs.isEmpty
 | .object xs => !xs.isEmpty
def countSortedFrom (previous : String) : List String → Nat
 | [] => 0
 | first::rest => (if Text.equal previous first then 0 else 1)+countSortedFrom first rest
def countSorted : List String → Nat
 | [] => 0
 | first::rest => 1+countSortedFrom first rest
def uniqueCount (values : List String) : Nat :=
 (values.foldl (fun (seen : List String) value => if seen.any (Text.equal value) then seen else value::seen) []).length
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
def replacePayload (row payload hash : Value) : Value := match row with
 | .object fields => .object ((fields.filter fun (key,_) => !(Text.equal key "source_target_payload" || Text.equal key "source_target_payload_hash")) ++
   [("source_target_payload",payload),("source_target_payload_hash",hash)])
 | .null | .boolean _ | .integer _ | .text _ | .array _ => row
def stringsAt (rows : List Target) (key : String) : Except String (List String) :=
 rows.mapM fun row => field row.row key >>= text
def familyCount (rows : List Target) (key : String) : Except String Nat := do
 pure (uniqueCount (← stringsAt rows key))
def overlapping (row : Target) : Bool := truth (get row.row "cross_property_overlap")
def sourceRows (identityBytes targetBytes manifestBytes summaryBytes : ByteArray)
 (identityDocument targets : Value) : Except String (List Target) := do
 let _ ← [(targetBytes,targetPath,targetHash),(manifestBytes,manifestPath,manifestHash),
  (summaryBytes,summaryPath,summaryHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-014 registered source changed: " path)
  pure ()
 let ids ← identities identityBytes identityDocument
 let targetRows ← RunningConvergenceMeasurement.array (get targets "rows")
 let prior ← RunningConvergenceMeasurement.array (get targets "source_target_files_first_opened_after_identity_seal")
 if !sameValue (get targets "schema") (.text "sft-v3-cross-property-withheld-targets/1") ||
  !sameValue (get targets "release_requires_complete_identity_prediction_seal") (.boolean true) ||
  !sameValue (get targets "identity_seal") (.text identityHash) || prior.length != 13 || targetRows.length != 9025 then
  throw "PROP-014 withheld registry changed"
 let resolved ← (ids.zip targetRows).mapM fun (id,target) => do
  if !(["cross_property_target_id","structural_carrier_id","property_family","source_target_id"].all fun key =>
   sameValue (get id key) (get target key)) ||
   !sameValue (.text (canonicalPayloadHash (get target "source_target_payload"))) (get target "source_target_payload_hash") then
   throw "PROP-014 source identity/target binding changed"
  let hash ← field target "source_target_payload_hash" >>= text
  let targetId ← field id "cross_property_target_id" >>= text
  let value ← CapabilityValues.heldLabel "source-target-payload-hash" hash
  pure (⟨targetId,replacePayload id (get target "source_target_payload") (.text hash),.label value⟩ : Target)
 let carriers ← familyCount resolved "structural_carrier_id"
 let overlapCarriers ← familyCount (resolved.filter overlapping) "structural_carrier_id"
 let properties ← familyCount resolved "property_family"
 if resolved.length != 9025 || uniqueCount (resolved.map Target.targetId) != 9025 || carriers != 1104 ||
  overlapCarriers != 676 || (resolved.filter overlapping).length != 6676 || properties != 13 then
  throw "PROP-014 complete carrier/property partition changed"
 pure resolved
end SFT.Chemistry.CrossPropertyMolecularVectorSource
