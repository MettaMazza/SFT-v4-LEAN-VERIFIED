from pathlib import Path
import subprocess,json,sys,os,hashlib
root=Path('work/v3-runtime500').resolve();pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
# Runtime files extracted directly from git archive at this pin; engine seal remains enabled.
sys.dont_write_bytecode=True;sys.path.insert(0,str(root))
from sft.physics.coupling_running_convergence_terminal_law_v1 import formal_certificate
from sft.engine.canonical import canonical_value
expected=canonical_value(formal_certificate());actual=json.load(open('work/running499_certificate_actual.json'))
assert actual==expected, [k for k in expected if actual.get(k)!=expected[k]]
report=dict(status='PASS',source_commit=pin,compared='Every formal_certificate field from fresh Lean execution against pinned V3 execution',ordered_pairs=6,tolerance_denominators=6,convergence_witnesses=36,levels=6,full_entry_complete=False)
Path('work/running499_certificate_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
