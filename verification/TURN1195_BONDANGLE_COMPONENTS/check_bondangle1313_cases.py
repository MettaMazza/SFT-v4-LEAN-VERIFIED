from pathlib import Path
import os,subprocess,json,hashlib
w=Path('work');root=(w/'turn1064_recovery').resolve()
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(root)+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean',LEAN_NUM_THREADS='1')
cmd=['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/MolecularBondAngleCases1313.lean']
p=subprocess.run(cmd,env=env,capture_output=True,text=True)
(w/'bondangle1313_cases_execution.log').write_text(p.stdout+p.stderr)
assert p.returncode==0,p.stdout[-1500:]+p.stderr[-500:]
actual=json.loads(p.stdout);expected=json.loads((w/'bondangle1313_cases_expected.json').read_text());assert actual==expected
(w/'bondangle1313_cases_output.json').write_text(json.dumps(actual,indent=2)+'\n')
(w/'bondangle1313_cases_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),command=cmd,source_sha256={str(p.relative_to(root)):hashlib.sha256(p.read_bytes()).hexdigest() for p in (root/'SFT/Chemistry').glob('MolecularBondAngle.lean')}),indent=2)+'\n')
print('PASS',len(expected),'original/native equal-sector law-domain cases')
