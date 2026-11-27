import SFT.Chemistry.EliminationAnalysis
namespace SFT.Chemistry.EliminationSource
open SFT.Host EliminationAnalysis
open ConformerPrediction (get equal)
open JointCorrelationTargets (field text)
open ConformerAnalysis (array)
def authorities : List (String × String) := [("audits/CHEMISTRY_ORG_001_016_FAMILY_BOUNDARY_2026-07-27.json","sha256:ccbc91e9873a84f31b50670c9a8f063ee6a6096d3dd216b5e7c3bf86521681b2"),("experiments/external_sources/chemistry/org_001_016_family_source_identity_registry_v1.json","sha256:12c6822a695eb7135081ef8d044a3136c2fee2b0d486c9164b1f1166ef087381"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/source-inventory-v1.json","sha256:d542adb23900f765fcd0205afae8a666813af160881bb70b0676637b090b4acc"),("sft/chemistry/elimination_reaction_law_v1.py","sha256:cf72f096c86839a5010293fad12d70851ff9b55cf972b65348deca2f6b87ca9e"),("experiments/external_sources/chemistry/org_010_target_identities_v1.json","sha256:fffd58022997ba69d30e1cd940fc600465b39d9a7c4cfab993b1799c3302cefe"),("experiments/sealed_predictions/chemistry_org_010_elimination_reaction_pre_source_v1.json","sha256:13869cd3759eea606af331d1aa8468c77f3b1449c41c6c0ac52db757bd702239"),("experiments/external_sources/chemistry/snapshots/org-010-europe-pmc-blind-v1/source-inventory-v1.json","sha256:0d4204dfd4633dbc6ada89cd87cda76813c989f2444490547371d7aca64696de"),("experiments/external_sources/chemistry/snapshots/org-010-europe-pmc-blind-v1/complete-postseal-analysis-v1.json","sha256:157144f86339efa5ddb583d860ef1fd444af6761c3080a82465367544735b89b"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-e02038.json","sha256:99ec6c2aae4b034e06eb5bc91d11c2c3773aefc78819f6406c7efd35bf7ad075"),("tools/capture_chemistry_org_010_blind_sources_v1.py","sha256:e44b7fd29ebe44dbbedcce0010a029a645325520ab619a81c999719b082263b0"),("tools/build_chemistry_org_010_external_v1.py","sha256:41cd2d211f8ee3ab4b5baac104756db0e176bd979f3e4f73e918d5ca8a953184")]
def authority (input : Input) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let authorityMatches := match input.files.find? (fun r => Text.equal r.path path) with
   | none => false
   | some row => row.present && Text.equal row.hash expected
  if !authorityMatches then throw (Text.append "ORG-010 authority changed: " path)
  pure ()
 let fields ← match input.preseal with
  | .object fs => pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "ORG-010 prediction seal changed"
 let unsealed : Canonical.Value := .object (fields.filter fun p => !Text.equal p.1 "sealed_payload_hash")
 if !equal (get input.preseal "sealed_payload_hash") (.text "sha256:c0a9be98e698ea18317d3cf66f431f56c11e38f78d5bb835f4eb4562d9d08c39") ||
  !Text.equal (Canonical.identity unsealed) "sha256:c0a9be98e698ea18317d3cf66f431f56c11e38f78d5bb835f4eb4562d9d08c39" ||
  !equal (get input.preseal "supplementary_archive_product_structures_yields_spectra_or_complete_page_contents_opened_before_this_seal") (.boolean false) ||
  !equal (get input.preseal "external_target_content_used_by_candidate_generator_or_eliminator") (.boolean false) then
  throw "ORG-010 prediction seal changed"
 let products ← field input.analysisDocument "characterized_product_rows_in_source_order" >>= array
 let unsuccessful ← field input.analysisDocument "unsuccessful_substrate_rows" >>= array
 let optimisation ← field input.analysisDocument "optimisation_tables" >>= array
 if products.length != 32 || unsuccessful.length != 5 || optimisation.length != 7 then
  throw "ORG-010 complete external row boundary changed"
 pure ()
end SFT.Chemistry.EliminationSource
