import SFT.Chemistry.NuclideCarrierAnalysis
namespace SFT.Chemistry.RadiochemicalAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-RADIOCHEMICAL-EQUILIBRIUM-005"
def targetIds : List String := ["SFT-CHEM-NUCHEM-005-PARENT-DAUGHTER","SFT-CHEM-NUCHEM-005-TIME-SUPPORT","SFT-CHEM-NUCHEM-005-ACTIVITY","SFT-CHEM-NUCHEM-005-RATIO-REGIME","SFT-CHEM-NUCHEM-005-TRANSIENT","SFT-CHEM-NUCHEM-005-SECULAR","SFT-CHEM-NUCHEM-005-ADVERSE-METHODS","SFT-CHEM-NUCHEM-005-COMPLETE-SOURCES"]
def authorities : List (String × String) := [("audits/CHEMISTRY_NUCHEM_001_012_FAMILY_BOUNDARY_2026-07-28.json","sha256:77cefa7bb8a338c3b0e2de615ee7335c7c18c680423c58ecf336a5420bc4109f"),("experiments/external_sources/chemistry/nuchem_001_012_family_source_identity_registry_v1.json","sha256:9dcc65c3ac597ba67453fe6e7b10b3b33903f7a1d4732081dde8aac7041395d9"),("experiments/external_sources/chemistry/nuchem_005_008_family_source_identity_registry_v1.json","sha256:19b2874fb1bf1300e9f6b60d1e76fe4f32fd00f02a660c9cf35f7dd889ade77b"),("sft/chemistry/radiochemical_equilibrium_law_v1.py","sha256:517914e1953e8bde79ec94c56001ebd78008fdf84fa0227896d58e1914048a69"),("sft/chemistry/isotope_exchange_law_v1.py","sha256:8020c83a3cd234074d80695493dd9b615671030fce80bead491fbc26a03a81d4"),("sft/chemistry/equilibrium_isotope_fractionation_law_v1.py","sha256:b5df27ccdcce7c48864b69d26837f5c34586faab26a0325f9b2d83ddd887eccd"),("sft/chemistry/kinetic_isotope_fractionation_law_v1.py","sha256:7ee759e8694ce914142c47d0b3b648771090119b81a0a951ed796cdc5ee3d331"),("experiments/external_sources/chemistry/nuchem_005_target_identities_v1.json","sha256:5aa52d065525eb8f6fad00e7ace2b09b2c73b66216659bc9d0a2918d93791487"),("experiments/external_sources/chemistry/nuchem_006_target_identities_v1.json","sha256:9ebf33adb3d143519029025bc31b2a7d5a8a9fff6b691457abe2c039844b81b6"),("experiments/external_sources/chemistry/nuchem_007_target_identities_v1.json","sha256:98fbc69aba91a79c974cd49824febdf8f2c36d76d00e9b75cb75d16498f6a216"),("experiments/external_sources/chemistry/nuchem_008_target_identities_v1.json","sha256:94a2706d5a1b8a3fcdb69036b4cfb8b1a675acb811c50fbbb74301384f951b99"),("experiments/sealed_predictions/chemistry_nuchem_005_pre_source_v1.json","sha256:9436a1000ff1efdf8b2f934f9f44024e5fd8862da321ab2182f96fccd0d95a91"),("experiments/sealed_predictions/chemistry_nuchem_006_pre_source_v1.json","sha256:bcd18bde92a7ee35b3541a0d83ed3ac3cb54c323dd26482d7d3f1bf76f7ea5f8"),("experiments/sealed_predictions/chemistry_nuchem_007_pre_source_v1.json","sha256:0733d1926431ed8e6f875f13f9fa6a81eee6b509e565c97f5d4491ad6d891944"),("experiments/sealed_predictions/chemistry_nuchem_008_pre_source_v1.json","sha256:938778dff4ddcc3896f0e4e3be91c878fa346bca3fe51f63f3a8b2c0ae53af1a"),("experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/source-inventory-v1.json","sha256:bd9cc53f97b20a2d92bc26ab28ce2f5eefb71e6b3ee1f02bf840214adaccdaee"),("experiments/external_sources/chemistry/snapshots/nuchem-005-008-isotope-v1/complete-postseal-analysis-v1.json","sha256:fdadea49308fe7ee400c77ffb2573a3ff436a4cac19d68f0dea633e922019527"),("tools/seal_chemistry_nuchem_005_008_predictions_v1.py","sha256:d9bf2aee533a522ee16737937fb6c44cfb7a566a467902df13c3285aec703207"),("tools/capture_chemistry_nuchem_005_008_sources_v1.py","sha256:2ad6dfabff175e1d6f7f9ee97ce18805f1678d0063806802196e653be2f5bfd0"),("tools/build_chemistry_nuchem_005_008_external_v1.py","sha256:48b3b1673a00035e6cfdc6b29b5d4c9bb03dcf7c16be61d6302f640fb54f56a3")]
def validateAuthorities (files : List Snapshot) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let bytes ← SFT.Materials.MaterialSource.readSnapshot files path
  if !Text.equal (SFT.Materials.MaterialSource.bytesHash bytes) expected then
   throw (Text.append "NUCHEM-005–008 authority changed: " path)
 return ()
def verifySurfaces (analysis : J) (inputs : List SurfaceInput) : Except String (Nat × Nat × Nat) := do
 let sources ← field analysis "complete_source_reconstruction" >>= fields
 let total ← sources.foldlM (fun (total : Nat × Nat × Nat) (_,source) => do
  let path ← field source "snapshot_path" >>= text
  let kind ← field source "surface_kind" >>= text
  let input ← match inputs.find? (fun row => Text.equal row.path path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some row => .ok row
  let reconstructed := NuclideCarrierSurface.surface kind input.pages input.events
  let expected ← field source "complete_surface_vector"
  if !equal (.array reconstructed) expected then throw "complete NUCHEM-005–008 source reconstruction changed"
  let characters ← reconstructed.foldlM (fun sum row => do
   let n ← field row "character_count" >>= nat
   return sum+n) 0
  if Text.equal kind "pdf" then return (total.1+reconstructed.length,total.2.1,total.2.2+characters)
  else return (total.1,total.2.1+reconstructed.length,total.2.2+characters)) (0,0,0)
 let p ← field analysis "complete_pdf_page_count" >>= nat
 let d ← field analysis "complete_html_document_count" >>= nat
 let c ← field analysis "complete_extracted_character_count" >>= nat
 if total.1!=266 || total.2.1!=1 || total.2.2!=410095 || total.1!=p || total.2.1!=d || total.2.2!=c then
  throw "complete NUCHEM-005–008 source surface changed"
 return total

def radiochemicalChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let parentDaughters ← field row "complete_parent_daughter_vectors" >>= array
 let times ← field row "complete_reference_time_vector" >>= array
 let activities ← field row "certified_activity_vector" >>= array
 let first ← ConjugatedSupportAnalysis.valueAt activities 0 >>= fun x => field x "value" >>= text
 let second ← ConjugatedSupportAnalysis.valueAt activities 1 >>= fun x => field x "value" >>= text
 let regimes ← field row "equilibrium_records" >>= array
 let secondPair ← ConjugatedSupportAnalysis.valueAt parentDaughters 1 >>= array
 let progeny ← ConjugatedSupportAnalysis.valueAt secondPair 1 >>= text
 let secular ← ConjugatedSupportAnalysis.valueAt regimes 0 >>= text
 let retained ← field row "all_assumptions_uncertainties_corrections_confirmations_and_unavailable_rows_retained" >>= bool
 let unavailable ← field row "transient_or_secular_numeric_time_series_in_registered_sources" >>= text
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-005-PARENT-DAUGHTER",parentDaughters.length==2),
 ("SFT-CHEM-NUCHEM-005-TIME-SUPPORT",times.length==2),
 ("SFT-CHEM-NUCHEM-005-ACTIVITY",Text.equal first "29.492" && Text.equal second "26.30"),
 ("SFT-CHEM-NUCHEM-005-RATIO-REGIME",regimes.length==2),
 ("SFT-CHEM-NUCHEM-005-TRANSIENT",Text.contains progeny "complete retained progeny"),
 ("SFT-CHEM-NUCHEM-005-SECULAR",Text.contains secular "radioactive equilibrium"),
 ("SFT-CHEM-NUCHEM-005-ADVERSE-METHODS",retained && (Text.chars "unavailable").isPrefixOf (Text.chars unavailable)),
 ("SFT-CHEM-NUCHEM-005-COMPLETE-SOURCES",sourceCount==5)]
def exactRadiochemicalAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-005–008 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_005"
 let fullChecks ← radiochemicalChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("equilibrium_records",.integer 2),("certified_activity_rows",.integer 2),
  ("numeric_regime_time_series",.text "unavailable__preserved_not_fabricated"),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
  ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.RadiochemicalAnalysis
