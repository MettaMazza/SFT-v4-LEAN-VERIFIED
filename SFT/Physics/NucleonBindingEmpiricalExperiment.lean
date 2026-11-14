import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.NucleonBindingEmpiricalEvidence
set_option maxRecDepth 20000
namespace SFT.Physics.NucleonBindingEmpiricalExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-NUCLEON-BINDING-TERMINAL-005"
def experimentId : String := "SFT-EXP-PHYS-NUCLEON-BINDING-TERMINAL-005"
def expectedLabel : String := "sealed-three-colour-uud-udd-singlet-correspondence-passes-PDG__structural-one-over-128-and-PDG-uud-current-share-both-below-one-percent__nonidentity-of-those-two-objects-retained__held-residuals-above-99-percent__down-up-and-neutron-proton-ordering-pass-complete-PDG-NIST-intervals"
def frozenRelation : String := "PDG independently corresponds to a three-colour qqq singlet; both sealed 1/128 and the complete PDG uud current-mass fraction are below 1/100 while remaining explicitly non-identical objects; both residuals exceed 99/100; complete PDG d/u and NIST neutron/proton intervals preserve the sealed ordering."
def sourcePath : String := "experiments/external_sources/physics/snapshots/nucleon-binding-successor-source-record.json"
def snapshotHash : String := "sha256:2f75c5124ce570fad3becd1ff5901f6062c6dea05b5a41a1892819006fa6290e"
def falsification : String := "The claim fails if qqq colour closure differs, either complete dominance inequality fails, structural and scheme-dependent quantities are conflated, d/u or neutron/proton intervals cease to order, the direct mass difference leaves propagated intervals, a source/uncertainty changes, or target access precedes sealing."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PDG-THREE-COLOUR-QQQ-SINGLET","PDG-NIST-NUCLEON-BINDING-2022-2026","PDG 2025 Quark Model complete colour-singlet and baryon composition rows","sealed-three-colour-uud-udd-singlet-correspondence-passes-PDG__structural-one-over-128-and-PDG-uud-current-share-both-below-one-percent__nonidentity-of-those-two-objects-retained__held-residuals-above-99-percent__down-up-and-neutron-proton-ordering-pass-complete-PDG-NIST-intervals"⟩,⟨"PDG-LIGHT-QUARK-MASS-DOMINANCE","PDG-NIST-NUCLEON-BINDING-2022-2026","PDG 2025 MSbar 2 GeV u/d mass values with complete total uncertainties and scheme boundary","sealed-three-colour-uud-udd-singlet-correspondence-passes-PDG__structural-one-over-128-and-PDG-uud-current-share-both-below-one-percent__nonidentity-of-those-two-objects-retained__held-residuals-above-99-percent__down-up-and-neutron-proton-ordering-pass-complete-PDG-NIST-intervals"⟩,⟨"NIST-NUCLEON-MASS-ORDERING","PDG-NIST-NUCLEON-BINDING-2022-2026","NIST CODATA 2022 proton, neutron and direct difference energy-equivalent rows","sealed-three-colour-uud-udd-singlet-correspondence-passes-PDG__structural-one-over-128-and-PDG-uud-current-share-both-below-one-percent__nonidentity-of-those-two-objects-retained__held-residuals-above-99-percent__down-up-and-neutron-proton-ordering-pass-complete-PDG-NIST-intervals"⟩]

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

theorem completeTargetCount : targetRows.length = 3 := rfl

theorem completeTargetLabels : targetRows.map ObservationCarrier.ExternalTargetRow.observedLabel = [expectedLabel,expectedLabel,expectedLabel] := rfl

theorem changedSourceRejected (bytes : ByteArray) (changed : sourceMatches bytes = false) :
 checkSource bytes = .error "ValueError: external measurement snapshot differs from registration" := by
 unfold checkSource
 rw [changed]
 rfl

def specDependencies : List String := ["SFT-PHYS-NUCLEON-BINDING-TERMINAL-005", "SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001", "SFT-PHYS-MEAS-TARGET-CUSTODY-001", "SFT-PHYS-MEAS-UNCERTAINTY-001", "SFT-MATH-EXACT-ARITHMETIC-001"]

def specDimensions : List (String × List Bool) :=
 [("carrier",[false,true]),("relation",[false,true]),("provenance",[false,true]),
 ("prediction",[false,true]),("record",[false,true]),("rows",[false,true]),
 ("generality",[false,true]),("extension",[false,true])]

def uniqueNames : List String → Bool
 | [] => true
 | head::tail => !(tail.any (Text.equal head)) && uniqueNames tail

def specWitnesses : Except String Bool := .ok (NucleonBindingEmpiricalWitnesses.witnesses.all NucleonBindingEmpiricalWitnesses.Witness.passed)

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

end SFT.Physics.NucleonBindingEmpiricalExperiment
