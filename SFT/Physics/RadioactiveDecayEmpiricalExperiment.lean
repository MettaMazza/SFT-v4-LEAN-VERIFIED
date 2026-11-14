import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.RadioactiveDecayEmpiricalEvidence
set_option maxRecDepth 20000
namespace SFT.Physics.RadioactiveDecayEmpiricalExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005"
def experimentId : String := "SFT-EXP-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005"
def expectedLabel : String := "sealed-three-primitive-radioactive-topologies-and-exact-survival-1-over-2-to-k__complete-NUBASE2020-5843-state-5500-decay-row-8718-entry-50-code-census__all-50-codes-map-to-release-conversion-deexcitation-or-ordered-composition__4700-positive-numeric-half-life-carriers-transport-without-selecting-the-law__alpha-beta-gamma-retained-as-representatives-while-literal-only-three-named-code-reading-is-rejected"
def frozenRelation : String := "All 50 distinct NUBASE2020 decay codes across 8,718 entries map to boundary release/decomposition, held-label conversion, internal de-excitation or an ordered composition. The table contains 4,700 positive numeric half-life carriers; exact transport yields survival 1/2^k at each positive integer multiple. Alpha, beta and gamma remain canonical representatives, while the literal claim that only three named codes exist is rejected."
def sourcePath : String := "experiments/external_sources/physics/snapshots/radioactive-decay-successor-source-record.json"
def snapshotHash : String := "sha256:9a2275f1c4f82f0bdf3d41b25a1c8af535fefb7451ea28bad4f6cb2beec32391"
def falsification : String := "The claim fails if any NUBASE2020 decay code cannot be expressed by the three primitive topologies or their composition, a positive half-life cannot transport exact finite survival, a row or uncertainty is omitted, the literal only-three-code claim is retained, or target access precedes sealing."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"NUBASE2020-COMPLETE-DECAY-CENSUS","AMDC-NUBASE2020-DECAY-HALFLIFE-2021","NUBASE2020 complete state, decay-row, mode-entry and distinct-code census","sealed-three-primitive-radioactive-topologies-and-exact-survival-1-over-2-to-k__complete-NUBASE2020-5843-state-5500-decay-row-8718-entry-50-code-census__all-50-codes-map-to-release-conversion-deexcitation-or-ordered-composition__4700-positive-numeric-half-life-carriers-transport-without-selecting-the-law__alpha-beta-gamma-retained-as-representatives-while-literal-only-three-named-code-reading-is-rejected"⟩,⟨"NUBASE2020-COMPLETE-HALFLIFE-CENSUS","AMDC-NUBASE2020-DECAY-HALFLIFE-2021","NUBASE2020 all positive numeric half-life carriers, units and reported uncertainties","sealed-three-primitive-radioactive-topologies-and-exact-survival-1-over-2-to-k__complete-NUBASE2020-5843-state-5500-decay-row-8718-entry-50-code-census__all-50-codes-map-to-release-conversion-deexcitation-or-ordered-composition__4700-positive-numeric-half-life-carriers-transport-without-selecting-the-law__alpha-beta-gamma-retained-as-representatives-while-literal-only-three-named-code-reading-is-rejected"⟩,⟨"NUBASE2020-RELEASE-REPRESENTATIVES","AMDC-NUBASE2020-DECAY-HALFLIFE-2021","NUBASE2020 uranium-238/beryllium-8 alpha, cluster and fission records","sealed-three-primitive-radioactive-topologies-and-exact-survival-1-over-2-to-k__complete-NUBASE2020-5843-state-5500-decay-row-8718-entry-50-code-census__all-50-codes-map-to-release-conversion-deexcitation-or-ordered-composition__4700-positive-numeric-half-life-carriers-transport-without-selecting-the-law__alpha-beta-gamma-retained-as-representatives-while-literal-only-three-named-code-reading-is-rejected"⟩,⟨"NUBASE2020-CONVERSION-REPRESENTATIVES","AMDC-NUBASE2020-DECAY-HALFLIFE-2021","NUBASE2020 carbon-14 beta-minus and beryllium-7 electron-capture records","sealed-three-primitive-radioactive-topologies-and-exact-survival-1-over-2-to-k__complete-NUBASE2020-5843-state-5500-decay-row-8718-entry-50-code-census__all-50-codes-map-to-release-conversion-deexcitation-or-ordered-composition__4700-positive-numeric-half-life-carriers-transport-without-selecting-the-law__alpha-beta-gamma-retained-as-representatives-while-literal-only-three-named-code-reading-is-rejected"⟩,⟨"NUBASE2020-DEEXCITATION-REPRESENTATIVE","AMDC-NUBASE2020-DECAY-HALFLIFE-2021","NUBASE2020 technetium-99m internal-transition record","sealed-three-primitive-radioactive-topologies-and-exact-survival-1-over-2-to-k__complete-NUBASE2020-5843-state-5500-decay-row-8718-entry-50-code-census__all-50-codes-map-to-release-conversion-deexcitation-or-ordered-composition__4700-positive-numeric-half-life-carriers-transport-without-selecting-the-law__alpha-beta-gamma-retained-as-representatives-while-literal-only-three-named-code-reading-is-rejected"⟩,⟨"NUBASE2020-ONLY-THREE-ADVERSE","AMDC-NUBASE2020-DECAY-HALFLIFE-2021","All NUBASE2020 proton, neutron, cluster, fission, capture and delayed composite codes","sealed-three-primitive-radioactive-topologies-and-exact-survival-1-over-2-to-k__complete-NUBASE2020-5843-state-5500-decay-row-8718-entry-50-code-census__all-50-codes-map-to-release-conversion-deexcitation-or-ordered-composition__4700-positive-numeric-half-life-carriers-transport-without-selecting-the-law__alpha-beta-gamma-retained-as-representatives-while-literal-only-three-named-code-reading-is-rejected"⟩]

def registration : Value := .object [
 ("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("frozen_relation",.text frozenRelation),("source_snapshot_path",.text sourcePath),
 ("source_snapshot_hash",.text snapshotHash),
 ("target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("target_locators",.array (targetRows.map fun row => .array [.text row.targetId,.text row.sourceId,.text row.sourceLocator])),
 ("prediction_program",programDocument),("expected_observation_label",.text expectedLabel),
 ("falsification_condition",.text falsification),("all_rows_required",.boolean true),
 ("target_inaccessible_before_seal",.boolean true)]

def registrationHash : String := admissionIdentity registration

def sourceMatches (bytes : ByteArray) : Bool :=
 Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) snapshotHash

def checkSource (bytes : ByteArray) : Except String Unit :=
 if sourceMatches bytes then .ok () else .error "ValueError: external measurement snapshot differs from registration"

def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetRows.map fun row => .text row.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]

def targets : List (String × Value) := targetRows.map fun row =>
 (row.targetId,labelValue "external-observation" row.observedLabel)

def targetsValue : Value := .object targets

theorem completeTargetCount : targetRows.length = 6 := rfl

theorem completeTargetLabels : targetRows.map ObservationCarrier.ExternalTargetRow.observedLabel = [expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel,expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-NUCLEAR-RADIOACTIVE-DECAY-TERMINAL-005", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (RadioactiveDecayEmpiricalWitnesses.witnesses.all RadioactiveDecayEmpiricalWitnesses.Witness.passed)

def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-PHYS-").isPrefixOf (Text.chars claimId) ||
    !(Text.chars "SFT-EXP-PHYS-").isPrefixOf (Text.chars experimentId) then
   .error "ValueError: empirical Physics identity is invalid"
 else if specDependencies.isEmpty || specDimensions.length != 8 || targetRows.isEmpty then
   .error "ValueError: empirical Physics law lacks dependencies, eight dimensions or targets"
 else if !uniqueNames (specDimensions.map Prod.fst) then
   .error "ValueError: empirical Physics law contains duplicate dimensions"
 else if !(specDimensions.all (fun d => d.2.length == 2)) then
   .error "ValueError: each empirical dimension must exhaust two registered forms"
 else if !(specDimensions.all (fun d => (d.2.filter id).length == 1)) then
   .error "ValueError: dimension requires one preserving form"
 else if !nonblank expectedLabel || !nonblank falsification then
   .error "ValueError: empirical prediction or falsification condition is missing"
 else if !uniqueNames (targetRows.map ObservationCarrier.ExternalTargetRow.targetId) then
   .error "ValueError: empirical target identities are duplicated"
 else
   let witnesses ← specWitnesses
   if witnesses then .ok () else .error "ValueError: empirical Physics operational witness failed"

theorem registeredSpecValid : validateSpec = .ok () := rfl

theorem sourceMatchesOriginal (bytes : ByteArray) :
 sourceMatches bytes = Text.equal (Text.append "sha256:" (SHA256.digest bytes)) snapshotHash := by
 unfold sourceMatches
 rw [SHA256Chunks.digestPreserved]

end SFT.Physics.RadioactiveDecayEmpiricalExperiment
