import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.ThermalMeasuredEvidence
import SFT.Physics.ThermalMeasuredRecords
set_option maxRecDepth 20000
namespace SFT.Physics.ThermalMeasuredExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-THERMAL-HISTORY-MEASURED-VALUE-058"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-THERMAL-HISTORY-MEASURED-VALUE-058"
def expectedLabel : String := "temperature-exponent-and-physical-helium-59-over-240-inside-measurements__freezeout-deuterium-recombination-and-acoustic-records-complete__no-quarter-exclusion-reward"
def frozenRelation : String := "Exact exponent One lies inside [49/50,517/500]. Exact physical helium-isotope share 59/240 lies inside [489/2000,2471/10000]. The one-sixth to one-seventh freezeout sequence, positive deuterium, finite recombination support, eighteen extrema and all seven TT rows remain complete. No excluded quarter or angular noninteger record is admitted as a successful result."
def sourcePath : String := "experiments/external_sources/physics/snapshots/thermal-history-measured-value-successor-source-record.json"
def snapshotHash : String := "sha256:9b62430aa48d7f3d1811327ca147c133777c9e7c37cfcfff3e927f04e7a68641"
def falsification : String := "Reject if a source or dependency changes; exponent One or 59/240 leaves its complete measured interval; the freezeout sequence, positive deuterium, finite recombination support, extrema or TT rows are missing; an uncertainty is widened; a mismatch is rewarded; or targets alter either formal survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"CMB-TEMPERATURE-EXPONENT","NOTERDAEME-ET-AL-2011-CMB-TEMPERATURE","complete measured exponent interval","temperature-exponent-and-physical-helium-59-over-240-inside-measurements__freezeout-deuterium-recombination-and-acoustic-records-complete__no-quarter-exclusion-reward"⟩,⟨"PHYSICAL-PRIMORDIAL-HELIUM","AVER-ET-AL-2026-PRIMORDIAL-HELIUM","complete direct Yp interval","temperature-exponent-and-physical-helium-59-over-240-inside-measurements__freezeout-deuterium-recombination-and-acoustic-records-complete__no-quarter-exclusion-reward"⟩,⟨"PRIMORDIAL-DEUTERIUM","COOKE-PETTINI-STEIDEL-2018-DEUTERIUM","complete direct D/H interval","temperature-exponent-and-physical-helium-59-over-240-inside-measurements__freezeout-deuterium-recombination-and-acoustic-records-complete__no-quarter-exclusion-reward"⟩,⟨"PLANCK-PEAK-CENSUS","PLANCK-2018-OVERVIEW-PEAKS","eighteen extrema and complete seven TT rows","temperature-exponent-and-physical-helium-59-over-240-inside-measurements__freezeout-deuterium-recombination-and-acoustic-records-complete__no-quarter-exclusion-reward"⟩,⟨"PLANCK-RECOMBINATION","PLANCK-2018-COSMOLOGICAL-PARAMETERS","finite recombination-redshift record","temperature-exponent-and-physical-helium-59-over-240-inside-measurements__freezeout-deuterium-recombination-and-acoustic-records-complete__no-quarter-exclusion-reward"⟩,⟨"PDG-FREEZEOUT-CAPTURE","PDG-2025-BBN-REVIEW","complete approximate one-sixth to one-seventh sequence","temperature-exponent-and-physical-helium-59-over-240-inside-measurements__freezeout-deuterium-recombination-and-acoustic-records-complete__no-quarter-exclusion-reward"⟩]

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

def targetIds : List String := ["THERMAL-HISTORY-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← ThermalMeasuredRecords.authoritativeRecord files payload
 pure [("THERMAL-HISTORY-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD",record)]
theorem completeTargetCount : targetRows.length=6 := rfl
theorem originalVaultTarget : targetIds=["THERMAL-HISTORY-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"] := rfl
end SFT.Physics.ThermalMeasuredExperiment
