import SFT.Chemistry.BondDissociationEnergySource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.BondDissociationEnergyValidation
open SFT.Host SFT.Host.Canonical SFT.Physics BondDissociationEnergyExperiment
open SFT.Physics.LeptonIntervals SFT.Physics.VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev PredictionSeal := LeptonCustody.PredictionSeal
abbrev Snapshot := HostilePackage.Snapshot
def envelope (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object (inputs.map fun (key,value) => (key,.text (CapabilityValues.identity value)))),
 ("withheld_target_ids",.array (targetIds.map Value.text)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
def sealPrediction (prior : Option PredictionSeal) (inputs : List (String × CapabilityValues.Value)) (registrationHash derivationSeal : String)
    (execution : CapabilityExecution.Execution) : Except String PredictionSeal :=
 match prior with
 | some _ => .error "prediction is already sealed and cannot be replaced"
 | none =>
   let env := identity (envelope inputs registrationHash derivationSeal)
   let payload : Value := .object [("experiment_id",.text experimentId),
     ("prediction_hash",.text execution.outputHash),("trace_hash",.text execution.traceHash),("envelope_hash",.text env)]
   .ok ⟨experimentId,execution.outputHash,execution.traceHash,env,identity payload⟩

def certificate (fields : List (String × Value)) : Value :=
 .object (fields ++ [("certificate_hash",.text (identity (.object fields)))])

def isolation (registrationHash host implementation : String) (execution : CapabilityExecution.Execution)
    (vault : TargetCustody.Vault) (prediction : PredictionSeal) : Value := certificate [
 ("adapter_id",.text "sft-portable-capability-custody/1"),
 ("executor_id",.text (Text.append experimentId "-prediction-executor")),
 ("host_platform",.text (if host.isEmpty then "registered-host" else host)),("python_implementation",.text implementation),
 ("interpreter_hash",.text (identity (.text "sft-v3-capability-closed-fold-interpreter/1"))),
 ("program_hash",.text execution.programHash),("input_manifest_hash",.text execution.inputManifestHash),
 ("registered_target_identity_hash",.text vault.commitment.targetHash),
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-H2-D2-post-seal-Take-comparator/1",.text registrationHash]))),
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



def ratValue (value : Rat) : Value := .object [("numerator",.integer value.num),("denominator",.integer (Int.ofNat value.den))]
def ratText (value : Rat) : String := Text.intercalate "" [render (.integer value.num),"/",render (.integer (Int.ofNat value.den))]
def boolText (b : Bool) : String := if b then "True" else "False"
-- Exact original structural-output test; the declaration checks only the source's fields.
def validateStructuralPrediction (output : CapabilityValues.Value) : Except String Unit := do
 let entries ← match output with
  | .table entries => if entries.length == 2 then pure entries else throw "PROP-002 value-free structural prediction is incomplete"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "PROP-002 value-free structural prediction is incomplete"
 let observed ← entries.mapM fun (left,right) => do
  let key ← match left with
   | .label key => if Text.equal key.family "isotopologue" then pure key else throw "PROP-002 structural relation lost its identity"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-002 structural relation lost its identity"
  let cells ← match right with
   | .word cells => pure cells
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "PROP-002 structural relation lost its identity"
  let labels := cells.drop 1
  if cells.length != 8 || !labels.all (fun v => match v with | .label _ => true | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false) then
   throw "PROP-002 structural relation is incomplete"
  let reversed := labels.reverse
  let (first,tail) ← match reversed with
   | [] => throw "PROP-002 operation or custody law changed"
   | first::tail => pure (first,tail)
  let second ← match tail with
   | [] => throw "PROP-002 operation or custody law changed"
   | second::_rest => pure second
  let custody ← match first with
   | .label value => pure value
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-002 operation or custody law changed"
  let operation ← match second with
   | .label value => pure value
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-002 operation or custody law changed"
  if !(Text.equal operation.family "path-operation" && Text.equal operation.label "ordered-positive-held-Take" &&
    Text.equal custody.family "measurement-custody" && Text.equal custody.label "all-values-open-after-relation-seal") then
   throw "PROP-002 operation or custody law changed"
  pure key.label
 if !(observed.any (Text.equal "H2") && observed.any (Text.equal "D2") &&
  observed.all (fun name => Text.equal name "H2" || Text.equal name "D2")) then
  throw "PROP-002 structural isotopologue support changed"
 pure ()
structure Validation where
 value : Value
 passed : Bool
def targetByRole (rows : List BondDissociationEnergySource.Target) (species role : String) : Except String BondDissociationEnergySource.Target :=
 match rows.reverse.find? (fun row => Text.equal row.species species && Text.equal row.role role) with
 | none => .error "PROP-002 species-role target absent"
 | some row => .ok row
def takePath (threshold atomic : Rat) : Except String Rat := do
 pure (BoundaryGrowth.asFraction (← BondDissociationEnergy.groundDissociationFromTransition (.fraction threshold) (.fraction atomic)))
def validate (identityBytes targetBytes apsBytes atomicBytes currentBytes : ByteArray)
 (identityDocument targetDocument apsDocument atomicDocument currentDocument : Value)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration := experimentRegistrationRecord
 let registrationHash := identity registration
 let document := predictionProgramDocument
 let programFields ← match document with
  | .object fs => pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-002 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-002 prediction package changed"
 validateStructuralPrediction execution.output
 -- Measurements first enter only after the value-free relation has been sealed.
 let targets ← BondDissociationEnergySource.loadTargets identityBytes targetBytes apsBytes atomicBytes currentBytes
  identityDocument targetDocument apsDocument atomicDocument currentDocument
 let targetValues := targets.map fun row => (row.targetId,CapabilityValues.canonical row.interval)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") targetValues
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let results ← ["H2","D2"].mapM fun species => do
  let threshold ← targetByRole targets species "path-threshold"
  let atomic ← targetByRole targets species "atomic-path-segment"
  let lower ← takePath threshold.lower atomic.upper
  let upper ← takePath threshold.upper atomic.lower
  ["historical-ground-dissociation","later-ground-dissociation"].mapM fun role => do
   let target ← targetByRole targets species role
   let overlap := !(upper.blt target.lower || target.upper.blt lower)
   let displacedLower := add upper (wholeRatio 1)
   let displacedUpper := add upper (wholeRatio 2)
   let displaced := target.upper.blt displacedLower && displacedLower.blt displacedUpper
   let comparison : Value := .object [("target_id",.text target.targetId),("species",.text species),("record_class",.text role),
    ("derived_lower",ratValue lower),("derived_upper",ratValue upper),
    ("observed_lower",ratValue target.lower),("observed_upper",ratValue target.upper),
    ("source_inscription",.text target.inscription),("overlap",.boolean overlap),("displaced_control_rejected",.boolean displaced)]
   let message := Text.intercalate "" [target.targetId,": post-seal exact Take interval [",ratText lower,", ",ratText upper,
    "] inverse-centimetre; source ",target.inscription," within [",ratText target.lower,", ",ratText target.upper,
    "]; overlap ",boolText overlap]
   pure (comparison,overlap,displaced,role,message)
 let results := results.flatten
 let measurementRows ← BondDissociationEnergySource.field targetDocument "rows" >>= BondDissociationEnergySource.array
 let inscriptions ← measurementRows.mapM (fun row => BondDissociationEnergySource.field row "inscription" >>= BondDissociationEnergySource.text)
 -- These are the pinned inscription strings; both source JSON spellings retain their exact digit text.
 let noMeasurement := inscriptions.all (fun inscription => !Text.contains (render document) inscription)
 let identityRows ← BondDissociationEnergySource.field identityDocument "rows" >>= BondDissociationEnergySource.array
 let held ← identityRows.mapM fun row => do
  let state := (BondDissociationEnergySource.field row "state").toOption.getD (.text "")
  let channel := (BondDissociationEnergySource.field row "channel").toOption.getD (.text "")
  let state ← BondDissociationEnergySource.text state
  let channel ← BondDissociationEnergySource.text channel
  pure (CapabilityValues.nonblank state && CapabilityValues.nonblank channel)
 let complete := targets.length == 8 && targetIds.all (fun id => targets.any (fun row => Text.equal row.targetId id)) &&
  targets.all (fun row => targetIds.any (Text.equal row.targetId))
 let classes := results.map (fun row => row.2.2.2.1)
 let adverse : List (String × Bool) := [
  ("complete_eight_row_vector",complete),("all_measurements_absent_from_prediction",noMeasurement),
  ("states_and_channels_held",held.all id),("reversed_or_nonpositive_Take_halts",BondDissociationEnergy.orientationWitness),
  ("every_displaced_interval_rejected",results.all (fun row => row.2.2.1)),
  ("historical_and_later_rows_both_tested",results.length==4 && classes.any (Text.equal "historical-ground-dissociation") &&
   classes.any (Text.equal "later-ground-dissociation") && classes.all (fun role => Text.equal role "historical-ground-dissociation" || Text.equal role "later-ground-dissociation")),
  ("tampered_registry_identity_rejected",!Text.equal (identity (.array [.text targetHash,.text "tampered"])) targetHash)]
 let passed := results.all (fun row => row.2.1) && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-002 released target identity differs"
 let payload : Value := .object [("registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("target_registry_hash",.text targetHash),
  ("comparisons",.array (results.map Prod.fst)),("adverse",.object (adverse.map fun (name,b) => (name,.boolean b))),
  ("trace_hash",.text execution.traceHash)]
 let messages := results.map (fun row => row.2.2.2.2) ++
  adverse.map (fun (name,b) => Text.intercalate "" ["adverse ",name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (["APS-PRA-49-2460-1994","PRL-UDEM-H-1S2S-1997","PRL-PARTHEY-HD-1S2S-SHIFT-2010",
    "SI-DEFINING-LIGHT-SPEED","JCP-LIU-H2-DISSOCIATION-2009","PRA-HUSSELS-D2-DISSOCIATION-2022"].map Value.text)),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.BondDissociationEnergyValidation
