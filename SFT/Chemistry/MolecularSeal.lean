import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.MolecularSeal
open SFT.Host SFT.Host.Canonical SFT.Chemistry.SourceExtraction
def derivationHash : String := "sha256:39dab1fec6c9e889b12c65751b46a41b382d8686aaa24569f88d4b98a550c0e5"
def payloadHash : String := "sha256:583e2aa3abd0239e5e7c67d460090e1942958947324e66575b0b6a881f2f7488"
def predictions : List (String × String × String) := [("SFT-CHEM-MOL-MOLECULE-001","multiple-atomic-occurrences__complete-bond-support__one-connected-component__closed-charge-boundary__constituent-identities-retained","multi-atomic-carrier__connected-complete-bond-support__closed-charge-boundary__constituent-identities-retained"),("SFT-CHEM-MOL-GEOMETRY-001","identified-molecular-carrier__complete-atom-adjacency__held-relative-orientation__complete-pair-support__rigid-relabel-equivalence","identified-molecular-carrier__complete-atom-adjacency__held-relative-orientation__source-bounded-geometry-record"),("SFT-CHEM-MOL-ISOMER-001","two-identified-carriers__equal-exact-composition__complete-structure-signatures__all-identity-preserving-relabelings__connectivity-or-orientation-difference","equal-composition__distinct-structural-signature__connectivity-or-orientation-distinction__separate-chemical-identity"),("SFT-CHEM-MOL-INTERMOLECULAR-001","distinct-molecular-carriers__between-whole-interaction-support__constituent-identities-retained__collective-recurrence__explicit-molecular-boundary","distinct-molecular-carriers__between-whole-interaction-support__constituent-identities-retained__collective-recurrence"),("SFT-CHEM-MOL-SUPRAMOLECULAR-001","multiple-molecular-components__noncovalent-interaction-support__complementary-recognition__reversible-component-release__assembled-whole-identity","multiple-molecular-components__reversible-noncovalent-recognition__component-identities-retained__assembled-whole"),("SFT-CHEM-MOL-NETWORK-001","finite-molecular-node-set__registered-interaction-edges__connected-maximal-component__complete-reachability-census__finite-maximal-boundary","finite-molecular-node-set__registered-interaction-edges__connected-maximal-component__complete-network-trace")]
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

def resolveDependency (dependency : String) : String :=
 if Text.equal dependency "SFT-PHYS-KINEMATICS-POSITION-001" || Text.equal dependency "SFT-PHYS-KINEMATICS-DISPLACEMENT-001"
 then "SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001" else dependency

def resolveLoop : List String → List String → List String
 | [], seen => seen
 | first::rest, seen =>
   let resolved := resolveDependency first
   resolveLoop rest (if seen.any (fun x => Text.equal x resolved) then seen else seen++[resolved])
def resolvedDependencies (dependencies : List String) := resolveLoop dependencies []

def aliasesMatch (aliases : Value) : Bool := objectSize aliases == 2 &&
 Text.equal (textField aliases "SFT-PHYS-KINEMATICS-POSITION-001") "SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001" &&
 Text.equal (textField aliases "SFT-PHYS-KINEMATICS-DISPLACEMENT-001") "SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001"

def unchangedFields : List String := ["candidate_dimensions_changed","candidate_census_changed","survivors_changed","exact_results_changed","predicted_observation_labels_changed","external_targets_changed"]

def validate (derivationBytes : ByteArray) (sealedRecord amendment : Value) : Except String Unit := do
 if !Text.equal (Text.append "sha256:" (SHA256.digest derivationBytes)) derivationHash then
  throw "target-blind molecular derivation changed after its pre-source seal"
 if !Text.equal (textField sealedRecord "sealed_payload_hash") payloadHash || !Text.equal (identity (removeClaimedHash sealedRecord)) payloadHash then
  throw "molecular pre-source seal payload is invalid"
 if !predictionRowsMatch (arrayValue (field sealedRecord "claim_predictions")) predictions then
  throw "molecular predictions differ from the pre-source seal"
 if !isFalse (field sealedRecord "external_source_identities_selected") then
  throw "molecular derivation was not sealed before source selection"
 if !isFalse (field sealedRecord "external_target_content_opened") then
  throw "molecular target content was not withheld at derivation seal"
 if !Text.equal (textField amendment "schema") "sft-v3-sealed-derivation-engineering-amendment/1" then
  throw "molecular dependency amendment schema is invalid"
 if !Text.equal (textField amendment "original_sealed_payload_hash") payloadHash then
  throw "molecular dependency amendment is not bound to the original seal"
 if !aliasesMatch (field amendment "alias_resolution") then
  throw "molecular dependency amendment differs from executable alias resolution"
 if !(unchangedFields.all (fun key => isFalse (field amendment key))) then
  throw "molecular dependency amendment changes scientific content"
 pure ()

theorem strictFalseRejectsInteger : isFalse (.integer 0)=false := rfl

theorem positionAlias : resolveDependency "SFT-PHYS-KINEMATICS-POSITION-001"="SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001" := rfl

theorem displacementAlias : resolveDependency "SFT-PHYS-KINEMATICS-DISPLACEMENT-001"="SFT-PHYS-MECH-LOCATION-DISPLACEMENT-001" := rfl

end SFT.Chemistry.MolecularSeal
