from pathlib import Path
import os,time,json,subprocess,sys
w=Path('work');receipt=w/'addition1501_program_native_build.json'
while not receipt.exists():
 try:os.kill(6314,0)
 except ProcessLookupError:raise RuntimeError('Recorded builder terminal without receipt; inspect retained log, do not duplicate')
 time.sleep(5)
assert json.load(open(receipt))['status']=='PASS'
expected=json.load(open(w/'addition1501_original_program.json'));source=expected['registration']['source_hash']
with(w/'addition1501_program_output.log').open('w')as out:subprocess.run([sys.executable,'work/prepare_addition1501_program_native.py','--execute',source],stdout=out,stderr=subprocess.STDOUT,check=True)
lines=(w/'addition1501_program_output.log').read_text().splitlines();actual=next(json.loads(x)for x in lines if x.startswith('{')and '"registration"'in x);assert actual==expected
(w/'addition1501_program_output.json').write_text(json.dumps(actual,indent=2)+'\n');(w/'addition1501_program_report.json').write_text(json.dumps({'status':'PASS','candidates':256,'all_original_decisions_registration_closure_controls_and_unknown_id_match':True},indent=2)+'\n');print('PASS full256candidate programme')
