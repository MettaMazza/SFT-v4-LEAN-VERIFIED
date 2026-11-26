from pathlib import Path
import ast,subprocess,json,re,sys,copy,hashlib
from types import SimpleNamespace
w=Path('work');stage=w/'pinned_coordisomer1473';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-CHEM-COORDINATION-ISOMERISM-EQUIVALENCE-005'
def read(rel):return subprocess.check_output(['git','-C',repo,'show',pin+':'+rel])
batch=read('sft/chemistry/coordination_isomerism_batch_v1.py');execution=read('claims/'+cid+'/execution.py').decode();constants={}
for n in ast.parse(batch).body:
 if isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
  try:constants[n.targets[0].id]=ast.literal_eval(n.value)
  except (ValueError,TypeError):pass
source_paths=re.findall(r'root / "([^"]+)"',execution.split('source_hash =')[0])+[constants[n]for n in re.findall(r'root / ([A-Z_]+)',execution.split('source_hash =')[0])]+[p for p,_ in constants['SOURCE_FILES']]
paths=list(dict.fromkeys(source_paths+['claims/'+cid+'/certificate.json','claims/'+cid+'/independent_validator.py','sft/chemistry/coordination_entity_law_v1.py']))
rows=[]
for rel in paths:
 b=read(rel);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);rows.append({'path':rel,'sha256':hashlib.sha256(b).hexdigest()})
for d in ['census','receipts']:
 p=stage/d
 if not p.exists():p.symlink_to((w/'v3-runtime500'/d).resolve(),target_is_directory=True)
(w/'coordisomer1474_source_pin.json').write_text(json.dumps({'commit':pin,'files':rows},indent=2)+'\n')
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry.coordination_isomerism_batch_v1 import COORDINATION_ISOMERISM_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.chemistry.coordination_isomerism_validation_v1 import CoordinationIsomerismValidator
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
source=build_source_manifest(stage,[stage/p for p in source_paths]).manifest_hash
assert source==json.loads((stage/'claims'/cid/'certificate.json').read_text())['source_manifest_hash']
p=GeneratedObservationalChemistryProgram(spec,source);c=p.generate_candidates();dec=tuple(p.decide_candidate(x)for x in c.candidates)
out=canonical_value(dict(registration=p.registration,census=c,decisions=dec,closure=p.closure_evidence(dec),controls=p.run_controls(),unknown_id='StopIteration'))
(w/'coordisomer1474_original_program.json').write_text(json.dumps(out,indent=2)+'\n')
before=snapshot_protected_tree(stage);report=canonical_value(CoordinationIsomerismValidator(stage).validate(SimpleNamespace(seal_hash='native-coordisomer1474')));assert report['passed'] and before==snapshot_protected_tree(stage)
(w/'coordisomer1474_original_empirical.json').write_text(json.dumps(report,indent=2)+'\n');cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(out,claim_id=cid,seal_hash='native-coordisomer1474'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('coordisomer1474_independent_'+case+'.json');f.write_text(json.dumps(sealed));q=subprocess.run([sys.executable,str((stage/'claims'/cid/'independent_validator.py').resolve()),str(f.resolve())],capture_output=True,text=True,check=True);value=json.loads(q.stdout);assert value['passed']==(case=='original');cases.append({'case':case,'result':value})
(w/'coordisomer1474_original_independent.json').write_text(json.dumps(cases,indent=2)+'\n')
a={'status':'PASS','source_manifest_hash':source,'source_files':len(rows),'candidates':len(c.candidates),'survivors':sum(x.survives for x in dec),'controls':len(out['controls']),'empirical_fields':len(report),'measurements':len(report['measurements']),'independent_cases':len(cases),'protected_tree_unchanged':True};(w/'coordisomer1474_original_report.json').write_text(json.dumps(a,indent=2)+'\n');print(a)
