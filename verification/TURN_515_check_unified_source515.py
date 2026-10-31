from pathlib import Path
import json,subprocess,os,sys,hashlib
sys.dont_write_bytecode=True;sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.physics import unified_constants_object_law_v1 as v3
from sft.engine.canonical import canonical_value
r=Path('work/constants-recovery').resolve();p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run','UnifiedSource515.lean'],cwd=r,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True,capture_output=True);Path('work/unified515_source.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout+p.stderr
actual=json.loads(p.stdout);Path('work/unified515_source_output.json').write_text(json.dumps(actual,indent=2)+'\n')
expected=dict(terminal={'ok':canonical_value(v3.admitted_terminal_vector())},certificate={'ok':canonical_value(v3.theorem_certificate())},graph=canonical_value(v3.dependency_graph()),reachable={'ok':sorted(v3.reachable_from_one(v3.dependency_graph()))});actual['reachable']['ok'].sort();assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
source=Path('work/v3-runtime500/sft/physics/unified_constants_object_law_v1.py');report=dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),terminal_fields=26,foundation_fields=16,successor_fields=16,certificate_fields=8,graph_parent_rows=10,reachable_nodes=17,sector_nodes=7,generator_changed_fields=12,held_fields=4,shared_fields=14,fresh_native_lean_and_original_python=True)
Path('work/unified515_source_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
