from pathlib import Path
import sys,json,subprocess,os,copy,hashlib,re,tempfile,ast
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';root='/Volumes/One Touch/ernos-labs-sft-platform'
const={};tree=ast.parse((w/'velocity_composition_fizeau_empirical_v1.py').read_text())
for n in tree.body:
 if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name):
  try:const[n.targets[0].id]=ast.literal_eval(n.value)
  except ValueError:pass
payload=json.loads(subprocess.check_output(['git','-C',root,'show',pin+':'+const['SOURCE_PATH']]))
fn=next(n for n in ast.parse((w/'velocity_composition_fizeau_validation_v1.py').read_text()).body if isinstance(n,ast.FunctionDef)and n.name=='authoritative_record');env={**const,'Path':Path,'json':json};env['source_hashes']=lambda:{const['SOURCE_PATH']:const['SOURCE_HASH'],const['PDF_PATH']:const['PDF_HASH']};exec(compile(ast.Module(body=[fn],type_ignores=[]),'original-pinned-authoritative-record','exec'),env)
tests=[payload]
for path in [('schema',),('source_id',),('source','snapshot_hash'),('source','snapshot_path')]+[('registered_target',k)for k in payload['registered_target'] if k!='systematic_limitations_retained']+[('row_custody',k)for k in payload['row_custody']]:
 for value in [None,False,True,0,1,'changed']:
  t=copy.deepcopy(payload);parent=t
  for k in path[:-1]:parent=parent[k]
  parent[path[-1]]=value;tests.append(t)
for value in [[],['a']*3,['a']*4,['a']*5,'abcd',{'a':1,'b':2,'c':3,'d':4}]:
 t=copy.deepcopy(payload);t['registered_target']['systematic_limitations_retained']=value;tests.append(t)
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
s='''import SFT.Physics.FizeauRecords
open SFT.Host.Canonical SFT.Physics.FizeauRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Value → Value | .ok v => .object [("ok",v)] | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join('result (payloadBoundary ('+val(t)+'))'for t in tests)+']))\n';p=w/'fizeau1030_records_cases.lean';p.write_text(s);envlean={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=envlean,capture_output=True,text=True);(w/'fizeau1030_records_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-1000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e)for i,(a,e)in enumerate(zip(actual,expected))if a!=e][:3]
s=(r/'SFT/Physics/FizeauRecords.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'fizeau1030_records_audit.lean';p.write_text('import SFT.Physics.FizeauRecords\n'+''.join('#print axioms SFT.Physics.FizeauRecords.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=envlean,capture_output=True,text=True);(w/'fizeau1030_records_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names)
(w/'fizeau1030_records_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),axioms=[],declarations=names,source_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Original authoritative_record payload outcomes and errors; original file hashes stubbed only to isolate payload conditions. Full source binding/validator remains separate.'),indent=2));print('PASS',len(tests))
