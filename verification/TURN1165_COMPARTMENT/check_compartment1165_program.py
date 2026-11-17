from pathlib import Path
import sys,os,json,subprocess,re,hashlib,copy
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
lean=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.biology
sft.biology.__path__=[str((w/'pinned1165/sft/biology').resolve())]+list(sft.biology.__path__)
from sft.biology.generated_law import BIOLOGY_SPECS,GeneratedEmpiricalBiologyProgram
spec=next(s for s in BIOLOGY_SPECS if s.claim_id=='SFT-BIO-COMPARTMENT-001')
from sft.engine.canonical import canonical_value
cid=spec.claim_id
certificate=json.loads((w/'pinned1165/claims'/cid/'certificate.json').read_text());source=certificate['source_manifest_hash']
from sft.engine.source import build_source_manifest
stage=w/'pinned1165'
manifest=build_source_manifest(stage,[stage/p for p in ['sft/biology/obligations.py', 'sft/biology/structural_counts.py', 'sft/biology/derivation.py', 'sft/biology/generated_law.py', 'sft/biology/external_bindings.py', 'sft/biology/sources.py', 'claims/SFT-BIO-COMPARTMENT-001/execution.py', 'sft/physics/generated_empirical_law.py', 'sft/claim_evidence/fold_language.py', 'sft/claim_evidence/custody.py', 'sft/claim_evidence/hostile.py', 'sft/engine/isolation.py', 'sft/engine/empirical.py']])
assert manifest.manifest_hash==source

p=subprocess.run(lean+['--run',str(root/'CompartmentProgram1165.lean'),source],env=env,capture_output=True,text=True)
(w/'compartment1165_program_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1200:]+p.stderr[-500:]
actual=json.loads(p.stdout);(w/'compartment1165_program_output.json').write_text(json.dumps(actual,indent=2)+'\n')
program=GeneratedEmpiricalBiologyProgram(spec,source);census=program.generate_candidates();decisions=tuple(program.decide_candidate(c) for c in census.candidates)
expected=canonical_value(dict(registration=program.registration,census=census,decisions=decisions,closure=program.closure_evidence(decisions),controls=program.run_controls(),unknown_id='StopIteration'))
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/'compartment1165_program_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_manifest_hash=source,candidates=len(census.candidates),all_fields_and_hashes=True,fresh_native=True,fresh_original=True),indent=2)+'\n')
validator=(w/'pinned1165/claims'/cid/'independent_validator.py').resolve();cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 sealed=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-compartment1165'))
 if case=='omitted_candidate':sealed['census']['candidates']=sealed['census']['candidates'][1:]
 if case=='additional_survivor':sealed['decisions'][0]['survives']=True
 if case=='failed_control':sealed['controls'][0]['passed']=False
 f=w/('compartment1165_independent_'+case+'.json');f.write_text(json.dumps(sealed))
 p=subprocess.run([sys.executable,str(validator),str(f.resolve())],capture_output=True,text=True,check=True)
 result=json.loads(p.stdout);assert result['passed']==(case=='original'),result
 cases.append(dict(case=case,result=result))
(w/'compartment1165_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('PASS complete256 programme, fresh V3 comparison, retained grammar/evidence audit and original independent validator with three adverse cases',flush=True)
