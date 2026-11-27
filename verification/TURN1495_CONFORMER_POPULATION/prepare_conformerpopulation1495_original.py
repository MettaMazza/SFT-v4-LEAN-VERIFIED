from pathlib import Path
import ast,subprocess,json,sys,copy,hashlib
from types import SimpleNamespace
w=Path('work');stage=w/'pinned_conformerpopulation1495';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-CHEM-CONFORMER-POPULATION-ORDERING-006'
def read(rel):return subprocess.check_output(['git','-C',repo,'show',pin+':'+rel])
batch=read('sft/chemistry/conformer_population_ordering_batch_v1.py');execution=read('claims/'+cid+'/execution.py');constants={}
for n in ast.parse(batch).body:
 if isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
  try:constants[n.targets[0].id]=ast.literal_eval(n.value)
  except (ValueError,TypeError):pass
fixed=next(n.value for n in ast.walk(ast.parse(execution)) if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='fixed'for t in n.targets))
source_paths=[constants[n.id]if isinstance(n,ast.Name)else ast.literal_eval(n)for n in fixed.elts]
targets=json.loads(read(constants['TARGET_PATH']));tree=set(subprocess.check_output(['git','-C',repo,'ls-tree','-r','--name-only',pin],text=True).splitlines())
def paths(value):
 if isinstance(value,dict):
  for v in value.values():yield from paths(v)
 elif isinstance(value,list):
  for v in value:yield from paths(v)
 elif isinstance(value,str) and not value.startswith('sha256:') and '/' in value and len(value)<512 and not Path(value).is_absolute() and value in tree:yield value
source_paths=list(dict.fromkeys(source_paths+list(paths(targets))))
allpaths=list(dict.fromkeys(source_paths+['claims/'+cid+'/certificate.json','claims/'+cid+'/independent_validator.py','sft/chemistry/conformer_generation_equivalence_law_v1.py']))
rows=[]
for rel in allpaths:
 b=read(rel);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);rows.append({'path':rel,'sha256':hashlib.sha256(b).hexdigest()})
for d in ['census','receipts']:
 p=stage/d
 if not p.exists():p.symlink_to((w/'v3-runtime500'/d).resolve(),target_is_directory=True)
(w/'conformerpopulation1495_source_pin.json').write_text(json.dumps({'commit':pin,'files':rows,'source_manifest_files':source_paths},indent=2)+'\n')
sys.path.insert(0,str((w/'v3-runtime500').resolve()));import sft.chemistry
sft.chemistry.__path__.insert(0,str((stage/'sft/chemistry').resolve()))
from sft.chemistry.conformer_population_ordering_batch_v1 import CONFORMER_POPULATION_ORDERING_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.chemistry.conformer_population_ordering_validation_v1 import ConformerPopulationOrderingValidator
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
source=build_source_manifest(stage,[stage/p for p in source_paths]).manifest_hash
execution_comparison=json.loads((w/'conformerpopulation1495_execution_manifest_comparison.json').read_text())
assert source==execution_comparison['stage_hash']==execution_comparison['original_hash']
assert set(source_paths)==set(execution_comparison['original_paths'])
p=GeneratedObservationalChemistryProgram(spec,source);c=p.generate_candidates();dec=tuple(p.decide_candidate(x)for x in c.candidates)
out=canonical_value(dict(registration=p.registration,census=c,decisions=dec,closure=p.closure_evidence(dec),controls=p.run_controls(),unknown_id='StopIteration'))
(w/'conformerpopulation1495_original_program.json').write_text(json.dumps(out,indent=2)+'\n')
before=snapshot_protected_tree(stage);report=canonical_value(ConformerPopulationOrderingValidator(stage).validate(SimpleNamespace(seal_hash='native-conformerpopulation1495')));assert report['passed'] and before==snapshot_protected_tree(stage)
(w/'conformerpopulation1495_original_empirical.json').write_text(json.dumps(report,indent=2)+'\n');cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(out,claim_id=cid,seal_hash='native-conformerpopulation1495'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('conformerpopulation1495_independent_'+case+'.json');f.write_text(json.dumps(sealed));q=subprocess.run([sys.executable,str((stage/'claims'/cid/'independent_validator.py').resolve()),str(f.resolve())],capture_output=True,text=True,check=True);value=json.loads(q.stdout);assert value['passed']==(case=='original');cases.append({'case':case,'result':value})
(w/'conformerpopulation1495_original_independent.json').write_text(json.dumps(cases,indent=2)+'\n')
a={'status':'PASS','source_manifest_hash':source,'source_files':len(rows),'candidates':len(c.candidates),'survivors':sum(x.survives for x in dec),'controls':len(out['controls']),'empirical_fields':len(report),'measurements':len(report['measurements']),'independent_cases':len(cases),'protected_tree_unchanged':True};(w/'conformerpopulation1495_original_report.json').write_text(json.dumps(a,indent=2)+'\n');print(a)
