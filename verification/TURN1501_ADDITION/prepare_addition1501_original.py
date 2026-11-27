from pathlib import Path
import ast,subprocess,json,hashlib
w=Path('work');stage=w/'pinned_addition1499';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';cid='SFT-CHEM-ADDITION-REACTION-FAMILY-009'
def read(rel):return subprocess.check_output(['git','-C',repo,'show',pin+':'+rel])
batch=read('sft/chemistry/addition_reaction_batch_v3.py');execution=read('claims/'+cid+'/execution.py');constants={}
for n in ast.parse(batch).body:
 if isinstance(n,ast.Assign)and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
  key=n.targets[0].id
  if key.endswith(('_PATH','_PATHS','_HASH')) or key in ['CLAIM_ID','OBLIGATION_ID']:
   constants[key]=eval(compile(ast.Expression(n.value),'pinned-batch-constant','eval'),{'__builtins__':{},'tuple':tuple,'range':range})
fixed=next(n.value for n in ast.walk(ast.parse(execution))if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='fixed'for t in n.targets))
source_paths=[]
for n in fixed.elts:
 if isinstance(n,ast.Starred):source_paths.extend(constants[n.value.id])
 else:source_paths.append(constants[n.id]if isinstance(n,ast.Name)else ast.literal_eval(n))
inventory=json.loads(read(constants['INVENTORY_PATH']));tree=set(subprocess.check_output(['git','-C',repo,'ls-tree','-r','--name-only',pin],text=True).splitlines())
def paths(value):
 if isinstance(value,dict):
  for v in value.values():yield from paths(v)
 elif isinstance(value,list):
  for v in value:yield from paths(v)
 elif isinstance(value,str)and not value.startswith('sha256:')and '/'in value and len(value)<512 and value in tree:yield value
source_paths=list(dict.fromkeys(source_paths+list(paths(inventory))))
allpaths=list(dict.fromkeys(source_paths+['claims/'+cid+'/certificate.json','claims/'+cid+'/independent_validator.py']))
rows=[]
for rel in allpaths:
 b=read(rel);p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(b);rows.append({'path':rel,'sha256':hashlib.sha256(b).hexdigest(),'bytes':len(b)})
for d in ['census','receipts']:
 p=stage/d
 if not p.exists():p.symlink_to((w/'v3-runtime500'/d).resolve(),target_is_directory=True)
(w/'addition1501_source_pin.json').write_text(json.dumps({'commit':pin,'files':rows,'source_manifest_files':source_paths},indent=2)+'\n');print('Pinned',len(rows),'files',sum(x['bytes']for x in rows),'bytes')
