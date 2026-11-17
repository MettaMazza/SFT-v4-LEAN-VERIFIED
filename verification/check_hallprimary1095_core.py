from pathlib import Path
import sys,json,hashlib,subprocess,os
w=Path('work');r=w/'turn1064_recovery';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.materials.successor_structural_counts import primary_fractional_hall_classes
from sft.engine.exact import PositiveCount
from sft.engine.canonical import canonical_value
bounds=list(range(1,33))+[63]
p=w/'HallPrimaryProgram1095.lean';p.write_text('''import SFT.Materials.HallPrimary
open SFT.Host SFT.Materials.HallPrimary
def bounds : List SFT.Materials.RotationTotient.PositiveCount := ['''+','.join('⟨'+str(n)+',by decide⟩'for n in bounds)+''']
def main : IO Unit := IO.println (Canonical.render (.array (bounds.map (fun bound => .array ((primaryClasses bound).map value)))))
''')
env=dict(os.environ,LEAN_PATH='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/lib/lean:'+str(r.resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean')
with(w/'hallprimary1095_core_output.json').open('w')as out,(w/'hallprimary1095_core_execution.log').open('w')as err:subprocess.run(['python3','work/run_lean_guarded.py','/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1','-M8192','--run',str(p)],env=env,stdout=out,stderr=err,check=True)
expected=[canonical_value(primary_fractional_hall_classes(PositiveCount(n)))for n in bounds];assert json.loads((w/'hallprimary1095_core_output.json').read_text())==expected
log=(w/'hallprimary1095_core_build.log').read_text();assert log.count('does not depend on any axioms')==8 and'depends on axioms:'not in log
(w/'hallprimary1095_core_report.json').write_text(json.dumps(dict(status='PASS',positive_bounds=len(bounds),ordered_fraction_rows=sum(map(len,expected)),original_seven_bound_rows=13,axioms=[],declarations=8,source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_sha256=hashlib.sha256((r/'SFT/Materials/HallPrimary.lean').read_bytes()).hexdigest()),indent=2)+'\n');print('PASS33 positive bounds;',sum(map(len,expected)),'ordered reduced fractions;8 empty-axiom declarations')
