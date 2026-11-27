from pathlib import Path
import sys,json,re
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
import sft.materials
sft.materials.__path__.insert(0,str(Path('work/pinned_bulkwater1499/sft/materials').resolve()))
from sft.materials.successor_evidence import SPECS
from sft.materials.derivation import SUBBRANCH_DEPENDENCIES
spec=next(x for x in SPECS if x.claim_id=='SFT-MAT-BULK-WATER-RESPONSE-002');q=lambda x:json.dumps(x,ensure_ascii=False)
s='''import SFT.Materials.BulkWaterEvidence
import SFT.Materials.BulkWaterSource
import SFT.Chemistry.SourceExtraction
import SFT.Physics.ObservationPrediction
namespace SFT.Materials.BulkWaterExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
'''
for n,v in [('claimId',spec.claim_id),('experimentId',spec.experiment_id),('subbranch',spec.subbranch),('targetId',spec.target_id),('frozenRelation',spec.exact_result),('expectedLabel',spec.expected_observation_label),('falsification',spec.falsification_condition)]:s+='def '+n+' : String := '+q(v)+'\n'
s+='def sourceIds : List String := ['+','.join(q(x)for x in spec.source_ids)+']\n'
s+='def registeredSubbranches : List String := ['+','.join(q(x)for x in SUBBRANCH_DEPENDENCIES)+']\n'
s+='def dimensions : List (String × List (String × Bool)) := ['+','.join('('+q(d.key)+',['+','.join('('+q(c.name)+','+str(c.admitted).lower()+')'for c in d.choices)+'])'for d in spec.dimensions)+']\n'
old=Path('work/constants-recovery/SFT/Materials/QuasicrystalExperiment.lean').read_text();a=old.index('def preservingNames');b=old.index('def binding',a);s+=old[a:b]
a=old.index('def validateSpec');b=old.index('theorem registeredSpecValid',a);v=old[a:b].replace('QuasicrystalEvidence','BulkWaterEvidence').replace('BulkWaterEvidence.witness0 && BulkWaterEvidence.witness1 && BulkWaterEvidence.witness2','BulkWater.witness');v=v[:v.index('  else match binding')]+'''  else if sourceIds.isEmpty || sourceIds.any (fun id => !(BulkWaterSource.sources.any (fun row => Text.equal row.sourceId id))) then
   .error "invalid successor source binding"
  else .ok ()
''';s+=v
s+='''def labelValue (family label : String) : Value := .object [("family",.text family),("label",.text label)]
def program : CapabilityAdmission.Program :=
 ⟨Text.append experimentId "-prediction",[
  ⟨.input,"premise",["registered-premise"]⟩,
  ⟨.label,"prediction",["materials-observation",expectedLabel]⟩,
  ⟨.emit,"",["prediction"]⟩]⟩
def programFields : List (String × Value) := [
 ("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
 ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]
def programDocument : Value := .object programFields
def registrationHash (preSourceSeal : String) (receipts : List Value) : String :=
 identity (.array [.text claimId,.text preSourceSeal,.array receipts])
def envelope (registryHash derivationSeal : String) : Value := .object [
 ("experiment_id",.text experimentId),
 ("registered_inputs",.object [("registered-premise",.text (identity (labelValue "sealed-derivation" derivationSeal)))]),
 ("withheld_target_ids",.array [.text targetId]),
 ("frozen_relation_hash",.text derivationSeal),("experiment_registration_hash",.text registryHash)]
'''
s+='\n'.join('#print axioms '+n for n in re.findall(r'^def (\w+)',s,re.M))+'\nend SFT.Materials.BulkWaterExperiment\n';Path('work/turn1064_recovery/SFT/Materials/BulkWaterExperiment.lean').write_text(s)
