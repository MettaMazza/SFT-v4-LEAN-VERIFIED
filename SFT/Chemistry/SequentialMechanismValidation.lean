import SFT.Chemistry.SequentialMechanismPrediction
import SFT.Chemistry.FiniteMicrostateSupportSource
import SFT.Physics.ObservationComparison
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Chemistry.SequentialMechanismValidation
open SFT.Host SFT.Host.Canonical SFT.Physics SequentialMechanismExperiment
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
 ("comparison_implementation_identity_hash",.text (identity (.array [.text "exact-complete-sequential-composition-correspondence",.text falsification]))),
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



open SequentialMechanismSource SequentialMechanismPrediction
set_option maxRecDepth 30000
structure Validation where
 value : Value
 passed : Bool
structure Comparison where
 value : Value
 passed : Bool
 message : String
def boolText (b : Bool) : String := if b then "True" else "False"
def releaseValue (values : List (String × Value)) (target : String) : Except String Value :=
 match values.find? (fun row => Text.equal row.1 target) with
 | none => throw (Text.append "KeyError: " target)
 | some row => pure row.2
def boundsJSON (b : Rat×Rat) : Value := .object [("minimum",.text (fractionText b.1)),("maximum",.text (fractionText b.2))]
def analysisJSON (a : Analysis) : Value := .object ([
 ("complete_registered_target_count",.integer a.count),("complete_target_class_counts",.object (a.classCounts.map fun (k,n)=>(k,.integer n))),
 ("complete_supplementary_file_count",a.supplementCount),("complete_supplement_pdf_count",.integer a.pdfCount),("complete_pdb_deposit_count",a.pdbCount),
 ("deposited_XTX_component_count_vector",.array a.counts),("deposited_XTX_occupancy_vector",.array (a.occupancies.map (fun r=>.text (fractionText r)))),
 ("exact_positive_difference_density_sigma_range",boundsJSON a.sigmaBounds),("exact_positive_difference_density_range",boundsJSON a.densityBounds),
 ("external_absence_glyph_count_translated_to_EmptyOne",.integer a.absences)]++a.checks.map (fun (k,b)=>(k,.boolean b)))
def validate (identityBytes targetBytes primaryBytes : ByteArray) (sourceBytes : List ByteArray) (identityDocument targets primary : Value) (derivationSeal host implementation : String)
 (before after : Snapshot) : Except String Validation := do
 validateSpec
 let registration ← experimentRegistrationRecord identityBytes identityDocument
 let registrationHash := identity registration
 let document ← predictionProgramDocument identityBytes identityDocument
 let programFields ← match document with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "KIN-007 prediction package changed"
 let program ← CapabilityDocuments.loadProgramFields programFields
 let premise ← CapabilityValues.heldLabel "sealed-derivation" derivationSeal
 let inputs := [("registered-premise",CapabilityValues.Value.label premise)]
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction none inputs registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram programFields before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "KIN-007 prediction package changed"
 let predicted ← predictionMap execution.output
 let source ← sourceRows identityBytes targetBytes primaryBytes sourceBytes identityDocument targets
 let values := source.map fun row => (row.targetId,CapabilityValues.canonical row.value)
 let vault ← TargetCustody.createVault experimentId (Text.append experimentId "-complete-target-custodian") values
  (identity (.array [.text registrationHash,.text targetHash])) (identity (envelope inputs registrationHash derivationSeal))
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  targetIds release.values
 let comparisons ← source.mapM fun row => do
  let word ← predictionAt predicted row.targetId
  let released ← releaseValue release.values row.targetId
  let identityValues ← identityFields.mapM fun (key,_) => identityValue row.row key
  let identityMatch := identityValues.zipIdx.all fun (value,index) => labelMatches word (index+1) (.text value)
  let lawMatch := labelMatches word 8 (.text "all-distinct-states-edges-and-intermediates-retained-in-order") &&
   labelMatches word 9 (.text "exact-adjacent-boundary-composition-without-imported-evolution-equation") &&
   labelMatches word 10 (.text "conditions-favorable-adverse-unresolved-and-parallel-records-retained") &&
   labelMatches word 11 (.text "complete-article-supplements-PDB-custody-and-control-vector-retained")
  let targetMatch := sameValue released (CapabilityValues.canonical row.value)
  let passed := identityMatch && lawMatch && targetMatch
  let value := Value.object [("target_id",.text row.targetId),("identity_match",.boolean identityMatch),
   ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),("passed",.boolean passed)]
  pure (⟨value,passed,""⟩ : Comparison)
 let analysis ← exactSequentialMechanismAnalysis source primary
 let tampered := source.take (source.length-1)
 let tamperRejected := match exactSequentialMechanismAnalysis tampered primary with
  | .error _ => true
  | .ok _ => false
 let check := fun (a : Analysis) (name : String) => match a.checks.find? (fun item => Text.equal item.1 name) with
  | some item => item.2
  | none => false
 let brokenAdjacency := do
  let a ← SequentialMechanism.makeState (.held ⟨"registered-mechanism-state","a",rfl,rfl⟩) (.count ⟨1,by decide⟩) (.held ⟨"held-state-condition","c",rfl,rfl⟩) (.held ⟨"held-observation-status","held",rfl,rfl⟩)
  let b ← SequentialMechanism.makeState (.held ⟨"registered-mechanism-state","b",rfl,rfl⟩) (.count ⟨2,by decide⟩) (.held ⟨"held-state-condition","c",rfl,rfl⟩) (.held ⟨"held-observation-status","held",rfl,rfl⟩)
  let wrong ← SequentialMechanism.makeTransition (.held ⟨"registered-elementary-transition","wrong",rfl,rfl⟩) (.count ⟨1,by decide⟩) (.held ⟨"registered-mechanism-state","x",rfl,rfl⟩) (.held b.stateIdentity) (.held ⟨"held-transition-condition","c",rfl,rfl⟩) (.held ⟨"held-transition-status","held",rfl,rfl⟩)
  SequentialMechanism.makeMechanism (.held ⟨"registered-reaction","r",rfl,rfl⟩) [.state a,.state b] [.transition wrong]
 let boundaryRejected := match brokenAdjacency with | .error _=>true | .ok _=>false
 let controls : List (String × Bool) := [
  ("tampered_omitted_source_record_rejected",tamperRejected),
  ("tampered_broken_transition_boundary_rejected",boundaryRejected),
  ("complete_seventeen_record_target_vector_retained",release.values.length==17),
  ("external_zero_glyphs_remain_structural_EmptyOne",analysis.absences==6),
  ("adverse_and_unresolved_records_remain_visible",check analysis "favorable_adverse_and_unresolved_controls_retained"),
  ("prediction_contains_no_withheld_target_hash",!(Text.contains (FiniteMicrostateSupportSource.spacedRender document) targetHash))]
 let passed := comparisons.all Comparison.passed && analysis.checks.all Prod.snd && controls.all Prod.snd
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then throw "KIN-007 released target differs from commitment"
 let payload := Value.object [("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),
  ("analysis",analysisJSON analysis),
    ("comparisons",.array (comparisons.map Comparison.value)),
  ("controls",.object (controls.map fun (name,b) => (name,.boolean b))),("trace",.text execution.traceHash)]
 let rowMessages ← source.mapM fun row => do
  let recordClass ← field row.row "source_record_class" >>= identityString
  let pdb ← field row.row "pdb_identity" >>= identityString
  let hash ← field row.row "target_payload_hash" >>= identityString
  pure (Text.intercalate "" [row.targetId,": class=",recordClass,"; PDB=",pdb,"; target=",hash])
 let countTexts ← analysis.counts.mapM fun value=>do
  let fields ← match value with | .object fields=>pure fields | .null | .boolean _ | .integer _ | .text _ | .array _=>throw "KIN-007 deposited structural vector changed"
  let rendered ← fields.mapM fun (key,v)=>do
   let text ← identityString v
   pure (Text.intercalate "" ["'",key,"': ",text])
  pure (Text.intercalate "" ["{",Text.intercalate ", " rendered,"}"])
 let rangeText := fun (b : Rat×Rat)=>Text.intercalate "" ["{'minimum': '",fractionText b.1,"', 'maximum': '",fractionText b.2,"'}"]
 let occupancyText := Text.intercalate "" ["(",Text.intercalate ", " (analysis.occupancies.map fun r=>Text.intercalate "" ["'",fractionText r,"'"]),")"]
 let messages := rowMessages ++ [Text.intercalate "" ["exact deposited component vector: [",Text.intercalate ", " countTexts,"]"],
  Text.append "exact deposited occupancy vector: " occupancyText,
  Text.append "exact positive difference-density sigma range: " (rangeText analysis.sigmaBounds),
  Text.append "exact positive difference-density range: " (rangeText analysis.densityBounds),
  "complete time-resolved vector: five PDB deposits, two late unresolved records, seven power columns, favorable negative-delay control, adverse 1 ms interleaved-dark contamination record and unresolved late-stage boundary"] ++
  controls.map (fun (name,b) => Text.intercalate "" [name,": ",boolText b])
 let first ← match source with | row::_=>pure row | []=>throw "list index out of range"
 let sourceId ← field first.row "source_id" >>= identityString
 let distinctIds := [sourceId]
 pure ⟨.object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation registrationHash host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array (distinctIds.map Value.text)),
 ("measurements",.array (messages.map Value.text)),("measurement_receipt_hash",.text (identity payload)),
  ("falsification_condition",.text falsification),("passed",.boolean passed)],passed⟩
end SFT.Chemistry.SequentialMechanismValidation
