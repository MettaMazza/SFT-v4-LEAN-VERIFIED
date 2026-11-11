from pathlib import Path
import json,re
r=Path('work/constants-recovery/SFT/Physics');v=json.load(open('work/interval644_spec.json'));q=lambda x:json.dumps(x,ensure_ascii=False)
s=(r/'UnitExperiment.lean').read_text().replace('SFT.Physics.Unit','SFT.Physics.InverseSquareInterval').replace('UnitEvidence','InverseSquareIntervalEvidence').replace('open SFT.Host.Canonical','open SFT.Host.Canonical')
for name,key in [('claimId','claim_id'),('experimentId','experiment_id'),('expectedLabel','expected_observation_label'),('frozenRelation','exact_result'),('sourcePath','source_snapshot_path'),('snapshotHash','source_snapshot_hash'),('falsification','falsification_condition')]:
 s=re.sub(r'^def '+name+r' : String := .*$',lambda m:'def '+name+' : String := '+q(v[key]),s,flags=re.M)
s=re.sub(r'^def targetRows : List TargetRow := .*$',lambda m:'def targetRows : List TargetRow := ['+','.join('⟨'+','.join(q(x[k]) for k in ['target_id','source_id','source_locator','observed_label'])+'⟩' for x in v['target_rows'])+']',s,flags=re.M)
s=re.sub(r'^def specDependencies : List String := .*$',lambda m:'def specDependencies : List String := '+q(v['dependencies']),s,flags=re.M)
s=s.replace('targetRows.length = 2','targetRows.length = 1').replace('[expectedLabel,expectedLabel]','[expectedLabel]').replace('InverseSquareIntervalEvidence.onePairWitness && InverseSquareIntervalEvidence.successorWitness','InverseSquareIntervalEvidence.witness0 && InverseSquareIntervalEvidence.witness1 && InverseSquareIntervalEvidence.witness2')
(r/'InverseSquareIntervalExperiment.lean').write_text(s)
s=(r/'UnitValidation.lean').read_text().replace('SFT.Physics.Unit','SFT.Physics.InverseSquareInterval').replace('UnitExperiment','InverseSquareIntervalExperiment')
(r/'InverseSquareIntervalValidation.lean').write_text(s)
