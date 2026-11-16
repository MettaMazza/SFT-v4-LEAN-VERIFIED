from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re,tempfile,ast
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';root='/Volumes/One Touch/ernos-labs-sft-platform'
const={};tree=ast.parse((w/'collective_radiation_empirical_v11035.py').read_text())
for n in tree.body:
 if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name):
  try:const[n.targets[0].id]=ast.literal_eval(n.value)
  except ValueError:pass
payload=json.loads(subprocess.check_output(['git','-C',root,'show',pin+':'+const['SOURCE_PATH']]))
fn=next(n for n in ast.parse((w/'collective_radiation_validation_v11035.py').read_text()).body if isinstance(n,ast.FunctionDef)and n.name=='authoritative_record');env={**const,'Path':Path,'json':json};env['source_hashes']=lambda:{const['SOURCE_PATH']:const['SOURCE_HASH'],**dict(const['SOURCE_FILES'])};exec(compile(ast.Module(body=[fn],type_ignores=[]),'original-pinned-authoritative-record','exec'),env)
tests=[payload]
paths=[('schema',),('formal_receipt_hash',)]+[('registered_target',k)for k in payload['registered_target'] if not isinstance(payload['registered_target'][k],list)]+[('row_custody',k)for k in payload['row_custody']]
for path in paths:
 for value in [None,False,True,0,1,'changed']:
  t=copy.deepcopy(payload);parent=t
  for k in path[:-1]:parent=parent[k]
  parent[path[-1]]=value;tests.append(t)
for order in [[],[0],[1,0],[0,1,2,3,4],[4,3,2,1,0],[0,1,2,3,4,4]]:
 t=copy.deepcopy(payload);t['sources']=[payload['sources'][i]for i in order];tests.append(t)
expected=[]
with tempfile.TemporaryDirectory()as tmp:
 p=Path(tmp)/const['SOURCE_PATH'];p.parent.mkdir(parents=True);env['hash_file']=lambda p:env['source_hashes']()[str(p.relative_to(tmp))]
 for t in tests:
  p.write_text(json.dumps(t))
  try:expected.append({'ok':env['authoritative_record'](Path(tmp))})
  except ValueError as e:expected.append({'error':str(e)})
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+json.dumps(x,ensure_ascii=False)
 if isinstance(x,list):return '.array ['+','.join(map(val,x))+']'
 if isinstance(x,dict):return '.object ['+','.join('('+json.dumps(k)+','+val(v)+')'for k,v in x.items())+']'
s='''import SFT.Physics.CollectiveObservationRecords
open SFT.Host.Canonical SFT.Physics.CollectiveObservationRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (payloadBoundary ('+val(t)+'))'for t in tests)+']))\n';p=w/'collectiveobservation1035_records_cases.lean';p.write_text(s);envlean={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=envlean,capture_output=True,text=True);(w/'collectiveobservation1035_records_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e)for i,(a,e)in enumerate(zip(actual,expected))if a!=e][:3]
s=(r/'SFT/Physics/CollectiveObservationRecords.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'collectiveobservation1035_records_audit.lean';p.write_text('import SFT.Physics.CollectiveObservationRecords\n'+''.join('#print axioms SFT.Physics.CollectiveObservationRecords.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=envlean,capture_output=True,text=True);(w/'collectiveobservation1035_records_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names)
(w/'collectiveobservation1035_records_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original authoritative_record payload outcomes and errors; original file hashes stubbed only to isolate payload conditions. Full source binding/validator remains separate.'),indent=2));print('PASS',len(tests))
