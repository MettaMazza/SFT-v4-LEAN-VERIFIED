import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.CatalystSeal
open SFT.Host SFT.Host.Canonical SFT.Chemistry.SourceExtraction
def derivationHash : String := "sha256:92cb7099db038b0b6ecc13f58504a7b9ff8c5872990b24f4ae1e5cdca0a3b37a"
def payloadHash : String := "sha256:9c3921021511b019f9cb9aee9e5aba33269dc06318df591da32c9cbb8490206f"
def predictions : List (String × String × String) := [("SFT-CHEM-CAT-CATALYST-001","reaction-cycle-participant__exact-catalyst-identity-returned__alternative-step-path-retained__reaction-rate-increased__net-reaction-unchanged","reaction-rate-increased__alternative-reaction-pathway__catalyst-regenerated__net-reaction-unchanged"),("SFT-CHEM-CAT-PATHWAY-001","same-overall-reaction__alternative-reaction-mechanism__lower-activation-support__catalyst-cycle-retained__all-intermediates-balanced","alternative-reaction-mechanism__lower-activation-energy-path__same-overall-reaction__catalyst-cycle-retained"),("SFT-CHEM-CAT-SELECTIVITY-001","all-accessible-products-generated__complete-product-recurrence-order__one-product-favored__cofavored-class-at-tie__reactant-consumption-held","one-product-favored-among-alternatives__specified-reactant-consumption__condition-and-method-bounded__competing-products-retained"),("SFT-CHEM-NET-REACTION-001","chemical-species-nodes__reaction-steps-connect-species__shared-species-compose-paths__source-product-boundary-held__all-generated-paths-retained","chemical-species-nodes__reaction-steps-connect-species__combined-network-paths__complete-source-product-boundary"),("SFT-CHEM-NET-AUTOCATALYSIS-001","reaction-product-is-catalyst__product-accelerates-own-formation__same-identity-feedback__resource-consuming-amplification__positive-feedback-cycle","reaction-product-is-catalyst__product-accelerates-own-formation__positive-feedback-cycle__finite-resource-bounded"),("SFT-CHEM-SURFACE-ADSORPTION-001","retained-interface__adsorbate-and-adsorbent-retained__accumulation-at-interface__surface-concentration-differs__reversible-desorption-boundary","accumulation-at-interface__adsorbate-and-adsorbent-retained__surface-concentration-differs-from-bulk__reversible-desorption-boundary"),("SFT-CHEM-COLLOID-DISPERSION-001","dispersed-and-continuous-phases__finite-dispersed-particles__phase-interface-retained__particles-distributed-through-medium__particle-size-source-bounded","microscopic-phase-dispersed-in-continuous-phase__phase-interface-retained__particle-size-boundary__dispersion-condition-bounded"),("SFT-CHEM-INTERFACE-TRANSFER-001","two-phase-boundary__chemical-species-retained__held-donor-to-receiver-orientation__mass-balance-preserved__boundary-crossing-transition","chemical-species-crosses-phase-boundary__donor-and-receiver-phases-retained__transfer-rate-condition-bounded__mass-balance-preserved")]
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
  throw "catalysis/interfaces derivation changed after seal"
 if !Text.equal (textField sealedRecord "sealed_payload_hash") payloadHash || !Text.equal (identity (removeClaimedHash sealedRecord)) payloadHash then
  throw "catalysis/interfaces seal invalid"
 if !predictionRowsMatch (arrayValue (field sealedRecord "claim_predictions")) predictions then
  throw "catalysis/interfaces pre-source boundary invalid"
 if !isFalse (field sealedRecord "external_source_identities_selected") || !isFalse (field sealedRecord "external_target_content_opened") then
  throw "catalysis/interfaces pre-source boundary invalid"
 pure ()

theorem strictFalseRejectsInteger : isFalse (.integer 0)=false := rfl

end SFT.Chemistry.CatalystSeal
