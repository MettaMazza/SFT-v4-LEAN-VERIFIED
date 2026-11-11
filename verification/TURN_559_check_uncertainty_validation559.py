from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/uncertainty_spec559.py').read_text(),ns);raw=ns['raw'];spec=ns['spec'];q=lambda s:json.dumps(s,ensure_ascii=False)
def cv(v):
 if v is None:return '.null'
 if isinstance(v,str):return '.text '+q(v)
 if isinstance(v,bool):return '.boolean '+str(v).lower()
 if isinstance(v,int):return '.integer '+str(v)
 if isinstance(v,list):return '.array ['+','.join(cv(x) for x in v)+']'
 if isinstance(v,dict):return '.object ['+','.join('('+q(k)+','+cv(x)+')' for k,x in v.items())+']'
 raise TypeError(v)
expected=json.loads(raw('claims/'+spec.claim_id+'/empirical_validation.json'));expected.pop('claim_id');registry=raw(spec.observation_registry_path);ref=spec.target_rows[0];source=raw(ref.snapshot_path)
s='import SFT.Chemistry.UncertaintyValidation\nopen SFT.Chemistry SFT.Physics SFT.Host.Canonical\nset_option maxRecDepth 10000\n'
s+='def registry : Value := '+cv(json.loads(registry))+'\ndef document : Value := '+cv(json.loads(source))+'\n'
s+='def main : IO Unit := do\n let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩\n'
s+=' match UncertaintyValidation.validate ('+q(registry)+').toUTF8 registry [⟨'+q(ref.snapshot_path)+',('+q(source)+').toUTF8,document⟩] '+q(expected['validated_seal_hash'])+' '+q(expected['isolation_certificate']['host_platform'])+' '+q(expected['isolation_certificate']['python_implementation'])+' before before with\n | .error e => throw (IO.userError e)\n | .ok result => IO.println (render result.value)\n'
r=Path('work/constants-recovery').resolve();(r/'UncertaintyValidationProgram559.lean').write_text(s);Path('work/uncertainty_validation559_expected.json').write_text(json.dumps(expected,indent=2));env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run','UncertaintyValidationProgram559.lean'],cwd=r,env=env,capture_output=True,text=True);Path('work/uncertainty_validation559_output.log').write_text(p.stdout+p.stderr);assert p.returncode==0,(p.stdout+p.stderr)[-3000:];actual=json.loads(p.stdout);Path('work/uncertainty_validation559_output.json').write_text(json.dumps(actual,indent=2));assert actual==expected,[(k,actual.get(k),v) for k,v in expected.items() if actual.get(k)!=v];Path('work/uncertainty_validation559_report.json').write_text(json.dumps({'status':'PASS','source_commit':ns['pin'],'all_validation_fields_and_hashes_match':True,'source_snapshot_bytes':len(source.encode()),'registry_bytes':len(registry.encode()),'source_extraction_compared':True,'fresh_native_lean_execution':True,'adapter_inputs':'JSON documents decoded from same pinned bytes by source IO adapter; original host metadata; equal protected snapshots'},indent=2));print('PASS full chemistry validator output including all hashes')
