from pathlib import Path
import subprocess,json,copy,importlib.util
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-MATH-PRIME-PAIR-CENSUS-002';p=w/'mathematics_lineage_independent861.py';p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':tools/validate_mathematics_lineage_claim.py']));spec=importlib.util.spec_from_file_location('original_prime_validator',p);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
actual=json.load(open(w/'prime_program861_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-prime-861'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('prime_independent861_'+name+'.json');f.write_text(json.dumps(s));o=m.validate(cid,str(f));assert o['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=o))
(w/'prime_independent861_report.json').write_text(json.dumps(cases,indent=2));print('PASS original and three adverse cases')
