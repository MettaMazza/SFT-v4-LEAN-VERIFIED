import SFT.Foundation.AdmissionControls
import SFT.Host.SHA256Chunks
import SFT.Physics.ObservationPrediction
import SFT.Physics.CriticalObservationEvidence
import SFT.Physics.CriticalObservationRecords
set_option maxRecDepth 20000
namespace SFT.Physics.CriticalObservationExperiment
open SFT.Host SFT.Host.Canonical
open SFT.Foundation.AdmissionControls (admissionIdentity)
def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def nonblank := CapabilityValues.nonblank

abbrev TargetRow := ObservationCarrier.ExternalTargetRow
def claimId : String := "SFT-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048"
def experimentId : String := "SFT-EXP-PHYS-VALIDATION-CRITICALITY-UNIVERSALITY-TURBULENCE-048"
def expectedLabel : String := "sealed-criticality-and-cascade__complete-exponent-intervals-and-five-thirds-plateaux__nonmatching-row-and-boundaries-retained"
def frozenRelation : String := "The erbium intervals [46,50]/100 for beta, [90,102]/100 for gamma and [47,51]/100 for nu contain exactly 1/2, One and 1/2. Of the complete five-row manganite record, La00, La04, La06 and La08 contain the entire beta=1/2, gamma=One, delta=three vector; La02 excludes gamma=One and delta=three and therefore cannot be admitted to that generated universality class. The independent turbulence interval [666,692]/1000 contains exactly 2/3. A Reynolds-count-720 physical flow exhibits five-thirds compensated plateaux over 40--4000 Hz by Fourier analysis and 20--2000 Hz by Hilbert analysis. The nonmatching composition, finite-Reynolds correction boundary, structure-function range limitation, normalized-threshold boundary and empty-exponent typing are all retained."
def sourcePath : String := "experiments/external_sources/physics/snapshots/criticality-universality-turbulence-postseal-source-record.json"
def snapshotHash : String := "sha256:7c3cb34584f3581b46c9c9e1f91d2c550cfd8441761a512fee767baf8cc801fa"
def falsification : String := "Reject if any source or reported row changes; the erbium vector excludes a sealed carrier; fewer than the registered four manganite rows match or La02 is concealed or relabelled as a complete match; the zeta_2 interval excludes 2/3; either registered physical spectrum route lacks its five-thirds plateau; any limitation is omitted; or target data alter the sealed survivor."
def program := ObservationPrediction.predictionProgram experimentId expectedLabel
def programValue : Value := CapabilityExecution.canonicalProgram program
def programDocument : Value := .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def targetRows : List TargetRow := [⟨"MANGANITE-CRITICAL-VECTOR","SPRINGER-CETIN-MANGANITE-CRITICAL-EXPONENTS-2026","Complete five-composition beta/gamma/delta interval vector, including nonmatch","sealed-criticality-and-cascade__complete-exponent-intervals-and-five-thirds-plateaux__nonmatching-row-and-boundaries-retained"⟩,⟨"ERBIUM-CRITICAL-VECTOR","MCMASTER-LIN-ERBIUM-CRITICAL-SCATTERING-1993","Physical beta/gamma/nu neutron-scattering interval vector","sealed-criticality-and-cascade__complete-exponent-intervals-and-five-thirds-plateaux__nonmatching-row-and-boundaries-retained"⟩,⟨"TURBULENCE-STRUCTURE-EXPONENT","APS-MCCOMB-TURBULENCE-STRUCTURE-2014","Independent computational zeta_2 interval and finite-Reynolds boundary","sealed-criticality-and-cascade__complete-exponent-intervals-and-five-thirds-plateaux__nonmatching-row-and-boundaries-retained"⟩,⟨"TURBULENCE-SPECTRUM","APS-HUANG-TURBULENCE-SPECTRUM-2010","Physical five-thirds compensated plateaux by two analysis routes","sealed-criticality-and-cascade__complete-exponent-intervals-and-five-thirds-plateaux__nonmatching-row-and-boundaries-retained"⟩]

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

def targetIds : List String := ["CRITICALITY-UNIVERSALITY-TURBULENCE-WITHHELD-COMPLETE-RECORD"]
def envelope (derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (admissionIdentity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def targets (files : List (String × ByteArray)) (payload : Value) : Except String (List (String × Value)) := do
 let record ← CriticalObservationRecords.authoritativeRecord files payload
 pure [("CRITICALITY-UNIVERSALITY-TURBULENCE-WITHHELD-COMPLETE-RECORD",← RunningConvergenceMeasurement.field record "registered_target")]
theorem completeTargetCount : targetRows.length=4 := rfl
theorem originalVaultTarget : targetIds=["CRITICALITY-UNIVERSALITY-TURBULENCE-WITHHELD-COMPLETE-RECORD"] := rfl
end SFT.Physics.CriticalObservationExperiment
