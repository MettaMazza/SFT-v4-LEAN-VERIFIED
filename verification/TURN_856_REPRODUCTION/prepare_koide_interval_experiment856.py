from pathlib import Path
import json,re
r=Path('work/constants-recovery/SFT/Physics');v=json.load(open('work/koide_interval856_spec.json'));q=lambda x:json.dumps(x,ensure_ascii=False)
s=(r/'UnitExperiment.lean').read_text().replace('SFT.Physics.Unit','SFT.Physics.KoideInterval').replace('UnitEvidence','KoideIntervalEvidence').replace('open SFT.Host.Canonical','open SFT.Host.Canonical')
for name,key in [('claimId','claim_id'),('experimentId','experiment_id'),('expectedLabel','expected_observation_label'),('frozenRelation','exact_result'),('sourcePath','source_snapshot_path'),('snapshotHash','source_snapshot_hash'),('falsification','falsification_condition')]:
 s=re.sub(r'^def '+name+r' : String := .*$',lambda m:'def '+name+' : String := '+q(v[key]),s,flags=re.M)
s=re.sub(r'^def targetRows : List TargetRow := .*$',lambda m:'def targetRows : List TargetRow := ['+','.join('⟨'+','.join(q(x[k]) for k in ['target_id','source_id','source_locator','observed_label'])+'⟩' for x in v['target_rows'])+']',s,flags=re.M)
s=re.sub(r'^def specDependencies : List String := .*$',lambda m:'def specDependencies : List String := '+q(v['dependencies']),s,flags=re.M)
s=s.replace('KoideIntervalEvidence.onePairWitness && KoideIntervalEvidence.successorWitness','KoideIntervalEvidence.witness0 && KoideIntervalEvidence.witness1 && KoideIntervalEvidence.witness2')
(r/'KoideIntervalExperiment.lean').write_text(s)
s=(r/'UnitValidation.lean').read_text().replace('SFT.Physics.Unit','SFT.Physics.KoideInterval').replace('UnitExperiment','KoideIntervalExperiment')
(r/'KoideIntervalValidation.lean').write_text(s)
