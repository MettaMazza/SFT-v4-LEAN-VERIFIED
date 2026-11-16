import SFT.Chemistry.ConjugatedSupportAnalysis
namespace SFT.Chemistry.ConjugatedSupportSource
open SFT.Host ConjugatedSupportAnalysis

def identityHash : String := "sha256:8d63eeae30f819ec961ac73e98add98258ad48faa670d0ea140ed9bd2271a893"
def targetHash : String := "sha256:580934f71639b83e6e1f5e24ddd87e8bb19db150a6bdae3c4b6e899a34b74192"
def primaryHash : String := "sha256:6d40642ebbd21ff6b9abb72a09e0cc0b76a40539540b50d07add3666a5375550"
def predecessorHash : String := "sha256:adade1c9a6bed06b83a745680a63f73f0685cbf422bb4a2f3f5f0bf9830e0e7f"
def identityKeys : List String := ["target_id","source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"]
def forbiddenIdentityKeys : List String := ["definition","coordinate","peak","intensity","value","outcome","source_outcome","presence","target_payload_hash"]
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
def isTen : J → Bool
 | .integer (.ofNat n) => n==10
 | .integer (.negSucc _) | .text _ | .boolean _ | .null | .array _ | .object _ => false
def hasForbidden (row : J) : Except String Bool :=
 match row with
 | .object fields => .ok (fields.any (fun p => forbiddenIdentityKeys.any (Text.equal p.1)))
 | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "source identity dictionary required"

def identities (actualHash : String) (document : J) : Except String (List J) := do
 if !Text.equal actualHash identityHash then throw "ORG-001 identity changed"
 let rows ← getDefault document "rows" (.array []) >>= array
 let registered ← getDefault document "complete_registered_target_count" .null
 let boundary ← getDefault document "target_definitions_coordinates_peaks_intensities_values_outcomes_presence_flags_or_payload_hashes_present" .null
 if !isTen registered || !isBoolean boundary false || rows.length != 10 then
  throw "ORG-001 value-free identity boundary changed"
 let forbidden ← rows.mapM hasForbidden
 if forbidden.any id then throw "ORG-001 value-free identity boundary changed"
 return rows

def sourceRows (actualIdentityHash actualTargetHash actualPrimaryHash : String)
 (identityDocument document : J) : Except String (List J) := do
 if !Text.equal actualTargetHash targetHash || !Text.equal actualPrimaryHash primaryHash then
  throw "ORG-001 external evidence changed"
 let declared ← identities actualIdentityHash identityDocument
 let rows ← getDefault document "rows" (.array []) >>= array
 let registered ← getDefault document "complete_registered_target_count" .null
 let releaseRequired ← getDefault document "release_requires_prediction_seal" .null
 if !isTen registered || rows.length != 10 || !isBoolean releaseRequired true then
  throw "ORG-001 corrected target vector incomplete"
 let predecessor ← getDefault document "preserved_predecessor" (.array [.null,.null]) >>= array
 let previous ← valueAt predecessor 1
 if !isText previous predecessorHash then throw "ORG-001 corrected target vector incomplete"
 (declared.zip rows).forM fun (identity,row) => do
  let equalFields ← identityKeys.mapM (fun key => do
   let original ← field identity key
   let observed ← getDefault row key .null
   pure (Text.equal (Canonical.render original) (Canonical.render observed)))
  if !(equalFields.all id) then throw "ORG-001 identity changed after target opening"
  let claimedHash ← getDefault row "target_payload_hash" .null
  let targetId ← field identity "target_id"
  let role ← field identity "source_record_role"
  let outcome ← getDefault row "source_outcome" .null
  if !isText claimedHash (Canonical.identity (.array [targetId,role,outcome])) then
   throw "ORG-001 target payload changed"
 return rows
#print axioms identityHash
#print axioms targetHash
#print axioms primaryHash
#print axioms predecessorHash
#print axioms identityKeys
#print axioms forbiddenIdentityKeys
#print axioms getDefault
#print axioms isBoolean
#print axioms isTen
#print axioms hasForbidden
#print axioms identities
#print axioms sourceRows
end SFT.Chemistry.ConjugatedSupportSource
