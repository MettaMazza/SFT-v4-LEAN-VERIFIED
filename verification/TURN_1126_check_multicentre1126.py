from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'multicentre1126_output.json').open('w')as out,(w/'multicentre1126_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/MulticentreProgram1126.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'multicentre1126_output.json').read_text());e=json.loads((w/'multicentre1126_expected.json').read_text());assert a==e
report={'status':'PASS','original_complete_support_cases':len(a['cases']),'original_witnesses':len(a['witnesses']),'all_fields_and_errors_match':True,'source_sha256':hashlib.sha256((r/'SFT/Chemistry/MulticentreSupport.lean').read_bytes()).hexdigest()}
(w/'multicentre1126_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS462complete support cases5witnesses',flush=True)
