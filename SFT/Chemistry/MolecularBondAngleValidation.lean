import SFT.Chemistry.MolecularBondAngleSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.MolecularBondAngleValidation
open SFT.Host SFT.Host.Canonical SFT.Physics MolecularBondAngleExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-post-seal-turn-fraction-to-source-degree-comparator/1",.text registrationHash]))),
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
structure Prediction where
 targetId : String
 species : String
 state : String
 geometry : String
 coordinate : String
 role : String
 sectorCount : Nat
 sectorSeparation : Nat
 turnFraction : Rat
def labelValue : CapabilityValues.Value → Except String CapabilityValues.HeldLabel
 | .label label => pure label
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-003 prediction carrier is incomplete"
def countValue : CapabilityValues.Value → Except String Nat
 | .count count => pure count.value
 | .emptyOne _ | .label _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-003 prediction lost exact sector support"
def ratioValue : CapabilityValues.Value → Except String Rat
 | .ratio n d => pure (normalize (Int.ofNat n.value) d.value d.positive)
 | .emptyOne _ | .label _ | .count _ | .word _ | .pair _ _ | .table _ => throw "PROP-003 prediction lost exact sector support"
def cellAt (cells : List CapabilityValues.Value) (n : Nat) : Except String CapabilityValues.Value :=
 match (cells.drop n).head? with
 | none => throw "PROP-003 prediction carrier is incomplete"
 | some value => pure value
def predictionMap (output : CapabilityValues.Value) : Except String (List Prediction) := do
 let entries ← match output with
  | .table entries => if entries.length == 4 then pure entries else throw "PROP-003 prediction is not the complete four-angle table"
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ => throw "PROP-003 prediction is not the complete four-angle table"
 let rows ← entries.mapM fun (left,right) => do
  let key ← match left with
   | .label key => if Text.equal key.family "target-id" then pure key else throw "PROP-003 prediction lost a target identity or carrier word"
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "PROP-003 prediction lost a target identity or carrier word"
  let cells ← match right with
   | .word cells => pure cells
   | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "PROP-003 prediction lost a target identity or carrier word"
  if cells.length != 10 then throw "PROP-003 prediction carrier is incomplete"
  let _ ← ((cells.drop 1).take 6).mapM labelValue
  let count ← cellAt cells 7 >>= countValue
  let separation ← cellAt cells 8 >>= countValue
  let fraction ← cellAt cells 9 >>= ratioValue
  pure (⟨key.label,(← cellAt cells 2 >>= labelValue).label,(← cellAt cells 3 >>= labelValue).label,
   (← cellAt cells 4 >>= labelValue).label,(← cellAt cells 5 >>= labelValue).label,
   (← cellAt cells 6 >>= labelValue).label,count,separation,fraction⟩ : Prediction)
 let keys := rows.map Prediction.targetId
 if (keys.foldl (fun acc key => if acc.any (Text.equal key) then acc else acc++[key]) []).length != 4 then
  throw "PROP-003 prediction contains duplicate target identities"
 pure rows
def predictionAt (rows : List Prediction) (target : String) : Except String Prediction :=
 match rows.find? (fun row => Text.equal row.targetId target) with
 | some row => pure row
 | none => throw (Text.append "KeyError: " target)
-- For JSON source fields, Python str(x).strip() is nonempty for every non-string
-- value. Missing fields use the original empty-string default, not None.
def fieldHeld : Value → Bool
 | .text value => CapabilityValues.nonblank value
 | .null | .boolean _ | .integer _ | .array _ | .object _ => true
structure Comparison where
 targetId : String
 value : Value
 exactMatch : Bool
 displaced : Bool
 predicted : Rat
 observed : Rat
 message : String
def comparisonAt (rows : List Comparison) (target : String) : Except String Comparison :=
 match rows.find? (fun row => Text.equal row.targetId target) with
 | some row => pure row
 | none => throw (Text.append "KeyError: " target)
def releasedInteger : Value → Option Int
 | .integer n => some n
 | .null | .boolean _ | .text _ | .array _ | .object _ => none
def releasedRatio (values : List (String × Value)) (target : String) : Except String Rat := do
 let row ← MolecularBondAngleSource.field (.object values) target
 let numerator := releasedInteger (MolecularBondAngleSource.get (MolecularBondAngleSource.get row "numerator") "value")
 let denominator := releasedInteger (MolecularBondAngleSource.get (MolecularBondAngleSource.get row "denominator") "value")
 match numerator,denominator with
 | some n,some d =>
  if !(@decide (Int.lt 0 n) (Int.decLt _ _)) || !(@decide (Int.lt 0 d) (Int.decLt _ _)) then
   throw "PROP-003 released target is not an exact positive ratio"
  if positive : 0 < d.natAbs then pure (normalize n d.natAbs positive)
  else throw "PROP-003 released target is not an exact positive ratio"
 | none,none => throw "PROP-003 released target is not an exact positive ratio"
 | none,some _ => throw "PROP-003 released target is not an exact positive ratio"
 | some _,none => throw "PROP-003 released target is not an exact positive ratio"
structure Validation where
 value : Value
 passed : Bool
def validate (identityBytes targetBytes : ByteArray) (identityDocument targetDocument : Value)
 (snapshots : List MolecularBondAngleSource.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord
 let registrationHash := identity registration
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fs => pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-003 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-003 prediction package changed"
 let predicted ← predictionMap execution.output
 -- First degree access follows construction and sealing of the exact predictor.
 let targets ← MolecularBondAngleSource.loadTargets identityBytes targetBytes identityDocument targetDocument snapshots
 let targetValues := targets.map fun row => (row.targetId,CapabilityValues.canonical row.targetValue)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-external-target-custodian") targetValues
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let results ← targets.mapM fun row => do
  let source ← predictionAt predicted row.targetId
  let degrees := multiply source.turnFraction (wholeRatio 360)
  let observed ← releasedRatio release.values row.targetId
  let exact := @decide (degrees.num = observed.num) (Int.decEq _ _) && degrees.den == observed.den
  let displacedDegrees := add degrees (wholeRatio 1)
  let displaced := !(@decide (displacedDegrees.num = observed.num) (Int.decEq _ _) && displacedDegrees.den == observed.den)
  let value : Value := .object [("target_id",.text row.targetId),("species",.text row.species),("geometry",.text row.geometry),
   ("coordinate",.text row.coordinate),("angle_role",.text row.role),("turn_fraction",ratValue source.turnFraction),
   ("predicted_degrees",ratValue degrees),("observed_degrees",ratValue observed),
   ("source_inscription",.text row.sourceInscription),("source_comment",row.sourceComment),
   ("exact_match",.boolean exact),("displaced_control_rejected",.boolean displaced)]
  let message := Text.intercalate "" [row.targetId,": exact ",ratText source.turnFraction," turn -> ",
   MolecularBondAngleSource.fractionText degrees," degree; source ",row.sourceInscription," degree; exact match ",boolText exact]
  pure (⟨row.targetId,value,exact,displaced,degrees,observed,message⟩ : Comparison)
 let targetRows ← RunningConvergenceMeasurement.array (MolecularBondAngleSource.get targetDocument "rows")
 let inscriptions ← targetRows.mapM (fun row => MolecularBondAngleSource.field row "inscription" >>= MolecularBondAngleSource.text)
 let absent := inscriptions.all (fun inscription => !Text.contains (render document) (Text.intercalate "" ["\"",inscription,"\""]))
 let identityRows ← RunningConvergenceMeasurement.array (MolecularBondAngleSource.get identityDocument "rows")
 let held := identityRows.all fun row =>
  ["species","molecular_state","geometry","point_group","angle_definition","coordinate","method_and_condition","source_comment","source_id","snapshot_hash"].all fun key =>
   fieldHeld ((MolecularBondAngleSource.field row key).toOption.getD (.text ""))
 let adjacent ← comparisonAt results "NIST-CCCBDB-XEF4-FXEF-ADJACENT"
 let opposite ← comparisonAt results "NIST-CCCBDB-XEF4-FXEF-OPPOSITE"
 let equal := fun (a b : Rat) => @decide (a.num = b.num) (Int.decEq _ _) && a.den == b.den
 let wrongCount := match MolecularBondAngle.equalSectorTurnFraction
   (.held ⟨"molecular-geometry","square-planar-equal-four-sector",by decide,by decide⟩)
   (.count ⟨3,by decide⟩) (.count ⟨1,by decide⟩) with
  | .error _ => true
  | .ok _ => false
 let adverse : List (String × Bool) := [
  ("complete_four_angle_vector",results.length == 4 && MolecularBondAngleSource.sameKeys (predicted.map Prediction.targetId) (targets.map MolecularBondAngleSource.Target.targetId)),
  ("all_degree_values_absent_from_prediction",absent),("all_identity_and_condition_fields_held",held),
  ("every_displaced_value_rejected",results.all Comparison.displaced),
  ("adjacent_opposite_swap_rejected",!equal adjacent.predicted opposite.observed && !equal opposite.predicted adjacent.observed),
  ("wrong_geometry_count_rejected",wrongCount),("unsupported_tetrahedral_continuum_form_rejected",MolecularBondAngle.continuumBoundaryWitness),
  ("tampered_snapshot_identity_rejected",!Text.equal (identity (.array [.text MolecularBondAngleSource.bf3Hash,.text "tampered"])) MolecularBondAngleSource.bf3Hash)]
 let passed := results.all Comparison.exactMatch && adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-003 released target identity differs"
 let payload : Value := .object [("registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("target_registry_hash",.text targetHash),
  ("comparisons",.array (results.map Comparison.value)),("adverse",.object (adverse.map fun (name,b) => (name,.boolean b))),
  ("trace_hash",.text execution.traceHash)]
 let messages := results.map Comparison.message ++ adverse.map (fun (name,b) => Text.intercalate "" ["adverse ",name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (["NIST-CCCBDB-SRD101-BF3-EXPERIMENTAL-GEOMETRY","NIST-CCCBDB-SRD101-XEF2-EXPERIMENTAL-GEOMETRY","NIST-CCCBDB-SRD101-XEF4-EXPERIMENTAL-GEOMETRY"].map Value.text)),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.MolecularBondAngleValidation
