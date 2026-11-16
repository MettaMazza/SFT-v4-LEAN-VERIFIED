import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.InflationObservationEvidence
import SFT.Physics.InflationObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.InflationObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-INFLATION-GROWTH-040"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-INFLATION-GROWTH-040"
def expectedLabel : String := "sealed-inflation-growth-law__complete-scalar-index-and-tensor-bound-record__exact-31-of-32-partition-tested-without-fit"
def frozenRelation : String := "Planck ns=0.9649+/-0.0042 gives exact interval [9607/10000,9691/10000]; the independently forced 31/32 equals 0.96875 and lies inside that interval. BICEP/Keck plus Planck reports r<0.032=4/125 at 95 percent; the independently forced 1/32=0.03125 lies strictly below the bound by 3/4000=0.00075. The complete exact 31/32+1/32 partition therefore passes both external rows without fitting. Five Fold doublings is not relabelled as a conventional natural-log e-fold count, for which this claim asserts no measured equality."
def sourcePath : String := "experiments/external_sources/physics/snapshots/inflation-growth-postseal-source-record.json"
def snapshotHash : String := "sha256:b04ac2ae7426e91117f0f7594019354fd4921629b22e42dbc38d3acce93ff45b"
def falsification : String := "Reject if any source identity or registered row changes; if 31/32 leaves the complete scalar interval; if 1/32 is not strictly below the tensor bound; if the narrow margin is omitted; if conventional e-fold language is asserted as exact equality; or if a target changes the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"PLANCK-SCALAR-INDEX","PLANCK-2018-INFLATION","Scalar index central value and complete standard interval","sealed-inflation-growth-law__complete-scalar-index-and-tensor-bound-record__exact-31-of-32-partition-tested-without-fit"⟩,⟨"BICEP-PLANCK-TENSOR-BOUND","BICEP-PLANCK-2022-TENSOR","Strict 95 percent tensor-to-scalar upper bound","sealed-inflation-growth-law__complete-scalar-index-and-tensor-bound-record__exact-31-of-32-partition-tested-without-fit"⟩]

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

def targetIds : List String := ["INFLATION-GROWTH-WITHHELD-COMPLETE-OBSERVATION-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← InflationObservationRecords.authoritativeRecord files payload
 pure [("INFLATION-GROWTH-WITHHELD-COMPLETE-OBSERVATION-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=2 := rfl
theorem originalVaultTarget : targetIds=["INFLATION-GROWTH-WITHHELD-COMPLETE-OBSERVATION-RECORD"] := rfl
end SFT.Physics.InflationObservationExperiment
