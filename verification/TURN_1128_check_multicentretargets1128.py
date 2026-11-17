from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'multicentretargets1128_output.json').open('w')as out,(w/'multicentretargets1128_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/MulticentreTargetsProgram1128.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'multicentretargets1128_output.json').read_text());e=json.loads((w/'multicentre1127_original_targets.json').read_text());assert a==e
report={'status':'PASS','targets':len(a),'complete_rows_magnitudes_and_words_match':True,'native_source_hashes':5,'source_sha256':hashlib.sha256((r/'SFT/Chemistry/MulticentreTargets.lean').read_bytes()).hexdigest()}
(w/'multicentretargets1128_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS20complete source targets with magnitudes and five-cell words',flush=True)
