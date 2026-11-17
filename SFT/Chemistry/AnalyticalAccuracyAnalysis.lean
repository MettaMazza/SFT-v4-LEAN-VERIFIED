import SFT.Chemistry.NuclideCarrierAnalysis
import SFT.Chemistry.AnalyticalAccuracySource
namespace SFT.Chemistry.AnalyticalAccuracyAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-ANALYTICAL-ACCURACY-TRUENESS-001"
def targetIds : List String := ["SFT-CHEM-ANAL-001-REFERENCE","SFT-CHEM-ANAL-001-VALUE-PAIRS","SFT-CHEM-ANAL-001-METHODS","SFT-CHEM-ANAL-001-UNCERTAINTY","SFT-CHEM-ANAL-001-BOUNDARY","SFT-CHEM-ANAL-001-STATUS","SFT-CHEM-ANAL-001-ADVERSE-LIMITS","SFT-CHEM-ANAL-001-COMPLETE-SOURCE"]
def authorities : List (String × String) := [("audits/CHEMISTRY_ANAL_001_022_FAMILY_BOUNDARY_2026-07-28.json","sha256:605cddeba92d16b319a24297668554cc206e625f5289cded52577ca887248260"),("experiments/external_sources/chemistry/anal_001_005_family_source_identity_registry_v1.json","sha256:2752bc157bb4529bff6c2c73b96671516e814c12e895ac48758730a2802e7109"),("sft/chemistry/analytical_accuracy_trueness_law_v1.py","sha256:86d1daeb93654ed5317b101dfeec3761c68b3da211b7c650f152762ab4bc2174"),("sft/chemistry/analytical_precision_repeatability_law_v1.py","sha256:2522daf23c7399d89a39d14076c593f75cd583e2e6e6c186217347857fccb13c"),("sft/chemistry/analytical_sensitivity_law_v1.py","sha256:8e7119a19798545ca3a206ca21f7b2d8fb315be68cb38a0cfcc63d180ddc7323"),("sft/chemistry/analytical_detection_quantification_law_v1.py","sha256:638578511ce17aefdf54e5c7c386b801bd21d0d543828edb4296e900873069be"),("sft/chemistry/analytical_selectivity_interference_law_v1.py","sha256:21fe300be303e15a643b45c5463b2c32343f974bb6684b4f5a0dc0a299f7a958"),("experiments/external_sources/chemistry/anal_001_target_identities_v1.json","sha256:daa645e09af87b363dd5d5f53a49fb0dc29e5efb61214e42a652fd72669ad650"),("experiments/external_sources/chemistry/anal_002_target_identities_v1.json","sha256:d37ebb3384350d91c4753f61a310d2df600628fbc1da44b6782be35678969f94"),("experiments/external_sources/chemistry/anal_003_target_identities_v1.json","sha256:c2dbf3fb2fc22dbd7c8665352292ca6b348406b437593f87336558f0905f2324"),("experiments/external_sources/chemistry/anal_004_target_identities_v1.json","sha256:54e57f7e69c34319813ee01e9095f35cce80ec42f25e9e1273410adbfb43f11d"),("experiments/external_sources/chemistry/anal_005_target_identities_v1.json","sha256:af93095c1a99cb3751b279db8e8c107f0c73a88f2e5616edb67fab858097cace"),("experiments/sealed_predictions/chemistry_anal_001_pre_source_v1.json","sha256:955ded74c39ffa1ab805b5cbe462c6c02768acf1101b2946708df85ac438ed03"),("experiments/sealed_predictions/chemistry_anal_002_pre_source_v1.json","sha256:9d7fa5db0e6cc0f3f8485e92bbe9e1e33722dd08743d0fafbf7796ed01003d14"),("experiments/sealed_predictions/chemistry_anal_003_pre_source_v1.json","sha256:293d37ff1ab266cb7636f06115c87213d392cfd6a6d7341d6f222c96c73b91ff"),("experiments/sealed_predictions/chemistry_anal_004_pre_source_v1.json","sha256:9355f073f2f0312d66f9172873199a91ec22b5a82bef7b68d7c01ffe7c7d4be1"),("experiments/sealed_predictions/chemistry_anal_005_pre_source_v1.json","sha256:41f0a6127c39b4dd820d8d1ac3e5bb47fd69fd45068ff04f0e5f316eaa9b204f"),("experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/source-inventory-v1.json","sha256:403aa3330798a75dfb68e606f855238c0b7cc75ac151535484f9597eeed6e6a9"),("experiments/external_sources/chemistry/anal_001_srm1959_certificate_addendum_identity_v1.json","sha256:1ece632f292fa382e3c3e027f0c5f40ddf593519e864241f4576f033f6ddc35c"),("experiments/sealed_predictions/chemistry_anal_001_certificate_addendum_pre_capture_v1.json","sha256:e75404075f3f90b264d929207d63026b0accd26ebfe9271d060ec1a58df2d4ae"),("experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/anal-001-srm1959-certificate-addendum-inventory-v1.json","sha256:340cae8eefd05ccccd6ee08afc1e1d07251de0e1591220fff20af0d1b85efcc7"),("experiments/external_sources/chemistry/snapshots/anal-001-005-performance-v1/complete-postseal-analysis-v1.json","sha256:d64666cd6403b01ca04c69d46d25aabf8cfdb9872fe4cad14b887cbae67032e9"),("tools/seal_chemistry_anal_001_005_predictions_v1.py","sha256:8aaa3a8ef289ad847465eb34e6817cef77aeb88b3b4b06bcc7d2e12ad609f949"),("tools/capture_chemistry_anal_001_005_sources_v1.py","sha256:a5aae0215e1c5209b025dd69475db6165520181d62e0e1beeda9143f2219332d"),("tools/seal_chemistry_anal_001_certificate_addendum_v1.py","sha256:a7877261d786dbad8ae54e39db6a10f47f87f3bc2f5a30dc368c086776634604"),("tools/capture_chemistry_anal_001_certificate_addendum_v1.py","sha256:411599517afcf1275d7ebcf2dfe7431abfa0016cf27ce7b64ef95b41a13fc522"),("tools/build_chemistry_anal_001_005_external_v1.py","sha256:5e32e84fb7d96ee5e55b4efc5dec3485c99a07e7d15ecdfad48e8f3b2d9f7ec5")]
def validateAuthorities (files : List Snapshot) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let bytes ← SFT.Materials.MaterialSource.readSnapshot files path
  if !Text.equal (SFT.Materials.MaterialSource.bytesHash bytes) expected then
   throw (Text.append "ANAL-001–005 authority changed: " path)
 return ()
def verifySurfaces (analysis : Value) (inputs : List SurfaceInput) : Except String (Nat × Nat × Nat) := do
 let sources ← field analysis "complete_source_reconstruction" >>= fields
 let total ← sources.foldlM (fun (total : Nat × Nat × Nat) (_,source) => do
  let path ← field source "snapshot_path" >>= text
  let kind ← field source "media_kind" >>= text
  let input ← match inputs.find? (fun row => Text.equal row.path path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some row => .ok row
  let reconstructed := AnalyticalAccuracySource.surface kind input.pages input.events
  let expected ← field source "complete_surface_vector"
  if !equal (.array reconstructed) expected then throw "complete ANAL-001–005 source reconstruction changed"
  let characters ← reconstructed.foldlM (fun sum row => do
   let n ← field row "character_count" >>= nat
   return sum+n) 0
  return (total.1+(if Text.equal kind "pdf" then reconstructed.length else 0),
   total.2.1+(if Text.equal kind "html" then 1 else 0),total.2.2+characters)) (0,0,0)
 let pages ← field analysis "complete_pdf_page_count" >>= nat
 let htmls ← field analysis "complete_html_document_count" >>= nat
 let chars ← field analysis "complete_extracted_character_count" >>= nat
 if total != (83,1,180366) || total != (pages,htmls,chars) then throw "complete ANAL-001–005 source surface changed"
 return total
def accuracyChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let certified ← field row "certified_row_count" >>= nat
 let reference ← if certified==6 then field row "reference_noncertified_row_count" >>= nat else pure 0
 let values ← field row "complete_certified_and_reference_value_vector" >>= array
 let paired ← if values.length==7 then do
  let first ← ConjugatedSupportAnalysis.valueAt values 0
  let firstText ← field first "mass_concentration_ng_mL" >>= text
  if !Text.equal firstText "1033 ± 97" then pure false else do
   let last ← ConjugatedSupportAnalysis.valueAt values (values.length-1)
   pure (Text.equal (← field last "mass_concentration_ng_mL" >>= text) "1008 ± 103")
  else pure false
 let methods ← field row "method_vector" >>= array
 let factor ← field row "coverage_factor" >>= text
 let uncertainty ← if Text.equal factor "2.1" then do
  pure (Text.equal (← field row "coverage_probability" >>= text) "approximately 95%") else pure false
 let temperature ← field row "use_temperature_C" >>= text
 let boundary ← if Text.equal temperature "20 to 25" then do
  pure (Text.equal (← field row "serum_density_g_mL" >>= text) "1.025") else pure false
 let issued ← field row "certificate_issue_date" >>= text
 let status ← if Text.equal issued "21 March 2011" then do
  pure (Text.equal (← field row "certificate_expiry" >>= text) "01 October 2015") else pure false
 let last ← ConjugatedSupportAnalysis.valueAt values (values.length-1)
 let lastStatus ← field last "status" >>= text
 let adverse ← if Text.equal lastStatus "reference_noncertified" then
  field row "complete_accuracy_use_and_storage_limits_retained" >>= bool else pure false
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-ANAL-001-REFERENCE",certified==6 && reference==1),
 ("SFT-CHEM-ANAL-001-VALUE-PAIRS",paired),("SFT-CHEM-ANAL-001-METHODS",methods.length==3),
 ("SFT-CHEM-ANAL-001-UNCERTAINTY",uncertainty),("SFT-CHEM-ANAL-001-BOUNDARY",boundary),
 ("SFT-CHEM-ANAL-001-STATUS",status),("SFT-CHEM-ANAL-001-ADVERSE-LIMITS",adverse),
 ("SFT-CHEM-ANAL-001-COMPLETE-SOURCE",sourceCount==6)]
def exactAccuracyAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "ANAL-001–005 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "anal_001"
 let fullChecks ← accuracyChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let values ← field row "complete_certified_and_reference_value_vector" >>= array
 let masses ← values.mapM (fun x => field x "mass_concentration_ng_mL")
 let summary : Value := .object [("certified_value_rows",.integer 6),("reference_noncertified_rows",.integer 1),
 ("mass_concentration_vector",.array masses),("coverage_factor",.text "2.1"),("certificate_status",.text "expired archived measured record"),
 ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
 ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
 ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.AnalyticalAccuracyAnalysis
