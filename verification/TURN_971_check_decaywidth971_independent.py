from pathlib import Path
import subprocess,json,copy
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-DECAY-WIDTH-BRANCHING-LIFETIME-TERMINAL-006';p=w/'decaywidth971_original_independent.py';p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':generated/physics/decay_width_branching_lifetime_terminal_validator_v1.py']))
actual=json.load(open(w/'decaywidth971_program_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-decaywidth-971'};cases=[]
import concurrent.futures
def run(name):
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':next(d for d in s['decisions'] if not d['survives'])['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('decaywidth_independent971_'+name+'.json');f.write_text(json.dumps(s));o=json.loads(subprocess.check_output(['python3',str(p),cid,str(f)],text=True));assert o['passed']==(name=='original');return dict(case=name,expected=name=='original',actual=o)
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:cases=list(pool.map(run,['original','omitted_candidate','additional_survivor','failed_control']))
(w/'decaywidth_independent971_report.json').write_text(json.dumps(cases,indent=2));print('PASS original and three adverse cases')
