from pathlib import Path
import ast,json,subprocess,tempfile,copy,hashlib,os
ns={};exec(Path('work/entity_spec554.py').read_text(),ns);spec=ns['spec'];raw=ns['raw'];repo=Path(ns['repo']);pin=ns['pin'];scope={};exec(raw('sft/engine/canonical.py'),scope)
for path,name in [('sft/engine/source.py','hash_file'),('sft/chemistry/generated_law.py','_source_derived_targets')]:
 tree=ast.parse(raw(path));body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0)]+[n for n in tree.body if getattr(n,'name',None)==name];scope.update(Path=Path);exec(compile(ast.fix_missing_locations(ast.Module(body=body,type_ignores=[])),path,'exec'),scope)
reference=spec.target_rows[0];source=raw(reference.snapshot_path).encode();registryBytes=raw(spec.observation_registry_path).encode();registry=json.loads(registryBytes);document=json.loads(source);expected=[];cases=[]
def obs(r):return next(x for x in r['observations'] if x['target_id']==reference.target_id)
for name in ['original','schema','duplicate','absent','source','term','feature','fragment','snapshot','casefold']:
 reg=copy.deepcopy(registry);data=source
 if name=='schema':reg['schema']='changed'
 if name=='duplicate':reg['observations'].append(copy.deepcopy(obs(reg)))
 if name=='absent':reg['observations']=[x for x in reg['observations'] if x['target_id']!=reference.target_id]
 if name=='source':obs(reg)['source_id']='changed'
 if name=='term':obs(reg)['term_code']='changed'
 if name=='feature':obs(reg)['ordered_feature_extractions'][0]['normalized_feature']=' '
 if name=='fragment':obs(reg)['ordered_feature_extractions'][0]['required_fragment']='not in the original definition'
 if name=='snapshot':data=source+b' '
 if name=='casefold':obs(reg)['ordered_feature_extractions'][0]['required_fragment']=obs(reg)['ordered_feature_extractions'][0]['required_fragment'].upper()
 with tempfile.TemporaryDirectory() as td:
  root=Path(td);p=root/reference.snapshot_path;p.parent.mkdir(parents=True);p.write_bytes(data);p=root/spec.observation_registry_path;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(reg))
  try:rows,_=scope['_source_derived_targets'](root,spec);result={'ok':list(rows)}
  except ValueError as ex:result={'error':str(ex)}
 expected.append({'case':name,'result':result});cases.append((name,reg,data))
q=lambda s:json.dumps(s,ensure_ascii=False)
def cv(v):
 if v is None:return '.null'
 if isinstance(v,str):return '.text '+q(v)
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(cv(x) for x in v)+']'
 if isinstance(v,dict):return '.object ['+','.join('('+q(k)+','+cv(x)+')' for k,x in v.items())+']'
 raise ValueError(type(v))
s='import SFT.Chemistry.SourceExtraction\nopen SFT.Host.Canonical SFT.Chemistry.SourceExtraction\nset_option maxRecDepth 10000\ndef reference : Reference := ⟨'+','.join(q(getattr(reference,k)) for k in ['target_id','source_id','source_locator','snapshot_path','snapshot_hash'])+'⟩\n'
s+='def document : Value := '+cv(document)+'\n'
s+='def main : IO Unit := do\n let mut rows : List Value := []\n'
for name,reg,data in cases:
 s+=' let result := resolveAll ('+cv(reg)+') [reference] [⟨reference.snapshotPath,('+q(data.decode())+').toUTF8,document⟩]\n'
 s+=' let value := match result with\n  | .ok xs => Value.object [("ok",.array (xs.map resolvedValue))]\n  | .error e => Value.object [("error",.text e)]\n'
 s+=' rows := rows ++ [.object [("case",.text '+q(name)+'),("result",value)]]\n'
s+=' IO.println (render (.array rows))\n';r=Path('work/constants-recovery').resolve();(r/'ExtractionProgram555.lean').write_text(s);Path('work/extraction555_expected.json').write_text(json.dumps(expected,indent=2));env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run','ExtractionProgram555.lean'],cwd=r,env=env,capture_output=True,text=True);Path('work/extraction555_output.log').write_text(o.stdout+o.stderr);assert o.returncode==0,(o.stdout+o.stderr)[-3000:];actual=json.loads(o.stdout);assert actual==expected,[(a,b) for a,b in zip(actual,expected) if a!=b];Path('work/extraction555_report.json').write_text(json.dumps({'status':'PASS','cases':expected,'source_commit':pin,'source_function':'sft/chemistry/generated_law.py:_source_derived_targets','comparison':'Fresh Lean execution against exact pinned Python function body'},indent=2));print('PASS all',len(cases),'source extraction comparisons')
