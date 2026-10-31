from pathlib import Path
import subprocess,json,os,copy
env=dict(os.environ,LEAN_NUM_THREADS="1",LEAN_STACK_SIZE_KB="2097152",LEAN_MAIN_USE_THREAD="0")
subprocess.run(['python3','work/check_running500.py'],env=env,check=True)
cid='SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v=Path('work/running500_independent.py');v.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':generated/physics/coupling_running_convergence_terminal_validator_v1.py']))
actual=json.load(open('work/running500_program_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-running500'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':next(d for d in s['decisions'] if not d['survives'])['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 p=Path('work/running500_independent_'+name+'.json');p.write_text(json.dumps(s));result=subprocess.run(['python3',str(v),cid,str(p)],capture_output=True,text=True);out=json.loads(result.stdout)
 assert out['passed']==(name=='original'),(name,out,result.stderr)
 cases.append(dict(case=name,expected=name=='original',actual=out))
Path('work/running500_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n');print('RUNNING FULL FORMAL PROGRAM AND INDEPENDENT CASES PASS',flush=True)
