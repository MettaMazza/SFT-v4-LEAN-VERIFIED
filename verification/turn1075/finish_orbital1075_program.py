from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
cfg=json.loads((w/'orbital1075_report.json').read_text());assert cfg['status']=='PASS'
for module,sha in cfg['source_sha256'].items():assert hashlib.sha256((root/'SFT/Chemistry'/(module+'.lean')).read_bytes()).hexdigest()==sha
import time
receipt=w/'lean_resource_61523.json'
while True:
 try: state=json.loads(receipt.read_text())
 except json.JSONDecodeError: time.sleep(1);continue
 if state['exit'] is not None:break
 time.sleep(2)
assert state['exit']==0,state
module=root/'SFT/Chemistry/OrbitalSupportEvidence'
with (w/'orbital1075_evidence_build.log').open('w') as log:
 subprocess.run(lean+['-o',str(module)+'.olean',str(module)+'.lean'],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)

names=[];digests={}
for module in ['OrbitalSupportGrammar','OrbitalSupportEvidence']:
 p=root/'SFT/Chemistry'/(module+'.lean');t=p.read_text();ns=re.search(r'^namespace (\S+)',t,re.M)[1];names.extend(ns+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',t,re.M));digests[module]=hashlib.sha256(p.read_bytes()).hexdigest()
p=w/'orbital1075_entry_audit.lean';p.write_text('import SFT.Chemistry.OrbitalSupportEvidence\n'+''.join('#print axioms '+n+'\n'for n in names))
o=subprocess.run(lean+[str(p)],env=env,capture_output=True,text=True);(w/'orbital1075_entry_audit.log').write_text(o.stdout+o.stderr);assert o.returncode==0;assert o.stdout.count('does not depend on any axioms')==len(names)
(w/'orbital1075_entry_audit_report.json').write_text(json.dumps(dict(status='PASS',new_declarations=len(names),names=names,source_sha256=digests,axioms=[]),indent=2)+'\n')
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry.orbital_support_batch_v1 import ORBITAL_SUPPORT_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1075/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
p=subprocess.run(lean+['--run',str(root/'OrbitalSupportProgram1075.lean'),source],env=env,capture_output=True,text=True)
(w/'orbital1075_program_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'orbital1075_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
program=GeneratedObservationalChemistryProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'orbital1075_program_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_manifest_hash=source,candidates=len(census.candidates),all_fields_and_hashes=True,fresh_native=True,fresh_original=True),indent=2)+'\n')
validator=(w/'pinned1075/claims'/cid/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-orbital1075'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('orbital1075_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
(w/'orbital1075_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('PASS complete256 programme, fresh V3 comparison, full declaration audit and original independent validator with three adverse cases',flush=True)
