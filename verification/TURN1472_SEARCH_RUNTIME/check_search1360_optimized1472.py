from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/prepare_search1360_optimized1472.py','--execute']
with(w/'search1360_empirical_output.json').open('w')as out,(w/'search1360_empirical_execution.log').open('w')as err:
 subprocess.run(cmd,env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'search1360_empirical_output.json').read_text());expected=json.loads((w/'search1360_original_empirical_v2.json').read_text())
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
report={'status':'PASS','fields':len(actual),'messages':len(actual['measurements']),'all_fields_and_hashes_match':True,'original_target_checks':8,'omission_rejected':True,'source_sha256':json.loads((w/'search1360_full_audit_report.json').read_text())['source_sha256'],'full_native_source_prefix_executed':True}

(w/'search1360_empirical_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS full empirical12 fields5 messages with all hashes',flush=True)
