from pathlib import Path
import json,sys,importlib.util,copy,subprocess,hashlib
from types import SimpleNamespace
w=Path('work');stage=w/'pinned_elimination1503';cid='SFT-CHEM-ELIMINATION-REACTION-FAMILY-010'
sys.path.insert(0,str((w/'radiochemical1122_pdf6142').resolve()));sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry;sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
from sft.chemistry import elimination_reaction_validation_v1 as v
sp=importlib.util.spec_from_file_location('original_electrophilic_execution',stage/'claims'/cid/'execution.py');m=importlib.util.module_from_spec(sp);sp.loader.exec_module(m);execution=m.build_execution(stage)
# Use the actual original execution object's program rather than a historical certificate hash.
print('execution fields',vars(execution).keys(),flush=True)
(w/'elimination1503_execution_fields.json').write_text(json.dumps({k:str(type(val))for k,val in vars(execution).items()},indent=2)+'\n')
p=execution.program;c=p.generate_candidates();dec=tuple(p.decide_candidate(x)for x in c.candidates)
out=canonical_value(dict(registration=p.registration,census=c,decisions=dec,closure=p.closure_evidence(dec),controls=p.run_controls(),unknown_id='StopIteration'))
(w/'elimination1503_original_program.json').write_text(json.dumps(out,indent=2)+'\n')
before=snapshot_protected_tree(stage)
try:empirical=canonical_value(v.EliminationReactionValidator(stage).validate(SimpleNamespace(seal_hash='native-elimination1503')))
except Exception as e:empirical={'error':str(e),'exception_type':type(e).__name__}
assert before==snapshot_protected_tree(stage)
(w/'elimination1503_original_empirical.json').write_text(json.dumps(empirical,indent=2)+'\n')
cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(out,claim_id=cid,seal_hash='native-elimination1503'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('elimination1503_independent_'+case+'.json');f.write_text(json.dumps(sealed));q=subprocess.run([sys.executable,str((stage/'claims'/cid/'independent_validator.py').resolve()),str(f.resolve())],capture_output=True,text=True,check=True);result=json.loads(q.stdout);assert result['passed']==(case=='original');cases.append(dict(case=case,result=result))
(w/'elimination1503_independent.json').write_text(json.dumps(cases,indent=2)+'\n')
print('Original programme',len(c.candidates),'candidates; independent4casesPASS; empirical',empirical.get('passed',empirical.get('error')),flush=True)
