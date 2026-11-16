from pathlib import Path
import os,sys,json,subprocess,time,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH=str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
# Preserve and await the already-running original grammar build.
receipt=w/'lean_resource_47795.json'
while True:
 try: state=json.loads(receipt.read_text())
 except json.JSONDecodeError: time.sleep(1);continue
 if state['exit'] is not None: break
 time.sleep(2)
assert state['exit']==0,state
for module in ['MolecularRovibronicExperiment']:
 p=root/'SFT/Chemistry'/module
 with (w/(module+'1070_build.log')).open('w') as log:
  subprocess.run(lean+['-o',str(p)+'.olean',str(p)+'.lean'],env=env,stdout=log,stderr=subprocess.STDOUT,check=True)
modules=['State','Witnesses','Recurrences','Grammar','Evidence','Experiment'];names=[];digests={}
for suffix in modules:
 p=root/'SFT/Chemistry'/('MolecularRovibronic'+suffix+'.lean');s=p.read_text()
 ns=re.search(r'^namespace (\S+)',s,re.M)[1]
 names.extend(ns+'.'+x for x in re.findall(r'^(?:def|theorem) (\w+)',s,re.M))
 digests[str(p.relative_to(root))]=hashlib.sha256(p.read_bytes()).hexdigest()
audit=w/'rovibronic1070_audit.lean'
audit.write_text('\n'.join('import SFT.Chemistry.MolecularRovibronic'+x for x in modules)+'\n'+'\n'.join('#print axioms '+x for x in names)+'\n')
p=subprocess.run(lean+[str(audit)],env=env,capture_output=True,text=True)
(w/'rovibronic1070_audit.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
assert len(re.findall('does not depend on any axioms',p.stdout))==len(names),p.stdout[-1800:]
(w/'rovibronic1070_audit_report.json').write_text(json.dumps(dict(status='PASS',declarations=len(names),names=names,source_sha256=digests,all_axiom_dependencies_empty=True),indent=2)+'\n')
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.chemistry.rovibronic_composition_batch import ROVIBRONIC_COMPOSITION_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1070/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
p=subprocess.run(lean+['--run',str(root/'MolecularRovibronicProgram1070.lean'),source],env=env,capture_output=True,text=True)
(w/'rovibronic1070_program_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'rovibronic1070_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
program=GeneratedObservationalChemistryProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'rovibronic1070_program_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_manifest_hash=source,candidates=len(census.candidates),all_fields_and_hashes=True,fresh_native=True,fresh_original=True),indent=2)+'\n')
validator=(w/'pinned1070/claims'/cid/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-rovibronic1070'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('rovibronic1070_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
(w/'rovibronic1070_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('PASS complete256 programme, fresh V3 comparison, full declaration audit and original independent validator with three adverse cases',flush=True)
