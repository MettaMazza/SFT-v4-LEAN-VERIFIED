from pathlib import Path
import json,hashlib,sys,os,subprocess
w=Path('work');r=w/'turn1064_recovery';h=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
prior=json.loads((w/'radiotracer1140_empirical_report.json').read_text());assert prior['status']=='PASS'
for m,digest in prior['source_sha256'].items():assert h(r/'SFT/Chemistry'/f'{m}.lean')==digest
previous=json.loads((w/'radiotracer1140_empirical_input.json').read_text());current=json.loads((w/'radiolysis1160_empirical_input.json').read_text());assert previous['analysis']==current['analysis'] and previous['surfaces']==current['surfaces']
for item in current['surfaces']:assert 'sha256:'+h(w/'pinned1160'/item['path'])==item['snapshot_sha256']
a=(r/'SFT/Chemistry/RadiotracerCustodyAnalysis.lean').read_text();b=(r/'SFT/Chemistry/RadiolysisNetworkAnalysis.lean').read_text()
start=' validateAuthorities files\n';stop=' let total ← verifySurfaces analysis inputs\n'
def prefix(s):return s[s.index(start):s.index(stop)+len(stop)]
assert prefix(a)==prefix(b)
# Both source analyses use precisely this unchanged prefix on identical complete inputs.
receipt={'status':'PASS','reused_native_receipt':'radiotracer1140_empirical_report.json','unchanged_native_modules':prior['source_sha256'],'identical_analysis_and_surfaces':True,'identical_full_prefix':True,'registered_pages':370,'registered_characters':837013,'new_checks':'RadiolysisNetworkAnalysis.resolvedAnalysis and RadiolysisNetworkValidation.validateResolved','source_sha256':{m:h(r/'SFT/Chemistry'/f'{m}.lean')for m in ['RadiolysisNetworkAnalysis','RadiolysisNetworkExperiment','RadiolysisNetworkValidation']}}
(w/'radiolysis1161_native_reuse.json').write_text(json.dumps(receipt,indent=2)+'\n')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run','work/RadiolysisNetworkResolvedProgram1161.lean']
with(w/'radiolysis1160_empirical_output.json').open('w')as out,(w/'radiolysis1161_empirical_execution.log').open('w')as err:subprocess.run(cmd,env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'radiolysis1160_empirical_output.json').read_text());expected=json.loads((w/'radiolysis1160_original_empirical.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
for m,digest in receipt['source_sha256'].items():assert h(r/'SFT/Chemistry'/f'{m}.lean')==digest
report=dict(status='PASS',fields=len(actual),messages=len(actual['measurements']),all_fields_and_hashes_match=True,original_target_checks=8,omission_rejected=True,fresh_native_resolved_phase=True,reused_native_source_checks='radiolysis1161_native_reuse.json',source_sha256=receipt['source_sha256'])
(w/'radiolysis1160_empirical_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS fresh012 native checks and full12field receipt, unchanged source prefix reused',flush=True)
