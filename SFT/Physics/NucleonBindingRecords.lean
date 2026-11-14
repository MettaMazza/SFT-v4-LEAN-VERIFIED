import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.NucleonBindingRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 20000
def sourceHash : String := "sha256:2f75c5124ce570fad3becd1ff5901f6062c6dea05b5a41a1892819006fa6290e"
def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "classification").toOption.getD .null) (.text "observational_derivation") then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "complete_reported_uncertainties_retained").toOption.getD .null) (.boolean true) then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "scheme_boundary_retained").toOption.getD .null) (.boolean true) then throw "nucleon-binding custody disclosure changed"
 if !sameValue ((field custody "structural_fraction_not_conflated_with_current_quark_mass_ratio").toOption.getD .null) (.boolean true) then throw "nucleon-binding custody disclosure changed"
 let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "nucleon-binding source set changed"
  | .boolean _ => .error "nucleon-binding source set changed"
  | .integer _ => .error "nucleon-binding source set changed"
  | .null => .error "nucleon-binding source set changed"
  | .array _ => .error "nucleon-binding source set changed"
 let required := ["pdg_quark_model","pdg_light_quark_masses","nist_nucleon_masses"]
 if !(pairs.all (fun p => required.any (fun s => Text.equal s p.1))) || !(required.all (fun s => pairs.any (fun p => Text.equal s p.1))) then
  throw "nucleon-binding source set changed"
 pure payload
def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "nucleon-binding source record identity changed"
 let record ← payloadBoundary payload
 let row ← field (← field record "sources") "pdg_light_quark_masses"
 let path ← text (← field row "snapshot_path")
 if !sameValue (← field row "snapshot_hash") (.text "sha256:d544d099aa15739ec83d87711bd4c5b1e0a1032d6f70aaa4847ec78601f7aeae") then throw "PDG quark-mass snapshot changed"
 let component ← match files.find? (fun p => Text.equal p.1 path) with
  | none => .error (Text.append "FileNotFoundError: " path)
  | some p => .ok p.2
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) "sha256:d544d099aa15739ec83d87711bd4c5b1e0a1032d6f70aaa4847ec78601f7aeae" then throw "PDG quark-mass snapshot changed"
 let row ← field (← field record "sources") "nist_nucleon_masses"
 let path ← text (← field row "snapshot_path")
 if !sameValue (← field row "snapshot_hash") (.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67") then throw "NIST CODATA snapshot changed"
 let component ← match files.find? (fun p => Text.equal p.1 path) with
  | none => .error (Text.append "FileNotFoundError: " path)
  | some p => .ok p.2
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67" then throw "NIST CODATA snapshot changed"
 pure record
def componentFiles : List (String × String) := [("pdg-2025-quark-masses.pdf","sha256:d544d099aa15739ec83d87711bd4c5b1e0a1032d6f70aaa4847ec78601f7aeae"),("nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67")]
def registeredRecord : Value := .object [("schema",.text "sft-v3-nucleon-binding-successor-source-record/1"),("retrieval_date",.text "2026-07-24"),("custody",.object [("classification",.text "observational_derivation"),("development_targets_already_known",.boolean true),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("empirical_prediction_protocol",.boolean true),("target_inaccessible_during_prediction_execution",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("complete_reported_uncertainties_retained",.boolean true),("scheme_boundary_retained",.boolean true),("structural_fraction_not_conflated_with_current_quark_mass_ratio",.boolean true)]),("sources",.object [("pdg_quark_model",.object [("source_id",.text "PDG-2025-QUARK-MODEL"),("body",.text "Particle Data Group"),("source_uri",.text "https://pdg.lbl.gov/2025/reviews/rpp2025-rev-quark-model.pdf"),("reported_record",.object [("colour_count",.integer (3)),("physical_state_class",.text "colour singlet"),("minimal_baryon_constituent_count",.integer (3)),("baryon_class",.text "qqq"),("up_charge",.text "positive 2/3"),("down_charge",.text "opposed 1/3"),("source_boundary",.text "PDG correspondence only; SU(3) notation is not a formal SFT premise")])]),("pdg_light_quark_masses",.object [("source_id",.text "PDG-2025-QUARK-MASSES"),("body",.text "Particle Data Group"),("source_uri",.text "https://pdg.lbl.gov/2025/reviews/rpp2025-rev-quark-masses.pdf"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/pdg-2025-quark-masses.pdf"),("snapshot_hash",.text "sha256:d544d099aa15739ec83d87711bd4c5b1e0a1032d6f70aaa4847ec78601f7aeae"),("reported_record",.object [("scheme",.text "MSbar"),("scale_GeV",.text "2"),("active_flavour_theory",.text "NL=4"),("up_mass_MeV",.text "2.20"),("up_total_uncertainty_MeV",.text "0.07"),("down_mass_MeV",.text "4.69"),("down_total_uncertainty_MeV",.text "0.05"),("uncertainty_policy",.text "PDG bracketed total uncertainty, the quadrature of reported statistical and systematic components"),("quark_mass_status",.text "renormalization-scheme-and-scale-dependent inferred parameters, not directly observed free-particle masses")])]),("nist_nucleon_masses",.object [("source_id",.text "NIST-CODATA-2022-NUCLEON-MASS-ENERGY"),("body",.text "NIST / CODATA Task Group on Fundamental Constants"),("source_uri",.text "https://physics.nist.gov/cuu/Constants/Table/allascii.txt"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"),("snapshot_hash",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("reported_record",.object [("proton_mass_energy_MeV",.text "938.27208943"),("proton_standard_uncertainty_MeV",.text "0.00000029"),("neutron_mass_energy_MeV",.text "939.56542194"),("neutron_standard_uncertainty_MeV",.text "0.00000048"),("neutron_proton_difference_MeV",.text "1.29333251"),("difference_standard_uncertainty_MeV",.text "0.00000038")])])]),("comparison_policy",.object [("composition",.text "The sealed complete positive charge-word enumeration must return one three-member unit-positive word and one three-member empty-neutral word; PDG independently supplies the three-colour, qqq, colour-singlet correspondence."),("dominance",.text "The SFT structural ledger predicts bare 1/128 below 1/100 and held 127/128 above 99/100. The complete PDG u,u,d current-mass interval divided by the complete NIST proton interval must independently remain below 1/100; its positive residual must remain above 99/100."),("nonconflation",.text "No equality is asserted between exact structural 1/128 and the scheme-dependent PDG current-quark mass ratio. The registered empirical claim is the strict dominance class and complete ledger direction."),("ordering",.text "The sealed exact down-over-up and net neutron-surplus signs must agree with the complete PDG light-quark intervals and the complete NIST neutron/proton mass-energy intervals. Every standard uncertainty is propagated outward with exact fractions."),("adverse_control",.text "Any source revision making the uud current-mass upper fraction reach 1/100, reversing d/u ordering, or allowing proton and neutron intervals to overlap falsifies the registered comparison.")])]
theorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl
end SFT.Physics.NucleonBindingRecords
