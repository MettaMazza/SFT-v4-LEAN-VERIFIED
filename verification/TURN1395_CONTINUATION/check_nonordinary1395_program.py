from pathlib import Path
import json,subprocess,sys,copy,hashlib,os
w=Path('work');r=w/'turn1064_recovery';name=sys.argv[1];row=next(x for x in json.loads((w/'nonordinary1395_checks_plan.json').read_text())if x['name']==name);cid=row['claim_id'];source=json.loads((w/(name+'1395_original_report.json')).read_text())['source_manifest_hash'];driver=row['native_driver']
subprocess.run([sys.executable,driver],check=True)
p=subprocess.run([sys.executable,driver,'--execute',source],capture_output=True,text=True);(w/(name+'1395_program_execution.log')).write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1000:]+p.stderr[-500:];actual=json.loads(p.stdout);expected=json.loads((w/(name+'1395_expected.json')).read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
(w/(name+'1395_program_output.json')).write_text(json.dumps(actual,indent=2)+'\n');cases=[]
for case in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(dict(actual,claim_id=cid,seal_hash='native-nonordinary1395'))
 if case=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if case=='additional_survivor':s['decisions'][0]['survives']=True
 if case=='failed_control':s['controls'][0]['passed']=False
 f=w/(name+'1395_native_'+case+'.json');f.write_text(json.dumps(s));p=subprocess.run([sys.executable,'work/pinned1394/generated/consciousness/nonordinary_validator_v1.py',cid,str((w/'pinned1394').resolve()),str(f.resolve())],capture_output=True,text=True);v=json.loads(p.stdout);assert v['passed']==(case=='original');assert p.returncode==(0 if case=='original'else 1);cases.append({'case':case,'result':v})
mods=['NonordinaryLaws',name+'Grammar',name+'Evidence'];report={'status':'PASS','claim_id':cid,'candidates':256,'all_fields_and_hashes':True,'source_manifest_hash':source,'independent_cases':cases,'source_sha256':{'SFT/Consciousness/'+m+'.lean':hashlib.sha256((r/'SFT/Consciousness'/(m+'.lean')).read_bytes()).hexdigest()for m in mods}}
(w/(name+'1395_program_report.json')).write_text(json.dumps(report,indent=2)+'\n');print('PASS',name,'complete source programme and original independent controls',flush=True)
