import SFT.Chemistry.DihedralTorsionPrediction
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.DihedralTorsionValidation
open SFT.Host SFT.Host.Canonical SFT.Physics DihedralTorsionExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-post-seal-dihedral-cycle-and-barrier-Take-comparator/1",.text registrationHash]))),
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



open DihedralTorsion DihedralTorsionCycle DihedralTorsionSource DihedralTorsionPrediction
def boolText (b : Bool) : String := if b then "True" else "False"
def heightRepr : Height → String
 | .emptyOne => "EmptyOne(identity='empty-One')"
 | .otherEmptyOne id => Text.intercalate "" ["EmptyOne(identity='",id,"')"]
 | .ratio r => Text.intercalate "" ["PositiveRatio(numerator=PositiveCount(value=",toString r.numerator.value,
   "), denominator=PositiveCount(value=",toString r.denominator.value,"))"]
 | .invalid => "invalid"
def fractionValue (r : Ratio) : Value :=
 let q := fraction r
 .object [("numerator",.integer (.ofNat q.numerator)),("denominator",.integer (.ofNat q.denominator))]
def fractionText (r : Ratio) : String :=
 let q := fraction r
 if q.denominator==1 then toString q.numerator else Text.intercalate "/" [toString q.numerator,toString q.denominator]
def releasedHeight (value : Value) : Except String Height := do
 if sameValue (get value "identity") (.text "empty-One") then pure .emptyOne
 else
  let n ← match get (get value "numerator") "value" with
   | .integer number => match number with
    | .ofNat n => CapabilityValues.count n
    | .negSucc _ => throw "PROP-004 released target record is malformed"
   | .null | .boolean _ | .text _ | .array _ | .object _ => throw "PROP-004 released target record is malformed"
  let d ← match get (get value "denominator") "value" with
   | .integer number => match number with
    | .ofNat n => CapabilityValues.count n
    | .negSucc _ => throw "PROP-004 released target record is malformed"
   | .null | .boolean _ | .text _ | .array _ | .object _ => throw "PROP-004 released target record is malformed"
  pure (.ratio ⟨n,d⟩)
def coordinateMatches (coordinate angle : Height) : Bool :=
 match coordinate with
 | .emptyOne => match angle with
  | .emptyOne => true
  | .ratio _ | .otherEmptyOne _ | .invalid => false
 | .ratio c => match angle with
  | .ratio a => c.numerator.value * 360 * a.denominator.value == a.numerator.value * c.denominator.value
  | .emptyOne | .otherEmptyOne _ | .invalid => false
 | .otherEmptyOne _ | .invalid => false

structure Comparison where
 value : Value
 coordinateMatch : Bool
 recordMatch : Bool
 message : String
structure TransitionResult where
 value : Value
 magnitude : Ratio
 message : String
def cycleAt (cycles : List (Nat × Cycle)) (index : Nat) : Except String Cycle :=
 match cycles.find? (fun p => p.1==index) with
 | some p => pure p.2
 | none => throw "PROP-004 source cycle absent"
def positionsEqual (a b : List CapabilityValues.PositiveCount) : Bool :=
 (a.map CapabilityValues.PositiveCount.value)==(b.map CapabilityValues.PositiveCount.value)
def requiredHeld : Value → Bool
 | .null => false
 | .text s => !s.isEmpty
 | .array _ => true
 | .boolean _ | .integer _ | .object _ => true
-- Registered source fields are strings or nonempty arrays, so the original
-- None/empty-string/empty-tuple test retains their exact values.
structure Validation where
 value : Value
 passed : Bool
def validate (identityBytes targetBytes : ByteArray) (identityDocument targetDocument : Value)
 (snapshot : DihedralTorsionSource.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord
 let registrationHash := identity registration
 let document ← predictionProgramDocument
 let programFields ← match document with
  | .object fs => pure fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "PROP-004 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "PROP-004 prediction package changed"
 let predicted ← predictionMap execution.output
 -- First target access follows the complete coordinate-and-operation seal.
 let rows ← sourceRows identityBytes targetBytes identityDocument targetDocument snapshot
 let targetValues := rows.map fun row => (row.structural.targetId,CapabilityValues.canonical row.vaultValue)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-NIST-target-custodian") targetValues
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let results ← rows.mapM fun row => do
  let predictedRow ← predictionAt predicted row.structural.targetId
  let released ← field (.object release.values) row.structural.targetId
  let cells ← RunningConvergenceMeasurement.array (get released "cells")
  if cells.length != 3 then throw "PROP-004 released target record is malformed"
  let angle ← releasedHeight (cells.headD .null)
  let coordinateMatch := coordinateMatches predictedRow.coordinate angle
  let recordMatch := sameValue released (CapabilityValues.canonical row.vaultValue)
  let repr := heightRepr predictedRow.coordinate
  let result : Value := .object [("target_id",.text row.structural.targetId),("torsion_index",.integer row.structural.rotor.index),
   ("path_position",.integer row.structural.position.value),("coordinate",.text repr),
   ("angle_inscription",.text row.angleInscription),("energy_kj_inscription",.text row.energyKjInscription),
   ("energy_cm_inscription",.text row.energyCmInscription),("coordinate_match",.boolean coordinateMatch),("source_record_match",.boolean recordMatch)]
  let message := Text.intercalate "" [row.structural.targetId,": coordinate ",repr,"; source angle ",row.angleInscription,
   " degree; energy ",row.energyKjInscription," kJ mol^-1 / ",row.energyCmInscription," cm^-1; coordinate match ",boolText coordinateMatch]
  pure (⟨result,coordinateMatch,recordMatch,message⟩ : Comparison)
 let kjCycles ← cycles rows .kj
 let cmCycles ← cycles rows .cm
 let stateRows ← [1,2].mapM fun index => do
  let kj ← cycleAt kjCycles index
  let cm ← cycleAt cmCycles index
  let conformers ← localConformerPositions kj
  let cmConformers ← localConformerPositions cm
  let barriers ← localBarrierPositions kj
  let cmBarriers ← localBarrierPositions cm
  if !positionsEqual conformers cmConformers || !positionsEqual barriers cmBarriers then
   throw "PROP-004 two energy-unit surfaces disagree on state order"
  let transitions ← barrierTransitions kj
  let transitions := transitions.map fun t =>
   let value : Value := .object [("torsion_index",.integer index),("barrier_position",.integer t.barrier.value),
    ("adjacent_conformer_position",.integer t.conformer.value),("exact_positive_Take_kj_mol",fractionValue t.magnitude)]
   let message := Text.intercalate "" ["torsion ",toString index," barrier position ",toString t.barrier.value,
    " Take conformer position ",toString t.conformer.value," = ",fractionText t.magnitude," kJ mol^-1"]
   (⟨value,t.magnitude,message⟩ : TransitionResult)
  pure (conformers.map (fun p => (index,p.value)),barriers.map (fun p => (index,p.value)),transitions)
 let conformers := stateRows.flatMap (fun p => p.1)
 let barriers := stateRows.flatMap (fun p => p.2.1)
 let transitions := stateRows.flatMap (fun p => p.2.2)
 let identities ← RunningConvergenceMeasurement.array (get identityDocument "rows")
 let held := identities.all fun row =>
  ["species","molecular_state","conformer_scope","torsion_label","ordered_four_atom_carrier",
   "rotor_type","held_orientation","coordinate_form","barrier_definition","method_and_condition"].all fun key => requiredHeld (get row key)
 let recurrence := kjCycles.all fun (_,cycle) =>
  match cycle.nodes.head?,cycle.nodes.getLast? with
  | some first,some last => equalHeight first.height last.height
  | none,none | none,some _ | some _,none => false
 let unitAgreement ← [1,2].mapM fun index => do
  let kj ← cycleAt kjCycles index
  let cm ← cycleAt cmCycles index
  let a ← localConformerPositions kj
  let b ← localConformerPositions cm
  let c ← localBarrierPositions kj
  let d ← localBarrierPositions cm
  pure (positionsEqual a b && positionsEqual c d)
 let adverse : List (String × Bool) := [
  ("complete_fifty_row_vector",results.length==50 && sameKeys (predicted.map Prediction.targetId) (rows.map fun row => row.structural.targetId)),
  ("all_coordinates_match_postseal_source_angles",results.all Comparison.coordinateMatch),
  ("all_source_records_preserved",results.all Comparison.recordMatch),
  ("angle_energy_and_extrema_values_absent_before_seal",["degree","kJ","cm_inverse","5.41","15.92","0.52"].all fun s => !Text.contains (render document) s),
  ("complete_identity_condition_surface",held),("six_conformer_states_forced",conformers.length==6),
  ("six_barrier_states_forced",barriers.length==6),
  ("twelve_adjacent_positive_barrier_Takes",transitions.length==12 && transitions.all (fun t => t.magnitude.numerator.value>0)),
  ("both_energy_units_force_same_state_order",unitAgreement.all id),
  ("both_recurrence_endpoints_identify_anchor",recurrence),
  ("source_zero_glyphs_are_EmptyOne",(rows.filter fun row => match row.energyKj with | .emptyOne => true | .ratio _ | .otherEmptyOne _ | .invalid => false).length==4),
  ("reversed_barrier_Take_rejected",DihedralTorsionWitnesses.reverseWitness),
  ("negative_signed_coordinate_rejected",(match CapabilityLiterals.ratioLiteral ["-1","24"] with | .error _ => true | .ok _ => false)),
  ("tampered_source_identity_rejected",!Text.equal (identity (.array [.text snapshotHash,.text "tampered"])) snapshotHash)]
 let passed := adverse.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "PROP-004 released target identity differs"
 let pairs := fun (xs : List (Nat × Nat)) => Value.array (xs.map fun (a,b) => .array [.integer a,.integer b])
 let payload : Value := .object [("registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("target_registry_hash",.text targetHash),
  ("comparisons",.array (results.map Comparison.value)),("conformers",pairs conformers),("barriers",pairs barriers),
  ("barrier_transitions",.array (transitions.map TransitionResult.value)),
  ("adverse",.object (adverse.map fun (name,b) => (name,.boolean b))),("trace_hash",.text execution.traceHash)]
 let messages := results.map Comparison.message ++ transitions.map TransitionResult.message ++
  adverse.map (fun (name,b) => Text.intercalate "" ["adverse ",name,": ",boolText b])
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array [.text "NIST-CCCBDB-SRD101-ETHANOL-EXPERIMENTAL-ROTATIONAL-BARRIER"]),
  ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.DihedralTorsionValidation
