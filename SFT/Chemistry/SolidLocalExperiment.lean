import SFT.Chemistry.SolidLocalEvidence
import SFT.Chemistry.SolidLocalSource
import SFT.Chemistry.SolidLocal
import SFT.Chemistry.SolidLocalGenerator
import SFT.Chemistry.PairExchangeExperiment
namespace SFT.Chemistry.SolidLocalExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
def claimId : String := "SFT-CHEM-SOLID-STATE-LOCAL-COORDINATION-015"
def experimentId : String := "SFT-EXP-CHEM-SOLID-STATE-LOCAL-COORDINATION-015"
def expectedLabel : String := "complete-local-solid-and-ownership-vector"
def falsification : String := "The claim fails if any local occurrence or bond is omitted, if the formula is not the primitive positive count ratio, if repeat rank exceeds generator three, if absence uses numerical zero, if Chemistry claims bulk response, if the returned mixed-crystal identity mismatch is hidden, if any of ten source surfaces is removed, or if outcomes open before prediction sealing."
def targetRegistryHash : String := "sha256:db016fbc60b05d6da7db32c1f12a6b7d1a903ce6bb8ceef71a3fd5e2c550ac49"
def sourceFiles : List (String × String) := [("experiments/external_sources/chemistry/inorg_015_withheld_targets_v1.json","sha256:db016fbc60b05d6da7db32c1f12a6b7d1a903ce6bb8ceef71a3fd5e2c550ac49"),("experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-015-primary-records-v1.json","sha256:b80128c6cb2e5fbe0c566dd8b77f4cbee8fde5d8e8941e104347c0ba60065dc8")]
def sourceIds : List String := ["IUPAC-12823","IUPAC-S05735"]
def references : List SourceExtraction.Reference := [⟨"SFT-CHEM-INORG-015-001","IUPAC::IUPAC-12823::repeating-coordination-entity-support::family-development-observed","coordination network","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-12823.json","sha256:77fd0493785699114e933c4e742ca8f23ce4a12b9425856137e9003cc7579b2a"⟩,⟨"SFT-CHEM-INORG-015-002","IUPAC::IUPAC-12823::one-dimensional-crosslinked-network::family-development-observed","coordination network","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-12823.json","sha256:77fd0493785699114e933c4e742ca8f23ce4a12b9425856137e9003cc7579b2a"⟩,⟨"SFT-CHEM-INORG-015-003","IUPAC::IUPAC-12823::chain-loop-spiro-crosslink-classes::family-development-observed","coordination network","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-12823.json","sha256:77fd0493785699114e933c4e742ca8f23ce4a12b9425856137e9003cc7579b2a"⟩,⟨"SFT-CHEM-INORG-015-004","IUPAC::IUPAC-12823::two-dimensional-extension::family-development-observed","coordination network","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-12823.json","sha256:77fd0493785699114e933c4e742ca8f23ce4a12b9425856137e9003cc7579b2a"⟩,⟨"SFT-CHEM-INORG-015-005","IUPAC::IUPAC-12823::three-dimensional-extension::family-development-observed","coordination network","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-12823.json","sha256:77fd0493785699114e933c4e742ca8f23ce4a12b9425856137e9003cc7579b2a"⟩,⟨"SFT-CHEM-INORG-015-006","IUPAC::IUPAC-S05735::registered-solid-solution-returned-mixed-crystal::family-identity-only-unopened","solid solution","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-s05735.html","sha256:c98787d2ded225aa7d79f1f4e0359b3246986f0c92f250656b1639cd98faa796"⟩,⟨"SFT-CHEM-INORG-015-007","IUPAC::IUPAC-S05735::second-constituent-support::family-identity-only-unopened","solid solution","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-s05735.html","sha256:c98787d2ded225aa7d79f1f4e0359b3246986f0c92f250656b1639cd98faa796"⟩,⟨"SFT-CHEM-INORG-015-008","IUPAC::IUPAC-S05735::constituent-fits-host-lattice::family-identity-only-unopened","solid solution","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-s05735.html","sha256:c98787d2ded225aa7d79f1f4e0359b3246986f0c92f250656b1639cd98faa796"⟩,⟨"SFT-CHEM-INORG-015-009","IUPAC::IUPAC-S05735::constituent-distributed-in-host-lattice::family-identity-only-unopened","solid solution","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-s05735.html","sha256:c98787d2ded225aa7d79f1f4e0359b3246986f0c92f250656b1639cd98faa796"⟩,⟨"SFT-CHEM-INORG-015-010","IUPAC::IUPAC-S05735::amorphous-solid-solution-use-not-recommended::family-identity-only-unopened","solid solution","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-s05735.html","sha256:c98787d2ded225aa7d79f1f4e0359b3246986f0c92f250656b1639cd98faa796"⟩]
def registration (program : Value) : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-SOLID-STATE-LOCAL-COORDINATION-015"),("claim_id",.text "SFT-CHEM-SOLID-STATE-LOCAL-COORDINATION-015"),("provenance",.text "forward_forcing_with-family-identity-sealed-local-solid-vector"),("frozen_relation",.text "one-finite-local-chemical-motif__complete-species-occurrence-multiset__exact-primitive-positive-count-ratio__complete-local-bond-adjacency-support__generated-repeat-axis-rank-one-two-or-three__positive-second-constituent-support-or-EmptyOne__chemistry-local-materials-bulk-handoff__local-occurrence-successor-no-extra-rule"),("identity_registry",.array [.text "experiments/external_sources/chemistry/inorg_015_target_identities_v1.json",.text "sha256:a8888f42fb182bf845784b442c5eaa07c4a4899f2ce3d53ae363b5a977dbfdf6"]),("withheld_target_registry",.array [.text "experiments/external_sources/chemistry/inorg_015_withheld_targets_v1.json",.text "sha256:db016fbc60b05d6da7db32c1f12a6b7d1a903ce6bb8ceef71a3fd5e2c550ac49"]),("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-015-primary-records-v1.json",.text "sha256:b80128c6cb2e5fbe0c566dd8b77f4cbee8fde5d8e8941e104347c0ba60065dc8"]),("prediction_program",program),("target_ids",.array [.text "SFT-CHEM-INORG-015-001",.text "SFT-CHEM-INORG-015-002",.text "SFT-CHEM-INORG-015-003",.text "SFT-CHEM-INORG-015-004",.text "SFT-CHEM-INORG-015-005",.text "SFT-CHEM-INORG-015-006",.text "SFT-CHEM-INORG-015-007",.text "SFT-CHEM-INORG-015-008",.text "SFT-CHEM-INORG-015-009",.text "SFT-CHEM-INORG-015-010"]),("all_ten_rows_required",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("returned_mixed_crystal_identity_mismatch_must_be_preserved",.boolean true),("falsification_condition",.text "The claim fails if any local occurrence or bond is omitted, if the formula is not the primitive positive count ratio, if repeat rank exceeds generator three, if absence uses numerical zero, if Chemistry claims bulk response, if the returned mixed-crystal identity mismatch is hidden, if any of ten source surfaces is removed, or if outcomes open before prediction sealing.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("composition",[false,true]),("formula",[false,true]),("bonds",[false,true]),("network",[false,true]),("constituent",[false,true]),("ownership",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [SolidLocalGenerator.formulaWitness,SolidLocalGenerator.rankConstituentWitness,SolidLocalGenerator.successorWitness,SolidLocalGenerator.rankWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if SolidLocalEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.SolidLocalExperiment
