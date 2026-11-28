from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft
# runtime original source files already pinned
from sft.astronomy_cosmology.empirical_program import ASTRONOMY_SPECS,GeneratedEmpiricalAstronomyProgram
spec=next(s for s in ASTRONOMY_SPECS if s.claim_id=='SFT-ASTRO-SOURCE-001')
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1578/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
from sft.engine.source import build_source_manifest
stage=w/'pinned1578'
execution=(stage/'claims'/cid/'execution.py').read_text()
files=re.findall(r'root\s*/\s*"([^"]+)"',execution.split('source_hash')[0]);files.insert(10,spec.source_snapshot_path)
manifest=build_source_manifest(stage,[stage/p for p in files])
assert manifest.manifest_hash==source

p=subprocess.run([sys.executable,'work/run_lean_guarded.py','work/astrosource1578_native/AstronomicalSourceProgramme1578',source],env=env,capture_output=True,text=True)
(w/'astrosource1578_program_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'astrosource1578_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
program=GeneratedEmpiricalAstronomyProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'astrosource1578_program_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_manifest_hash=source,candidates=len(census.candidates),all_fields_and_hashes=True,fresh_native=True,fresh_original=True),indent=2)+'\n')
validator=(w/'pinned1578/claims'/cid/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-astrosource1578'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('astrosource1578_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
(w/'astrosource1578_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('PASS complete256 programme, fresh V3 comparison, retained grammar/evidence audit and original independent validator with three adverse cases',flush=True)
