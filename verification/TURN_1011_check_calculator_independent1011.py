from pathlib import Path
import subprocess,json,copy,hashlib
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-MATH-SCIENTIFIC-CALCULATOR-003';p=w/'calculator1010_original_independent.py';original=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':generated/mathematics/scientific_calculator_validator_v1.py']);assert p.read_bytes()==original
actual=json.load(open(w/'calculator_program1011_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-calculator-1011'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('calculator_independent1011_'+name+'.json');f.write_text(json.dumps(s));proc=subprocess.run(['python3',str(p),cid,str(f)],capture_output=True,text=True);o=json.loads(proc.stdout);assert o['passed']==(name=='original');assert proc.returncode==(0 if name=='original' else 1);cases.append(dict(case=name,expected=name=='original',actual=o))
(w/'calculator_independent1011_report.json').write_text(json.dumps(cases,indent=2));print('PASS original and three adverse cases')
