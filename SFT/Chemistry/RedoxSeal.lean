import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.RedoxSeal
open SFT.Host SFT.Host.Canonical SFT.Chemistry.SourceExtraction
def derivationHash : String := "sha256:803baf2ecb15116c290e38d3007e12b553a10db3e16fc5b747fe08f44c730e48"
def payloadHash : String := "sha256:ffbb0219ac03bd18dd37ab0ae9594ad961fbda7dc61491b1c74c3a7a4dffc1a9"
def predictions : List (String × String × String) := [("SFT-CHEM-ELECTRONEGATIVITY-001","two-named-atomic-occurrences__one-shared-electron-support__complete-endpoint-recurrence-comparison__held-preferred-endpoint__transitive-preorder-closure","atomic-attraction-for-shared-electrons__pairwise-affinity-order__ties-retained__scale-values-source-bounded"),("SFT-CHEM-BOND-POLARITY-001","registered-covalent-bond__unequal-complete-affinity__same-shared-electron-support__unequal-shared-partition__held-partial-charge-fibres","unequal-electron-attraction__polar-covalent-bond__partial-charge-separation__bond-support-remains-shared"),("SFT-CHEM-REDOX-OXIDATION-STATE-001","complete-bonded-chemical-whole__declared-ionic-approximation__assign-to-preferred-endpoint__equal-endpoint-division__each-electron-assigned-once","ionic-approximation__bond-electrons-assigned-by-electronegativity__per-atom-charge-accounting__complete-assignment-conserved"),("SFT-CHEM-REDOX-COUPLING-001","named-electron-carrier__registered-oxidation-endpoint__registered-reduction-endpoint__one-paired-transfer__same-carrier-before-after","oxidation-electron-loss__reduction-electron-gain__paired-half-reactions__electron-transfer-conserved"),("SFT-CHEM-ELECTROCHEM-CELL-001","distinct-oxidation-reduction-sites__complete-external-electron-path__complete-compensating-ionic-path__one-redox-transfer-cycle__source-bounded-work-transfer","separated-redox-half-cells__external-electron-path__ionic-circuit-closure__chemical-to-electrical-work-transfer")]
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
  throw "target-blind redox derivation changed after its pre-source seal"
 if !Text.equal (textField sealedRecord "sealed_payload_hash") payloadHash || !Text.equal (identity (removeClaimedHash sealedRecord)) payloadHash then
  throw "redox pre-source seal payload is invalid"
 if !predictionRowsMatch (arrayValue (field sealedRecord "claim_predictions")) predictions then
  throw "redox predictions differ from the pre-source seal"
 if !isFalse (field sealedRecord "external_source_identities_selected") || !isFalse (field sealedRecord "external_target_content_opened") then
  throw "redox derivation was not sealed before source selection"
 pure ()

theorem strictFalseRejectsInteger : isFalse (.integer 0)=false := rfl

end SFT.Chemistry.RedoxSeal
