import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.YangMillsSpectrumEvidence
import SFT.Physics.YangMillsSpectrumRecords
set_option maxRecDepth 20000
namespace SFT.Physics.YangMillsSpectrumExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027"
def experimentId : String := "SFT-EXP-PHYS-YANG-MILLS-SINGLET-GAP-EMPIRICAL-027"
def expectedLabel : String := "positive-physical-colour-singlet-gap__all-registered-pure-gauge-glueball-intervals-positive__ground-and-excitation-order-retained__quenched-mixing-full-QCD-and-nonidentification-boundaries-retained__no-dimensional-fit"
def frozenRelation : String := "The sealed Fold prediction of a positive physical colour-singlet gap matches every retained PDG pure-gauge lattice interval: 0++ at 1653+/-26 MeV, 2++ at 2376+/-32 MeV and 0-+ at 2561+/-40 MeV are each strictly positive and their intervals are ordered and disjoint.  These are external lattice records, not fitted Fold values.  Quenching, state mixing, full-QCD requirements and the lack of an unambiguous experimental glueball remain explicit boundaries."
def sourcePath : String := "experiments/external_sources/physics/snapshots/yang-mills-singlet-gap-source-record.json"
def snapshotHash : String := "sha256:cf0ccdbcb6d2fe3c69a5b64f07da0b9e5aef93c7d32654b341ec2eb1397ae75c"
def falsification : String := "Reject if either source snapshot changes; if any registered spectrum or limitation row is omitted; if the least retained pure-gauge mass interval reaches the empty boundary; if registered intervals lose their stated ordering; if an external mass is imported into the Fold proof; if a lattice prediction is relabelled as direct detection; or if the target is available to the capability-closed predictor before sealing."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PDG-GLUEBALL-0PP-POSITIVE","PDG-2026-QUARK-MODEL-GLUEBALL-BOUNDARY","pages 11-12 scalar ground-state and precise 0++ row","positive-physical-colour-singlet-gap__all-registered-pure-gauge-glueball-intervals-positive__ground-and-excitation-order-retained__quenched-mixing-full-QCD-and-nonidentification-boundaries-retained__no-dimensional-fit"⟩,⟨"PDG-GLUEBALL-2PP-POSITIVE","PDG-2026-QUARK-MODEL-GLUEBALL-BOUNDARY","page 12 precise 2++ row","positive-physical-colour-singlet-gap__all-registered-pure-gauge-glueball-intervals-positive__ground-and-excitation-order-retained__quenched-mixing-full-QCD-and-nonidentification-boundaries-retained__no-dimensional-fit"⟩,⟨"PDG-GLUEBALL-0MP-POSITIVE","PDG-2026-QUARK-MODEL-GLUEBALL-BOUNDARY","page 12 precise 0-+ row","positive-physical-colour-singlet-gap__all-registered-pure-gauge-glueball-intervals-positive__ground-and-excitation-order-retained__quenched-mixing-full-QCD-and-nonidentification-boundaries-retained__no-dimensional-fit"⟩,⟨"PDG-GLUEBALL-ORDER","PDG-2026-QUARK-MODEL-GLUEBALL-BOUNDARY","pages 11-12 ground/first-excitation ordering","positive-physical-colour-singlet-gap__all-registered-pure-gauge-glueball-intervals-positive__ground-and-excitation-order-retained__quenched-mixing-full-QCD-and-nonidentification-boundaries-retained__no-dimensional-fit"⟩,⟨"PDG-GLUEBALL-THEORY-SCOPE","PDG-2026-QUARK-MODEL-GLUEBALL-BOUNDARY","pages 11 and 32 quenched, mixing and full-QCD limitations","positive-physical-colour-singlet-gap__all-registered-pure-gauge-glueball-intervals-positive__ground-and-excitation-order-retained__quenched-mixing-full-QCD-and-nonidentification-boundaries-retained__no-dimensional-fit"⟩,⟨"PDG-GLUEBALL-IDENTIFICATION-BOUNDARY","PDG-2026-QUARK-MODEL-GLUEBALL-BOUNDARY","pages 12 and 32 unresolved predominantly-glueball assignment","positive-physical-colour-singlet-gap__all-registered-pure-gauge-glueball-intervals-positive__ground-and-excitation-order-retained__quenched-mixing-full-QCD-and-nonidentification-boundaries-retained__no-dimensional-fit"⟩]

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

def targetIds : List String := ["PDG-2026-WITHHELD-COMPLETE-GLUEBALL-BOUNDARY"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← YangMillsSpectrumRecords.authoritativeRecord files payload
 pure [("PDG-2026-WITHHELD-COMPLETE-GLUEBALL-BOUNDARY",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=6 := rfl
theorem originalVaultTarget : targetIds=["PDG-2026-WITHHELD-COMPLETE-GLUEBALL-BOUNDARY"] := rfl
end SFT.Physics.YangMillsSpectrumExperiment
