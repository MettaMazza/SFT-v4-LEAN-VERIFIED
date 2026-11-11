import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.ThermochemistrySeal
open SFT.Host SFT.Host.Canonical SFT.Chemistry.SourceExtraction
def derivationHash : String := "sha256:2f8e10639b626a3108429b920806dff78a7292ec750a7c74c9a35a43d3c7cdd2"
def payloadHash : String := "sha256:58e46c68b49f729d29d799de0b50b9f8459034cbc8bf3027e61beecb751dfa04"
def predictions : List (String × String × String) := [("SFT-CHEM-THERMO-REACTION-001","registered-reaction-trace__complete-reactant-energy-support__complete-product-energy-support__energy-transfer-balanced__held-absorbed-or-released-orientation","reaction-energy-change__products-minus-reactants__absorbed-or-released-transfer__state-and-condition-source-bounded"),("SFT-CHEM-THERMO-DIRECTION-001","forward-and-reverse-paths__complete-energy-transfer-ledgers__complete-accessible-distinction-census__strict-support-order__held-favored-direction","forward-or-reverse-spontaneous-tendency__Gibbs-energy-condition__equilibrium-at-no-driving-force__direction-state-bounded"),("SFT-CHEM-PHASE-CHEMICAL-001","maximal-connected-region__complete-intensive-trace-equivalence__extent-independent-class__retained-phase-interface__paired-interface-recurrence","homogeneous-material-region__uniform-intensive-properties__phase-boundary-retained__coexistence-condition-bounded"),("SFT-CHEM-SOLUTION-EQUILIBRIUM-001","retained-solute-solvent-organization__dissolution-and-return-transitions__paired-opposed-event-support__source-bounded-capacity-boundary__macroscopic-dissolved-class-recurs","dissolution-and-crystallization-continue__rates-balanced-at-saturation__dissolved-composition-constant__solubility-condition-bounded"),("SFT-CHEM-PHOTOCHEM-001","one-retained-photon-carrier__carrier-absorbed-once__distinct-excited-state-support__source-bound-reaction-or-relaxation-channel__complete-photon-molecule-energy-ledger","light-absorption-initiates-chemical-change__molecular-excited-state__reaction-or-relaxation-pathways__photon-energy-accounted")]
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
  throw "thermochemistry derivation changed after seal"
 if !Text.equal (textField sealedRecord "sealed_payload_hash") payloadHash || !Text.equal (identity (removeClaimedHash sealedRecord)) payloadHash then
  throw "thermochemistry seal invalid"
 if !predictionRowsMatch (arrayValue (field sealedRecord "claim_predictions")) predictions then
  throw "thermochemistry pre-source boundary invalid"
 if !isFalse (field sealedRecord "external_source_identities_selected") || !isFalse (field sealedRecord "external_target_content_opened") then
  throw "thermochemistry pre-source boundary invalid"
 pure ()

theorem strictFalseRejectsInteger : isFalse (.integer 0)=false := rfl

end SFT.Chemistry.ThermochemistrySeal
