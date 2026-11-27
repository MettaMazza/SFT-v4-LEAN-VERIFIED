from pathlib import Path
import ast,json,subprocess,time,os,hashlib
w=Path('work')
assert json.load(open(w/'rearrangement1504_program_report.json'))['status']=='PASS'
assert json.load(open(w/'rearrangement1504_full_audit_report.json'))['status']=='PASS'
subprocess.run(['python3','work/prepare_rearrangement1504_validation_native.py'],check=True)
with(w/'rearrangement1504_validation_output.log').open('w')as out:subprocess.run(['python3','work/prepare_rearrangement1504_validation_native.py','--execute'],stdout=out,stderr=subprocess.STDOUT,check=True)
a=next(json.loads(l)for l in(w/'rearrangement1504_validation_output.log').read_text().splitlines()if l.startswith('{')and'analysis_result'in l)
assert a['analysis_result']==json.load(open(w/'rearrangement1504_analysis_expected.json')),a['analysis_result']
assert a['empirical_result']==json.load(open(w/'rearrangement1504_original_empirical.json')),str(a['empirical_result'])[:1500]
(w/'rearrangement1504_analysis_output.json').write_text(json.dumps(a['analysis_result'],indent=2)+'\n')
(w/'rearrangement1504_analysis_report.json').write_text(json.dumps({'status':'PASS','analysis_fields':9,'checks':16,'fresh_full_validation_run':True},indent=2)+'\n')
(w/'rearrangement1504_validation_output.json').write_text(json.dumps(a['empirical_result'],indent=2)+'\n')
ps=list((w/'turn1064_recovery/SFT/Chemistry').glob('Rearrangement*.lean'))
report={'status':'PASS','analysis_fields':9,'checks':16,'return_fields':12,'messages':7,'full_empirical_replay_passed':True,'source_hashes':{str(p):hashlib.sha256(p.read_bytes()).hexdigest()for p in ps},'native_build_receipt':'work/rearrangement1504_validation_native_build.json','actual_output_log_sha256':hashlib.sha256((w/'rearrangement1504_validation_output.log').read_bytes()).hexdigest(),'original_report':'work/rearrangement1504_original_empirical.json'}
(w/'rearrangement1504_validation_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS full original native empirical report')
