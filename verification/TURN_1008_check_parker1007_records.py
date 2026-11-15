from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re,tempfile
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=w/'v3-runtime500';sys.path.insert(0,str(root.resolve()))
from sft.physics import parker_proton_energy_terminal_validation_v1 as src
payload=json.load(open(root/src.SOURCE_RECORD_PATH));tests=[payload]
for key in ['schema','source_id']:
 for value in [None,False,'changed']:
  t=copy.deepcopy(payload);t[key]=value;tests.append(t)
for i in range(2):
 for key in ['source_id','snapshot_path','snapshot_hash']:
  t=copy.deepcopy(payload);t['sources'][i][key]='changed';tests.append(t)
for key,value in payload['registered_target']['parker_event'].items():
 choices=[None,'changed',0,False,True] if isinstance(value,bool) else ['changed']
 for new in choices:
  t=copy.deepcopy(payload);t['registered_target']['parker_event'][key]=new;tests.append(t)
for value in [[],['a','b'],['a','b','c'],'abc',{'a':1,'b':2,'c':3}]:
 t=copy.deepcopy(payload);t['registered_target']['parker_event']['reported_energy_wording']=value;tests.append(t)
for key in payload['registered_target']['proton_rest_energy']:
 t=copy.deepcopy(payload);t['registered_target']['proton_rest_energy'][key]='changed';tests.append(t)
for key,value in payload['row_custody'].items():
 if isinstance(value,bool):
  for new in [not value,int(value),None]:
   t=copy.deepcopy(payload);t['row_custody'][key]=new;tests.append(t)
expected=[]
with tempfile.TemporaryDirectory(prefix='sft-spectrum-payload-') as tmp:
 temp=Path(tmp);f=temp/src.SOURCE_RECORD_PATH;f.parent.mkdir(parents=True);originalHash=src.hash_file
 # Isolate the original payload branches; byte identity is independently checked against the pinned sources.
 src.hash_file=lambda p:src.source_hashes()[str(p.relative_to(temp))]
 try:
  for t in tests:
   f.write_text(json.dumps(t))
   try:expected.append({'ok':src.authoritative_record(temp)})
   except ValueError as e:expected.append({'error':str(e)})
 finally:src.hash_file=originalHash
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(val(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='''import SFT.Physics.ParkerRecords
open SFT.Host.Canonical SFT.Physics.ParkerRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (payloadBoundary ('+val(t)+'))' for t in tests)+']))\n';p=w/'constants-recovery/ParkerRecords1007.lean';p.write_text(s)
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'parker1007_records_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-3000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
s=(r/'SFT/Physics/ParkerRecords.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'parker1007_records_audit.lean';p.write_text('import SFT.Physics.ParkerRecords\n'+''.join('#print axioms SFT.Physics.ParkerRecords.'+n+'\n' for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'parker1007_records_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'parker1007_records_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original authoritative_record payload checks and all original rejection messages; source hash IO is isolated in payload mutation tests, not reported as full validator verification'),indent=2));print('PASS',len(tests),'original payload/domain outcomes;',len(names),'empty-axiom definitions')
