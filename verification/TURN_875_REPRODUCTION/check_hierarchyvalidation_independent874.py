from pathlib import Path
import subprocess,json,copy
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003';p=w/'hierarchyvalidation874_original_independent.py';p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003/independent_validator.py']))
actual=json.load(open(w/'hierarchyvalidation_program874_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-hierarchyvalidation-874'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('hierarchyvalidation_independent874_'+name+'.json');f.write_text(json.dumps(s));o=json.loads(subprocess.check_output(['python3',str(p),str(f)],text=True));assert o['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=o))
(w/'hierarchyvalidation_independent874_report.json').write_text(json.dumps(cases,indent=2));print('PASS original and three adverse cases')
