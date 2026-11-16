import SFT.Chemistry.ConjugatedSupportEvidence
import SFT.Chemistry.ConjugatedSupportPrediction
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
set_option maxRecDepth 100000
namespace SFT.Chemistry.ConjugatedSupportExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics SourceExtraction
def claimId : String := "SFT-CHEM-CONJUGATED-SUPPORT-001"
def experimentId : String := "SFT-EXP-CHEM-CONJUGATED-SUPPORT-001"
def frozenRelation : String := "one-retained-molecular-subcarrier__complete-connected-adjacency-path__two-forced-held-support-fibres__exact-opposed-adjacent-fibre-recurrence__complete-atom-and-incidence-support__shared-centre-support-propagation__structure-sealed-before-external-observation__opposed-fibre-successor-no-extra-rule"
def falsification : String := "The claim fails if its path is disconnected; if any atom, incidence or support fibre is omitted; if adjacent fibres repeat; if an external name, definition, coordinate or spectrum selects the survivor; if the separated-double-bond control is misclassified from bond counts alone; if any of ten rows or any of 502 UV-visible points is lost; if the external signed control inscription is erased or made native; if the V1 parser overrun is hidden; or if outcomes open before the value-free prediction seal."
def expectedLabel : String := "complete-connected-alternating-conjugated-support-structure-and-spectrum-vector"
def identityRegistryPath : String := "experiments/external_sources/chemistry/org_001_target_identities_v1.json"
def identityRegistryHash : String := "sha256:8d63eeae30f819ec961ac73e98add98258ad48faa670d0ea140ed9bd2271a893"
def targetRegistryPath : String := "experiments/external_sources/chemistry/org_001_withheld_targets_v2.json"
def targetRegistryHash : String := "sha256:580934f71639b83e6e1f5e24ddd87e8bb19db150a6bdae3c4b6e899a34b74192"
def primarySourcePath : String := "experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/org-001-primary-records-v2.json"
def primarySourceHash : String := "sha256:6d40642ebbd21ff6b9abb72a09e0cc0b76a40539540b50d07add3666a5375550"
def references : List Reference := [⟨"SFT-CHEM-ORG-001-001","IUPAC::IUPAC-C01267::complete-conjugated-system-record::family-development-observed","conjugated system complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-c01267.json","sha256:0783de7619d1738cd5977f0921dd08596452118a00da0c75aeb32b23fc2f2b53"⟩,⟨"SFT-CHEM-ORG-001-002","IUPAC::IUPAC-08786::complete-pi-conjugated-system-record::family-development-observed","pi-conjugated system complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-08786.json","sha256:f9a6746d14f359927f1a38df5811c87770d759613250c5ff7800b56cdbbe1497"⟩,⟨"SFT-CHEM-ORG-001-003","IUPAC::IUPAC-D01583::complete-delocalization-record::family-identity-only-unopened","delocalization complete current term record","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/iupac-d01583.json","sha256:4a6ad1affe5c228511297827f6bd9ca2217697d9ff10089309369e924dfa3443"⟩,⟨"SFT-CHEM-ORG-001-004","NIST CCCBDB::NIST-CCCBDB-106990-NEUTRAL-EXPERIMENTAL::complete-conjugated-molecular-identity-surface::family-development-observed","CAS 106-99-0 neutral complete experimental-property page","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/nist-cccbdb-106990-neutral-experimental.html","sha256:84bc04038ede574a76e387c61f038bf7f412742f139e9033f4572b5779317d66"⟩,⟨"SFT-CHEM-ORG-001-005","NIST CCCBDB::NIST-CCCBDB-106990-NEUTRAL-EXPERIMENTAL::complete-conjugated-bond-and-coordinate-surface::family-development-observed","CAS 106-99-0 neutral complete experimental-property page","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/nist-cccbdb-106990-neutral-experimental.html","sha256:84bc04038ede574a76e387c61f038bf7f412742f139e9033f4572b5779317d66"⟩,⟨"SFT-CHEM-ORG-001-006","NIST CCCBDB::NIST-CCCBDB-106990-NEUTRAL-EXPERIMENTAL::complete-conjugated-vibrational-surface::family-development-observed","CAS 106-99-0 neutral complete experimental-property page","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/nist-cccbdb-106990-neutral-experimental.html","sha256:84bc04038ede574a76e387c61f038bf7f412742f139e9033f4572b5779317d66"⟩,⟨"SFT-CHEM-ORG-001-007","NIST CCCBDB::NIST-CCCBDB-591935-NEUTRAL-GEOMETRY::complete-separated-double-bond-control-identity::family-development-observed","CAS 591-93-5 neutral complete experimental-geometry page","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/nist-cccbdb-591935-neutral-geometry.html","sha256:0893bd81347c5c0220d73cf6edb00e6cf7be405afb29ee38bfe9df96407652d6"⟩,⟨"SFT-CHEM-ORG-001-008","NIST CCCBDB::NIST-CCCBDB-591935-NEUTRAL-GEOMETRY::complete-separated-double-bond-control-coordinate-surface::family-development-observed","CAS 591-93-5 neutral complete experimental-geometry page","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/nist-cccbdb-591935-neutral-geometry.html","sha256:0893bd81347c5c0220d73cf6edb00e6cf7be405afb29ee38bfe9df96407652d6"⟩,⟨"SFT-CHEM-ORG-001-009","NIST Chemistry WebBook SRD 69::NIST-WEBBOOK-C106990-SPECTRA::complete-uv-visible-spectrum-metadata-and-link-surface::family-development-observed","CAS 106-99-0 complete returned phase-change, IR and UV-visible spectrum surface","experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/nist-webbook-c106990-spectra.html","sha256:95e197d79153a8092487190884a97ac540d3efc8dc5b0b1a5c424a0e1f566373"⟩,⟨"SFT-CHEM-ORG-001-010","NIST Chemistry WebBook SRD 69::NIST-WEBBOOK-C106990-UVVIS-JCAMP-INDEX-0::complete-uv-visible-jcamp-point-surface::addendum-identity-only-unopened","CAS 106-99-0 UV-visible spectrum, sole linked JCAMP-DX payload at registered index 0","experiments/external_sources/chemistry/snapshots/org-001-spectral-addendum-v1/nist-c106990-uvvis-index-0.jdx","sha256:47331306d7e7be8c4b9cbf694b0eedf4a940915793e78ed313521b1fee18c81b"⟩]
def registration (program : Value) : Value := .object [
 ("experiment_id",.text "SFT-EXP-CHEM-CONJUGATED-SUPPORT-001"),
 ("claim_id",.text "SFT-CHEM-CONJUGATED-SUPPORT-001"),
 ("provenance",.text "forward_forcing_with-value-free-sealed-organic-structure-and-spectrum-vector"),
 ("frozen_relation",.text "one-retained-molecular-subcarrier__complete-connected-adjacency-path__two-forced-held-support-fibres__exact-opposed-adjacent-fibre-recurrence__complete-atom-and-incidence-support__shared-centre-support-propagation__structure-sealed-before-external-observation__opposed-fibre-successor-no-extra-rule"),
 ("identity_registry",.array [.text "experiments/external_sources/chemistry/org_001_target_identities_v1.json",.text "sha256:8d63eeae30f819ec961ac73e98add98258ad48faa670d0ea140ed9bd2271a893"]),
 ("withheld_target_registry",.array [.text "experiments/external_sources/chemistry/org_001_withheld_targets_v2.json",.text "sha256:580934f71639b83e6e1f5e24ddd87e8bb19db150a6bdae3c4b6e899a34b74192"]),
 ("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/org-001-016-family-v1/org-001-primary-records-v2.json",.text "sha256:6d40642ebbd21ff6b9abb72a09e0cc0b76a40539540b50d07add3666a5375550"]),
 ("prediction_program",program),
 ("target_ids",.array [.text "SFT-CHEM-ORG-001-001",.text "SFT-CHEM-ORG-001-002",.text "SFT-CHEM-ORG-001-003",.text "SFT-CHEM-ORG-001-004",.text "SFT-CHEM-ORG-001-005",.text "SFT-CHEM-ORG-001-006",.text "SFT-CHEM-ORG-001-007",.text "SFT-CHEM-ORG-001-008",.text "SFT-CHEM-ORG-001-009",.text "SFT-CHEM-ORG-001-010"]),
 ("all_ten_rows_required",.boolean true),
 ("all_uv_visible_points_required",.boolean true),
 ("target_content_inaccessible_to_prediction_execution",.boolean true),
 ("v1_parser_overrun_must_be_preserved",.boolean true),
 ("falsification_condition",.text "The claim fails if its path is disconnected; if any atom, incidence or support fibre is omitted; if adjacent fibres repeat; if an external name, definition, coordinate or spectrum selects the survivor; if the separated-double-bond control is misclassified from bond counts alone; if any of ten rows or any of 502 UV-visible points is lost; if the external signed control inscription is erased or made native; if the V1 parser overrun is hidden; or if outcomes open before the value-free prediction seal.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("connectivity",[false,true]),("fibres",[false,true]),("alternation",[false,true]),("coverage",[false,true]),("propagation",[false,true]),("observation",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [ConjugatedSupportWitnesses.baseWitness,ConjugatedSupportWitnesses.successorWitness,ConjugatedSupportWitnesses.repetitionWitness,ConjugatedSupportWitnesses.coverageWitness,ConjugatedSupportWitnesses.identityWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if ConjugatedSupportEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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
end SFT.Chemistry.ConjugatedSupportExperiment
