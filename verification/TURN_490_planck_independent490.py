from pathlib import Path
import subprocess,json,copy
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';r='/Volumes/One Touch/ernos-labs-sft-platform'
x=json.load(open('work/planck_native489_output.json'))
config=json.load(open('work/planck489_current_config.json'))
print('config keys',list(config))
cov=json.load(open('/Volumes/One Touch/SFT v4 Full model LEAN/COVERAGE.json'))
e=next(e for e in cov['claims'] if e['lean_status']=='in_progress')
cid=e['claim_id'];print('claim',cid)
p=Path('work/planck_original_independent490.py');p.write_bytes(subprocess.check_output(['git','-C',r,'show',pin+':generated/physics/precision_value_validator_v1.py']))
sealed={**x,'claim_id':cid,'seal_hash':'native-planck-490'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':
  row=next(row for row in s['decisions'] if not row['survives']);row['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 dest=Path('work/planck_independent490_'+name+'.json');dest.write_text(json.dumps(s))
 result=json.loads(subprocess.check_output(['python3',str(p),cid,str(dest)],text=True));assert result['passed']==(name=='original'),result
 cases.append(dict(case=name,expected=name=='original',actual=result))
Path('work/planck_independent490_report.json').write_text(json.dumps(cases,indent=2)+'\n');print('four cases PASS')
