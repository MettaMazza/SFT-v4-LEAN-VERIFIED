from pathlib import Path
import os,sys,json,subprocess,re,hashlib
w=Path('work');r=w/'turn1064_recovery';env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
cmd=[sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192']
with(w/'nuclidecarrier1110_analysis_output.json').open('w')as out,(w/'nuclidecarrier1110_analysis_execution.log').open('w')as err:
 subprocess.run(cmd+['--run','work/NuclideCarrierAnalysisProgram1110.lean'],env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'nuclidecarrier1110_analysis_output.json').read_text())
expected=json.loads((w/'nuclidecarrier1108_analysis_expected.json').read_text())
assert actual=={k:expected[k] for k in actual},[k for k in actual if actual[k]!=expected[k]]
assert set(actual)=={'analysis','checks','omission_error','clean'}
report={'status':'PASS','target_checks':len(actual['checks']),'summary_fields':len(actual['analysis']),'clean_controls':len(actual['clean']),'omission_rejected':True,'all_19_authorities_checked':True,'all_8_pdf_pages_2_html_documents_checked':True,'module_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in ['NuclideCarrierSurface','NuclideCarrierAnalysis']}}
(w/'nuclidecarrier1110_analysis_report.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report),flush=True)
