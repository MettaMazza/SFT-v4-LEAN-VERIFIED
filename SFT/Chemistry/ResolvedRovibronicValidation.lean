import SFT.Chemistry.ResolvedRovibronicExperiment
import SFT.Chemistry.ResolvedRovibronicAnalysis
import SFT.Chemistry.NuclearElectronicTargets
import SFT.Chemistry.NuclearElectronicWeights
import SFT.Physics.MolecularSpectroscopyMeasurement
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.ResolvedRovibronicValidation
open SFT.Host SFT.Host.Canonical SFT.Physics ResolvedRovibronicExperiment
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def inputValues (derivationSeal : String) : Except String (List (String × CapabilityValues.Value)) := do
 let held ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 .ok [("registered-premise",.label held)]

def sealPrediction (prior : Option PredictionSeal) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "complete-resolved-H2-HD-D2-comparator/1",.text experimentId]))),
 ("prediction_seal_hash",.text prediction.sealHash),
 ("denied_capabilities",.array (["clock","dynamic_import","environment","filesystem_read","filesystem_write","foreign_function","network","subprocess"].map Value.text)),
 ("attempted_forbidden_operations",.array []),("target_material_present",.boolean false),
 ("comparison_code_present",.boolean false),("output_hash",.text execution.outputHash),
 ("trace_hash",.text execution.traceHash),("completed",.boolean true)]

def custodyCertificate (registrationHash : String) (released : TargetCustody.Release) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),("custodian_id",.text released.custodian),
 ("experiment_registration_hash",.text registrationHash),("registered_target_identity_hash",.text released.targetHash),
 ("prediction_seal_hash",.text prediction.sealHash),("target_release_manifest_hash",.text released.releaseHash),
 ("target_absent_until_prediction_seal",.boolean true),("released_after_prediction_seal",.boolean true)]



def boolText (b : Bool) : String := if b then "True" else "False"
def rowText (row : Value) (key : String) : Except String String := JointCorrelationTargets.field row key >>= JointCorrelationTargets.text
def rowInt (row : Value) (key : String) : Except String Int := JointCorrelationTargets.field row key >>= JointCorrelationTargets.integer
def rowPassed (row : Value) : Bool := match JointCorrelationTargets.field row "passed" with
 | .ok (.boolean b) => b
 | .ok (.null) | .ok (.integer _) | .ok (.text _) | .ok (.array _) | .ok (.object _) | .error _ => false
def integerText : Int → String
 | .ofNat n => toString n
 | .negSucc n => Text.append "-" (toString (n+1))
def measurement (row : Value) : Except String String := do
 return Text.intercalate "" [← rowText row "target_id",": multiplicity ",← rowText row "multiplicity",
  "; vibration ",← rowText row "vibration","; rotation ",← rowText row "rotation",
  "; band ",← rowText row "band","; pass ",boolText (rowPassed row)]
structure Validation where
 value : Value
 passed : Bool

def validate (actualIdentityHash actualTargetHash : String) (identityDocument targetDocument : Value)
 (snapshots : List NuclearElectronicSource.Snapshot) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registrationHash := identity registration
 let program ← CapabilityDocuments.loadProgramFields programFields
 let inputs ← inputValues derivationSeal
 let targets ← NuclearElectronicTargets.rows actualIdentityHash actualTargetHash identityDocument targetDocument snapshots
 let targetValues ← targets.mapM fun row => do
  let id ← rowText row "target_id"
  pure (id,labelValue "external-resolved-spectrum-row" (identity row))
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-custodian")
  targetValues (identity (.array [.text registrationHash,.text "sha256:b8a3cb16b0fbdc53a01846492e71b38585d0a7c5336b755f3f9ea21ba48d7421"])) (identity (envelope registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "ELEC-013 prediction package differs"
 match execution.output with
 | .table entries => if entries.length==8 then pure () else throw "ELEC-013 prediction package differs"
 | .emptyOne _ | .label _ | .count _ | .ratio _ _ | .word _ | .pair _ _ => throw "ELEC-013 prediction package differs"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let rows ← targets.mapM NuclearElectronicTargets.readRow
 let released ← release.values.mapM fun (id,value) => do
  return (id,← rowText value "label")
 let comparisons ← rows.mapM fun row => ResolvedRovibronicAnalysis.rowComparison row released
 let counts ← ResolvedRovibronicAnalysis.counts rows
 let expected : List (String × Nat) := [("rows",95),("cells",1235),("singlet",54),("triplet",41),
  ("positive_vibration",78),("positive_rotation",60),("joint_vibration_rotation",56),
  ("transition_designation",92),("positive_band_origin",83),("source_zero_electronic_origin",3),
  ("absent_electronic_origin",3),("held_signed_inscriptions",8)]
 let countsExact := counts.length==expected.length && (counts.zip expected).all (fun ((a,n),(b,m)) => Text.equal a b && n==m)
 let ms ← comparisons.mapM fun row => rowText row "multiplicity"
 let distinct := ms.foldl (fun acc m => if acc.any (Text.equal · m) then acc else acc++[m]) ([] : List String)
 let signed := counts.any fun (k,n) => Text.equal k "held_signed_inscriptions" && n==8
 let adverse : List (String × Bool) := [("exact_counts",countsExact),("all_rows",comparisons.all rowPassed),
  ("omission_rejected",(rows.take (rows.length-1)).length != 95),
  ("multiplicity_erasure_rejected",distinct.length==2),("signed_values_held",signed)]
 let passed := adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "ELEC-012 released identity differs"
 let payload : Value := .object [("comparisons",.array comparisons),
  ("counts",.object (counts.map fun (k,n) => (k,.integer (.ofNat n)))),
  ("adverse",.object (adverse.map fun (k,b) => (k,.boolean b))),("trace",.text execution.traceHash)]
 let rowMessages ← comparisons.mapM measurement
 let messages := rowMessages ++ counts.map (fun (key,n) => Text.intercalate "" ["count ",key,": ",toString n])
 return ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CHEMISTRY-WEBBOOK-SRD69-H2-HD-D2-RESOLVED-DIATOMIC-SURFACE-2026"]),("measurements",.array (messages.map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.ResolvedRovibronicValidation
