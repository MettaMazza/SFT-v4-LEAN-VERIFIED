import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.AcidbaseSeal
open SFT.Host SFT.Host.Canonical SFT.Chemistry.SourceExtraction
def derivationHash : String := "sha256:50e328d932a018c7895f07d723b31076f96e99529b38504df1490ccaa764008c"
def payloadHash : String := "sha256:4be0b7e80ca75740fb8cec8a4ca2dfd747a4ac6a0e4c4cb3375a94c0e74bdc01"
def predictions : List (String × String × String) := [("SFT-CHEM-AB-ACID-BASE-001","two-conjugate-identities__one-held-proton-occurrence__proton-donor-role__proton-acceptor-role__differ-by-one-proton","proton-donor-acid__proton-acceptor-base__conjugates-differ-by-one-proton__paired-relation"),("SFT-CHEM-AB-PROTON-TRANSFER-001","one-named-proton-carrier__registered-donor__registered-acceptor__donor-to-acceptor-transfer__same-carrier-before-after","one-proton-carrier__donor-to-acceptor-transfer__carrier-conserved__endpoint-identities-retained"),("SFT-CHEM-AB-LEWIS-001","distinct-donor-acceptor__two-electron-occurrences__pair-donor-support__pair-acceptor-support__shared-or-transferred-pair","electron-pair-donor__electron-pair-acceptor__shared-or-transferred-pair__pair-conserved"),("SFT-CHEM-AB-AMPHOTERIC-001","same-species-identity__valid-donor-event__valid-acceptor-event__contexts-separately-held__both-roles-realized","same-species-acid-role__same-species-base-role__context-dependent-dual-response__both-traces-retained"),("SFT-CHEM-AB-BUFFER-001","conjugate-pair-reservoir__positive-support-of-both__base-member-accepts-proton__acid-member-supplies-proton__conjugate-pair-retained","weak-acid-conjugate-base-pair__responds-to-added-acid-or-base__composition-change-limited__source-bounded-capacity")]
def objectSize : Value → Nat
 | .object fields => fields.length
 | .text _ | .boolean _ | .integer _ | .null | .array _ => 0

def removeClaimedHash : Value → Value
 | .object fields => .object (fields.filter (fun row => !Text.equal row.1 "sealed_payload_hash"))
 | .text value => .text value
 | .boolean value => .boolean value
 | .integer value => .integer value
 | .null => .null
 | .array value => .array value

def isFalse : Value → Bool
 | .boolean false => true
 | .boolean true | .text _ | .integer _ | .null | .array _ | .object _ => false

def predictionRowsMatch : List Value → List (String × String × String) → Bool
 | [], [] => true
 | row::rest, expected::more => objectSize row == 3 &&
   Text.equal (textField row "claim_id") expected.1 &&
   Text.equal (textField row "exact_result") expected.2.1 &&
   Text.equal (textField row "predicted_observation_label") expected.2.2 && predictionRowsMatch rest more
 | [], _::_ => false
 | _::_, [] => false

def validate (derivationBytes : ByteArray) (sealedRecord : Value) : Except String Unit := do
 if !Text.equal (Text.append "sha256:" (SHA256.digest derivationBytes)) derivationHash then
  throw "target-blind acid/base derivation changed after its pre-source seal"
 if !Text.equal (textField sealedRecord "sealed_payload_hash") payloadHash || !Text.equal (identity (removeClaimedHash sealedRecord)) payloadHash then
  throw "acid/base pre-source seal payload is invalid"
 if !predictionRowsMatch (arrayValue (field sealedRecord "claim_predictions")) predictions then
  throw "acid/base predictions differ from the pre-source seal"
 if !isFalse (field sealedRecord "external_source_identities_selected") || !isFalse (field sealedRecord "external_target_content_opened") then
  throw "acid/base derivation was not sealed before source selection"
 pure ()

theorem strictFalseRejectsInteger : isFalse (.integer 0)=false := rfl

end SFT.Chemistry.AcidbaseSeal
