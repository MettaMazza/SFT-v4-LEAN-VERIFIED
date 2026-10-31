from pathlib import Path
import os,time,subprocess,json,copy
p=Path('work/unified_program515_report.json');assert p.exists() and json.loads(p.read_text())['status']=='PASS','Native comparator has not passed'
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-PHYS-UNIFIED-CONSTANTS-OBJECT-077'
v=Path('work/unified515_independent.py');v.write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':generated/physics/unified_constants_object_validator_v1.py']))
actual=json.load(open('work/unified_program515_output.json'));sealed={**actual,'claim_id':cid,'seal_hash':'native-unified515'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 p=Path('work/unified515_independent_'+name+'.json');p.write_text(json.dumps(s))
 result=subprocess.run(['python3',str(v),cid,str(Path('work/v3-runtime500').resolve()),str(p)],capture_output=True,text=True);out=json.loads(result.stdout)
 assert out['passed']==(name=='original'),(name,out,result.stderr)
 assert result.returncode==(0 if name=='original' else 1)
 cases.append(dict(case=name,expected=name=='original',actual=out))
Path('work/unified515_independent_report.json').write_text(json.dumps(cases,indent=2)+'\n')
print('UNIFIED NATIVE AND FOUR ORIGINAL INDEPENDENT CASES PASS',flush=True)
