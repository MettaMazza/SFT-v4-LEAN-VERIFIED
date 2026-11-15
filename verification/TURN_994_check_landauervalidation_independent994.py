from pathlib import Path
import subprocess,json,copy
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-THERMO-LANDAUER-EMPIRICAL-019';p=w/'landauervalidation994_original_independent.py';p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':generated/physics/landauer_demon_empirical_validator_v1.py']))
actual=json.load(open(w/'landauervalidation_program994_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-landauervalidation-994'};cases=[]
import concurrent.futures
def run(name):
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':next(d for d in s['decisions'] if not d['survives'])['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('landauervalidation_independent994_'+name+'.json');f.write_text(json.dumps(s));proc=subprocess.run(['python3',str(p),cid,str(f)],text=True,capture_output=True);o=json.loads(proc.stdout);assert proc.returncode==(0 if name=='original' else 1);assert o['passed']==(name=='original');return dict(case=name,expected=name=='original',actual=o)
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:cases=list(pool.map(run,['original','omitted_candidate','additional_survivor','failed_control']))
(w/'landauervalidation_independent994_report.json').write_text(json.dumps(cases,indent=2));print('PASS original and three adverse cases')
