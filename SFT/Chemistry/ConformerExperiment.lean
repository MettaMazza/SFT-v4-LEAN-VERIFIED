import SFT.Chemistry.ConformerGenerationEvidence
import SFT.Chemistry.ConformerSource
import SFT.Chemistry.ConformerCensus
import SFT.Chemistry.PairExchangeExperiment
namespace SFT.Chemistry.ConformerExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
def claimId : String := "SFT-CHEM-CONFORMER-GENERATION-EQUIVALENCE-005"
def experimentId : String := "SFT-EXP-CHEM-CONFORMER-GENERATION-EQUIVALENCE-005"
def expectedLabel : String := "complete-finite-conformer-generation-equivalence-and-small-molecule-census"
def falsification : String := "The claim fails if an atom, bond, rotor, held state, Cartesian assignment or preserving graph bijection is omitted; if equivalence uses a coordinate tolerance or measured energy; if any assignment occurs in no class or more than one class; if the four-site witness does not generate three assignments, two graph actions and two classes of sizes one and two; if any of four authority records or any of the 19 tables and 105 CCCBDB rows is omitted; if Anti/Gauche is selected rather than compared after derivation; or if the adverse Gauche false-minimum row, signed values, conventional zeros or absent cells are erased."
def targetRegistryHash : String := "sha256:ed750adf9e52a8257fd3784f19fee213bca5c3a147cd72cb9488a2a4ec45c8f3"
def sourceFiles : List (String × String) := [("experiments/external_sources/chemistry/org_005_withheld_targets_v1.json","sha256:ed750adf9e52a8257fd3784f19fee213bca5c3a147cd72cb9488a2a4ec45c8f3"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/org-005-primary-records-v1.json","sha256:a5eb356e0240a4e56457ba7265368cc7e06ca0396b38b103eac357e9ac186f10"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-c01262.json","sha256:f686caa621df7cf972b28ec2a6a2e0cad7a98f460f4dad1941f7c467e7af5272"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-c01258.json","sha256:0c3bb6d2269ccf22f21eba5bb88f469420f24d4896c359a288d49ed8438675ea"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-c01259.json","sha256:2e89a8097482247a7a26ecd91a81ee53d79404a2b8dea6afb3a005bc7f18bcc0"),("experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/nist-cccbdb-106978-neutral-experimental.html","sha256:def4b433b4e91faf8c1ae0dfc81b84edfb32a1634fee95153f3db912f26382a1")]
def references : List SourceExtraction.Reference := [⟨"SFT-CHEM-ORG-005-001","IUPAC::IUPAC-C01262::complete-conformer-term-record::family-development-observed-before-ORG-005-seal","conformer complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-c01262.json","sha256:f686caa621df7cf972b28ec2a6a2e0cad7a98f460f4dad1941f7c467e7af5272"⟩,⟨"SFT-CHEM-ORG-005-002","IUPAC::IUPAC-C01258::complete-conformation-term-record::family-development-observed-before-ORG-005-seal","conformation complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-c01258.json","sha256:0c3bb6d2269ccf22f21eba5bb88f469420f24d4896c359a288d49ed8438675ea"⟩,⟨"SFT-CHEM-ORG-005-003","IUPAC::IUPAC-C01259::complete-conformational-analysis-term-record::family-development-observed-before-ORG-005-seal","conformational analysis complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-c01259.json","sha256:2e89a8097482247a7a26ecd91a81ee53d79404a2b8dea6afb3a005bc7f18bcc0"⟩,⟨"SFT-CHEM-ORG-005-004","NIST CCCBDB SRD 101::NIST-CCCBDB-106978-NEUTRAL-EXPERIMENTAL::complete-butane-conformer-census-and-experimental-surface::family-development-observed-before-ORG-005-seal","CAS 106-97-8 neutral complete experimental-property and conformer-reference page","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/nist-cccbdb-106978-neutral-experimental.html","sha256:def4b433b4e91faf8c1ae0dfc81b84edfb32a1634fee95153f3db912f26382a1"⟩]
def registration (program : Value) : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-CONFORMER-GENERATION-EQUIVALENCE-005"),("claim_id",.text "SFT-CHEM-CONFORMER-GENERATION-EQUIVALENCE-005"),("provenance",.text "observational_derivation_all-four-records-development-observed-not-claimed-blind"),("frozen_relation",.text "complete-finite-molecular-graph__complete-ordered-rotor-census__complete-cartesian-state-generation__exhaustive-graph-automorphism-action__exact-automorphism-orbit-equivalence__complete-disjoint-orbit-quotient__value-free-operational-census-seal__finite-product-successor-no-extra-rule"),("identity_registry",.array [.text "experiments/external_sources/chemistry/org_005_target_identities_v1.json",.text "sha256:7f148f0b99d0939aefb6023521d697dc00386a0de2f7a328d6b1220377965ad4"]),("complete_target_registry",.array [.text "experiments/external_sources/chemistry/org_005_withheld_targets_v1.json",.text "sha256:ed750adf9e52a8257fd3784f19fee213bca5c3a147cd72cb9488a2a4ec45c8f3"]),("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/org-005-primary-records-v1.json",.text "sha256:a5eb356e0240a4e56457ba7265368cc7e06ca0396b38b103eac357e9ac186f10"]),("prediction_program",program),("target_ids",.array [.text "SFT-CHEM-ORG-005-001",.text "SFT-CHEM-ORG-005-002",.text "SFT-CHEM-ORG-005-003",.text "SFT-CHEM-ORG-005-004"]),("all_four_rows_required",.boolean true),("all_rows_development_observed_and_disclosed",.boolean true),("unknown_target_blind_prediction_claimed",.boolean false),("all_complete_cccbdb_table_rows_required",.boolean true),("target_payload_hashes_released_only_after_derivation_seal",.boolean true),("falsification_condition",.text "The claim fails if an atom, bond, rotor, held state, Cartesian assignment or preserving graph bijection is omitted; if equivalence uses a coordinate tolerance or measured energy; if any assignment occurs in no class or more than one class; if the four-site witness does not generate three assignments, two graph actions and two classes of sizes one and two; if any of four authority records or any of the 19 tables and 105 CCCBDB rows is omitted; if Anti/Gauche is selected rather than compared after derivation; or if the adverse Gauche false-minimum row, signed values, conventional zeros or absent cells are erased.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("rotor",[false,true]),("generation",[false,true]),("symmetry",[false,true]),("equivalence",[false,true]),("quotient",[false,true]),("observation",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [ConformerCensus.generationWitness,ConformerCensus.automorphismWitness,ConformerCensus.quotientWitness,ConformerCensus.partitionWitness,ConformerCensus.reversalWitness,ConformerCensus.pathWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if ConformerGenerationEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.ConformerExperiment
