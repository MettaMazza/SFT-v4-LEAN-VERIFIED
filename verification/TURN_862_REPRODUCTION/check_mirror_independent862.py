from pathlib import Path
import subprocess,json,copy,importlib.util
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-MATH-RIEMANN-MIRROR-002';p=w/'mathematics_lineage_independent862.py';p.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':tools/validate_mathematics_lineage_claim.py']));spec=importlib.util.spec_from_file_location('original_mirror_validator',p);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
actual=json.load(open(w/'mirror_program862_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-mirror-862'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('mirror_independent862_'+name+'.json');f.write_text(json.dumps(s));o=m.validate(cid,str(f));assert o['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=o))
(w/'mirror_independent862_report.json').write_text(json.dumps(cases,indent=2));print('PASS original and three adverse cases')
