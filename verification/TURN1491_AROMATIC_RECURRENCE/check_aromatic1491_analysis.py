from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'aromatic1491_analysis_output.json').open('w')as out,(w/'aromatic1491_analysis_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/AromaticAnalysisCasesProgram1491.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'aromatic1491_analysis_output.json').read_text());e=json.loads((w/'aromatic1491_analysis_expected.json').read_text());assert a==e
modules=['AromaticRecurrenceAnalysis','AromaticMagnitude']
report={'status':'PASS','cases':len(a),'all_fields_match':True,'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/(m+'.lean')).read_bytes()).hexdigest() for m in modules}}
(w/'aromatic1491_analysis_comparison_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS '+str(len(a))+' full original interface comparisons',flush=True)
