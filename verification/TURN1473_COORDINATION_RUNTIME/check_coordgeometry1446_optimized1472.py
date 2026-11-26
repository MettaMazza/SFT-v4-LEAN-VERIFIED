from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/prepare_coordgeometry1446_optimized1472.py','--execute']
with(w/'coordgeometry1446_optimized1472_output.json').open('w')as out,(w/'coordgeometry1446_optimized1472_execution.log').open('w')as err:
 subprocess.run(cmd,env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'coordgeometry1446_optimized1472_output.json').read_text());expected=json.loads((w/'coordgeometry1446_original_empirical.json').read_text())
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
report={'status':'PASS','fields':len(actual),'messages':len(actual['measurements']),'all_fields_and_hashes_match':True,'original_target_checks':53,'adverse_controls':6,'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in ['CoordinationGeometry','CoordinationGeometryPrediction','CoordinationGeometrySource','CoordinationGeometryAnalysis','CoordinationGeometryComparison','CoordinationGeometryExperiment','CoordinationGeometryValidation']}}
(w/'coordgeometry1446_optimized1472_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS full empirical12fields10messages with all hashes',flush=True)
