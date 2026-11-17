from pathlib import Path
import sys,json,hashlib,os,subprocess
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.materials.successor_structural_counts import rectification_certificate
from sft.engine.exact import PositiveCount
from sft.engine.canonical import canonical_value
pairs=[(b,a) for b in range(1,33) for a in range(1,33)]+[(10**20,1),(1,10**20),(10**20,10**20),(10**20,10**20-1)]
p=w/'RectificationProgram1091.lean'
p.write_text('''import SFT.Materials.RectificationSource
open SFT.Host SFT.Materials.RectificationSource
def pairs : List (SFT.Materials.RotationTotient.PositiveCount × SFT.Materials.RotationTotient.PositiveCount) := ['''+','.join('(⟨'+str(b)+',by decide⟩,⟨'+str(a)+',by decide⟩)'for b,a in pairs)+''']
def main : IO Unit := IO.println (Canonical.render (.array (pairs.map (fun (b,a) => certificate b a))))
''')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'rectification1091_core_output.json').open('w')as out,(w/'rectification1091_core_execution.log').open('w')as err:
 subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
expected=[canonical_value(rectification_certificate(PositiveCount(b),PositiveCount(a)))for b,a in pairs]
assert json.loads((w/'rectification1091_core_output.json').read_text())==expected
log=(w/'rectification1091_core_build.log').read_text();assert log.count('does not depend on any axioms')==9 and 'depends on axioms:'not in log
report=dict(status='PASS',positive_pair_cases=len(pairs),certificate_fields=3,axioms=[],declarations=9,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_sha256=hashlib.sha256((r/'SFT/Materials/RectificationSource.lean').read_bytes()).hexdigest(),original_source_sha256=hashlib.sha256((w/'v3-runtime500/sft/materials/successor_structural_counts.py').read_bytes()).hexdigest())
(w/'rectification1091_core_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS 1028 pairs, all three certificate fields; nine empty-axiom declarations')
