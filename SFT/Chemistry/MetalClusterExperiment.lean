import SFT.Chemistry.MetalClusterEvidence
import SFT.Chemistry.MetalClusterSource
import SFT.Chemistry.MetalCluster
import SFT.Chemistry.MetalClusterDerivation
import SFT.Chemistry.PairExchangeExperiment
namespace SFT.Chemistry.MetalClusterExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
def claimId : String := "SFT-CHEM-METAL-CLUSTER-BONDING-014"
def experimentId : String := "SFT-EXP-CHEM-METAL-CLUSTER-BONDING-014"
def expectedLabel : String := "complete-cluster-topology-and-iron-sulfur-vector"
def falsification : String := "The claim fails if centre support is finite-incomplete, duplicated or disconnected; if direct, bridging and held grouping relations are conflated; if bridge occurrences are implicit; if absent classes use numerical zero; if an observed example or charge inscription selects the law; if any of ten IUPAC surfaces is removed; or if outcomes open before sealing."
def targetRegistryHash : String := "sha256:68d44d6477269f114837fb23c58baa874adbf12c56bb81377c73558e0fcf547c"
def sourceFiles : List (String × String) := [("experiments/external_sources/chemistry/inorg_014_withheld_targets_v1.json","sha256:68d44d6477269f114837fb23c58baa874adbf12c56bb81377c73558e0fcf547c"),("experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-014-primary-records-v1.json","sha256:2973e1623fb7fdfa890b600cc787d2c2e84cef65a8aff270a17a74f4d21495a8")]
def sourceIds : List String := ["IUPAC-CT06769","IUPAC-IT06779"]
def references : List SourceExtraction.Reference := [⟨"SFT-CHEM-INORG-014-001","IUPAC::IUPAC-CT06769::multiple-metal-centre-support::family-identity-only-unopened","cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-ct06769.json","sha256:f13319605c529b7ef3783134dd847ab2382272e39096e3de60d5d44864f68c81"⟩,⟨"SFT-CHEM-INORG-014-002","IUPAC::IUPAC-CT06769::direct-metal-bond-interaction::family-identity-only-unopened","cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-ct06769.json","sha256:f13319605c529b7ef3783134dd847ab2382272e39096e3de60d5d44864f68c81"⟩,⟨"SFT-CHEM-INORG-014-003","IUPAC::IUPAC-CT06769::bridging-ligand-interaction::family-identity-only-unopened","cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-ct06769.json","sha256:f13319605c529b7ef3783134dd847ab2382272e39096e3de60d5d44864f68c81"⟩,⟨"SFT-CHEM-INORG-014-004","IUPAC::IUPAC-CT06769::interaction-not-necessary-for-cluster-grouping::family-identity-only-unopened","cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-ct06769.json","sha256:f13319605c529b7ef3783134dd847ab2382272e39096e3de60d5d44864f68c81"⟩,⟨"SFT-CHEM-INORG-014-005","IUPAC::IUPAC-IT06779::two-or-more-iron-support::family-identity-only-unopened","iron-sulfur cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-it06779.json","sha256:30e3d6f2715a91f06198bc5fdf20ad372835508785b41e86b4b8c62f775db775"⟩,⟨"SFT-CHEM-INORG-014-006","IUPAC::IUPAC-IT06779::bridging-sulfur-ligand-support::family-identity-only-unopened","iron-sulfur cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-it06779.json","sha256:30e3d6f2715a91f06198bc5fdf20ad372835508785b41e86b4b8c62f775db775"⟩,⟨"SFT-CHEM-INORG-014-007","IUPAC::IUPAC-IT06779::iron-sulfur-content-designation::family-identity-only-unopened","iron-sulfur cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-it06779.json","sha256:30e3d6f2715a91f06198bc5fdf20ad372835508785b41e86b4b8c62f775db775"⟩,⟨"SFT-CHEM-INORG-014-008","IUPAC::IUPAC-IT06779::two-iron-two-sulfur-example::family-identity-only-unopened","iron-sulfur cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-it06779.json","sha256:30e3d6f2715a91f06198bc5fdf20ad372835508785b41e86b4b8c62f775db775"⟩,⟨"SFT-CHEM-INORG-014-009","IUPAC::IUPAC-IT06779::three-iron-four-sulfur-example::family-identity-only-unopened","iron-sulfur cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-it06779.json","sha256:30e3d6f2715a91f06198bc5fdf20ad372835508785b41e86b4b8c62f775db775"⟩,⟨"SFT-CHEM-INORG-014-010","IUPAC::IUPAC-IT06779::external-oxidation-level-charge-inscriptions::family-identity-only-unopened","iron-sulfur cluster","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-it06779.json","sha256:30e3d6f2715a91f06198bc5fdf20ad372835508785b41e86b4b8c62f775db775"⟩]
def registration (program : Value) : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-METAL-CLUSTER-BONDING-014"),("claim_id",.text "SFT-CHEM-METAL-CLUSTER-BONDING-014"),("provenance",.text "forward_forcing_with-family-identity-sealed-cluster-vector"),("frozen_relation",.text "one-retained-cluster-entity__complete-finite-multicentre-support__complete-connected-cluster-relation-graph__explicit-direct-metal-bond-subgraph__complete-bridging-ligand-path-support__held-grouping-relation-without-bond-necessity__positive-count-or-EmptyOne-per-relation-class__connected-centre-successor-no-extra-rule"),("identity_registry",.array [.text "experiments/external_sources/chemistry/inorg_014_target_identities_v1.json",.text "sha256:9fb4f98fd0946c187bb0e02e700d4f18e2df7455a445b2030d7a768f826db287"]),("withheld_target_registry",.array [.text "experiments/external_sources/chemistry/inorg_014_withheld_targets_v1.json",.text "sha256:68d44d6477269f114837fb23c58baa874adbf12c56bb81377c73558e0fcf547c"]),("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-014-primary-records-v1.json",.text "sha256:2973e1623fb7fdfa890b600cc787d2c2e84cef65a8aff270a17a74f4d21495a8"]),("prediction_program",program),("target_ids",.array [.text "SFT-CHEM-INORG-014-001",.text "SFT-CHEM-INORG-014-002",.text "SFT-CHEM-INORG-014-003",.text "SFT-CHEM-INORG-014-004",.text "SFT-CHEM-INORG-014-005",.text "SFT-CHEM-INORG-014-006",.text "SFT-CHEM-INORG-014-007",.text "SFT-CHEM-INORG-014-008",.text "SFT-CHEM-INORG-014-009",.text "SFT-CHEM-INORG-014-010"]),("all_ten_rows_required",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("external_signed_charge_inscriptions_downstream_only",.boolean true),("falsification_condition",.text "The claim fails if centre support is finite-incomplete, duplicated or disconnected; if direct, bridging and held grouping relations are conflated; if bridge occurrences are implicit; if absent classes use numerical zero; if an observed example or charge inscription selects the law; if any of ten IUPAC surfaces is removed; or if outcomes open before sealing.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("centres",[false,true]),("connectivity",[false,true]),("direct",[false,true]),("bridge",[false,true]),("grouping",[false,true]),("counts",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [MetalCluster.directWitness,MetalCluster.bridgeGroupWitness,MetalCluster.successorWitness,MetalCluster.disconnectedWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if MetalClusterEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.MetalClusterExperiment
