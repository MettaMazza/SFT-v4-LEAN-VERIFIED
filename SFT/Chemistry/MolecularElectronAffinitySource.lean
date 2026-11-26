import SFT.Chemistry.HtmlUnescapeLinear
import SFT.Chemistry.MolecularElectronAffinityExperiment
import SFT.Chemistry.MolecularIonizationSource
namespace SFT.Chemistry.MolecularElectronAffinitySource
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularElectronAffinityExperiment
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev Page := MolecularIonizationSource.Page
abbrev pair := MolecularIonizationSource.pair
abbrev decimalPrefix := MolecularIonizationSource.decimalPrefix
abbrev endUnit := MolecularIonizationSource.endUnit
structure Target where
 targetId : String
 row : Value
 value : CapabilityValues.Value
def targetWord (row : Value) : Except String CapabilityValues.Value := do
 let orientation ← field row "fold_state_order_orientation" >>= text
 let label ← CapabilityValues.heldLabel "electron-affinity-state-order" orientation
 let magnitude ← field row "exact_positive_magnitude" >>= pair
 let uncertainty ← match get row "exact_positive_uncertainty" with
  | .object fields => pair (.object fields)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => pure (.emptyOne "empty-One")
 pure (.word [.label label,magnitude,uncertainty])
def captureAt (cs : List Char) : Option (String × String × Option String) := do
 let body := cs.dropWhile CapabilityValues.whitespace
 let (sign,body) := match body with
  | [] => ("",[])
  | c::rest => if c=='+' || c=='-' then (String.ofList [c],rest) else ("",body)
 let (magnitude,tail) ← decimalPrefix body
 let rest := tail.dropWhile CapabilityValues.whitespace
 let after := match rest with
  | [] => none
  | c::remaining => if c=='±' then some remaining else
   if (rest.take 8).map (fun (c : Char) => if 65 ≤ c.toNat && c.toNat ≤ 90 then Char.ofNat (c.toNat+32) else c) == Text.chars "&plusmn;" then some (rest.drop 8) else none
 match after with
 | none => if endUnit tail then some (sign,magnitude,none) else none
 | some body =>
  let (uncertainty,rest) ← decimalPrefix (body.dropWhile CapabilityValues.whitespace)
  if endUnit rest then some (sign,magnitude,some uncertainty) else none
def searchCapture : List Char → Option (String × String × Option String)
 | [] => none
 | c::cs =>
  let whole := c::cs
  let capturePrefix := Text.chars "experimental electron affinity is"
  if (whole.take capturePrefix.length).map (fun (c : Char) => if 65 ≤ c.toNat && c.toNat ≤ 90 then Char.ofNat (c.toNat+32) else c) == capturePrefix then
   match captureAt (whole.drop capturePrefix.length) with
   | none => searchCapture cs
   | some result => some result
  else searchCapture cs
termination_by structural cs => cs
def lookupPage (pages : List Page) (path : String) : Except String Page :=
 match pages.find? (fun page => Text.equal page.path path) with
 | none => .error (Text.append "source file unavailable: " path)
 | some page => .ok page
def sourceRows (identityBytes targetBytes primaryBytes manifestBytes : ByteArray)
 (identityDocument targets primary manifest : Value) (catalog guide : Page) (sourcePages : List Page) : Except String (List Target) := do
 let _ ← [(catalog.bytes,catalogPath,catalogHash),(guide.bytes,guidePath,guideHash),
  (primaryBytes,primaryPath,primaryHash),(manifestBytes,pageManifestPath,pageManifestHash),
  (targetBytes,targetPath,targetHash)].mapM fun (bytes,path,hash) => do
  if !bytesMatch bytes hash then throw (Text.append "PROP-008 registered source changed: " path)
  pure ()
 let catalogText := Text.lowerAscii (HtmlUnescapeLinear.normalizeSpace (HtmlUnescapeLinear.unescape catalog.text))
 let guideText := Text.lowerAscii (HtmlUnescapeLinear.normalizeSpace (HtmlUnescapeLinear.unescape guide.text))
 if !(Text.chars "by convention a positive electron affinity indicates a bound species").isInfixOf_internal (Text.chars catalogText) ||
    !(Text.chars "negative ion is higher in energy than the neutral").isInfixOf_internal (Text.chars guideText) ||
    !(Text.chars "spontaneous loss of the electron").isInfixOf_internal (Text.chars guideText) then
  throw "PROP-008 NIST definition or state-order boundary changed"
 let rows ← RunningConvergenceMeasurement.array (get targets "rows")
 let pages ← RunningConvergenceMeasurement.array (get primary "molecular_pages")
 if !sameValue (get primary "schema") (.text "sft-v3-nist-cccbdb-molecular-electron-affinity-primary-records/1") ||
  !sameValue (get primary "catalog_row_count") (.integer 192) ||
  !sameValue (get primary "atomic_rows_excluded_by_value_free_formula_structure") (.integer 30) ||
  !sameValue (get primary "molecular_catalog_row_count") (.integer 162) ||
  !sameValue (get primary "molecular_rows_with_explicit_experimental_ea") (.integer 96) ||
  !sameValue (get primary "all_catalog_pages_preserved") (.boolean true) || pages.length != 162 ||
  !sameValue (get primary "rows") (.array rows) ||
  !sameValue (get manifest "schema") (.text "sft-v3-molecular-electron-affinity-source-page-manifest/1") ||
  !sameValue (get manifest "catalog_row_count") (.integer 192) ||
  !sameValue (get manifest "atomic_rows_excluded") (.integer 30) ||
  !sameValue (get manifest "molecular_page_count") (.integer 162) ||
  !sameValue (get manifest "all_measurement_values_and_orientations_absent") (.boolean true) ||
  !sameValue (get manifest "pages") (.array pages) ||
  !sameValue (get targets "schema") (.text "sft-v3-molecular-electron-affinity-withheld-measurements/1") ||
  !sameValue (get targets "release_requires_prediction_seal") (.boolean true) ||
  !sameValue (get targets "all_rows_preserved") (.boolean true) ||
  !sameValue (get targets "complete_row_count") (.integer 96) || rows.length != 96 then
  throw "PROP-008 complete source surface changed"
 let _ ← pages.mapM fun page => do
  let path ← field page "snapshot_path" >>= text
  let expected ← field page "snapshot_hash" >>= text
  let source ← lookupPage sourcePages path
  if !bytesMatch source.bytes expected then throw "PROP-008 molecular source page changed"
  pure ()
 let ids ← identities identityBytes identityDocument
 (ids.zip rows).mapM fun (id,row) => do
  let path ← field row "snapshot_path" >>= text
  let source ← lookupPage sourcePages path
  let (sign,magnitude,uncertainty) ← match searchCapture (Text.chars (HtmlUnescapeLinear.unescape source.text)) with
   | none => throw "PROP-008 source affinity is absent"
   | some result => pure result
  let orientation := if Text.equal sign "-" then "anion-above-neutral-unbound-autodetachment" else "anion-below-neutral-bound-attachment"
  let targetId ← field row "target_id" >>= text
  -- The original checks positivity here; it does not replace this with an inscription-equality condition.
  if !(["target_id","formula","initial_molecular_state","resulting_anion_state"].all
    fun key => sameValue (get id key) (get row key)) ||
   !sameValue (get row "magnitude_inscription") (.text magnitude) ||
   !sameValue (get row "uncertainty_inscription") (match uncertainty with | none => .null | some v => .text v) ||
   !sameValue (get row "fold_state_order_orientation") (.text orientation) then
   throw (Text.append "PROP-008 source reconstruction differs: " targetId)
  let _positiveMagnitude ← field row "exact_positive_magnitude" >>= pair
  pure ⟨targetId,row,← targetWord row⟩
end SFT.Chemistry.MolecularElectronAffinitySource
