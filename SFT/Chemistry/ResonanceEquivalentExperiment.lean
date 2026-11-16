import SFT.Chemistry.ResonanceEquivalentEvidence
import SFT.Chemistry.ResonanceEquivalentPrediction
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
set_option maxRecDepth 100000
namespace SFT.Chemistry.ResonanceEquivalentExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics SourceExtraction
def claimId : String := "SFT-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002"
def experimentId : String := "SFT-EXP-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002"
def frozenRelation : String := "one-retained-molecular-carrier__complete-equal-atom-occurrence-support__complete-equal-adjacency-support__multiple-distinct-encoding-identities__complete-opposed-fibre-complement__one-carrier-many-representations__representation-relation-only__shared-complement-successor-no-extra-rule"
def falsification : String := "The claim fails if equivalent encodings change the carrier, atom occurrences or adjacency; if the minimal pair is not a complete opposed-fibre complement; if formal encodings are counted as multiple species or an equilibrium; if any of four complete records is omitted; if external wavefunction, coefficient or signed-charge language enters native forcing; if the V1 search-scope error is hidden; or if outcomes open before the value-free prediction seal."
def expectedLabel : String := "complete-one-carrier-multiple-formal-representation-vector"
def identityRegistryPath : String := "experiments/external_sources/chemistry/org_002_target_identities_v1.json"
def identityRegistryHash : String := "sha256:d90bb68121cb37ea8a2d85242fd0b3ba4673ec9e3eb01d151c79fb8118b0fbbc"
def targetRegistryPath : String := "experiments/external_sources/chemistry/org_002_withheld_targets_v2.json"
def targetRegistryHash : String := "sha256:873777e871d3b15278afd2502ac6fa4ad5b5083eb05192b06e16cf3b04d7be51"
def primarySourcePath : String := "experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/org-002-primary-records-v2.json"
def primarySourceHash : String := "sha256:0987db81474d56aacfeffa3b317e3380bfb4ec79b985ab09eed931594c366247"
def references : List Reference := [⟨"SFT-CHEM-ORG-002-001","IUPAC::IUPAC-R05326::complete-resonance-record::family-development-observed","resonance complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-r05326.json","sha256:036f02f7be4f5ce4c85055a5bf65ddbc8bdb8525671977020b2181d51bac5730"⟩,⟨"SFT-CHEM-ORG-002-002","IUPAC::IUPAC-08205::complete-resonance-form-record::family-development-observed","resonance form complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-08205.json","sha256:b2683a3091a8fbb38e9eea6544b992cf1d9e62386befa309bec170d2ebcfd2bb"⟩,⟨"SFT-CHEM-ORG-002-003","IUPAC::IUPAC-C01309::complete-contributing-structure-record::family-development-observed","contributing structure complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-c01309.json","sha256:2e79ecba254a304e7f5c2240e5770ba995acbc1925d2ae3ec40ade4d7cbbbee4"⟩,⟨"SFT-CHEM-ORG-002-004","IUPAC::IUPAC-D01583::complete-delocalization-correspondence-record::family-identity-opened-by-admitted-ORG-001","delocalization complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-d01583.json","sha256:4a6ad1affe5c228511297827f6bd9ca2217697d9ff10089309369e924dfa3443"⟩]
def registration (program : Value) : Value := .object [
 ("experiment_id",.text "SFT-EXP-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002"),
 ("claim_id",.text "SFT-CHEM-RESONANCE-EQUIVALENT-REPRESENTATION-002"),
 ("provenance",.text "forward_forcing_with-value-free-sealed-organic-representation-vector"),
 ("frozen_relation",.text "one-retained-molecular-carrier__complete-equal-atom-occurrence-support__complete-equal-adjacency-support__multiple-distinct-encoding-identities__complete-opposed-fibre-complement__one-carrier-many-representations__representation-relation-only__shared-complement-successor-no-extra-rule"),
 ("identity_registry",.array [.text "experiments/external_sources/chemistry/org_002_target_identities_v1.json",.text "sha256:d90bb68121cb37ea8a2d85242fd0b3ba4673ec9e3eb01d151c79fb8118b0fbbc"]),
 ("withheld_target_registry",.array [.text "experiments/external_sources/chemistry/org_002_withheld_targets_v2.json",.text "sha256:873777e871d3b15278afd2502ac6fa4ad5b5083eb05192b06e16cf3b04d7be51"]),
 ("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/org-002-primary-records-v2.json",.text "sha256:0987db81474d56aacfeffa3b317e3380bfb4ec79b985ab09eed931594c366247"]),
 ("prediction_program",program),
 ("target_ids",.array [.text "SFT-CHEM-ORG-002-001",.text "SFT-CHEM-ORG-002-002",.text "SFT-CHEM-ORG-002-003",.text "SFT-CHEM-ORG-002-004"]),
 ("all_four_rows_required",.boolean true),
 ("target_content_inaccessible_to_prediction_execution",.boolean true),
 ("v1_search_scope_error_must_be_preserved",.boolean true),
 ("falsification_condition",.text "The claim fails if equivalent encodings change the carrier, atom occurrences or adjacency; if the minimal pair is not a complete opposed-fibre complement; if formal encodings are counted as multiple species or an equilibrium; if any of four complete records is omitted; if external wavefunction, coefficient or signed-charge language enters native forcing; if the V1 search-scope error is hidden; or if outcomes open before the value-free prediction seal.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("atoms",[false,true]),("adjacency",[false,true]),("encodings",[false,true]),("fibres",[false,true]),("identity",[false,true]),("process",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [ResonanceEquivalent.baseWitness,ResonanceEquivalent.successorWitness,ResonanceEquivalent.carrierWitness,ResonanceEquivalent.adjacencyWitness,ResonanceEquivalent.partialWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if ResonanceEquivalentEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
  .error "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 else if !SourceExtraction.unique (specDimensions.map Prod.fst) then
  .error "empirical Chemistry law contains duplicate dimensions"
 else if !(specDimensions.all (fun d => d.2.length == 2)) then
  .error "each Chemistry dimension must exhaust two registered forms"
 else if !(specDimensions.all (fun d => (d.2.filter id).length == 1)) then
  .error "dimension requires one preserving form"
 else if !SourceText.nonblank expectedLabel || !SourceText.nonblank falsification then
  .error "Chemistry prediction or falsification condition is missing"
 else if !SourceExtraction.unique (references.map Reference.targetId) then
  .error "Chemistry target identities are duplicated"
 else if references.any (fun row => !(Text.chars "sha256:").isPrefixOf (Text.chars row.snapshotHash)) then
  .error "Chemistry target snapshot identity is invalid"
 else if !(specWitnesses.all id) then
  .error "Chemistry operational witness failed"
 else .ok ()

#print axioms claimId
#print axioms experimentId
#print axioms frozenRelation
#print axioms falsification
#print axioms expectedLabel
#print axioms identityRegistryPath
#print axioms identityRegistryHash
#print axioms targetRegistryPath
#print axioms targetRegistryHash
#print axioms primarySourcePath
#print axioms primarySourceHash
#print axioms references
#print axioms registration
#print axioms labelValue
#print axioms envelope
#print axioms specDimensions
#print axioms specWitnesses
#print axioms validateSpec
end SFT.Chemistry.ResonanceEquivalentExperiment
