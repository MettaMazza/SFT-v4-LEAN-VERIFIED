from pathlib import Path
import json
r=Path('work/constants-recovery/SFT/Chemistry');old=json.load(open('work/entity554_spec.json'));new=json.load(open('work/ionic572_spec.json'));q=lambda x:json.dumps(x,ensure_ascii=False);s=(r/'EntityExperiment.lean').read_text().replace('EntityExperiment','IonicExperiment').replace('EntityEvidence','IonicEvidence')
for k in ['claim_id','experiment_id','expected_observation_label','exact_result','falsification_condition','observation_registry_path']:s=s.replace(q(old[k]),q(new[k]))
for a,b in zip(old['target_rows'],new['target_rows']):
 for k in a:s=s.replace(q(a[k]),q(b[k]))
a=s.index('def specDimensions');b=s.index('\ndef validateSpec',a);s=s[:a]+'def specDimensions : List (String × List Bool) := ['+','.join('('+q(x['key'])+',['+','.join(str(c['admitted']).lower() for c in x['choices'])+'])' for x in new['dimensions'])+']\ndef specWitnesses : List Bool := ['+','.join(str(x[2]).lower() for x in new['operational_witnesses'])+']\n'+s[b:];(r/'IonicExperiment.lean').write_text(s)
s=(r/'BondValidation.lean').read_text().replace('BondExperiment','IonicExperiment').replace('BondValidation','IonicValidation');(r/'IonicValidation.lean').write_text(s)
s=Path('work/check_entity_validation555.py').read_text().replace('entity_spec554','ionic_spec572').replace('entity_validation555','ionic_validation572').replace('EntityValidation','IonicValidation').replace('555','572');Path('work/check_ionic_validation572.py').write_text(s)

# Frozen derivation and observation labels differ in this source.
import re
p=r/'IonicExperiment.lean'
p.write_text(re.sub(r'^def frozenRelation : String := .*$', 'def frozenRelation : String := '+q(new['exact_result']),p.read_text(),flags=re.M))
