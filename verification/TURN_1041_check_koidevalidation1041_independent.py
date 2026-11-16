from pathlib import Path
import subprocess,json,copy,hashlib,os
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-002';root=Path('/Volumes/One Touch/ernos-labs-sft-platform');p=(w/'v3-runtime500/claims/SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-002/independent_validator.py').resolve();original=subprocess.check_output(['git','-C',str(root),'show',pin+':claims/SFT-PHYS-VALIDATION-CHARGED-LEPTON-KOIDE-002/independent_validator.py']);assert p.read_bytes()==original
actual=json.load(open(w/'koidevalidation1041_program_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-calculator-1027'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('koidevalidation1041_independent_'+name+'.json');f.write_text(json.dumps(s));proc=subprocess.run(['python3',str(p),str(f.resolve())],env={**os.environ,'PYTHONDONTWRITEBYTECODE':'1'},capture_output=True,text=True);assert proc.stdout,proc.stderr;o=json.loads(proc.stdout);assert o['passed']==(name=='original'),o;assert proc.returncode==0;cases.append(dict(case=name,expected=name=='original',actual=o))
(w/'koidevalidation1041_independent_report.json').write_text(json.dumps(cases,indent=2));print('PASS original validator and three adverse cases')
