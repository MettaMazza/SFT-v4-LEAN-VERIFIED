from pathlib import Path
import subprocess,json,copy,os
env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_STACK_SIZE_KB='1048576',LEAN_MAIN_USE_THREAD='1')
subprocess.run(['python3','work/check_sector498.py'],env=env,check=True)
actual=json.load(open('work/sector498_program_output.json'));sealed={**actual,'claim_id':'SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003','seal_hash':'native-colour-496'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 p=Path('work/sector498_independent_'+name+'.json');p.write_text(json.dumps(s));out=json.loads(subprocess.check_output(['python3','work/sector498_independent.py',str(p)],text=True));assert out['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=out))
Path('work/sector498_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n');print('COLOUR ALL CHECKS PASS',flush=True)
