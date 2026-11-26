import SFT.Chemistry.InsertionEliminationEvidence
import SFT.Chemistry.InsertionEliminationSource
import SFT.Chemistry.InsertionElimination
import SFT.Chemistry.InsertionEliminationDerivation
import SFT.Chemistry.PairExchangeExperiment
namespace SFT.Chemistry.InsertionEliminationExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
def claimId : String := "SFT-CHEM-INSERTION-ELIMINATION-PATHWAY-013"
def experimentId : String := "SFT-EXP-CHEM-INSERTION-ELIMINATION-PATHWAY-013"
def expectedLabel : String := "complete-insertion-migratory-elimination-vector"
def falsification : String := "The claim fails if any carrier, centre, eliminand or before/after adjacency is lost, duplicated or invented; if removed/added support differs from the exact graph difference; if insertion, extrusion, migratory composition or elimination boundaries are conflated; if an observed product or named mechanism selects the law; if any of ten IUPAC surfaces, the host-lattice scope row or absent rendered example is removed; or if outcomes open before sealing."
def targetRegistryHash : String := "sha256:f9366ae730b5a25b28b91c4a4f1f38e32e3669858023d1bf20f0fae86a67f3ca"
def sourceFiles : List (String × String) := [("experiments/external_sources/chemistry/inorg_013_withheld_targets_v2.json","sha256:f9366ae730b5a25b28b91c4a4f1f38e32e3669858023d1bf20f0fae86a67f3ca"),("experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-013-primary-records-v2.json","sha256:4b5266c18b8de2018bd9b3c24c5fa113162cff71c88c27a0cf75b49c1c3b8b5f")]
def sourceIds : List String := ["IUPAC-M03924","IUPAC-I03058","IUPAC-E02038"]
def references : List SourceExtraction.Reference := [⟨"SFT-CHEM-INORG-013-001","IUPAC::IUPAC-M03924::migration-plus-insertion-composition::family-development-observed","migratory insertion","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-m03924.json","sha256:d5a3876c567c665359be5592e3720d8085e1c8eb82565bc21727be571f791d1a"⟩,⟨"SFT-CHEM-INORG-013-002","IUPAC::IUPAC-M03924::organometallic-primary-use-scope::family-development-observed","migratory insertion","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-m03924.json","sha256:d5a3876c567c665359be5592e3720d8085e1c8eb82565bc21727be571f791d1a"⟩,⟨"SFT-CHEM-INORG-013-003","IUPAC::IUPAC-I03058::xz-plus-y-to-xyz-transformation::family-identity-only-unopened","insertion","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-i03058.json","sha256:d89a322c19e7438fdca4cf9e027521b0994574aadc5c4d920c704ad63aef368e"⟩,⟨"SFT-CHEM-INORG-013-004","IUPAC::IUPAC-I03058::connecting-group-replaces-xz-bond::family-identity-only-unopened","insertion","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-i03058.json","sha256:d89a322c19e7438fdca4cf9e027521b0994574aadc5c4d920c704ad63aef368e"⟩,⟨"SFT-CHEM-INORG-013-005","IUPAC::IUPAC-I03058::carbene-example-introduced-with-rendered-structure-absent::family-identity-only-unopened","insertion","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-i03058.json","sha256:d89a322c19e7438fdca4cf9e027521b0994574aadc5c4d920c704ad63aef368e"⟩,⟨"SFT-CHEM-INORG-013-006","IUPAC::IUPAC-I03058::host-crystal-lattice-scope-distinction::family-identity-only-unopened","insertion","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-i03058.json","sha256:d89a322c19e7438fdca4cf9e027521b0994574aadc5c4d920c704ad63aef368e"⟩,⟨"SFT-CHEM-INORG-013-007","IUPAC::IUPAC-E02038::reverse-of-addition::family-identity-only-unopened","elimination","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-e02038.json","sha256:0c0ccf2845dbf936369bf0c5b35fb1e59ceea70736cc250c43ff56bc024cc57d"⟩,⟨"SFT-CHEM-INORG-013-008","IUPAC::IUPAC-E02038::two-groups-lost-from-distinct-centres::family-identity-only-unopened","elimination","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-e02038.json","sha256:0c0ccf2845dbf936369bf0c5b35fb1e59ceea70736cc250c43ff56bc024cc57d"⟩,⟨"SFT-CHEM-INORG-013-009","IUPAC::IUPAC-E02038::unsaturation-or-new-ring-product::family-identity-only-unopened","elimination","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-e02038.json","sha256:0c0ccf2845dbf936369bf0c5b35fb1e59ceea70736cc250c43ff56bc024cc57d"⟩,⟨"SFT-CHEM-INORG-013-010","IUPAC::IUPAC-E02038::single-centre-carbene-product-boundary::family-identity-only-unopened","elimination","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-e02038.json","sha256:0c0ccf2845dbf936369bf0c5b35fb1e59ceea70736cc250c43ff56bc024cc57d"⟩]
def registration (program : Value) : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-INSERTION-ELIMINATION-PATHWAY-013"),("claim_id",.text "SFT-CHEM-INSERTION-ELIMINATION-PATHWAY-013"),("provenance",.text "forward_forcing_with-frozen-complete-IUPAC-vector"),("frozen_relation",.text "complete-retained-carrier-support__complete-before-after-adjacency-difference__xz-plus-y-to-x-y-z-adjacency-law__migration-plus-insertion-composition__extrusion-exact-insertion-inverse__complete-two-eliminand-centre-trace__held-unsaturation-ring-or-carbene-boundary__adjacency-trace-composition-no-extra-rule"),("identity_registry",.array [.text "experiments/external_sources/chemistry/inorg_013_target_identities_v1.json",.text "sha256:62bdd91e56629d4c841657ea94e339dd49b00913f11e58dbb73c67537ef46fa1"]),("withheld_target_registry",.array [.text "experiments/external_sources/chemistry/inorg_013_withheld_targets_v2.json",.text "sha256:f9366ae730b5a25b28b91c4a4f1f38e32e3669858023d1bf20f0fae86a67f3ca"]),("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-013-primary-records-v2.json",.text "sha256:4b5266c18b8de2018bd9b3c24c5fa113162cff71c88c27a0cf75b49c1c3b8b5f"]),("prediction_program",program),("target_ids",.array [.text "SFT-CHEM-INORG-013-001",.text "SFT-CHEM-INORG-013-002",.text "SFT-CHEM-INORG-013-003",.text "SFT-CHEM-INORG-013-004",.text "SFT-CHEM-INORG-013-005",.text "SFT-CHEM-INORG-013-006",.text "SFT-CHEM-INORG-013-007",.text "SFT-CHEM-INORG-013-008",.text "SFT-CHEM-INORG-013-009",.text "SFT-CHEM-INORG-013-010"]),("all_ten_rows_required",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("host_lattice_scope_and_absent_rendered_example_preserved",.boolean true),("falsification_condition",.text "The claim fails if any carrier, centre, eliminand or before/after adjacency is lost, duplicated or invented; if removed/added support differs from the exact graph difference; if insertion, extrusion, migratory composition or elimination boundaries are conflated; if an observed product or named mechanism selects the law; if any of ten IUPAC surfaces, the host-lattice scope row or absent rendered example is removed; or if outcomes open before sealing.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("trace",[false,true]),("insertion",[false,true]),("migration",[false,true]),("reverse",[false,true]),("elimination",[false,true]),("product",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [InsertionElimination.insertionWitness,InsertionElimination.extrusionWitness,InsertionElimination.migrationWitness,InsertionElimination.eliminationWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if InsertionEliminationEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
  .error "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 else if !SourceExtraction.unique (specDimensions.map Prod.fst) then
  .error "empirical Chemistry law contains duplicate dimensions"
 else if !(specDimensions.all (fun d => d.2.length == 2)) then
  .error "each Chemistry dimension must exhaust two registered forms"
 else if !(specDimensions.all (fun d => (d.2.filter id).length == 1)) then
  .error "dimension requires one preserving form"
 else if !SourceText.nonblank expectedLabel || !SourceText.nonblank falsification then
  .error "Chemistry prediction or falsification condition is missing"
 else if !SourceExtraction.unique (references.map SourceExtraction.Reference.targetId) then
  .error "Chemistry target identities are duplicated"
 else if references.any (fun row => !(Text.chars "sha256:").isPrefixOf (Text.chars row.snapshotHash)) then
  .error "Chemistry target snapshot identity is invalid"
 else if !(specWitnesses.all id) then
  .error "Chemistry operational witness failed"
 else .ok ()

end SFT.Chemistry.InsertionEliminationExperiment
