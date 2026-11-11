from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/selectivity_spec617.py').read_text(),ns);raw=ns['raw'];spec=ns['spec'];q=lambda s:json.dumps(s,ensure_ascii=False)
def cv(v):
 if v is None:return '.null'
 if isinstance(v,str):return '.text '+q(v)
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(cv(x) for x in v)+']'
 if isinstance(v,dict):return '.object ['+','.join('('+q(k)+','+cv(x)+')' for k,x in v.items())+']'
 raise TypeError(v)
expected=json.loads(raw('claims/'+spec.claim_id+'/empirical_validation.json'));expected.pop('claim_id');registry=raw(spec.observation_registry_path);ref=spec.target_rows[0];source=raw(ref.snapshot_path); row=next(x for x in json.loads(registry)['observations'] if x['target_id']==ref.target_id); docs=[(d['snapshot_path'],raw(d['snapshot_path'])) for d in row['support_documents']]
import ast,re
from html import unescape
source_tree=ast.parse(raw('sft/chemistry/generated_multi_source_law.py'))
exec(compile(ast.Module(body=[n for n in source_tree.body if isinstance(n,ast.FunctionDef) and n.name=='_html_corpus'],type_ignores=[]),'pinned-html-adapter','exec'))
def document_value(path,body):
 kind=next(d['kind'] for d in row['support_documents'] if d['snapshot_path']==path)
 if kind=='goldbook-json':return '⟨⟨'+q(path)+',('+q(body)+').toUTF8,'+cv(json.loads(body))+'⟩,""⟩'
 assert kind=='official-html'
 encoded=body.encode('utf8');assert encoded.isascii(), 'Use exact byte representation for non-ASCII HTML'
 return '⟨⟨'+q(path)+',('+q(body)+').toUTF8,.null⟩,'+q(_html_corpus(encoded.decode('iso-8859-1')))+'⟩'
s='import SFT.Chemistry.SelectivityValidation\nopen SFT.Chemistry SFT.Physics SFT.Host.Canonical\nset_option maxRecDepth 10000\n'
s+='def registry : Value := '+cv(json.loads(registry))+'\ndef document : Value := '+cv(json.loads(source))+'\n'
s+='def main : IO Unit := do\n let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩\n'
s+=' match SelectivityValidation.validate ('+q(registry)+').toUTF8 registry ['+','.join(document_value(path,body) for path,body in docs)+'] '+q(expected['validated_seal_hash'])+' '+q(expected['isolation_certificate']['host_platform'])+' '+q(expected['isolation_certificate']['python_implementation'])+' before before with\n | .error e => throw (IO.userError e)\n | .ok result => IO.println (render result.value)\n'
r=Path('work/constants-recovery').resolve();(r/'SelectivityValidationProgram617.lean').write_text(s);Path('work/selectivity_validation617_expected.json').write_text(json.dumps(expected,indent=2));env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run','SelectivityValidationProgram617.lean'],cwd=r,env=env,capture_output=True,text=True);Path('work/selectivity_validation617_output.log').write_text(p.stdout+p.stderr);assert p.returncode==0,(p.stdout+p.stderr)[-3000:];actual=json.loads(p.stdout);Path('work/selectivity_validation617_output.json').write_text(json.dumps(actual,indent=2));assert actual==expected,[(k,actual.get(k),v) for k,v in expected.items() if actual.get(k)!=v];Path('work/selectivity_validation617_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'all_validation_fields_and_hashes_match':True,'source_snapshot_bytes':len(source.encode()),'registry_bytes':len(registry.encode()),'source_extraction_compared':True,'fresh_native_lean_execution':True,'adapter_inputs':'JSON decoding and exact pinned HTML extraction from the same source bytes; original host metadata; equal protected snapshots'},indent=2));print('PASS full chemistry validator output including all hashes')
