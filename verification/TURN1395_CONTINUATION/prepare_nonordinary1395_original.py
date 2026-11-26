from pathlib import Path
import sys,subprocess,json,copy,hashlib
w=Path('work');stage=w/'pinned1394';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.consciousness.nonordinary_laws_v1 import SPECS,StructuralConsciousnessProgram,EMPIRICAL_ID
from sft.engine.canonical import canonical_value
from sft.engine.source import build_source_manifest
rows=[]
def retain(rel):
 p=stage/rel
 if not p.exists():
  b=subprocess.check_output(['git','-C',repo,'show',pin+':'+rel]);p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b)
 rows.append({'path':rel,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()});return p
for cid,spec in SPECS.items():
 for rel in [f'claims/{cid}/execution.py',f'claims/{cid}/registration.json',f'claims/{cid}/certificate.json']+[f'claims/{d}/{n}.json'for d in spec.dependencies for n in ['registration','certificate']]:retain(rel)
 fixed=['sft/consciousness/nonordinary_laws_v1.py','sft/consciousness/nonordinary_execution_v1.py','sft/physics/structural_constants.py',f'claims/{cid}/execution.py']
 if cid==EMPIRICAL_ID:fixed+=['sft/consciousness/nonordinary_external_v1.py']
 fixed += [f'claims/{d}/{n}.json'for d in spec.dependencies for n in ['registration','certificate']]
 source=build_source_manifest(stage,[stage/rel for rel in dict.fromkeys(fixed)]).manifest_hash
 cert=json.loads((stage/f'claims/{cid}/certificate.json').read_text());assert source==cert['source_manifest_hash'],cid
 p=StructuralConsciousnessProgram(spec,source);c=p.generate_candidates();ds=tuple(p.decide_candidate(x)for x in c.candidates)
 expected=canonical_value(dict(registration=p.registration,census=c,decisions=ds,closure=p.closure_evidence(ds),controls=p.run_controls(),unknown_id='StopIteration'))
 tag=next(x['name']for x in json.loads((w/'nonordinary1394_plan.json').read_text())if x['claim_id']==cid)
 (w/(tag+'1395_expected.json')).write_text(json.dumps(expected,indent=2)+'\n')
 cases=[]
 for case in ['original','omitted_candidate','additional_survivor','failed_control']:
  s=copy.deepcopy(dict(expected,claim_id=cid,seal_hash='native-nonordinary1395'))
  if case=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
  if case=='additional_survivor':s['decisions'][0]['survives']=True
  if case=='failed_control':s['controls'][0]['passed']=False
  f=w/(tag+'1395_original_'+case+'.json');f.write_text(json.dumps(s));x=subprocess.run([sys.executable,str(stage/'generated/consciousness/nonordinary_validator_v1.py'),cid,str(stage.resolve()),str(f.resolve())],capture_output=True,text=True);v=json.loads(x.stdout);assert v['passed']==(case=='original');assert x.returncode==(0 if case=='original'else 1);cases.append({'case':case,'result':v})
 (w/(tag+'1395_original_report.json')).write_text(json.dumps({'status':'PASS','source_manifest_hash':source,'source_pin':pin,'candidates':len(c.candidates),'survivors':sum(x.survives for x in ds),'original_independent_cases':cases},indent=2)+'\n')
 print(tag,'original programme256 + four independent cases PASS',flush=True)
(w/'nonordinary1395_original_files.json').write_text(json.dumps(rows,indent=2)+'\n')
