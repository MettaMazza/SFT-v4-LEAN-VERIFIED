import SFT.Chemistry.RearrangementAnalysis
namespace SFT.Chemistry.RearrangementSource
open SFT.Host RearrangementAnalysis
open ConformerPrediction (get equal)
open JointCorrelationTargets (field text)
open ConformerAnalysis (array)
def authorities : List (String × String) := [("audits/CHEMISTRY_ORG_001_016_FAMILY_BOUNDARY_2026-07-27.json","sha256:ccbc91e9873a84f31b50670c9a8f063ee6a6096d3dd216b5e7c3bf86521681b2"),("experiments/external_sources/chemistry/org_001_016_family_source_identity_registry_v1.json","sha256:12c6822a695eb7135081ef8d044a3136c2fee2b0d486c9164b1f1166ef087381"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/source-inventory-v1.json","sha256:d542adb23900f765fcd0205afae8a666813af160881bb70b0676637b090b4acc"),("sft/chemistry/rearrangement_reaction_law_v1.py","sha256:9e06ff8f7e720ef9efb6b79db6c501d8b01d04506744b84362c7b614c0d9ce3a"),("experiments/external_sources/chemistry/org_011_target_identities_v1.json","sha256:7fe944b94b3796a55124388d9ef4228df5e0aca1daf45d5c10c7b87ca1b54490"),("experiments/external_sources/chemistry/org_011_target_identities_v2.json","sha256:8ce3b0650526f9b3ce6fa66694e44e5771c41fe02447fd12b82b7270f364728d"),("experiments/sealed_predictions/chemistry_org_011_rearrangement_reaction_pre_source_v1.json","sha256:261ca2fed579e3a02906c04edf3c7e44fd5c752ecf6abfb3b24f08945e682b1c"),("experiments/sealed_predictions/chemistry_org_011_rearrangement_reaction_pre_source_v2.json","sha256:6808f37f9cf1faa657e5f5a5c65483f6b8585aa35bd0fd229774165ed1691c7c"),("experiments/external_sources/chemistry/snapshots/org-011-europe-pmc-blind-v1/source-inventory-v1.json","sha256:5613c4057adf9c3d7d7d09ebbd3d7e06bc24bf9ff8e575132c2c20b39569879b"),("experiments/external_sources/chemistry/snapshots/org-011-europe-pmc-blind-v1/complete-postseal-analysis-v1.json","sha256:ac22ce665f1b93617b07705518b499ef233c1a8e22122bd27a6768180dfbe031"),("experiments/external_sources/chemistry/snapshots/org-011-claisen-blind-v2/source-inventory-v2.json","sha256:7a66799333f95fe3ae35f060d2b7f1e81a01d4a41112d4dd159f6a513a66f11c"),("experiments/external_sources/chemistry/snapshots/org-011-claisen-blind-v2/acs-figshare-s001-record-v2.json","sha256:6bdf4f6b04d7521ec68674d32852ba0f743603382273ed4431b0251a6119655a"),("experiments/external_sources/chemistry/snapshots/org-011-claisen-blind-v2/complete-postseal-analysis-v2.json","sha256:2e200b570d0a407ef960fc02e0cd203d73f970af0c666fe5478f930385ef1a27"),("experiments/external_sources/chemistry/snapshots/org-011-claisen-blind-v2/ja803370x_si_001.pdf","sha256:c4720e6f02dfe930c2b0b45630e8b6a8f15b95108f0285fcfc35e30a0a0d9ca3"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-m03997.json","sha256:55614e4895882e0d0405d675ffce95f09fffbf30f0f001e071b138655a3ccedd"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-r05194.html","sha256:420b101c1f21ba8055e107379491a899067479c12002a6ae0707016eeadde0ba"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-r05196.json","sha256:70da8c9927572e8c39fec4b69fb711b7ebdc5581b275dd310a46fd3a3551d17c"),("tools/capture_chemistry_org_011_blind_sources_v1.py","sha256:62a787e014d470255a0c8059ba35b427c710969aeccd9251cb8eb8676c0b925a"),("tools/build_chemistry_org_011_external_v1.py","sha256:21cddf23094fce442406603269fb277748e5c174ec65b5a06ce8bd3d19856d34"),("tools/capture_chemistry_org_011_claisen_blind_v2.py","sha256:7e993ee95eafe6a6b54375e3cf4b499310464f5a32e924e47ebfb7ab3b575103"),("tools/build_chemistry_org_011_claisen_external_v2.py","sha256:f2b87cd71e8e914ef725d2d1b2a676b61c3fcb6ef374061adba6c3d1d812817d")]
def authority (input : Input) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let authorityMatches := match input.files.find? (fun r => Text.equal r.path path) with
   | none => false
   | some row => row.present && Text.equal row.hash expected
  if !authorityMatches then throw (Text.append "ORG-011 authority changed: " path)
  pure ()
 let fields ← match input.preseal with
  | .object fs => pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "ORG-011 prediction seal changed"
 let unsealed : Canonical.Value := .object (fields.filter fun p => !Text.equal p.1 "sealed_payload_hash")
 let claimed := get input.preseal "sealed_payload_hash"
 if !equal claimed (.text "sha256:a772e044a114e8cea5d8698148f46ffe8d6b4f0165eb976b3513eb2245bed36e") ||
  !equal (.text (Canonical.identity unsealed)) claimed ||
  !equal (get input.preseal "new_supplementary_pdf_pages_characterization_structures_formulas_or_spectra_opened_before_this_seal") (.boolean false) ||
  !equal (get input.preseal "external_target_content_used_by_candidate_generator_or_eliminator") (.boolean false) then
  throw "ORG-011 prediction seal changed"
 let pairs ← field input.analysisDocument "explicit_claisen_source_product_pairs_in_source_order" >>= array
 if pairs.length != 8 then throw "ORG-011 complete pair boundary changed"
 pure ()
end SFT.Chemistry.RearrangementSource
