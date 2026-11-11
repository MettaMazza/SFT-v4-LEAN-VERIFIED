import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.StereoSeal
open SFT.Host SFT.Host.Canonical SFT.Chemistry.SourceExtraction
def derivationHash : String := "sha256:2a45849856b248dee0eef97a3f99ffb64414475f881b980c231d887ce0970e26"
def payloadHash : String := "sha256:20dcf6b67d382b7ea55694356c769f7ceb0f8800932d70fab95a0de90b68696e"
def predictions : List (String × String × String) := [("SFT-CHEM-STEREO-CHIRALITY-001","complete-three-dimensional-object__exact-mirror-image-generated__composition-preserved__adjacency-preserved__no-proper-superposition","object-not-superposable-on-mirror-image__chirality-retained__reflection-distinction__observation-boundary-held"),("SFT-CHEM-STEREO-ENANTIOMER-001","paired-stereoisomers__same-composition-and-connectivity__exact-mirror-relation__non-superposable-pair__opposed-configurations-held","molecular-entities-mirror-images__non-superposable__opposed-configurations__chiral-observation-bounded"),("SFT-CHEM-STEREO-DIASTEREOMER-001","paired-stereoisomers__same-composition-and-connectivity__non-superposable-pair__not-mirror-related__complete-relative-configurations-held","stereoisomers__not-mirror-images__distinct-configurations__property-distinction-possible"),("SFT-CHEM-ORGANIC-FUNCTIONAL-GROUP-001","named-atom-or-group-support__molecular-embedding-held__recurs-across-molecules__characteristic-reaction-role__group-identity-retained","atom-or-group-with-characteristic-properties__recurs-across-molecules__reaction-role-retained__molecular-context-bounded"),("SFT-CHEM-ORGANIC-REACTION-FAMILY-001","multiple-generated-reactions__complete-reactant-product-maps__shared-bond-change-pattern__reactant-product-role-correspondence__elemental-carriers-balanced","shared-bond-change-pattern__reactant-product-role-correspondence__mechanism-not-assumed__conditions-source-bounded"),("SFT-CHEM-POLYMER-CHAIN-001","connected-macromolecular-carrier__repeated-low-mass-unit-identity__covalent-sequence-connections__ordered-chain-incidence__positive-finite-repeat-count","high-relative-molecular-mass-molecule__repeated-low-mass-units__covalent-sequence__chain-end-boundary"),("SFT-CHEM-POLYMER-DISTRIBUTION-001","all-observed-chain-carriers__exact-chain-length-counts__positive-chain-multiplicities__number-and-mass-support-separated__complete-molar-mass-distribution","polymer-sample-many-chain-lengths__molar-mass-distribution__number-and-mass-fractions-retained__method-bounded"),("SFT-CHEM-BIOMOLECULAR-BOUNDARY-001","chemical-molecular-identity-retained__composition-preserved__molecular-structure-preserved__chemical-state-boundary-held__biological-function-separately-held","chemical-molecular-identity-retained__biological-function-not-chemical-identity__structure-composition-handoff__biology-boundary-explicit")]
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
  throw "stereochemistry/organic/polymer derivation changed after seal"
 if !Text.equal (textField sealedRecord "sealed_payload_hash") payloadHash || !Text.equal (identity (removeClaimedHash sealedRecord)) payloadHash then
  throw "stereochemistry/organic/polymer seal invalid"
 if !predictionRowsMatch (arrayValue (field sealedRecord "claim_predictions")) predictions then
  throw "stereochemistry/organic/polymer pre-source boundary invalid"
 if !isFalse (field sealedRecord "external_source_identities_selected") || !isFalse (field sealedRecord "external_target_content_opened") then
  throw "stereochemistry/organic/polymer pre-source boundary invalid"
 pure ()

theorem strictFalseRejectsInteger : isFalse (.integer 0)=false := rfl

end SFT.Chemistry.StereoSeal
