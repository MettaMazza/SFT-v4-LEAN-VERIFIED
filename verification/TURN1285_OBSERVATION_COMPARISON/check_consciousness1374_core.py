from pathlib import Path
import os,subprocess,json,hashlib
w=Path('work');r=w/'turn1064_recovery'
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
p=subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/ConsciousnessCoreCases1374.lean'],env=env,capture_output=True,text=True)
(w/'consciousness1374_core_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:]
actual=[json.loads(line)for line in p.stdout.splitlines()];expected=json.loads((w/'consciousness1374_core_expected.json').read_text());assert actual==expected,[(i,a,e)for i,(a,e)in enumerate(zip(actual,expected))if a!=e]
(w/'consciousness1374_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),source_sha256={str(p.relative_to(r)):hashlib.sha256(p.read_bytes()).hexdigest()for p in [(r/'SFT/Consciousness'/(m+'.lean'))for m in ['StructuralModel']]}),indent=2)+'\n')
print('PASS original consciousness observations',len(expected),flush=True)
