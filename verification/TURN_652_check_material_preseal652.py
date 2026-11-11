exec(open('work/material_source651.py').read().split('registration=')[0])
import tempfile,os,copy
from pathlib import Path
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer '+str(x)
 if isinstance(x,(list,tuple)):return '.array ['+','.join(cv(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 if x is None:return '.null'
 raise TypeError(x)
original=json.loads((root/namespace['PRE_SOURCE_SEAL_PATH']).read_text());cases=[]
p=copy.deepcopy(original);p.pop('sealed_payload_hash');cases.append(p)
p=copy.deepcopy(original);p['sealed_payload_hash']='changed';cases.append(p)
for k,v in [('external_source_identities_selected',True),('external_target_content_opened',True),('required_claim_count',83),('candidate_count',1),('claim_prediction_set_hash','changed'),('inventory_hash','changed'),('structural_counts_hash','changed'),('derivation_hash','changed')]:
 p=copy.deepcopy(original);p.pop('sealed_payload_hash');p[k]=v;p['sealed_payload_hash']=namespace['sha256_identity'](p);cases.append(p)
expected=[]
with tempfile.TemporaryDirectory(prefix='sft-material-seal-') as td:
 temp=Path(td);dst=temp/namespace['PRE_SOURCE_SEAL_PATH'];dst.parent.mkdir(parents=True)
 for pathkey in ['inventory_path','structural_counts_path','derivation_path']:
  p=temp/original[pathkey];p.parent.mkdir(parents=True,exist_ok=True);p.symlink_to(root/original[pathkey])
 for case in cases:
  dst.write_text(json.dumps(case))
  try:expected.append({'ok':namespace['validate_pre_source_seal'](temp)})
  except KeyError as e:expected.append({'error':'KeyError: '+e.args[0]})
  except ValueError as e:expected.append({'error':str(e)})
rels=[original[k] for k in ['inventory_path','structural_counts_path','derivation_path']]
s='''import SFT.Materials.MaterialSource
open SFT.Host.Canonical SFT.Materials
def main : IO Unit := do
 let paths : List String := '''+q(rels)+'''
 let files ← paths.mapM fun p => do
  let b ← IO.FS.readBinFile (System.FilePath.mk ('''+q(str(root))+''' ++ "/" ++ p))
  pure (MaterialSource.Snapshot.mk p b)
 let cases : List Value := ['''+','.join(cv(x) for x in cases)+''']
 IO.println (render (.array (cases.map fun p => match MaterialSource.validatePreSeal p files with
 | .ok h => .object [("ok",.text h)]
 | .error e => .object [("error",.text e)])))
'''
r=Path('work/constants-recovery').resolve();(r/'MaterialPreseal652.lean').write_text(s)
o=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','--run','MaterialPreseal652.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),capture_output=True,text=True);Path('work/material_preseal652_output.log').write_text(o.stdout+o.stderr);assert o.returncode==0,o.stdout+o.stderr;actual=json.loads(o.stdout);assert actual==expected,(actual,expected);Path('work/material_preseal652_report.json').write_text(json.dumps({'status':'PASS','cases':len(cases),'source_operation':'validate_pre_source_seal actual pinned function, original guards and error order','expected':expected},indent=2));print('PASS',len(cases),'pre-source seal adverse cases')
