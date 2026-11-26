import SFT.Chemistry.OxidativeReductiveEvidence
import SFT.Chemistry.OxidativeReductiveSource
import SFT.Chemistry.OxidativeReductive
import SFT.Chemistry.OxidativeReductiveDerivation
import SFT.Chemistry.PairExchangeExperiment
namespace SFT.Chemistry.OxidativeReductiveExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
def claimId : String := "SFT-CHEM-OXIDATIVE-ADDITION-REDUCTIVE-ELIMINATION-012"
def experimentId : String := "SFT-EXP-CHEM-OXIDATIVE-ADDITION-REDUCTIVE-ELIMINATION-012"
def expectedLabel : String := "complete-oxidative-addition-and-reductive-elimination-vector"
def falsification : String := "The claim fails if either carrier or any metal occurrence is lost or duplicated; if the source bond is not replaced by exactly two incidences; if the exact transfer partition differs from two or one-plus-one; if signed oxidation arithmetic enters proof; if reductive elimination is not the exact inverse; if any of five IUPAC surfaces is removed; or if outcomes open before prediction sealing."
def targetRegistryHash : String := "sha256:b6ab8c6bb59de36c53d604c96c3c45630284f33c9554661e1b941ce4d6c38689"
def sourceFiles : List (String × String) := [("experiments/external_sources/chemistry/inorg_012_withheld_targets_v1.json","sha256:b6ab8c6bb59de36c53d604c96c3c45630284f33c9554661e1b941ce4d6c38689"),("experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-012-primary-records-v1.json","sha256:34c79b8b441a37c81e41a7f39887db53fda71e4a5e1dae4ed3169470c8ac2b1d")]
def sourceIds : List String := ["IUPAC-O04367","IUPAC-R05223"]
def references : List SourceExtraction.Reference := [⟨"SFT-CHEM-INORG-012-001","IUPAC::IUPAC-O04367::metal-complex-covalent-bond-insertion::family-development-observed","oxidative addition","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-o04367.json","sha256:976736625deeff512942168807eca813a99353ff8c8a7172f421887a543bcfd2"⟩,⟨"SFT-CHEM-INORG-012-002","IUPAC::IUPAC-O04367::single-metal-two-electron-transfer::family-development-observed","oxidative addition","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-o04367.json","sha256:976736625deeff512942168807eca813a99353ff8c8a7172f421887a543bcfd2"⟩,⟨"SFT-CHEM-INORG-012-003","IUPAC::IUPAC-O04367::two-metal-one-electron-each-transfer::family-development-observed","oxidative addition","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-o04367.json","sha256:976736625deeff512942168807eca813a99353ff8c8a7172f421887a543bcfd2"⟩,⟨"SFT-CHEM-INORG-012-004","IUPAC::IUPAC-O04367::radical-chemistry-scope-distinction::family-development-observed","oxidative addition","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-o04367.json","sha256:976736625deeff512942168807eca813a99353ff8c8a7172f421887a543bcfd2"⟩,⟨"SFT-CHEM-INORG-012-005","IUPAC::IUPAC-R05223::reverse-of-oxidative-addition::family-development-observed","reductive elimination","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-r05223.json","sha256:ac12ca065ec50b342edf2d410d208d8e71c14bdc3d3512b9b8b6d2e4eb94a483"⟩]
def registration (program : Value) : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-OXIDATIVE-ADDITION-REDUCTIVE-ELIMINATION-012"),("claim_id",.text "SFT-CHEM-OXIDATIVE-ADDITION-REDUCTIVE-ELIMINATION-012"),("provenance",.text "forward_forcing_with-frozen-complete-IUPAC-correspondence"),("frozen_relation",.text "one-retained-organometallic-process__complete-two-carrier-source-bond__two-generated-metal-carrier-incidences__exact-carrier-and-metal-conservation__held-two-electron-transfer-orientation__complete-one-metal-two-or-two-metal-one-one-partition__exact-reductive-inverse-correspondence__trace-composition-with-no-extra-rule"),("identity_registry",.array [.text "experiments/external_sources/chemistry/inorg_012_target_identities_v1.json",.text "sha256:a103ace65a1351b493859a403b0bbb564fdea57d8299b930a5a7a959ed48f06e"]),("withheld_target_registry",.array [.text "experiments/external_sources/chemistry/inorg_012_withheld_targets_v1.json",.text "sha256:b6ab8c6bb59de36c53d604c96c3c45630284f33c9554661e1b941ce4d6c38689"]),("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/inorg-012-primary-records-v1.json",.text "sha256:34c79b8b441a37c81e41a7f39887db53fda71e4a5e1dae4ed3169470c8ac2b1d"]),("prediction_program",program),("target_ids",.array [.text "SFT-CHEM-INORG-012-001",.text "SFT-CHEM-INORG-012-002",.text "SFT-CHEM-INORG-012-003",.text "SFT-CHEM-INORG-012-004",.text "SFT-CHEM-INORG-012-005"]),("all_five_rows_required",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("signed_oxidation_formal_charge_or_observed_mechanism_absent_from_forcing",.boolean true),("falsification_condition",.text "The claim fails if either carrier or any metal occurrence is lost or duplicated; if the source bond is not replaced by exactly two incidences; if the exact transfer partition differs from two or one-plus-one; if signed oxidation arithmetic enters proof; if reductive elimination is not the exact inverse; if any of five IUPAC surfaces is removed; or if outcomes open before prediction sealing.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("source",[false,true]),("product",[false,true]),("conservation",[false,true]),("transfer",[false,true]),("partition",[false,true]),("reverse",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [OxidativeReductive.singleWitness,OxidativeReductive.splitWitness,OxidativeReductive.reverseWitness,OxidativeReductive.partitionWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if OxidativeReductiveEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.OxidativeReductiveExperiment
