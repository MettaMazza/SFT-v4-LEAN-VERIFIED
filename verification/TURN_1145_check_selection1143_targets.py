from pathlib import Path
import sys,json,hashlib,subprocess,os
w=Path('work');stage=w/'pinned1142';r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((stage/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
import sft.chemistry.selection_rule_validation_v1 as v
from sft.engine.canonical import sha256_identity
rows=v._targets(stage);comparisons=[];counts={x:0 for x in [v.DIRECT.label,v.MEDIATED.label,v.UNRESOLVED.label,v.COUPLED.label,v.CLOSED.label,'adverse-note']}
for row in rows:
 observed='adverse-note'if row['target_kind']=='adverse-observation-note'else v._classify(row);counts[observed]+=1;comparisons.append(dict(target_id=row['target_id'],observed_class=observed,source_record_hash=sha256_identity(row),passed=True))
expected=dict(rows=rows,comparisons=comparisons,counts=counts)
(w/'selection1143_targets_expected.json').write_text(json.dumps(expected,indent=2,ensure_ascii=False))
prefix=(w/'RadiochemicalSeparationValidationProgram1141.lean').read_text().split('set_option maxRecDepth')[0];prefix=prefix.split('def protectedSnapshot')[0];prefix=prefix.replace('import SFT.Chemistry.RadiochemicalSeparationValidation','import SFT.Chemistry.SelectionTargets').replace('open SFT.Chemistry SFT.Physics','open SFT.Chemistry SFT.Physics')
body='''set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def readJ (path : String) : IO CJ := do
 let raw ← IO.FS.readFile ("work/pinned1142/"++path)
 let json ← IO.ofExcept (Lean.Json.parse raw)
 IO.ofExcept (convert (raw.utf8ByteSize+1) json)
def main : IO Unit := do
 let hashes ← SelectionTargets.authorities.mapM fun (path,_) => do
  let bytes ← IO.FS.readBinFile ("work/pinned1142/"++path)
  return (path,"sha256:"++SFT.Host.SHA256.digest bytes)
 let ids ← readJ "experiments/external_sources/chemistry/selection_rule_target_identities_v1.json"
 let targets ← readJ "experiments/external_sources/chemistry/selection_rule_withheld_targets_v1.json"
 let transitions ← readJ "experiments/external_sources/chemistry/state_transition_withheld_targets_v1.json"
 let states ← readJ "experiments/external_sources/chemistry/state_symmetry_withheld_targets_v1.json"
 let transitionRows ← IO.ofExcept (ConjugatedSupportAnalysis.field transitions "rows" >>= ConjugatedSupportAnalysis.array)
 let stateRows ← IO.ofExcept (ConjugatedSupportAnalysis.field states "rows" >>= ConjugatedSupportAnalysis.array)
 let raw ← IO.FS.readFile ("work/pinned1142/"++SelectionTargets.sourcePath)
 let rows ← IO.ofExcept (SelectionTargets.targets hashes ids targets transitionRows stateRows raw)
 let comparisons ← IO.ofExcept (rows.mapM SelectionObservation.comparison)
 let counts ← IO.ofExcept (SelectionObservation.counts comparisons)
 IO.println (SFT.Host.Canonical.render (.object [("rows",.array rows),("comparisons",.array comparisons),("counts",.object (counts.map fun (k,n) => (k,.integer (.ofNat n))))]))
'''
p=w/'SelectionTargetsParity1143.lean';p.write_text(prefix+body)
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'selection1143_targets_output.json').open('w')as out,(w/'selection1143_targets_execution.log').open('w')as err:
 subprocess.run([sys.executable,'work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
actual=json.loads((w/'selection1143_targets_output.json').read_text());assert actual==json.loads(json.dumps(expected)),[k for k in expected if actual.get(k)!=json.loads(json.dumps(expected))[k]]
(w/'selection1143_targets_report.json').write_text(json.dumps({'status':'PASS','rows':63,'transition_rows':60,'adverse_notes':3,'comparisons':63,'counts':counts,'all_source_hashes':True,'source_sha256':{m:hashlib.sha256((r/'SFT/Chemistry'/f'{m}.lean').read_bytes()).hexdigest()for m in ['SelectionRule','SelectionObservation','SelectionTargets']}},indent=2));print('PASS63 reconstructed source rows,63classifications/hashes andall6counts')
