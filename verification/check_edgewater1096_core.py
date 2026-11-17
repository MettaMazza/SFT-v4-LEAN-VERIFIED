from pathlib import Path
import sys,json,hashlib,subprocess,os
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.materials.successor_structural_counts import topological_edge_count,water_bulk_ledger_certificate
from sft.engine.exact import PositiveCount,InadmissibleExactValue
from sft.engine.canonical import canonical_value
pairs=[(a,b)for a in range(1,33)for b in range(1,33)]+[(10**20,1),(1,10**20),(10**20,10**20),(10**20,10**20-1)]
expected=[]
for a,b in pairs:
 try:expected.append({'ok':canonical_value(topological_edge_count(PositiveCount(a),PositiveCount(b)))})
 except InadmissibleExactValue as e:expected.append({'error':str(e)})
p=w/'EdgeWaterProgram1096.lean';p.write_text('''import SFT.Materials.BoundaryEdgeCount
import SFT.Materials.WaterBulkLedger
open SFT.Host
def pairs : List (SFT.Materials.RotationTotient.PositiveCount × SFT.Materials.RotationTotient.PositiveCount) := ['''+','.join('(⟨'+str(a)+',by decide⟩,⟨'+str(b)+',by decide⟩)'for a,b in pairs)+''']
def resultValue : Except String Canonical.Value → Canonical.Value
 | .error e => .object [("error",.text e)]
 | .ok value => .object [("ok",value)]
def main : IO Unit := IO.println (Canonical.render (.object [
 ("edges",.array (pairs.map (fun (a,b) => resultValue (SFT.Materials.BoundaryEdgeCount.certificate a b)))),
 ("water",SFT.Materials.WaterBulkLedger.certificate)]))
''')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'edgewater1096_core_output.json').open('w')as out,(w/'edgewater1096_core_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
assert json.loads((w/'edgewater1096_core_output.json').read_text())==dict(edges=expected,water=canonical_value(water_bulk_ledger_certificate()))
print('PASS1028 edge pairs including exact equality rejection and all water ledger fields')

for module,count,report in [('BoundaryEdgeCount',6,'edgecount1097_core_report.json'),('WaterBulkLedger',5,'waterbulk1097_core_report.json')]:
 log=(w/(module+'1097_build.log')).read_text();assert log.count('does not depend on any axioms')==count and 'depends on axioms:'not in log
 fields=dict(status='PASS',module=module,declarations=count,axioms=[],source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_sha256=hashlib.sha256((r/'SFT/Materials'/(module+'.lean')).read_bytes()).hexdigest())
 if module=='BoundaryEdgeCount':fields.update(positive_pair_cases=len(pairs),equal_rejections=sum(a==b for a,b in pairs),success_fields=2)
 else:fields.update(certificate_fields=3,ordered_required_fields=9)
 (w/report).write_text(json.dumps(fields,indent=2)+'\n')
