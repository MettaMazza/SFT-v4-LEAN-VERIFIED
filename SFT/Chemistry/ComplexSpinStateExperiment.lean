import SFT.Chemistry.ComplexSpinStateEvidence
import SFT.Chemistry.ComplexSpinStateSource
import SFT.Chemistry.ComplexSpinState
import SFT.Chemistry.ComplexSpinStateDerivation
import SFT.Chemistry.PairExchangeExperiment
namespace SFT.Chemistry.ComplexSpinStateExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
def claimId : String := "SFT-CHEM-COMPLEX-SPIN-STATE-ORDER-007"
def experimentId : String := "SFT-EXP-CHEM-COMPLEX-SPIN-STATE-ORDER-007"
def expectedLabel : String := "complete-high-low-crossover-definition-and-exact-value-vector"
def falsification : String := "The claim fails if the complete six-electron quotient census is not ten; if either extremum is nonunique; if the exact low and high signatures, spin widths or crossing counts differ; if the weak/boundary/strong order vector differs; if numerical zero, signed spin, a field or pairing parameter, a dimensional fit or measured target enters forcing; if any of the three registered external rows or the HT06789 transport mismatch is removed; or if the complete post-seal crossover row does not retain low spin at the shorter reported distance and high spin at the longer reported distance."
def targetRegistryHash : String := "sha256:c428c6350e9d4f6c79e362ef9b256cf278b003529e2d5d82cf793f639822866d"
def sourceFiles : List (String × String) := [("experiments/external_sources/chemistry/complex_spin_state_order_withheld_targets_v1.json","sha256:c428c6350e9d4f6c79e362ef9b256cf278b003529e2d5d82cf793f639822866d"),("experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/complex-spin-state-order-primary-records-v1.json","sha256:bad9ea5c0bf768db64a2fda8739f45889ab24cef27c2d089fffea7992684ee7e")]
def sourceIds : List String := ["IUPAC-HT06789","IUPAC-LT07067","IUPAC-ST07104"]
def references : List SourceExtraction.Reference := [⟨"SFT-CHEM-INORG-007-TARGET-001","IUPAC::IUPAC-HT06789::registered-high-spin-definition-surface::family-identity-sealed-before-capture","IUPAC-HT06789 :: registered-high-spin-definition-surface :: family-identity-sealed-before-capture","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-ht06789.html","sha256:7d2fa955a1cfeb300fa1059af7bfe4bed4ac8e7b13cbad156539d5ec030c9d35"⟩,⟨"SFT-CHEM-INORG-007-TARGET-002","IUPAC::IUPAC-LT07067::registered-low-spin-order-definition-surface::family-identity-sealed-before-capture","IUPAC-LT07067 :: registered-low-spin-order-definition-surface :: family-identity-sealed-before-capture","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-lt07067.json","sha256:0b505b9f07c78b939e5643cc8ffe950fcfcc99c3d3d398bd3ebc5b4e30a7838b"⟩,⟨"SFT-CHEM-INORG-007-TARGET-003","IUPAC::IUPAC-ST07104::registered-crossover-value-vector::family-development-observed-complete-row-preserved","IUPAC-ST07104 :: registered-crossover-value-vector :: family-development-observed-complete-row-preserved","experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/iupac-st07104.json","sha256:4fe37dde5a09b5a844fd8344272d0d04c0096260a2ceffe320095e82d6ccef64"⟩]
def registration (program : Value) : Value := .object [("experiment_id",.text "SFT-EXP-CHEM-COMPLEX-SPIN-STATE-ORDER-007"),("claim_id",.text "SFT-CHEM-COMPLEX-SPIN-STATE-ORDER-007"),("provenance",.text "forward_forcing_with_family-sealed_external_comparison"),("frozen_relation",.text "one-complex-electron-support__forced-three-plus-two-support__complete-pair-single-occupancy-census__least-crossing-then-least-unmatched-extremum__greatest-unmatched-then-least-crossing-extremum__counted-pair-closure-plus-split-crossing-paths__complete-weak-boundary-strong-trichotomy__monotone-dilution-with-no-extra-rule"),("identity_registry",.array [.text "experiments/external_sources/chemistry/complex_spin_state_order_target_identities_v1.json",.text "sha256:0bac4d73f7add7f9dd93a42b59da32b783225a2b34e92015e31b0c9cdaf06a79"]),("withheld_target_registry",.array [.text "experiments/external_sources/chemistry/complex_spin_state_order_withheld_targets_v1.json",.text "sha256:c428c6350e9d4f6c79e362ef9b256cf278b003529e2d5d82cf793f639822866d"]),("primary_source_record",.array [.text "experiments/external_sources/chemistry/snapshots/inorg-004-017-family-v1/complex-spin-state-order-primary-records-v1.json",.text "sha256:bad9ea5c0bf768db64a2fda8739f45889ab24cef27c2d089fffea7992684ee7e"]),("prediction_program",program),("target_ids",.array [.text "SFT-CHEM-INORG-007-TARGET-001",.text "SFT-CHEM-INORG-007-TARGET-002",.text "SFT-CHEM-INORG-007-TARGET-003"]),("all_three_rows_required",.boolean true),("registered_transport_mismatch_must_be_preserved",.boolean true),("target_content_inaccessible_to_prediction_execution",.boolean true),("no_field_pairing_temperature_distance_or_species_fit",.boolean true),("falsification_condition",.text "The claim fails if the complete six-electron quotient census is not ten; if either extremum is nonunique; if the exact low and high signatures, spin widths or crossing counts differ; if the weak/boundary/strong order vector differs; if numerical zero, signed spin, a field or pairing parameter, a dimensional fit or measured target enters forcing; if any of the three registered external rows or the HT06789 transport mismatch is removed; or if the complete post-seal crossover row does not retain low spin at the shorter reported distance and high spin at the longer reported distance.")]
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def envelope (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (references.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def specDimensions : List (String × List Bool) := [("carrier",[false,true]),("split",[false,true]),("enumeration",[false,true]),("low",[false,true]),("high",[false,true]),("cost",[false,true]),("order",[false,true]),("extension",[false,true])]
def specWitnesses : List Bool := [ComplexSpinStateDerivation.censusWitness,ComplexSpinStateDerivation.lowWitness,ComplexSpinStateDerivation.highWitness,ComplexSpinStateDerivation.orderWitness,ComplexSpinStateDerivation.capacityWitness,ComplexSpinStateDerivation.occupancyWitness]
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then
  .error "empirical Chemistry claim identity is invalid"
 else if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then
  .error "empirical Chemistry experiment identity is invalid"
 else if ComplexSpinStateEvidence.dependencies.isEmpty || specDimensions.length != 8 || references.isEmpty then
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

end SFT.Chemistry.ComplexSpinStateExperiment
