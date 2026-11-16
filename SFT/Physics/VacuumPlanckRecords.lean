import SFT.Physics.FizeauRecords
namespace SFT.Physics.VacuumPlanckRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourcePath : String := "experiments/external_sources/physics/snapshots/vacuum-density-planck-postseal-source-record.json"
def sourceHash : String := "sha256:a0c8d15b9ab666329943cac4d5899ff5617871d1e1d9d6f60e5d4dd22eed4652"
def pdfPath : String := "experiments/external_sources/physics/snapshots/planck-baseline-params-2018-68pc-v2.pdf"
def pdfHash : String := "sha256:03038805021f2f894e09f4b21b0f20418570e352822f095abcc085942919da70"
def codataPath : String := "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"
def codataHash : String := "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"
def sourceIds : List String := ["PLANCK-PLA-BASE-NRUN-TTTEEE-BAO-LENSING-68PC", "NIST-CODATA-2022-EXACT-C"]
def sourceHashes : List (String × String) := [(sourcePath,sourceHash),(pdfPath,pdfHash),(codataPath,codataHash)]
def expectedTarget : List (String × Value) := [("planck_hubble_central_km_s_mpc",.text "67.68"),("planck_hubble_standard_uncertainty_km_s_mpc",.text "0.42"),("planck_vacuum_fraction_central",.text "0.6889"),("planck_vacuum_fraction_standard_uncertainty",.text "0.0056"),("planck_matter_fraction_central",.text "0.3111"),("planck_matter_fraction_standard_uncertainty",.text "0.0056"),("codata_speed_km_s",.text "299792.458"),("planck_page",.integer 225)]
def requiredCustody : List String := ["formal_receipt_precedes_primary_pdf_retrieval", "target_inaccessible_to_formal_executable", "target_did_not_rewrite_formal_survivor", "complete_uncertainty_rows_retained", "local_floor_and_global_fraction_kept_separate", "dimensional_transport_uses_held_external_references_only", "unfavorable_type_control_retained"]
def payloadBoundary (record : Value) : Except String Value := do
 if !sameValue (getDefault record "schema") (.text "sft-v3-vacuum-density-planck-postseal-source-record/1") then throw "vacuum-density source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:c7b4777b12fc70628b0fd9a2f7d957274b61ede7f3624a665781364c8c9f7723") then throw "formal vacuum receipt binding changed"
 let sources := getDefault record "sources" (.array [])
 let count ← FizeauRecords.recordLength sources
 if count != 2 then throw "complete Planck/CODATA source pair is required"
 let rows ← array sources
 let pair ← match rows with
  | [] => throw "complete Planck/CODATA source pair is required"
  | p::rest => match rest with
   | [] => throw "complete Planck/CODATA source pair is required"
   | c::tail => match tail with
    | [] => pure (p,c)
    | _::_ => throw "complete Planck/CODATA source pair is required"
 let planck := pair.1
 let codata := pair.2
 if !sameValue (getDefault planck "snapshot_hash") (.text pdfHash) || !sameValue (getDefault planck "source_page") (.integer 225) then throw "Planck primary-table binding changed"
 if !sameValue (getDefault codata "snapshot_hash") (.text codataHash) then throw "CODATA speed binding changed"
 let target := getDefault record "registered_target" (.object [])
 if !expectedTarget.all (fun (k,v) => sameValue (getDefault target k) v) then throw "Planck/CODATA target row changed"
 if !sameValue (getDefault target "all_registered_rows_retained") (.boolean true) ||
  !sameValue (getDefault target "older_hubble_transcription_corrected_without_rewriting_prior_receipts") (.boolean true) then throw "Planck correction or row-retention control changed"
 let custody := getDefault record "row_custody" (.object [])
 if !requiredCustody.all (fun k => sameValue (getDefault custody k) (.boolean true)) then throw "Planck/CODATA custody record changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "vacuum-density source identity changed: " relative)
  pure ())
 payloadBoundary payload
end SFT.Physics.VacuumPlanckRecords
