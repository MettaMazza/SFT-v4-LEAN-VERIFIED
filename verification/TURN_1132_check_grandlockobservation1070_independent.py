from pathlib import Path
import subprocess,json,copy,hashlib,os
w=Path('work');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-VALIDATION-GRAND-LOCK-076';root=Path('/Volumes/One Touch/ernos-labs-sft-platform');p=(w/'v3-runtime500/generated/physics/grand_lock_empirical_validator_v1.py').resolve();cache=w/'pinned1070';identity=json.load(open(cache/'SOURCE_IDENTITIES.json'));assert identity['commit']==pin;rel='generated/physics/grand_lock_empirical_validator_v1.py';original=(cache/rel).read_bytes();blob=next(e['sha']for e in identity['files']if e['path']==rel);assert hashlib.sha1(b'blob '+str(len(original)).encode()+b'\0'+original).hexdigest()==blob;assert p.read_bytes()==original
actual=json.load(open(w/'grandlockobservation1064_program_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-calculator-1027'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 f=w/('grandlockobservation1064_independent_'+name+'.json');f.write_text(json.dumps(s));proc=subprocess.run(['python3',str(p),cid,str((w/'v3-runtime500'/'experiments/external_sources/physics/snapshots/physics-grand-lock-empirical-reconciliation-record.json').resolve()),str((w/'v3-runtime500').resolve()),str(f.resolve())],env={**os.environ,'PYTHONDONTWRITEBYTECODE':'1'},capture_output=True,text=True);assert proc.stdout,proc.stderr;o=json.loads(proc.stdout);assert o['passed']==(name=='original'),o;assert proc.returncode==(0 if name=='original'else 1);cases.append(dict(case=name,expected=name=='original',actual=o))
(w/'grandlockobservation1064_independent_report.json').write_text(json.dumps(cases,indent=2));print('PASS original validator and three adverse cases')
