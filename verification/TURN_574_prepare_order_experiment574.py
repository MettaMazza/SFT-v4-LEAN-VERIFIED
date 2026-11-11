from pathlib import Path
import json
r=Path('work/constants-recovery/SFT/Chemistry');old=json.load(open('work/entity554_spec.json'));new=json.load(open('work/order574_spec.json'));q=lambda x:json.dumps(x,ensure_ascii=False);s=(r/'EntityExperiment.lean').read_text().replace('EntityExperiment','OrderExperiment').replace('EntityEvidence','OrderEvidence')
for k in ['claim_id','experiment_id','expected_observation_label','exact_result','falsification_condition','observation_registry_path']:s=s.replace(q(old[k]),q(new[k]))
for a,b in zip(old['target_rows'],new['target_rows']):
 for k in a:s=s.replace(q(a[k]),q(b[k]))
a=s.index('def specDimensions');b=s.index('\ndef validateSpec',a);s=s[:a]+'def specDimensions : List (String × List Bool) := ['+','.join('('+q(x['key'])+',['+','.join(str(c['admitted']).lower() for c in x['choices'])+'])' for x in new['dimensions'])+']\ndef specWitnesses : List Bool := ['+','.join(str(x[2]).lower() for x in new['operational_witnesses'])+']\n'+s[b:];(r/'OrderExperiment.lean').write_text(s)
s=(r/'BondValidation.lean').read_text().replace('BondExperiment','OrderExperiment').replace('BondValidation','OrderValidation');(r/'OrderValidation.lean').write_text(s)
s=Path('work/check_entity_validation555.py').read_text().replace('entity_spec554','order_spec574').replace('entity_validation555','order_validation574').replace('EntityValidation','OrderValidation').replace('555','574');Path('work/check_order_validation574.py').write_text(s)

# Frozen derivation and observation labels differ in this source.
import re
p=r/'OrderExperiment.lean'
p.write_text(re.sub(r'^def frozenRelation : String := .*$', 'def frozenRelation : String := '+q(new['exact_result']),p.read_text(),flags=re.M))
