from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'multicentresurface1127_output.json').open('w')as out,(w/'multicentresurface1127_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/MulticentreSurfaceProgram1127.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'multicentresurface1127_output.json').read_text());e=json.loads((w/'multicentresurface1127_expected.json').read_text());assert a==e
report={'status':'PASS','documents':len(a),'all_parser_state_rows_and_text_match':True,'source_sha256':hashlib.sha256((r/'SFT/Chemistry/MulticentreSurface.lean').read_bytes()).hexdigest()}
(w/'multicentresurface1127_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS complete two NIST documents and ten parser edge cases',flush=True)
