from pathlib import Path
import subprocess,json,copy,importlib.util
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-FOUNDATION-ADMISSION-ENFORCEMENT-001';p=w/'foundation_prior_independent857.py';p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':generated/foundation_prior_independent_validator.py']));spec=importlib.util.spec_from_file_location('original_admission_validator',p);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
actual=json.load(open(w/'admission_program857_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-admission-857'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('admission_independent857_'+name+'.json');f.write_text(json.dumps(s));o=m.validate(str(f),cid);assert o['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=o))
(w/'admission_independent857_report.json').write_text(json.dumps(cases,indent=2));print('PASS original and three adverse cases')
