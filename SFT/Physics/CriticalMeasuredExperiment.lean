import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.CriticalMeasuredEvidence
import SFT.Physics.CriticalMeasuredRecords
set_option maxRecDepth 20000
namespace SFT.Physics.CriticalMeasuredExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-CRITICALITY-MEASURED-VALUE-056"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-CRITICALITY-MEASURED-VALUE-056"
def expectedLabel : String := "all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"
def frozenRelation : String := "All five manganite structural keys identify the binary local-order mean-field class. The complete fifteen-value mean squared normalized residual is exactly 5286961/10584000, below the One. The erbium beta/gamma/nu intervals contain 1/2, One and 1/2; the turbulence interval contains 2/3; and both physical routes exhibit the registered falling five-thirds plateau. No material mismatch is an acceptance condition."
def sourcePath : String := "experiments/external_sources/physics/snapshots/criticality-measured-value-successor-source-record.json"
def snapshotHash : String := "sha256:5a4db9bd5af7028de244c97e18e75fd4d2cd0b7004a6778c8581b493c99537f5"
def falsification : String := "Reject if a source or dependency changes; any material structural key is incomplete; the complete fifteen-value mean squared residual reaches the One; erbium or turbulence excludes a sealed exponent; either spectrum route is absent; any row is omitted or uncertainty rescaled; La02 displacement is rewarded; or targets alter the survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"MANGANITE-La00","SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026","complete structural key and beta/gamma/delta row for La00","all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"⟩,⟨"MANGANITE-La02","SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026","complete structural key and beta/gamma/delta row for La02","all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"⟩,⟨"MANGANITE-La04","SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026","complete structural key and beta/gamma/delta row for La04","all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"⟩,⟨"MANGANITE-La06","SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026","complete structural key and beta/gamma/delta row for La06","all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"⟩,⟨"MANGANITE-La08","SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026","complete structural key and beta/gamma/delta row for La08","all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"⟩,⟨"ERBIUM-COMPLETE-VECTOR","MCMASTER-LIN-ERBIUM-CRITICAL-SCATTERING-1993","complete beta/gamma/nu vector","all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"⟩,⟨"TURBULENCE-STRUCTURE","APS-MCCOMB-TURBULENCE-STRUCTURE-2014","complete zeta2 interval","all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"⟩,⟨"TURBULENCE-SPECTRUM","APS-HUANG-TURBULENCE-SPECTRUM-2010","both five-thirds plateau routes","all-five-manganite-structural-class-keys-and-complete-fifteen-value-ledger-pass__erbium-and-both-turbulence-routes-pass__no-La02-mismatch-reward"⟩]

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

def targetIds : List String := ["CRITICALITY-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← CriticalMeasuredRecords.authoritativeRecord files payload
 pure [("CRITICALITY-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD",record)]
theorem completeTargetCount : targetRows.length=8 := rfl
theorem originalVaultTarget : targetIds=["CRITICALITY-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD"] := rfl
end SFT.Physics.CriticalMeasuredExperiment
