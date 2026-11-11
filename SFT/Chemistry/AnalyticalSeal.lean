import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.AnalyticalSeal
open SFT.Host SFT.Host.Canonical SFT.Chemistry.SourceExtraction
def derivationHash : String := "sha256:eeddce8a3e937d7e78fdad233e52e37e17401d2151136abf8cac19331030fa08"
def payloadHash : String := "sha256:7a94f1bf8630a5c0908022749f8f9b791c5ec0bb39e261105eb3f896f1f7708b"
def predictions : List (String × String × String) := [("SFT-CHEM-ANALYTICAL-SAMPLE-001","declared-material-portion__complete-resolved-component-support__analyte-role-held__matrix-support-held__source-to-sample-map-held","sample-is-declared-material-portion__analyte-is-component-under-determination__matrix-is-other-sample-components__sampling-boundary-held"),("SFT-CHEM-ANALYTICAL-CALIBRATION-001","traceable-reference-input__reference-response-pair-held__exact-generated-comparison-order__sample-compared-with-reference-map__declared-calibration-domain","calibration-relates-response-to-reference-values__traceability-chain-retained__calibration-domain-explicit__uncertainty-method-bounded"),("SFT-CHEM-ANALYTICAL-SELECTIVITY-001","analyte-response-held__declared-interferent-support__all-analyte-interferent-responses-compared__distinguishable-analyte-response__interference-boundary-retained","analyte-response-distinguished-amid-components__interference-retained__selectivity-not-universal__method-condition-boundary-held"),("SFT-CHEM-SPEC-MASS-001","generated-ionized-carriers__composition-and-isotope-support-held__mass-charge-classes-held__class-position-and-abundance-held__precursor-fragment-map-held","ions-separated-by-mass-to-charge__mass-spectrum-retains-relative-abundance__composition-fragment-correspondence__ionization-method-bounded"),("SFT-CHEM-SPEC-INFRARED-001","incident-infrared-support-held__complete-molecular-carrier-held__vibrational-state-transition-held__dipole-response-change-required__complete-frequency-response-pattern","infrared-absorption-corresponds-to-molecular-vibration__frequency-pattern-retained__molecular-distinction-uses-whole-spectrum__state-method-bounded"),("SFT-CHEM-SPEC-UVVIS-001","ultraviolet-visible-support-held__molecular-or-ionic-carrier-held__paired-electronic-states__higher-state-transition-held__wavelength-response-pattern-held","ultraviolet-visible-absorption-involves-electronic-transition__carrier-and-state-retained__response-pattern-recorded__state-method-bounded"),("SFT-CHEM-SPEC-ROT-VIB-001","complete-molecular-geometry-held__rotational-state-classes-held__vibrational-state-classes-held__rotational-vibrational-composition__allowed-state-transition-trace","molecular-spectra-retain-rotational-and-vibrational-transitions__state-composition-held__transition-pattern-complete__population-resolution-bounded"),("SFT-CHEM-ANALYTICAL-COMPLETE-RECORD-001","measurand-and-purpose-held__sample-analyte-matrix-record__method-and-condition-record__calibration-and-reference-chain__all-raw-and-derived-rows-held__uncertainty-and-resolution-held__failed-tampered-and-falsification-record","analytical-result-identifies-measurand-sample-and-method__traceability-and-uncertainty-retained__all-results-and-controls-preserved__falsification-condition-explicit")]
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
  throw "analytical/spectroscopic derivation changed after seal"
 if !Text.equal (textField sealedRecord "sealed_payload_hash") payloadHash || !Text.equal (identity (removeClaimedHash sealedRecord)) payloadHash then
  throw "analytical/spectroscopic seal invalid"
 if !predictionRowsMatch (arrayValue (field sealedRecord "claim_predictions")) predictions then
  throw "analytical/spectroscopic pre-source boundary invalid"
 if !isFalse (field sealedRecord "external_source_identities_selected") || !isFalse (field sealedRecord "external_target_content_opened") then
  throw "analytical/spectroscopic pre-source boundary invalid"
 pure ()

theorem strictFalseRejectsInteger : isFalse (.integer 0)=false := rfl

end SFT.Chemistry.AnalyticalSeal
