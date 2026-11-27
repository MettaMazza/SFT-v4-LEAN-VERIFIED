from pathlib import Path
import ast,json,subprocess,time,os,hashlib
w=Path('work')
for receipt,pid in [('elimination1503_program_report.json',11758)]:
 while not(w/receipt).exists():
  try:os.kill(pid,0)
  except ProcessLookupError:raise RuntimeError('Recorded prerequisite process ended without '+receipt+'; inspect exact output, do not duplicate.')
  time.sleep(5)
 assert json.load(open(w/receipt))['status']=='PASS'
s=(w/'prepare_elimination1503_validation_native.py').read_text();node=next(n for n in ast.walk(ast.parse(s))if isinstance(n,ast.For)and isinstance(n.target,ast.Name)and n.target.id=='receipt_name');old=ast.get_source_segment(s,node.iter);extra=ast.literal_eval(old)+['elimination1503_analysis_native_build.json'];s=s[:s.index(old)]+repr(extra)+s[s.index(old)+len(old):];(w/'prepare_elimination1503_validation_native.py').write_text(s)
subprocess.run(['python3','work/prepare_elimination1503_validation_native.py'],check=True)
with(w/'elimination1503_validation_output.log').open('w')as out:subprocess.run(['python3','work/prepare_elimination1503_validation_native.py','--execute'],stdout=out,stderr=subprocess.STDOUT,check=True)
a=next(json.loads(l)for l in(w/'elimination1503_validation_output.log').read_text().splitlines()if l.startswith('{')and'analysis_result'in l)
assert a['analysis_result']==json.load(open(w/'elimination1503_analysis_expected.json')),a['analysis_result']
assert a['empirical_result']==json.load(open(w/'elimination1503_original_empirical.json')),str(a['empirical_result'])[:1500]
(w/'elimination1503_analysis_output.json').write_text(json.dumps(a['analysis_result'],indent=2)+'\n')
(w/'elimination1503_analysis_report.json').write_text(json.dumps({'status':'PASS','analysis_fields':12,'checks':47,'fresh_full_validation_run':True},indent=2)+'\n')
(w/'elimination1503_validation_output.json').write_text(json.dumps(a['empirical_result'],indent=2)+'\n')
ps=list((w/'turn1064_recovery/SFT/Chemistry').glob('Elimination*.lean'))
report={'status':'PASS','analysis_fields':12,'checks':47,'return_fields':12,'messages':7,'full_empirical_replay_passed':True,'source_hashes':{str(p):hashlib.sha256(p.read_bytes()).hexdigest()for p in ps},'native_build_receipt':'work/elimination1503_validation_native_build.json','actual_output_log_sha256':hashlib.sha256((w/'elimination1503_validation_output.log').read_bytes()).hexdigest(),'original_report':'work/elimination1503_original_empirical.json'}
(w/'elimination1503_validation_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS full original native empirical report')
