import SFT.Chemistry.NuclideCarrierSurface
import SFT.Chemistry.ConjugatedSupportAnalysis
import SFT.Materials.MaterialSource
namespace SFT.Chemistry.NuclideCarrierAnalysis
open SFT.Host SFT.Host.Canonical
abbrev Snapshot := SFT.Materials.MaterialSource.Snapshot
abbrev field := ConjugatedSupportAnalysis.field
abbrev array := ConjugatedSupportAnalysis.array
abbrev J := Canonical.Value
structure SurfaceInput where
 path : String
 pages : List (Option String)
 events : List NuclideCarrierSurface.Event
def authorities : List (String × String) := [("audits/CHEMISTRY_NUCHEM_001_012_FAMILY_BOUNDARY_2026-07-28.json","sha256:77cefa7bb8a338c3b0e2de615ee7335c7c18c680423c58ecf336a5420bc4109f"),("experiments/external_sources/chemistry/nuchem_001_012_family_source_identity_registry_v1.json","sha256:9dcc65c3ac597ba67453fe6e7b10b3b33903f7a1d4732081dde8aac7041395d9"),("sft/chemistry/nuclide_chemical_carrier_law_v1.py","sha256:5b1cba279810bdd761987c7970c717a881142d20a173320131bb07f29e4dc95b"),("sft/chemistry/radioactive_chemical_transformation_law_v1.py","sha256:4484c0c4efdef922aabd3fa14b9b74756305dfb03c6b3d884d96f661dd5ffd95"),("sft/chemistry/activity_amount_time_law_v1.py","sha256:186a95d558ac63e883b8af7b60c6c1780fcfb7b042bcfc264d73050ce22f96bd"),("sft/chemistry/radioactive_branching_yield_law_v1.py","sha256:163218db86c3cbdf11e55babcbcc5a982a3376a4841957f6c6ee05f2dd5ef52c"),("experiments/external_sources/chemistry/nuchem_001_target_identities_v1.json","sha256:4ca08fe787a69f03c55002905d835c0dcf012a7b8ff31935430693db2cc3f263"),("experiments/external_sources/chemistry/nuchem_002_target_identities_v1.json","sha256:a9e98d3078a684b6fcad2c64ad764da4f6202bb9a9f8a77d3369479821315b26"),("experiments/external_sources/chemistry/nuchem_003_target_identities_v1.json","sha256:7f2dbaba26aea9d499aae35ce29a8217e2fdb7c4ef8c60a9d5f4cc453176aa0d"),("experiments/external_sources/chemistry/nuchem_004_target_identities_v1.json","sha256:cb85154e9f9cbd381cd7824c57e63364117df291dc7f3148bcb507a15c9a8787"),("experiments/sealed_predictions/chemistry_nuchem_001_pre_source_v1.json","sha256:e6a292d3ea5d8b3afe46e66d65bcdfae056ea40c508ee0bd787794c562bc7104"),("experiments/sealed_predictions/chemistry_nuchem_002_pre_source_v1.json","sha256:3c3ede4d5d1f516a99e364b51e9462dd86214f5b640ee0008da3558102e39454"),("experiments/sealed_predictions/chemistry_nuchem_003_pre_source_v1.json","sha256:c16ac68db0ccb2c18515a007a756eac46595b8cbebe6078a1e16be23572ff9d3"),("experiments/sealed_predictions/chemistry_nuchem_004_pre_source_v1.json","sha256:3c03263c9c780e0888d90e0a4519726640dd9eb9f8ed1084bbc85ed590861ae0"),("experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/source-inventory-v1.json","sha256:c225880187ffd2839a2dc549b5d5466e91d650e4bc68373dd7674a18df34dc52"),("experiments/external_sources/chemistry/snapshots/nuchem-001-004-radioactivity-v1/complete-postseal-analysis-v1.json","sha256:ce2bd2582090dd694dc3ccfe3bd50fec5987fe361609be52282a28f0f530b474"),("tools/seal_chemistry_nuchem_001_004_predictions_v1.py","sha256:6845f016fafb3b3e71b1b2acb46dd9bd74828c0c644dce6d807b1997cd19e300"),("tools/capture_chemistry_nuchem_001_004_sources_v1.py","sha256:e1f689e44b5755ecd4217033f98734a223ccc545de1a212d278fd54e165b0864"),("tools/build_chemistry_nuchem_001_004_external_v1.py","sha256:76a20c053c17292d27cf4d547a998fa3f9e0058ac3234400d978d322321a9e08")]
def targetIds : List String := ["SFT-CHEM-NUCHEM-001-ELEMENT","SFT-CHEM-NUCHEM-001-NUCLIDE","SFT-CHEM-NUCHEM-001-STATE","SFT-CHEM-NUCHEM-001-SPECIES","SFT-CHEM-NUCHEM-001-PHASE","SFT-CHEM-NUCHEM-001-AMOUNT","SFT-CHEM-NUCHEM-001-UNCERTAINTY","SFT-CHEM-NUCHEM-001-COMPLETE-SOURCES"]
def claimId : String := "SFT-CHEM-NUCLEAR-CHEMICAL-CARRIER-001"
def text : J → Except String String
 | .text s => .ok s
 | .null | .boolean _ | .integer _ | .array _ | .object _ => .error "source text expected"
def nat : J → Except String Nat
 | .integer (.ofNat n) => .ok n
 | .integer (.negSucc _) | .null | .boolean _ | .text _ | .array _ | .object _ => .error "source count expected"
def bool : J → Except String Bool
 | .boolean b => .ok b
 | .null | .text _ | .integer _ | .array _ | .object _ => .error "source truth value expected"
def fields : J → Except String (List (String × J))
 | .object fs => .ok fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => .error "source object expected"
def equal (a b : J) : Bool := Text.equal (Canonical.render a) (Canonical.render b)
def validateAuthorities (files : List Snapshot) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let bytes ← SFT.Materials.MaterialSource.readSnapshot files path
  if !Text.equal (SFT.Materials.MaterialSource.bytesHash bytes) expected then
   throw (Text.append "NUCHEM-001–004 authority changed: " path)
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
  if !equal (.array reconstructed) expected then throw "complete NUCHEM-001–004 source reconstruction changed"
  let characters ← reconstructed.foldlM (fun sum row => do
   let n ← field row "character_count" >>= nat
   return sum+n) 0
  if Text.equal kind "pdf" then return (total.1+reconstructed.length,total.2.1,total.2.2+characters)
  else return (total.1,total.2.1+reconstructed.length,total.2.2+characters)) (0,0,0)
 let p ← field analysis "complete_pdf_page_count" >>= nat
 let d ← field analysis "complete_html_document_count" >>= nat
 let c ← field analysis "complete_extracted_character_count" >>= nat
 if total.1!=8 || total.2.1!=2 || total.2.2!=34442 || total.1!=p || total.2.1!=d || total.2.2!=c then
  throw "complete NUCHEM-001–004 source surface changed"
 return total

def carrierChecks (row : J) : Except String (List (String × Bool)) := do
 let element ← field row "element_identity_surface" >>= text
 let nuclides ← field row "complete_nuclide_identity_vector" >>= array
 let state ← field row "nuclear_state_custody" >>= text
 let species ← field row "chemical_carrier" >>= text
 let phases ← field row "complete_phase_matrix_vector" >>= array
 let amounts ← field row "amount_forms" >>= array
 let activity ← field row "certified_massic_activity" >>= fun x => field x "value"
 let uncertainties ← field row "complete_uncertainty_vector" >>= array
 let complete ← field row "complete_registered_source_surface_retained" >>= bool
 return [("SFT-CHEM-NUCHEM-001-ELEMENT",Text.contains element "elements 1 through 112"),
  ("SFT-CHEM-NUCHEM-001-NUCLIDE",nuclides.any (ConjugatedSupportAnalysis.isText · "90Sr") && nuclides.any (ConjugatedSupportAnalysis.isText · "90Y")),
  ("SFT-CHEM-NUCHEM-001-STATE",(Text.chars "state inferred").reverse.isPrefixOf (Text.chars state).reverse),
  ("SFT-CHEM-NUCHEM-001-SPECIES",Text.contains species "standardized 90Sr solution"),
  ("SFT-CHEM-NUCHEM-001-PHASE",phases.length==4),("SFT-CHEM-NUCHEM-001-AMOUNT",amounts.length==4),
  ("SFT-CHEM-NUCHEM-001-UNCERTAINTY",ConjugatedSupportAnalysis.isText activity "29.492" && uncertainties.length==12),
  ("SFT-CHEM-NUCHEM-001-COMPLETE-SOURCES",complete)]
def exactCarrierAnalysis (analysis : J) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (J × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Canonical.Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-001–004 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_001"
 let fullChecks ← carrierChecks row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Canonical.Value.text)) (.array (targetIds.map Canonical.Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let nuclides ← field row "complete_nuclide_identity_vector" >>= array
 let summary := Canonical.Value.object [("complete_nuclide_rows",.integer (.ofNat nuclides.length)),
  ("sr90_massic_activity_kBq_per_g",.text "29.492 ± 0.088"),("uncertainty_rows",.integer 12),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
  ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.NuclideCarrierAnalysis
