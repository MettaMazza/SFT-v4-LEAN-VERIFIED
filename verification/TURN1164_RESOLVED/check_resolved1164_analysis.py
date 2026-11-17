from pathlib import Path
import sys,json,subprocess,os,hashlib
from types import SimpleNamespace
w=Path('work');stage=w/'pinned1164';runtime=w/'v3-runtime500'
for rel in ['census','receipts/engine/model_admitted']:
 p=stage/rel;p.parent.mkdir(parents=True,exist_ok=True)
 if not p.exists():p.symlink_to((runtime/rel).resolve(),target_is_directory=True)
ids=json.loads((stage/'experiments/external_sources/chemistry/nuclear_electronic_target_identities_v1.json').read_text())['rows']
for row in ids:
 p=stage/row['snapshot_path'];p.parent.mkdir(parents=True,exist_ok=True)
 if not p.exists():p.write_bytes((w/'pinned1158'/row['snapshot_path']).read_bytes())
 assert 'sha256:'+hashlib.sha256(p.read_bytes()).hexdigest()==row['snapshot_hash']
sys.path.insert(0,str(runtime.resolve()));import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve()),str((w/'pinned1158/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import rovibronic_joint_validation_v1 as v
from sft.engine.canonical import canonical_value
from sft.claim_evidence import snapshot_protected_tree
captured={};original=v.sha256_identity
def capture(x):
 if isinstance(x,dict)and {'comparisons','counts','adverse','trace'}<=set(x):captured.update(x)
 return original(x)
v.sha256_identity=capture
before=snapshot_protected_tree(stage);result=v.RovibronicJointValidator(stage).validate(SimpleNamespace(seal_hash='native-resolved1164'));assert result.passed and before==snapshot_protected_tree(stage)
(w/'resolved1164_original_empirical.json').write_text(json.dumps(canonical_value(result),indent=2)+'\n');(w/'resolved1164_original_payload.json').write_text(json.dumps(canonical_value(captured),indent=2)+'\n')
rows=v._source_rows(stage);(w/'resolved1164_rows.json').write_text(json.dumps(rows,ensure_ascii=False))
base=(w/'NuclearElectronicValidationProgram1158.lean').read_text();base=base[:base.index('def field')].replace('import SFT.Chemistry.NuclearElectronicValidation','import SFT.Chemistry.ResolvedRovibronicAnalysis')
base+='''def main : IO Unit := do
 let raw ← IO.FS.readFile "work/resolved1164_rows.json"
 let j ← IO.ofExcept (Lean.Json.parse raw >>= convert (raw.utf8ByteSize+1))
 let rawRows ← IO.ofExcept (NuclearElectronicTargets.list j)
 let rows ← IO.ofExcept (rawRows.mapM NuclearElectronicTargets.readRow)
 let releases := rows.map fun r => (r.targetId,SFT.Host.Canonical.identity r.retained)
 let comparisons ← IO.ofExcept (rows.mapM fun r => ResolvedRovibronicAnalysis.rowComparison r releases)
 let counts ← IO.ofExcept (ResolvedRovibronicAnalysis.counts rows)
 IO.println (SFT.Host.Canonical.render (.object [("comparisons",.array comparisons),("counts",.object (counts.map fun (k,n) => (k,.integer (Int.ofNat n))))]))
'''
p=w/'ResolvedAnalysis1164.lean';p.write_text(base);env=dict(os.environ,LEAN_PATH=str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean')+':'+str((w/'turn1064_recovery').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean');a=subprocess.run([sys.executable,'work/run_lean_guarded.py',str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'),'-j1','-M8192','--run',str(p)],env=env,capture_output=True,text=True);(w/'resolved1164_analysis.log').write_text(a.stdout+a.stderr);assert a.returncode==0,a.stdout[-2000:];actual=json.loads(a.stdout);assert actual=={k:canonical_value(captured[k]) for k in ['comparisons','counts']}
(w/'resolved1164_analysis_report.json').write_text(json.dumps({'status':'PASS','rows':len(rows),'counts':actual['counts'],'fresh_original_empirical':result.passed,'native_comparisons':len(actual['comparisons'])},indent=2)+'\n');print('PASS95 row comparisons,12 original counts; original full empirical PASS',flush=True)
