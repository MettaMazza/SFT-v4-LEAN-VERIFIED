from pathlib import Path
import subprocess,json,copy
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-FIELD-MAXWELL-THREE-SPACE-CLOSURE-003';p=w/'maxwellspatial892_original_independent.py';p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':generated/physics/relativistic_field_validator_v1.py']))
actual=json.load(open(w/'maxwellspatial_program892_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-maxwellspatial-892'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('maxwellspatial_independent892_'+name+'.json');f.write_text(json.dumps(s));o=json.loads(subprocess.check_output(['python3',str(p),cid,str(f)],text=True));assert o['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=o))
(w/'maxwellspatial_independent892_report.json').write_text(json.dumps(cases,indent=2));print('PASS original and three adverse cases')
