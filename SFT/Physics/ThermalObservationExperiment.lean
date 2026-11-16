import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.ThermalObservationEvidence
import SFT.Physics.ThermalObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.ThermalObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-THERMAL-HISTORY-RECOMBINATION-038"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-THERMAL-HISTORY-RECOMBINATION-038"
def expectedLabel : String := "sealed-thermal-history-law__complete-temperature-abundance-recombination-peak-record__quarter-equality-and-angular-integer-controls-retained__no-fit"
def frozenRelation : String := "The direct high-redshift CMB temperature exponent interval [49/50,517/500] contains exact One. The external freeze-out sequence is approximately 1/6 then 1/7, matching the separately forced typed transport. Direct helium Yp=0.2458+/-0.0013 gives [489/2000,2471/10000], which excludes 1/4; therefore 1/4 remains the exact analytic helium-family partition and is not relabelled as the exact isotope measurement. Direct primordial deuterium (2.527+/-0.030) times 10^-5 is positive and subordinate. Planck retains z*=1089.92+/-0.25, eighteen finite extrema and seven complete TT peak rows. Those angular peak intervals are not integer multiples of the first, so the internal-whole-mode/observed-projection distinction passes and the old angular-integer reading is rejected."
def sourcePath : String := "experiments/external_sources/physics/snapshots/thermal-history-postseal-source-record.json"
def snapshotHash : String := "sha256:8ce41a6c68923395da2502fbb8e078dc770ac2c7648c966b241d8c671273a0d8"
def falsification : String := "Reject if any source identity or registered row changes; if exact One leaves the temperature-exponent interval; if the typed One/six to One/seven sequence is absent; if the unfavorable helium exclusion is hidden or used to fit a correction; if deuterium is nonpositive; if recombination support or the acoustic census is erased; if observed peak intervals are falsely relabelled as exact integer multiples; or if any target changes the formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"CMB-TEMPERATURE-EXPONENT","NOTERDAEME-ET-AL-2011-CMB-TEMPERATURE","Direct high-redshift temperature exponent and uncertainty","sealed-thermal-history-law__complete-temperature-abundance-recombination-peak-record__quarter-equality-and-angular-integer-controls-retained__no-fit"⟩,⟨"PRIMORDIAL-HELIUM","AVER-ET-AL-2026-PRIMORDIAL-HELIUM","Current direct helium mass fraction and unfavorable exact-quarter control","sealed-thermal-history-law__complete-temperature-abundance-recombination-peak-record__quarter-equality-and-angular-integer-controls-retained__no-fit"⟩,⟨"PRIMORDIAL-DEUTERIUM","COOKE-PETTINI-STEIDEL-2018-DEUTERIUM","Direct deuterium abundance and uncertainty","sealed-thermal-history-law__complete-temperature-abundance-recombination-peak-record__quarter-equality-and-angular-integer-controls-retained__no-fit"⟩,⟨"PLANCK-ACOUSTIC-EXTREMA","PLANCK-2018-OVERVIEW-PEAKS","Complete seven TT peak rows and eighteen-extrema mission count","sealed-thermal-history-law__complete-temperature-abundance-recombination-peak-record__quarter-equality-and-angular-integer-controls-retained__no-fit"⟩,⟨"PLANCK-RECOMBINATION","PLANCK-2018-COSMOLOGICAL-PARAMETERS","Finite recombination redshift record and uncertainty","sealed-thermal-history-law__complete-temperature-abundance-recombination-peak-record__quarter-equality-and-angular-integer-controls-retained__no-fit"⟩,⟨"FREEZEOUT-SEQUENCE","PDG-2025-BBN-REVIEW","One-sixth to one-seventh analytic transport benchmark","sealed-thermal-history-law__complete-temperature-abundance-recombination-peak-record__quarter-equality-and-angular-integer-controls-retained__no-fit"⟩]

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

def targetIds : List String := ["THERMAL-HISTORY-WITHHELD-COMPLETE-OBSERVATION-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← ThermalObservationRecords.authoritativeRecord files payload
 pure [("THERMAL-HISTORY-WITHHELD-COMPLETE-OBSERVATION-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=6 := rfl
theorem originalVaultTarget : targetIds=["THERMAL-HISTORY-WITHHELD-COMPLETE-OBSERVATION-RECORD"] := rfl
end SFT.Physics.ThermalObservationExperiment
