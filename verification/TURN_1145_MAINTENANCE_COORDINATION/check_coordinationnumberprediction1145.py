from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'coordinationnumberprediction1145_output.json').open('w')as out,(w/'coordinationnumberprediction1145_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/CoordinationNumberPredictionProgram1145.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'coordinationnumberprediction1145_output.json').read_text());e=json.loads((w/'coordinationnumberprediction1145_expected.json').read_text());assert a==e
report={'status':'PASS','instructions':len(a['instructions']),'all_fields_match':True,'native_source_hashes':1,'source_sha256':hashlib.sha256((r/'SFT/Chemistry/CoordinationNumberPrediction.lean').read_bytes()).hexdigest()}
(w/'coordinationnumberprediction1145_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS210instructions and23records match original prediction',flush=True)
