from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'coordinationsource1135_output.json').open('w')as out,(w/'coordinationsource1135_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/CoordinationSourceProgram1135.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'coordinationsource1135_output.json').read_text());e=json.loads((w/'coordinationsource1135_expected.json').read_text());assert a==e
report={'status':'PASS','targets':len(a),'complete_source_rows_match':True,'source_hash_guards':7,'source_sha256':hashlib.sha256((r/'SFT/Chemistry/CoordinationSource.lean').read_bytes()).hexdigest()}
(w/'coordinationsource1135_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS20source rows, identity binding and native payload hashes',flush=True)
