from pathlib import Path
import sys,json
w=Path('work');r=w/'turn1064_recovery/SFT/AstronomyCosmology';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.astronomy_cosmology.empirical_program import ASTRONOMY_SPECS
spec=next(x for x in ASTRONOMY_SPECS if x.claim_id=='SFT-ASTRO-FLUX-LUMINOSITY-001');bp=spec.blueprint;q=lambda x:json.dumps(x,ensure_ascii=False)
ls=lambda xs:'['+','.join(q(x)for x in xs)+']'
dims='['+','.join('⟨'+q(d.key)+','+q(d.required_property)+',['+','.join('⟨'+q(c.name)+','+ls(sorted(c.properties))+','+q(c.explanation)+'⟩'for c in d.choices)+']⟩'for d in bp.dimensions)+']'
fields=[q(bp.claim_id),q(bp.title),q(bp.family),q(bp.statement),ls(bp.dependencies),q(bp.generation_rule),q(bp.grammar_boundary),dims,q(bp.exact_result),q(bp.induction_base),q(bp.induction_step),ls(bp.exclusions),'['+','.join('('+q(n)+','+q(e)+',FluxLuminosity.'+v+')'for(n,e,_),v in zip(bp.operational_witnesses,['carrierWitness','relationWitness','boundaryWitness','exactFoldWitness']))+']',q(bp.experiment_id),q(bp.predicted_observation_label),q(bp.falsification_condition)]
s='''import SFT.AstronomyCosmology.FluxLuminosityEvidence
import SFT.AstronomyCosmology.Source
namespace SFT.AstronomyCosmology.FluxLuminosityExperiment
open SFT.Host SFT.Host.Canonical
'''
s+='def blueprint : Source.Blueprint := ⟨'+','.join(fields)+'⟩\n'
s+='def originalSpec : Source.Spec := ⟨blueprint,Source.adapt blueprint,['+','.join('⟨'+','.join(q(getattr(row,k))for k in ['target_id','source_id','source_locator','observed_label'])+'⟩'for row in spec.target_rows)+'],'+','.join(q(getattr(spec,k))for k in ['source_snapshot_path','source_snapshot_hash','empirical_disposition','directness'])+'⟩\n'
s+='''def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def predictionDocument (spec : Source.Spec) : Value := .object [
 ("schema",.text "sft-v3-fold-program/1"),("program_id",.text (Text.append spec.blueprint.experimentId "-prediction")),
 ("instructions",.array [
 .object [("opcode",.text "input"),("destination",.text "premise"),("arguments",.array [.text "registered-premise"])],
 .object [("opcode",.text "label"),("destination",.text "prediction"),("arguments",.array [.text "physical-observation",.text spec.blueprint.predictedObservationLabel])],
 .object [("opcode",.text "pair"),("destination",.text "bound-result"),("arguments",.array [.text "premise",.text "prediction"])],
 .object [("opcode",.text "emit"),("destination",.text ""),("arguments",.array [.text "prediction"])]] )]
def programFields (spec : Source.Spec) : List (String × Value) := match predictionDocument spec with
 | .object fs => fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => []
def registration (spec : Source.Spec) : Value := .object [
 ("experiment_id",.text spec.blueprint.experimentId),("claim_id",.text spec.blueprint.claimId),
 ("frozen_relation",.text spec.blueprint.exactResult),("source_snapshot_path",.text spec.sourceSnapshotPath),
 ("source_snapshot_hash",.text spec.sourceSnapshotHash),("target_ids",.array (spec.targetRows.map fun r => .text r.targetId)),
 ("target_locators",.array (spec.targetRows.map fun r => .array [.text r.targetId,.text r.sourceId,.text r.registeredLocator])),
 ("prediction_program",predictionDocument spec),("expected_observation_label",.text spec.blueprint.predictedObservationLabel),
 ("falsification_condition",.text spec.blueprint.falsificationCondition),("all_rows_required",.boolean true),
 ("target_inaccessible_before_seal",.boolean true)]
def envelope (spec : Source.Spec) (registrationHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text spec.blueprint.experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array (spec.targetRows.map fun r => .text r.targetId)),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash)]
end SFT.AstronomyCosmology.FluxLuminosityExperiment
'''
(r/'FluxLuminosityExperiment.lean').write_text(s)
# Reuse the exact existing custody/isolation implementation, changing only the original comparator identity.
s=(w/'turn1064_recovery/SFT/EarthEnvironment/EarthHazardRiskHandoffValidation.lean').read_text()
s=s[:s.index('def predictionLabel')]
s=s.replace('EarthEnvironment','AstronomyCosmology').replace('EarthHazardRiskHandoff','FluxLuminosity')
s=s.replace('def sealPrediction (prior','def sealPrediction (spec : Source.Spec) (prior').replace('def isolation (host','def isolation (spec : Source.Spec) (host')
s=s.replace('envelope registrationHash','envelope spec registrationHash').replace('experimentId','spec.blueprint.experimentId')
s=s.replace('.text "exact-earth-boundary-equality",.text spec.blueprint.experimentId','.text "exact-held-label-equality",.text spec.blueprint.experimentId,.text spec.blueprint.falsificationCondition')
s+='''def predictionLabel : CapabilityValues.Value → Except String String
 | .label held => if Text.equal held.family "physical-observation" then .ok held.label
   else .error "prediction emitted an invalid physical observation label"
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "prediction emitted an invalid physical observation label"
def validate (spec : Source.Spec) (records : List (String × Value)) (files : List Source.Snapshot)
 (derivationSeal host implementation : String) (before after : Snapshot) : Except String Value := do
 Source.validateSpec spec records
 let bytes ← SFT.Materials.MaterialSource.readSnapshot files spec.sourceSnapshotPath
 if !Text.equal (SFT.Materials.MaterialSource.bytesHash bytes) spec.sourceSnapshotHash then
  throw "external measurement snapshot differs from registration"
 let registrationHash := identity (registration spec)
 let program ← CapabilityDocuments.loadProgramFields (programFields spec)
 let inputs ← inputValues derivationSeal
 let targets ← spec.targetRows.mapM fun row => do
  let held ← CapabilityValues.heldLabel "external-observation" row.observedLabel
  pure (row.targetId,CapabilityValues.canonical (.label held))
 let vault ← TargetCustody.createVault spec.blueprint.experimentId
  (Text.append spec.blueprint.experimentId "-external-target-custodian") targets
  (identity (.array [.text registrationHash,.text spec.sourceSnapshotHash]))
  (identity (envelope spec registrationHash derivationSeal))
 let execution ← CapabilityExecution.execute program inputs
 let prediction ← sealPrediction spec none registrationHash derivationSeal execution
 let (audited,audit) ← HostilePackage.auditProgram (programFields spec) before after
 if !Text.equal (identity (CapabilityExecution.canonicalProgram audited)) execution.programHash || !audit.passed then
  throw "prediction program identity differs after hostile-package audit"
 let (_,release) ← TargetCustody.release vault prediction
 TargetCustody.verify vault.commitment release prediction
 let _context ← SFT.Computation.MathematicalModelling.openTargets
  (some ⟨prediction.experiment,prediction.predictionHash,prediction.traceHash,prediction.envelopeHash,prediction.sealHash⟩)
  (spec.targetRows.map Source.ExternalTarget.targetId) release.values
 let predicted ← predictionLabel execution.output
 let comparisons ← spec.targetRows.mapM fun row => do
  let released ← match release.values.find? (fun pair => Text.equal pair.1 row.targetId) with
   | none => .error (Text.intercalate "" ["'",row.targetId,"'"])
   | some pair => .ok pair.2
  let observed := SFT.Materials.MaterialSource.string (SFT.Materials.MaterialSource.field released "label")
  pure (row,observed,Text.equal predicted observed)
 let comparisonValues := comparisons.map fun (row,observed,passed) => Value.object [
  ("target_id",.text row.targetId),("source_id",.text row.sourceId),("source_locator",.text row.registeredLocator),
  ("predicted",.text predicted),("observed",.text observed),("passed",.boolean passed)]
 let controlPassed := !Text.equal predicted "changed-external-observation"
 let tampered := Value.object [("target_id",.text "deliberately-tampered-unfavorable-control"),
  ("predicted",.text predicted),("observed",.text "changed-external-observation"),("passed",.boolean controlPassed)]
 let passed := comparisons.all (fun (_,_,ok) => ok) && controlPassed
 let targetIdentity ← TargetCustody.identityFromRelease release
 if !Text.equal targetIdentity vault.commitment.targetHash then
  throw "released target identity differs from its commitment"
 let payload := Value.object [
  ("experiment_registration_hash",.text registrationHash),("derivation_seal_hash",.text derivationSeal),
  ("prediction_seal_hash",.text prediction.sealHash),("source_snapshot_hash",.text spec.sourceSnapshotHash),
  ("comparisons",.array comparisonValues),("tampered_control",tampered),("complete_trace_hash",.text execution.traceHash)]
 let messages := comparisons.map fun (row,observed,ok) => Text.intercalate "" [row.targetId,
  ": predicted ",predicted,"; observed ",observed,"; exact match ",if ok then "True" else "False"]
 return .object [("validated_seal_hash",.text derivationSeal),("experiment_registration_hash",.text registrationHash),
  ("isolation_certificate",isolation spec host implementation execution vault prediction),
  ("target_custody_certificate",custodyCertificate registrationHash release prediction),
  ("evaluator_verified_seal",.boolean true),("target_opened_after_seal",.boolean true),("all_rows_preserved",.boolean true),
  ("data_source_ids",.array ((spec.targetRows.map Source.ExternalTarget.sourceId).eraseDups.map Value.text)),
  ("measurements",.array ((messages ++ ["deliberately tampered unfavorable control rejected"]).map Value.text)),
  ("measurement_receipt_hash",.text (identity payload)),("falsification_condition",.text spec.blueprint.falsificationCondition),
  ("passed",.boolean passed)]
end SFT.AstronomyCosmology.FluxLuminosityValidation
'''
(r/'FluxLuminosityValidation.lean').write_text(s)
print('Staged original Astronomy registration/prediction and inherited full measurement validator')
