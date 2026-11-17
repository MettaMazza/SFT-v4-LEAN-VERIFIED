from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'coordinationanalysis1135_output.json').open('w')as out,(w/'coordinationanalysis1135_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/CoordinationAnalysisProgram1135.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'coordinationanalysis1135_output.json').read_text());e=json.loads((w/'coordinationanalysis1135_expected.json').read_text());assert a==e
report={'status':'PASS','cases':len(a),'all_outcomes_match':True,'source_sha256':hashlib.sha256((r/'SFT/Chemistry/CoordinationAnalysis.lean').read_bytes()).hexdigest()}
(w/'coordinationanalysis1135_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS original11field analysis and adverse cases',flush=True)
