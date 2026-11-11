from pathlib import Path
import json,subprocess,os
ns={};exec(Path('work/alpha_interval_spec650.py').read_text(),ns)
v=ns['values'];source=ns['raw'](v['source_snapshot_path']);expected=json.loads(ns['raw']('claims/'+v['claim_id']+'/empirical_validation.json'));expected.pop('claim_id')
q=lambda x:json.dumps(x,ensure_ascii=False)
s='import SFT.Physics.AlphaIntervalExternal\nopen SFT.Physics SFT.Host.Canonical\nset_option maxRecDepth 1000000\n'
s+='def main : IO Unit := do\n let before : HostilePackage.Snapshot := ⟨"registered-protected-root",[],"unchanged"⟩\n'
s+=' match AlphaIntervalExternal.validate '+q(source)+' '+q(expected['validated_seal_hash'])+' '+q(expected['isolation_certificate']['host_platform'])+' '+q(expected['isolation_certificate']['python_implementation'])+' before before with\n | .error e => throw (IO.userError e)\n | .ok result => IO.println (render result.value)\n'
r=Path('work/constants-recovery').resolve();(r/'AlphaValidationProgram650.lean').write_text(s)
p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288','--run','AlphaValidationProgram650.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True,capture_output=True)
Path('work/alpha_validation650_output.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr
actual=json.loads(p.stdout);Path('work/alpha_validation650_output.json').write_text(json.dumps(actual,indent=2));assert actual==expected,[(k,actual.get(k),v) for k,v in expected.items() if actual.get(k)!=v]
Path('work/alpha_validation650_report.json').write_text(json.dumps(dict(status='PASS',source_commit=ns['pin'],all_validation_fields_and_hashes_match=True,source_snapshot_bytes=len(source.encode()),adapter_inputs='Original complete source text drives both exact interval parsing and the original SHA-256 check; original host metadata and equal protected snapshots'),indent=2));print('PASS full original alpha validator output and hashes')
