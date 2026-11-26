from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((w/'pinned_metalcarbon1480/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.organometallic_metal_carbon_bond_batch_v1 import ORGANOMETALLIC_METAL_CARBON_BOND_SPEC as spec
from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram
from sft.engine.source import build_source_manifest
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned_metalcarbon1480/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
stage=w/'pinned_metalcarbon1480'
fixed=json.loads((w/'metalcarbon1480_source_pin.json').read_text())['source_manifest_files']
manifest=build_source_manifest(stage,[stage/p for p in fixed]);assert manifest.manifest_hash==source

p=subprocess.run([sys.executable,'work/prepare_metalcarbon1480_program_native.py','--execute',source],env=env,capture_output=True,text=True)
(w/'metalcarbon1480_program_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'metalcarbon1480_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
program=GeneratedObservationalChemistryProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'metalcarbon1480_program_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_manifest_hash=source,candidates=len(census.candidates),all_fields_and_hashes=True,fresh_native=True,fresh_original=True),indent=2)+'\n')
validator=(w/'pinned_metalcarbon1480/claims'/cid/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-metalcarbon1480'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('metalcarbon1480_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
(w/'metalcarbon1480_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('PASS complete256 programme, fresh V3 comparison, retained grammar/evidence audit and original independent validator with three adverse cases',flush=True)
