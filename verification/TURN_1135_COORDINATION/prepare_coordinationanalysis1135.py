from pathlib import Path
import sys,json,copy
w=Path('work');stage=w/'pinned1135';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import coordination_entity_validation_v1 as v
rows=v._source_rows(stage);primary=json.loads((stage/v.PRIMARY_PATH).read_text());base=dict(rows=rows,primary=primary);cases=[copy.deepcopy(base)]
for role in ['coordination-entity-current-term','FeCO5-C-Fe-link-count','FeCO5-entity-identity','ferrocene-C-Fe-link-count','ferrocene-entity-identity']:
 c=copy.deepcopy(base)
 for r in c['rows']:
  if r['source_record_role']==role:r['source_inscription']='changed'
 cases.append(c)
for key in primary['adverse_and_limitation_surface']:
 c=copy.deepcopy(base);c['primary']['adverse_and_limitation_surface'][key]=False;cases.append(c)
c=copy.deepcopy(base);c['primary']['no_source_value_used_as_fold_proof_parameter']=False;cases.append(c)
c=copy.deepcopy(base);c['rows']=c['rows'][:-1];cases.append(c)
c=copy.deepcopy(base);c['rows']=tuple(reversed(c['rows']));cases.append(c)
c=copy.deepcopy(base);c['rows'][0]['authority']='other';cases.append(c)
expected=[]
for c in cases:
 try:expected.append(dict(ok=v.exact_coordination_entity_analysis(c['rows'],c['primary'])))
 except Exception as e:expected.append(dict(error=str(e)))
(w/'coordinationanalysis1135_input.json').write_text(json.dumps(cases)+'\n');(w/'coordinationanalysis1135_expected.json').write_text(json.dumps(expected)+'\n');print('Original analysis cases',len(cases))
