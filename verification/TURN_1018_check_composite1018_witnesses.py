from pathlib import Path
import sys,os,subprocess,json,hashlib
sys.path.insert(0,'work/v3-runtime500')
from sft.physics.composite_confining_sector_terminal_law_v1 import SPEC
from dataclasses import asdict
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');p=Path('work/CompositeWitness1018.lean');p.write_text('''import SFT.Physics.CompositeConfiningWitnesses
import SFT.Host.Canonical
open SFT.Physics.CompositeConfiningWitnesses SFT.Host.Canonical
#eval IO.println (render (.array (witnesses.map (fun w => .object [("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)]))))
''');x=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);assert x.returncode==0,x.stdout+x.stderr;assert json.loads(x.stdout)==[asdict(w) for w in SPEC.witnesses];Path('work/composite1018_witness_comparison.json').write_text(json.dumps(dict(status='PASS',witnesses=7,source_sha256=hashlib.sha256((r/'SFT/Physics/CompositeConfiningWitnesses.lean').read_bytes()).hexdigest()),indent=2));print('PASS7 original full witness records')
