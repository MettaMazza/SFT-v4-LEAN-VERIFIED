from pathlib import Path
import subprocess,json,os,copy,time
stem='Entropy'
key='ENTROPY'
env=dict(os.environ,LEAN_NUM_THREADS='1',LEAN_HOST_STACK_SIZE='8192')
auditcfg=json.loads(Path('work/auditthermo524_config.json').read_text()) if Path('work/auditthermo524_config.json').exists() else {}
import re
r=Path('work/constants-recovery')
modules=['ThermoEntropy']+['Entropy'+x for x in ['Grammar','Evidence','Experiment','Validation','ValidationProofs']]
names=[];ths=[];defs=[]
for m in modules:
 s=(r/'SFT/Physics'/(m+'.lean')).read_text(); ns=re.search(r'^namespace (\S+)',s,re.M)[1]
 for kind,n in re.findall(r'^(def|theorem|inductive|structure|abbrev) (\w+)',s,re.M):
  name=ns+'.'+n;names.append(name)
  if kind=='theorem':ths.append(name)
  if kind in ['def','theorem']:defs.append(name)
audit=Path('work/auditthermo524_Entropy.log').read_text()
assert all("'"+n+"' does not depend on any axioms" in audit for n in names)
auditcfg[stem]=dict(modules=modules,declarations=names,theorems=ths,definitions_and_theorems=defs)
for check in ['program','validation']:
 start=time.monotonic();res=subprocess.run(['python3','work/'+stem.lower()+'_'+check+'524.py'],env=env,text=True,capture_output=True);Path('work/'+stem.lower()+'_'+check+'524.log').write_text(res.stdout+res.stderr);print(stem,check,'exit',res.returncode,'seconds',round(time.monotonic()-start,2),flush=True);assert res.returncode==0,res.stdout+res.stderr
actual=json.load(open('work/'+stem.lower()+'_program524_output.json'));sealed={**actual,'claim_id':'SFT-PHYS-THERMO-'+key.replace('_','-')+'-001','seal_hash':'native-'+stem.lower()+'-524'};cases=[]
for name in ['original','omitted_candidate','additional_survivor','failed_control']:
 s=copy.deepcopy(sealed)
 if name=='omitted_candidate':s['census']['candidates']=s['census']['candidates'][1:]
 if name=='additional_survivor':s['decisions'][0]['survives']=True
 if name=='failed_control':s['controls'][0]['passed']=False
 p=Path('work/'+stem.lower()+'_independent524_'+name+'.json');p.write_text(json.dumps(s));out=json.loads(subprocess.check_output(['python3','work/'+stem.lower()+'_independent524.py',str(p)],text=True));assert out['passed']==(name=='original');cases.append(dict(case=name,expected=name=='original',actual=out))
Path('work/'+stem.lower()+'_independent524_report.json').write_text(json.dumps(cases,indent=2)+'\n');Path('work/auditthermo524_config.json').write_text(json.dumps(auditcfg,indent=2)+'\n');print(stem,'all checks PASS',flush=True)
