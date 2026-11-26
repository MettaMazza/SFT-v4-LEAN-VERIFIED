import SFT.Chemistry.OrganometallicElectronAccountEvidence
import SFT.Chemistry.OrganometallicElectronAccountSource
import SFT.Chemistry.OrganometallicElectronAccount
import SFT.Chemistry.OrganometallicElectronAccountDerivation
import SFT.Chemistry.PairExchangeExperiment
namespace SFT.Chemistry.OrganometallicElectronAccountExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
def claimId : String := "SFT-CHEM-ORGANOMETALLIC-ELECTRON-ACCOUNTING-011"
def experimentId : String := "SFT-EXP-CHEM-ORGANOMETALLIC-ELECTRON-ACCOUNTING-011"
def expectedLabel : String := "complete-stable-complex-electron-account-vector"
def falsification : String := "The claim fails if capacity is imported rather than regenerated as 2+6+10; if any electron occurrence is missing, duplicated, unpaired or assigned to both account parts; if the exact total or capacity relation differs; if support exceeds capacity without halting; if observed eighteen, oxidation-state bookkeeping or a species lookup selects the law; if any of four IUPAC surfaces is removed; or if outcomes open before the prediction seal."
def targetRegistryHash : String := "sha256:f547856fc61f6de42089e7ac386bd919ae1488b5c7be8b11dcc8bca9be21d681"
def sourceFiles : List (String × String) := [("experiments/external_sources/chemistry/inorg_011_withheld_targets_v1.json","sha256:f547856fc61f6de42089e7ac386bd919ae1488b5c7be8b11dcc8bca9be21d681"),("experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-011-primary-records-v1.json","sha256:7ec6645469a1ea866a80582badabb8e15b9d544c0eb5fab9c76f652eafbfc96a")]
def sourceIds : List String := ["IUPAC-E01913"]
def references : List SourceExtraction.Reference := [⟨"SFT-CHEM-INORG-011-001","IUPAC::IUPAC-E01913::stable-diamagnetic-transition-metal-complex-scope::family-identity-only-unopened","eighteen-electron rule","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-e01913.json","sha256:a9f66a6e8dcdecd013f4a320e7085df5743d770904421abdd5d370be4ce93b6e"⟩,⟨"SFT-CHEM-INORG-011-002","IUPAC::IUPAC-E01913::nonbonded-metal-electron-account::family-identity-only-unopened","eighteen-electron rule","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-e01913.json","sha256:a9f66a6e8dcdecd013f4a320e7085df5743d770904421abdd5d370be4ce93b6e"⟩,⟨"SFT-CHEM-INORG-011-003","IUPAC::IUPAC-E01913::metal-ligand-bond-electron-account::family-identity-only-unopened","eighteen-electron rule","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-e01913.json","sha256:a9f66a6e8dcdecd013f4a320e7085df5743d770904421abdd5d370be4ce93b6e"⟩,⟨"SFT-CHEM-INORG-011-004","IUPAC::IUPAC-E01913::complete-eighteen-electron-total-and-octet-analogy::family-identity-only-unopened","eighteen-electron rule","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-e01913.json","sha256:a9f66a6e8dcdecd013f4a320e7085df5743d770904421abdd5d370be4ce93b6e"⟩]
def registration (program : Value) : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-ORGANOMETALLIC-ELECTRON-ACCOUNTING-011"),("claim_id",.text "SFT-CHEM-ORGANOMETALLIC-ELECTRON-ACCOUNTING-011"),("provenance",.text "forward_forcing_with-family-identity-sealed-IUPAC-comparison"),("frozen_relation",.text "one-retained-organometallic-entity__complete-nonbonded-and-bond-pair-support__forced-two-plus-six-plus-ten-capacity__complete-complementary-fibre-pairing__exact-nonbonded-plus-bond-partition__capacity-complete-or-incomplete-held-relation__postseal-stable-complex-correspondence__pair-successor-until-capacity-then-halt"),("identity_registry",.array [.text "experiments/external_sources/chemistry/inorg_011_target_identities_v1.json",.text "sha256:a439259572b5ea2b89ca4d9b46e659a915e717920f5ff5702862872bd5aa4782"]),("withheld_target_registry",.array [.text "experiments/external_sources/chemistry/inorg_011_withheld_targets_v1.json",.text "sha256:f547856fc61f6de42089e7ac386bd919ae1488b5c7be8b11dcc8bca9be21d681"]),("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-011-primary-records-v1.json",.text "sha256:7ec6645469a1ea866a80582badabb8e15b9d544c0eb5fab9c76f652eafbfc96a"]),("prediction_program",program),("target_ids",.array [.text "SFT-CHEM-INORG-011-001",.text "SFT-CHEM-INORG-011-002",.text "SFT-CHEM-INORG-011-003",.text "SFT-CHEM-INORG-011-004"]),("all_four_rows_required",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("observed_eighteen_oxidation_state_species_lookup_or_fit_absent_from_capacity_generation",.boolean true),("falsification_condition",.text "The claim fails if capacity is imported rather than regenerated as 2+6+10; if any electron occurrence is missing, duplicated, unpaired or assigned to both account parts; if the exact total or capacity relation differs; if support exceeds capacity without halting; if observed eighteen, oxidation-state bookkeeping or a species lookup selects the law; if any of four IUPAC surfaces is removed; or if outcomes open before the prediction seal.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("support",[false,true]),("capacity",[false,true]),("balance",[false,true]),("partition",[false,true]),("relation",[false,true]),("comparison",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [OrganometallicElectronAccount.capacityWitness,OrganometallicElectronAccount.completeWitness,OrganometallicElectronAccount.successorWitness,OrganometallicElectronAccount.haltWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if OrganometallicElectronAccountEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.OrganometallicElectronAccountExperiment
