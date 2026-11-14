from pathlib import Path
import os,subprocess,json
from sft.physics.vacuum_lineage_laws_v1 import vacuum_inertia_exchange,vacuum_floor,half_one,fold_part
w=Path('work');r=(w/'constants-recovery').resolve();expected=[[x.numerator,x.denominator] for x in [vacuum_inertia_exchange(),vacuum_floor(),half_one(),fold_part(vacuum_floor()),fold_part(half_one())]]
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'VacuumInertiaScience876.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True);actual=json.loads(out);assert actual==expected
(w/'vacuum_inertia876_science_report.json').write_text(json.dumps(dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source='sft/physics/vacuum_lineage_laws_v1.py:vacuum_inertia_exchange',actual=actual,expected=expected,fresh_original_execution=True,fresh_lean_execution=True),indent=2));print('PASS original source exchange and both carriers with their Fold results',flush=True)
