exec(open('work/prepare_material_source652.py').read().split("s='''")[0])
q=lambda v:json.dumps(v,ensure_ascii=False)
registration=namespace['experiment_registration_record'](root,spec)
s='''import SFT.Materials.MaterialSource
import SFT.Physics.ObservationPrediction
namespace SFT.Materials.MaterialExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
for name,v in [('claimId',spec.claim_id),('experimentId',spec.experiment_id),('expectedLabel',spec.expected_observation_label),('frozenRelation',spec.exact_result),('falsification',spec.falsification_condition),('targetId',spec.target_id)]:s+='def '+name+' : String := '+q(v)+'\n'
s+='def sourceIds : List String := '+q(list(spec.source_ids))+'\n'
s+='''def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def program : CapabilityAdmission.Program :=
 ⟨Text.append experimentId "-prediction",[
  ⟨.input,"premise",["registered-premise"]⟩,
  ⟨.label,"prediction",["materials-observation",expectedLabel]⟩,
  ⟨.pair,"bound-result",["premise","prediction"]⟩,
  ⟨.emit,"",["prediction"]⟩]⟩
def programFields : List (String × Value) := [
 ("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
 ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def programDocument : Value := .object programFields
'''
# Original registration fields except the dynamically verified pre-source seal and generated program.
s+='def registration (sealHash : String) : Value := .object ['+','.join('('+q(k)+','+('.text sealHash' if k=='pre_source_seal_hash' else 'programDocument' if k=='prediction_program' else cv(v))+')' for k,v in registration.items())+']\n'
s+='''def envelope (registryHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),("frozen_relation_hash",.text derivationSeal),
 ("experiment_registration_hash",.text registryHash)]

def validateSpec : Except String Unit :=
 if !(Text.chars "SFT-MAT-").isPrefixOf (Text.chars claimId) then .error "Materials blueprint claim identity is invalid"
 else if !(Text.chars "SFT-EXP-MAT-").isPrefixOf (Text.chars experimentId) then .error "Materials blueprint experiment identity is invalid"
 else if !(MaterialEvidence.witness0 && MaterialEvidence.witness1 && MaterialEvidence.witness2) then
   .error "Materials operational witness failed"
 else .ok ()

theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Materials.MaterialExperiment
'''
Path('work/constants-recovery/SFT/Materials/MaterialExperiment.lean').write_text(s)
