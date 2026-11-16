import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.StellarObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
def sourcePath : String := "experiments/external_sources/physics/snapshots/stellar-galactic-tidal-postseal-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/stellar-galactic-tidal-postseal-source-record.json","sha256:37f777d96a7d4844e16f4fbe57ad1fa150882eb097f5426c6e5481d47a713f6c"),("experiments/external_sources/physics/snapshots/nasa-ntrs-20010111092-helioseismology.pdf","sha256:e523f76ba101f8becc7c18e593d9dce2ce999e4393f3efbace74bada0a51e42e"),("experiments/external_sources/physics/snapshots/arxiv-1807.02568-main-sequence-relations.pdf","sha256:38f82514c2bcc9f3732581232d86d0798fb758f84018ddce1ad5e5941a359ff3"),("experiments/external_sources/physics/snapshots/arxiv-1606.09251-sparc.pdf","sha256:d089215877213661e40965543ee7e05736619082ad16d95e65ec059029588c63"),("experiments/external_sources/physics/snapshots/arxiv-1901.05966-baryonic-tully-fisher.pdf","sha256:a35dafd7d01967b64bbd78be5d337c0011f53fe3c3f6e224b32c23a7a7ba4e3f"),("experiments/external_sources/physics/snapshots/arxiv-astro-ph-0608407-bullet-cluster.pdf","sha256:59f2fb580797de5e5007fcea490a0f6c36036364546dbbb6a319a6e2fb5d0209"),("experiments/external_sources/physics/snapshots/nasa-grc-moon-tidal-locking.html","sha256:8591513db27d380612afdf5d4c34e3fa1502fdf89100f745b88a578c49135df4"),("experiments/external_sources/physics/snapshots/nasa-ntrs-20150000346-mercury-resonance.pdf","sha256:836e77ddea47e52734be957e4f41bfcddfc247c8b9beec3a9b0eb900756cfd4e")]
def sourceIds : List String := ["NASA-NTRS-HELIOSEISMOLOGY-2001", "EKER-2018-MAIN-SEQUENCE-RELATIONS", "SPARC-2016-ROTATION-CURVES", "LELLI-2019-BARYONIC-TULLY-FISHER", "CLOWE-2006-BULLET-CLUSTER", "NASA-GRC-MOON-SYNCHRONOUS-ROTATION", "NASA-NTRS-MESSENGER-MERCURY-RESONANCE"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "stellar/galactic/tidal source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-stellar-galactic-tidal-postseal-source-record/1") then throw "stellar/galactic/tidal source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:24674dfa019c208012414ab3c587656ee404512f20d00ab44e26ee137be22ae2") then throw "formal stellar/galactic/tidal receipt binding changed"
 let sources ← array (getDefault record "sources" (.array []))
 if !sameValue (.array (sources.map (fun row=>getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then throw "complete ordered seven-source vector required"
 let boundary := getDefault record "methodological_boundary" (.object [])
 if !ThermometryMeasurement.literalBoolean (getDefault boundary "external_measurement_selected_formal_survivor") false then throw "measurement selected formal survivor"
 if !["all_piecewise_stellar_rows_retained", "central_and_systematic_tully_fisher_results_retained", "mercury_resonance_retained_as_declared_boundary", "model_dependent_solar_value_not_relabelled_as_sft_prediction", "observational_rows_opened_only_after_formal_receipt", "reported_signed_coordinate_not_used_as_fold_proof_scalar"].all (fun key=>ThermometryMeasurement.literalBoolean (getDefault boundary key) true) then throw "stellar/galactic/tidal methodological boundary changed"
 .ok record
end SFT.Physics.StellarObservationRecords
