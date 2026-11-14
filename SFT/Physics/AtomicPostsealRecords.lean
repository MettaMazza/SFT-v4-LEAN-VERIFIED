import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.AtomicPostsealRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def sourceHash : String := "sha256:64fb03e6758e3274d33c6e15682b5739adfa7cf097453892d57248a98e6d12c3"
def componentHashes : List (String × String) := [("NIST-NCNR-DCS-SUPERFLUID-HELIUM","sha256:ab723f91d6658bd8b5d19889884fd87e07046d2b0060e23f7df8d7cb6c35fa5b"),("NIST-ASD-HYDROGEN-ATOMIC-DATA","sha256:cc54c774518d62cbb7e95f17b3b7fcd9d1faf0aa90043a607b91dff0a43e2087"),("NIST-KRAMIDA-HYDROGEN-CRITICAL-COMPILATION-2010-2019","sha256:86ccaeb875fcdb4445e727618509621ceee656e5dc02295140ecdb6e1d2dd443"),("NIST-WEBBOOK-SRD69-H2-DIATOMIC-CONSTANTS","sha256:18036a188088f880122249544ceb6b384fabfba93b300b4f9f0fa01aa0ed9b24")]
def sourceId (row : Value) : Value := (field row "source_id").toOption.getD .null
def sourceById (rows : List Value) (key : String) : Except String Value :=
 match rows.reverse.find? (fun row => sameValue (sourceId row) (.text key)) with
 | none => .error (Text.append "missing source: " key)
 | some row => .ok row
def payloadBoundary (payload : Value) : Except String Value := do
 if !sameValue ((field payload "schema").toOption.getD .null) (.text "sft-v3-atomic-spectra-postseal-source-record/1") then
  throw "atomic-spectrum source schema changed"
 let custody := (field payload "custody").toOption.getD .null
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "atomic-spectrum custody disclosure is incomplete"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "atomic-spectrum custody disclosure is incomplete"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "atomic-spectrum custody disclosure is incomplete"
 if !sameValue ((field custody "complete_reported_uncertainties_retained").toOption.getD .null) (.boolean true) then throw "atomic-spectrum custody disclosure is incomplete"
 if !sameValue ((field custody "unfavorable_molecular_ratio_retained").toOption.getD .null) (.boolean true) then throw "atomic-spectrum custody disclosure is incomplete"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "formal atomic relation improperly contains a measurement"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "measurement improperly selects a formal atomic survivor"
 let sources ← (do array (← field payload "sources")).mapError (fun _ => "atomic-spectrum source vector is incomplete")
 if sources.length != componentHashes.length then throw "atomic-spectrum source vector is incomplete"
 if !(componentHashes.all (fun pair => sources.any (fun row => sameValue (sourceId row) (.text pair.1)))) then
  throw "atomic-spectrum source identities changed"
 pure payload

def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "atomic-spectrum source record differs from registration"
 let record ← payloadBoundary payload
 let sources ← array (← field record "sources")
 let _ ← componentHashes.foldlM (fun (_ : Unit) pair => do
  let row ← sourceById sources pair.1
  if !sameValue ((field row "snapshot_hash").toOption.getD .null) (.text pair.2) then
   throw (Text.append "registered source hash changed: " pair.1)
  let path ← text (← field row "snapshot_path")
  let bytes ← match files.find? (fun p => Text.equal p.1 path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some p => .ok p.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) pair.2 then
   throw (Text.append "source snapshot differs from its registered hash: " pair.1)
  pure ()) ()
 pure record

def reportedRow (record : Value) (key : String) : Except String Value := do
 field (← sourceById (← array (← field record "sources")) key) "reported_record"
def registeredRecord : Value := .object [("schema",.text "sft-v3-atomic-spectra-postseal-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("development_targets_already_known",.boolean true),("classification",.text "observational_derivation"),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("complete_reported_uncertainties_retained",.boolean true),("unfavorable_molecular_ratio_retained",.boolean true)]),("sources",.array [.object [("source_id",.text "NIST-NCNR-DCS-SUPERFLUID-HELIUM"),("body",.text "National Institute of Standards and Technology, NIST Center for Neutron Research"),("source_uri",.text "https://www.nist.gov/document/dcs"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-simple-cubic-neighbours.pdf"),("snapshot_hash",.text "sha256:ab723f91d6658bd8b5d19889884fd87e07046d2b0060e23f7df8d7cb6c35fa5b"),("locator",.text "PDF page 10, nearest-neighbour packing comparison"),("reported_record",.object [("simple_cubic_nearest_neighbours",.integer (6))])],.object [("source_id",.text "NIST-ASD-HYDROGEN-ATOMIC-DATA"),("body",.text "National Institute of Standards and Technology, Atomic Spectra Database"),("source_uri",.text "https://physics.nist.gov/PhysRefData/Handbook/Tables/hydrogentable1.htm"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-hydrogen-atomic-data.html"),("snapshot_hash",.text "sha256:cc54c774518d62cbb7e95f17b3b7fcd9d1faf0aa90043a607b91dff0a43e2087"),("locator",.text "H I ground-state ionization-energy row"),("reported_record",.object [("hydrogen_ionization_wavenumber_cm_inverse",.text "109678.7717")])],.object [("source_id",.text "NIST-KRAMIDA-HYDROGEN-CRITICAL-COMPILATION-2010-2019"),("body",.text "National Institute of Standards and Technology, Atomic Physics Division"),("source_uri",.text "https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=842564"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-hydrogen-critical-compilation.pdf"),("snapshot_hash",.text "sha256:86ccaeb875fcdb4445e727618509621ceee656e5dc02295140ecdb6e1d2dd443"),("locator",.text "Table 11, Lyman n=2 observed wavenumber; Table 10, Balmer 2-3 observed wavenumber"),("reported_record",.object [("lyman_alpha_observed_wavenumber_cm_inverse",.text "82259.16"),("lyman_alpha_uncertainty_cm_inverse",.text "0.14"),("balmer_alpha_observed_wavenumber_cm_inverse",.text "15233.21"),("balmer_alpha_uncertainty_cm_inverse",.text "0.07")])],.object [("source_id",.text "NIST-WEBBOOK-SRD69-H2-DIATOMIC-CONSTANTS"),("body",.text "National Institute of Standards and Technology, Chemistry WebBook SRD 69"),("source_uri",.text "https://webbook.nist.gov/cgi/cbook.cgi?ID=C1333740&Mask=1828"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-webbook-h2-diatomic-constants.html"),("snapshot_hash",.text "sha256:18036a188088f880122249544ceb6b384fabfba93b300b4f9f0fa01aa0ed9b24"),("locator",.text "Constants of diatomic molecules, H2 X ground state and B excited state rows"),("reported_record",.object [("electronic_state_energy_cm_inverse",.text "91700.0"),("ground_vibrational_constant_cm_inverse",.text "4401.213"),("ground_rotational_constant_cm_inverse",.text "60.8530")])]]),("registered_results",.object [("cubic_support",.text "The formal six-neighbour result agrees exactly with the NIST simple-cubic packing row."),("hydrogen_gross_ratios",.text "Using the NIST hydrogen ionization wavenumber only as the dimensionful input carrier, the sealed exact ratios three-quarters and five-thirty-sixths predict intervals overlapping the complete reported Lyman-alpha and Balmer-alpha intervals."),("molecular_hierarchy",.text "The NIST H2 values confirm electronic above vibrational above rotational scales but reject a universal equality of rotational and vibrational quarter-supports or a universal two-to-one electronic/molecular numerical ratio; the leading formal receipt is retained and a versioned successor is mandatory.")]),("validation_boundary",.text "All source values are external observation records. They never enter the formal atomic candidate censuses. Comparison execution receives only the registered input carrier and sealed Fold ratios; withheld line targets and the unfavorable molecular ratio are released after the prediction seal.")]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.AtomicPostsealRecords
