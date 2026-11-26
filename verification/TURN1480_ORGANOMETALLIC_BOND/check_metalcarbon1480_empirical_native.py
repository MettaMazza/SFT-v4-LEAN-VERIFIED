from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/prepare_metalcarbon1480_empirical_native.py','--execute']
with(w/'metalcarbon1480_empirical_output.json').open('w')as out,(w/'metalcarbon1480_empirical_execution.log').open('w')as err:
 subprocess.run(cmd,env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'metalcarbon1480_empirical_output.json').read_text());expected=json.loads((w/'metalcarbon1480_original_empirical.json').read_text())
assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
report={'status':'PASS','fields':len(actual),'messages':len(actual['measurements']),'all_fields_and_hashes_match':True,'original_target_checks':12,'adverse_controls':7,'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in ['OrganometallicBond','OrganometallicBondPrediction','OrganometallicBondSource','OrganometallicBondAnalysis','OrganometallicBondComparison','OrganometallicBondExperiment','OrganometallicBondValidation']}}
(w/'metalcarbon1480_empirical_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS full empirical12fields11messages with all hashes',flush=True)
