from pathlib import Path
import ast,json,hashlib,os,subprocess,types
w=Path('work');r=w/'turn1064_recovery';pin=w/'pinned1126';src=pin/'sft/chemistry/multicentre_support_validation_v1.py'
q=lambda x:json.dumps(x,ensure_ascii=False)
# Execute original functions without changing their bodies; supply the original registration constants.
batch=ast.parse((pin/'sft/chemistry/multicentre_support_batch_v1.py').read_text())
call=next(n.value for n in batch.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='MULTICENTRE_SUPPORT_SPEC' for t in n.targets))
experiment_id=ast.literal_eval(next(k.value for k in call.keywords if k.arg=='experiment_id'))
MULTICENTRE_SUPPORT_SPEC=types.SimpleNamespace(experiment_id=experiment_id)
IDENTITY_PATH='experiments/external_sources/chemistry/multicentre_target_identities_v1.json'
IDENTITY_HASH='sha256:c77b359440bb7f44259974e34ce23b13de0ff2057f4c859c9015a27f033958c4'
def hash_file(p):return 'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()
nodes=[n for n in ast.parse(src.read_text()).body if isinstance(n,ast.FunctionDef) and n.name in ('_identities','prediction_program_document')]
exec(compile(ast.Module(body=nodes,type_ignores=[]),str(src),'exec'))
expected=prediction_program_document(pin);ids=[str(x['target_id']) for x in _identities(pin)]
code='import SFT.Chemistry.MulticentrePrediction\nopen SFT.Host SFT.Chemistry.MulticentrePrediction\ndef ids : List String := ['+','.join(map(q,ids))+']\ndef main : IO Unit := do\n let out ← IO.getStdout\n match predictionDocument identityHash "sft-v3-multicentre-identities/1" ids with\n | .error e => throw (IO.userError e)\n | .ok value => out.putStrLn (Canonical.render value)\n'
h=w/'MulticentrePredictionProgram1127.lean';h.write_text(code)
(w/'multicentreprediction1127_expected.json').write_text(json.dumps(expected))
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with (w/'multicentreprediction1127_output.json').open('w')as out,(w/'multicentreprediction1127_execution.log').open('w')as err:
 subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(h)],env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'multicentreprediction1127_output.json').read_text());assert actual==expected
report={'status':'PASS','original_instructions':len(expected['instructions']),'identity_count':len(ids),'source_sha256':hashlib.sha256(src.read_bytes()).hexdigest(),'lean_sha256':hashlib.sha256((r/'SFT/Chemistry/MulticentrePrediction.lean').read_bytes()).hexdigest()}
(w/'multicentreprediction1127_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
