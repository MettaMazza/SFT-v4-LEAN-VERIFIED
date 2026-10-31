from pathlib import Path
import os,time,subprocess,json,copy
pid=65418
while True:
 try:os.kill(pid,0)
 except ProcessLookupError:break
 time.sleep(5)
p=Path('work/planck_native_vacuum498_report.json');assert p.exists() and json.loads(p.read_text())['status']=='PASS','Native comparator has not passed'
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-VACUUM-DENSITY-SCALE-TERMINAL-035'
v=Path('work/vacuum499_independent.py');v.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':generated/physics/vacuum_density_scale_terminal_validator_v1.py']))
actual=json.load(open('work/planck_native_vacuum498_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-vacuum499'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 p=Path('work/vacuum499_independent_'+name+'.json');p.write_text(json.dumps(s))
 result=subprocess.run(['python3',str(v),cid,str(p)],capture_output=True,text=True);out=json.loads(result.stdout)
 assert out['passed']==(name=='original'),(name,out,result.stderr)
 assert result.returncode==(0 if name=='original' else 1)
 cases.append(dict(case=name,expected=name=='original',actual=out))
Path('work/vacuum499_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('VACUUM NATIVE AND FOUR ORIGINAL INDEPENDENT CASES PASS; ENTRY STILL AWAITS REGISTERED DEPENDENCIES',flush=True)
