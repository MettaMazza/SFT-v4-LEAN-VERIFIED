from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'multicentrecontrols1128_output.json').open('w')as out,(w/'multicentrecontrols1128_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/MulticentreControlsProgram1128.lean'],env=env,stdout=out,stderr=err,check=True)
a=json.loads((w/'multicentrecontrols1128_output.json').read_text());e=json.loads((w/'multicentrecontrols1128_expected.json').read_text());assert a==e
report={'status':'PASS','comparisons':len(a['comparisons']),'counts':len(a['counts']),'adverse_controls':len(a['adverse']),'all_fields_match':True,'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in ['MulticentreComparison','MulticentreControls']}}
(w/'multicentrecontrols1128_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS20complete comparisons6counts15adverse controls',flush=True)
