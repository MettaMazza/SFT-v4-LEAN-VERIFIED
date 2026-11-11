from pathlib import Path
import json,re
r=Path('work/constants-recovery/SFT/Physics');v=json.load(open('work/nuclear_sequence650_spec.json'));q=lambda x:json.dumps(x,ensure_ascii=False)
s=(r/'UnitExperiment.lean').read_text().replace('SFT.Physics.Unit','SFT.Physics.NuclearSequence').replace('UnitEvidence','NuclearSequenceEvidence').replace('open SFT.Host.Canonical','open SFT.Host.Canonical')
for name,key in [('claimId','claim_id'),('experimentId','experiment_id'),('expectedLabel','expected_observation_label'),('frozenRelation','exact_result'),('sourcePath','source_snapshot_path'),('snapshotHash','source_snapshot_hash'),('falsification','falsification_condition')]:
 s=re.sub(r'^def '+name+r' : String := .*$',lambda m:'def '+name+' : String := '+q(v[key]),s,flags=re.M)
s=re.sub(r'^def targetRows : List TargetRow := .*$',lambda m:'def targetRows : List TargetRow := ['+','.join('⟨'+','.join(q(x[k]) for k in ['target_id','source_id','source_locator','observed_label'])+'⟩' for x in v['target_rows'])+']',s,flags=re.M)
s=re.sub(r'^def specDependencies : List String := .*$',lambda m:'def specDependencies : List String := '+q(v['dependencies']),s,flags=re.M)
s=s.replace('targetRows.length = 2','targetRows.length = 1').replace('[expectedLabel,expectedLabel]','[expectedLabel]').replace('NuclearSequenceEvidence.onePairWitness && NuclearSequenceEvidence.successorWitness','NuclearSequenceEvidence.witness0 && NuclearSequenceEvidence.witness1 && NuclearSequenceEvidence.witness2')
(r/'NuclearSequenceExperiment.lean').write_text(s)
s=(r/'UnitValidation.lean').read_text().replace('SFT.Physics.Unit','SFT.Physics.NuclearSequence').replace('UnitExperiment','NuclearSequenceExperiment')
(r/'NuclearSequenceValidation.lean').write_text(s)
