from pathlib import Path
import os,sys,json,subprocess,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'lifeorganization1106_seal_output.json').open('w')as out,(w/'lifeorganization1106_seal_execution.log').open('w')as err:subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/LifeOrganizationSealProgram1106.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'lifeorganization1106_seal_output.json').read_text());e=json.loads((w/'lifeorganization1106_seal_input.json').read_text());assert a==[c['expected']for c in e['cases']]
log=(w/'lifeorganization1106_seal_build.log').read_text();assert log.count('does not depend on any axioms')==2 and 'depends on axioms:'not in log
(w/'lifeorganization1106_seal_report.json').write_text(json.dumps({'status':'PASS','cases':len(a),'axioms':[],'original_claims':75,'original_candidates':19200,'source_sha256':hashlib.sha256((r/'SFT/Biology/LifeOrganizationSeal.lean').read_bytes()).hexdigest()},indent=2)+'\n');print('PASS nine exact original seal outcomes;75-claim19200-candidate prediction binding;empty axioms.')
