import SFT.Chemistry.ConjugatedSupportAnalysis
namespace SFT.Chemistry.ResonanceEquivalentSource
open SFT.Host ConjugatedSupportAnalysis

def identityHash : String := "sha256:d90bb68121cb37ea8a2d85242fd0b3ba4673ec9e3eb01d151c79fb8118b0fbbc"
def targetHash : String := "sha256:873777e871d3b15278afd2502ac6fa4ad5b5083eb05192b06e16cf3b04d7be51"
def primaryHash : String := "sha256:0987db81474d56aacfeffa3b317e3380bfb4ec79b985ab09eed931594c366247"
def predecessorHash : String := "sha256:18df21662ac89606b6d6e3cd2c7c80247b20cfe86156a97f85f1375f74185dbd"
def identityKeys : List String := ["target_id","source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"]
def forbiddenIdentityKeys : List String := ["definition","note","example","value","outcome","source_outcome","presence","target_payload_hash"]
def getDefault (value : J) (key : String) (fallback : J) : Except String J :=
 match value with
 | .object fields => match fields.find? (fun p => Text.equal p.1 key) with
   | some p => .ok p.2
   | none => .ok fallback
 | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "source dictionary required"
def isBoolean (value : J) (wanted : Bool) : Bool :=
 match value with
 | .boolean b => b == wanted
 | .text _ | .integer _ | .null | .array _ | .object _ => false
def isFour : J → Bool
 | .integer (.ofNat n) => n==4
 | .integer (.negSucc _) | .text _ | .boolean _ | .null | .array _ | .object _ => false
def hasForbidden (row : J) : Except String Bool :=
 match row with
 | .object fields => .ok (fields.any (fun p => forbiddenIdentityKeys.any (Text.equal p.1)))
 | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "source identity dictionary required"

def identities (actualHash : String) (document : J) : Except String (List J) := do
 if !Text.equal actualHash identityHash then throw "ORG-002 identity changed"
 let rows ← getDefault document "rows" (.array []) >>= array
 let registered ← getDefault document "complete_registered_target_count" .null
 let boundary ← getDefault document "target_definitions_notes_examples_values_outcomes_presence_flags_or_payload_hashes_present" .null
 if !isFour registered || !isBoolean boundary false || rows.length != 4 then
  throw "ORG-002 value-free identity boundary changed"
 let forbidden ← rows.mapM hasForbidden
 if forbidden.any id then throw "ORG-002 value-free identity boundary changed"
 return rows

def sourceRows (actualIdentityHash actualTargetHash actualPrimaryHash : String)
 (identityDocument document : J) : Except String (List J) := do
 if !Text.equal actualTargetHash targetHash || !Text.equal actualPrimaryHash primaryHash then
  throw "ORG-002 external evidence changed"
 let declared ← identities actualIdentityHash identityDocument
 let rows ← getDefault document "rows" (.array []) >>= array
 let registered ← getDefault document "complete_registered_target_count" .null
 let releaseRequired ← getDefault document "release_requires_prediction_seal" .null
 if !isFour registered || rows.length != 4 || !isBoolean releaseRequired true then
  throw "ORG-002 corrected target vector incomplete"
 let predecessor ← getDefault document "preserved_predecessor" (.array [.null,.null]) >>= array
 let previous ← valueAt predecessor 1
 if !isText previous predecessorHash then throw "ORG-002 corrected target vector incomplete"
 (declared.zip rows).forM fun (identity,row) => do
  let equalFields ← identityKeys.mapM (fun key => do
   let original ← field identity key
   let observed ← getDefault row key .null
   pure (Text.equal (Canonical.render original) (Canonical.render observed)))
  if !(equalFields.all id) then throw "ORG-002 identity changed after target opening"
  let claimedHash ← getDefault row "target_payload_hash" .null
  let targetId ← field identity "target_id"
  let role ← field identity "source_record_role"
  let outcome ← getDefault row "source_outcome" .null
  if !isText claimedHash (Canonical.identity (.array [targetId,role,outcome])) then
   throw "ORG-002 target payload changed"
 return rows
#print axioms identityHash
#print axioms targetHash
#print axioms primaryHash
#print axioms predecessorHash
#print axioms identityKeys
#print axioms forbiddenIdentityKeys
#print axioms getDefault
#print axioms isBoolean
#print axioms isFour
#print axioms hasForbidden
#print axioms identities
#print axioms sourceRows
end SFT.Chemistry.ResonanceEquivalentSource
