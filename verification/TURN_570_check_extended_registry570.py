from pathlib import Path
from types import SimpleNamespace
import json,ast,subprocess,os,hashlib,tempfile
ns={};exec(Path('work/bond_spec570.py').read_text(),ns);tree=ast.parse(ns['raw']('sft/chemistry/generated_goldbook_extended_law.py'));scope={'Path':Path,'EmpiricalChemistrySpec':object,'json':json,'hash_file':lambda p:'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()};exec(compile(ast.Module(body=[n for n in tree.body if getattr(n,'name',None)=='source_derived_extended_targets'],type_ignores=[]),'source','exec'),scope)
helper=Path('work/check_extended570.py').read_text();exec(helper[helper.index('def cv('):helper.index('expected=[]')],globals())
cases=[[],[{}],[{'target_id':'valid'},{}],[{'target_id':[]}],[{'target_id':{}}],[{'target_id':True},{'target_id':1}],[{'target_id':False},{'target_id':0}],[{'target_id':'same'},{'target_id':'same'}],[None],[{'target_id':None}],[{'target_id':'1'},{'target_id':1}]]
registries=[{'schema':'sft-v3-chemistry-extended-source-derived-observations/1','observations':rows} for rows in cases];expected=[]
with tempfile.TemporaryDirectory() as temp:
 root=Path(temp);spec=SimpleNamespace(observation_registry_path='registry.json',target_rows=[])
 for registry in registries:
  (root/'registry.json').write_text(json.dumps(registry))
  try:scope['source_derived_extended_targets'](root,spec);expected.append({'ok':True})
  except (ValueError,KeyError,TypeError) as e:expected.append({'error':str(e)})
s='import SFT.Chemistry.ExtendedExtraction\nopen SFT.Chemistry.ExtendedExtraction SFT.Host.Canonical\ndef result (v : Value) : Value := match resolveAll v [] [] with\n | .error e => .object [("error",.text e)]\n | .ok _ => .object [("ok",.boolean true)]\ndef main : IO Unit := do\n'+'\n'.join(' IO.println (render (result ('+cv(v)+')))' for v in registries)+'\n';r=Path('work/constants-recovery').resolve();(r/'ExtendedRegistry570.lean').write_text(s);p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','ExtendedRegistry570.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/extended570_registry.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr;actual=[json.loads(x) for x in p.stdout.splitlines()];assert actual==expected,(actual,expected);Path('work/extended570_registry_report.json').write_text(json.dumps(dict(status='PASS',cases=len(cases),results=actual,source=ns['pin']),indent=2));print('PASS',len(cases),'original registry guard cases')
